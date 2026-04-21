import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:brotli/brotli.dart';
import 'package:charset/charset.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:filbet/constants/log.dart';
import 'package:filbet/http/direct_ip_connection_factory.dart';
import 'package:filbet/http/domain/domain/model/config_info.dart';
import 'package:filbet/http/domain/domain/model/ip_config.dart';
import 'package:filbet/http/http_client.dart' as http_client;
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:flutter/foundation.dart';

/// 由 [ConfigInfo] 展开的 h5/img 及并入包内备用后的完整列表。
typedef _DomainListBundle = ({
  List<String> h5,
  List<String> img,
  List<String> allH5,
  List<String> allImg,
});

class DomainManager {
  DomainManager._internal();

  static final DomainManager _singleton = DomainManager._internal();

  static DomainManager get instance => _singleton;

  // ---------------------------------------------------------------------------
  // 状态
  // ---------------------------------------------------------------------------

  /// 请求超时（毫秒）
  final int timeout = 8 * 1000;

  ///图片测速使用的线路列表（海外入口或 [changeDomainList] 赋值）。
  _DomainListBundle _speedLists = (
    h5: <String>[],
    img: <String>[],
    allH5: <String>[],
    allImg: <String>[],
  );
  final Map<String, String> _resolvedDomainIpCache = <String, String>{};

  // ---------------------------------------------------------------------------
  // 入口
  // ---------------------------------------------------------------------------

  /// [onTip] 用于 UI（如 domainTip）。
  Future<String?> queryDomainList({void Function(String)? onTip}) async {
    _tip('正在获取线路...', onTip);
    final isCn = await isCnIpConfigWithRetry(onTip: onTip);
    return isCn
        ? _queryDomainListCn(onTip: onTip)
        : _queryDomainListOverseas(onTip: onTip);
  }

  // ---------------------------------------------------------------------------
  // 海外线路
  // ---------------------------------------------------------------------------

  Future<String?> _queryDomainListOverseas({
    void Function(String)? onTip,
  }) async {
    final h5 = List<String>.from(AppEnvConfig.instance.onLineUrls);
    final img = List<String>.from(AppEnvConfig.instance.onLineImgUrls);
    _speedLists = (
      h5: h5,
      img: img,
      allH5: List<String>.from(h5),
      allImg: List<String>.from(img),
    );
    return _parallelSpeedTestApiAndImg(onTip: onTip);
  }

  // ---------------------------------------------------------------------------
  // 大陆线路
  // ---------------------------------------------------------------------------

  Future<String?> _queryDomainListCn({void Function(String)? onTip}) async {
    if (await _applyPersistedFastestDomains(onTip: onTip)) {
      unawaited(_refreshPersistedDomains());
      return AppEnvConfig.instance.apiUrl;
    }
    _tip('正在请求线路...', onTip);
    final info = await _fetchConfigInfoRace(onTip: onTip);
    if (info == null) {
      _tip('线路获取失败', onTip);
      return null;
    }
    _tip('线路获取成功', onTip);
    final remoteUrl = await changeDomainList(info, onTip: onTip);
    if (remoteUrl != null) {
      _persistFastestDomainPair(
        AppEnvConfig.instance.apiUrl,
        AppEnvConfig.instance.imageUrl,
      );
    }
    return remoteUrl;
  }

  /// 多个 Brotli 入口竞速，谁先返回有效 [ConfigInfo] 谁胜出。
  Future<ConfigInfo?> _fetchConfigInfoRace({
    void Function(String)? onTip,
  }) async {
    final urls = AppEnvConfig.instance.urls;
    return _raceFastestSuccess(
      urls.map((url) => queryConfigInfoByBrotli(url, onTip: onTip)).toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // 区域检测
  // ---------------------------------------------------------------------------

  Future<bool> isCnIpConfigWithRetry({
    void Function(String)? onTip,
    int attempts = 3,
  }) async {
    for (var i = 0; i < attempts; i++) {
      final value = await isCnIpConfig(onTip: onTip);
      if (value != null) {
        return value;
      }
      if (i < attempts - 1) {
        _tip('网络区域检测失败，重试 ${i + 2}/$attempts...', onTip);
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }
    return true;
  }

  Future<bool?> isCnIpConfig({void Function(String)? onTip}) async {
    try {
      final dio = _insecureDio(responseType: ResponseType.bytes);
      final response =
          await dio.get('https://whois.pconline.com.cn/ipJson.jsp?json=true');
      if (response.statusCode != HttpStatus.ok) {
        return null;
      }
      final cfg = IpConfig.fromJson(decodeData(response.data));
      final pro = cfg.pro?.toString() ?? '';
      Log.ip = cfg.ip;
      Log.address = "${cfg.addr ?? ''} ${cfg.pro ?? ''} ${cfg.city ?? ''}";
      return pro.isNotEmpty && !['香港', '台湾', '澳门'].contains(pro);
    } catch (_) {
      return null;
    }
  }

  dynamic decodeData(dynamic data) {
    String text;
    try {
      text = utf8.decode(data);
    } catch (_) {
      text = gbk.decode(data);
    }
    if (text.startsWith('callback(')) {
      text = text.substring(9, text.length - 1);
    }
    return jsonDecode(text);
  }

  // ---------------------------------------------------------------------------
  // 本地最快域名（prod / SharedPreferences）
  // ---------------------------------------------------------------------------

  /// 并行探测本地已存的 **API** 与 **图片** 域名，均通才写入 [AppEnvConfig] 并 [changeBaseUrl]。
  Future<bool> _applyPersistedFastestDomains({
    void Function(String)? onTip,
  }) async {
    if (!_isProd) {
      return false;
    }
    final api = SpStorage.getString(StorageKey.cachedFastestApiDomain);
    final img = SpStorage.getString(StorageKey.cachedFastestImgDomain);
    if (api.isEmpty || img.isEmpty) {
      return false;
    }

    _tip('正在检测已保存线路...', onTip);
    final results = await Future.wait([
      pingDomain(api, needWait: false),
      pingImgDomain(img, needWait: false),
    ]);
    final apiLive = results[0];
    final imgLive = results[1];
    if (apiLive == null || imgLive == null) {
      _tip('已保存线路不可用，正在获取新线路...', onTip);
      return false;
    }

    AppEnvConfig.instance.apiUrl = apiLive;
    AppEnvConfig.instance.imageUrl = imgLive;
    changeBaseUrl();
    _tip('线路连接成功', onTip);
    return true;
  }

  Future<void> _persistFastestDomainPair(String api, String img) async {
    if (api.isEmpty || img.isEmpty) {
      return;
    }
    try {
      await SpStorage.setString(StorageKey.cachedFastestApiDomain, api);
      await SpStorage.setString(StorageKey.cachedFastestImgDomain, img);
    } catch (e) {
      if (kDebugMode) {
        print('persist fastest domains: $e');
      }
    }
  }

  /// 不修改 [AppEnvConfig]、不 [changeBaseUrl]，仅更新本地缓存供下次冷启动。
  Future<void> _refreshPersistedDomains() async {
    if (!_isProd) {
      return;
    }
    try {
      final info = await _fetchConfigInfoRace();
      if (info == null) {
        return;
      }
      final picked = await _raceFastestApiAndImg(_mergedListsFrom(info));
      final api = picked.api;
      final img = picked.img;
      if (api == null || api.isEmpty || img == null || img.isEmpty) {
        return;
      }
      await _persistFastestDomainPair(api, img);
    } catch (e) {
      if (kDebugMode) {
        print('[DomainManager] background domain refresh: $e');
      }
    }
  }

  _DomainListBundle _mergedListsFrom(ConfigInfo? info) {
    final h5 = info?.h5 ?? [];
    final img = info?.img ?? [];
    return (
      h5: h5,
      img: img,
      allH5: [...h5, ...AppEnvConfig.instance.onLineUrls],
      allImg: [...img, ...AppEnvConfig.instance.onLineImgUrls],
    );
  }

  /// 对 [lists] 并行测最快 API 与图片线路；不修改 [_speedLists]。
  /// 空列表由 [checkFastestDomain] / [checkFastestImgDomain] 内部处理为 null。
  Future<({String? api, String? img})> _raceFastestApiAndImg(
    _DomainListBundle lists,
  ) async {
    final pair = await Future.wait([
      _fastestApiInBundle(lists),
      _fastestImgInBundle(lists),
    ]);
    return (api: pair[0], img: pair[1]);
  }

  /// 配置无 h5 时仅测 [lists.allH5]。
  Future<String?> _fastestApiInBundle(_DomainListBundle lists) async {
    return await checkFastestDomain(lists.h5) ??
        await checkFastestDomain(lists.allH5);
  }

  /// 配置无图时仅测 [lists.allImg]。
  Future<String?> _fastestImgInBundle(_DomainListBundle lists) async {
    return await checkFastestImgDomain(lists.img) ??
        await checkFastestImgDomain(lists.allImg);
  }

  // ---------------------------------------------------------------------------
  // 应用 [ConfigInfo] 并写入 AppEnv + baseUrl
  // ---------------------------------------------------------------------------

  /// 依赖已写入的 [_speedLists]。
  Future<String?> _parallelSpeedTestApiAndImg({
    void Function(String)? onTip,
  }) async {
    final results = await Future.wait<String?>([
      getFastestImgDomain(onTip: onTip),
      getFastestDomain(onTip: onTip),
    ]);
    return results[1];
  }

  Future<String?> changeDomainList(
    ConfigInfo? info, {
    void Function(String)? onTip,
  }) async {
    _tip('正在检测网络...', onTip);
    _speedLists = _mergedListsFrom(info);
    _tip('正在选择最快节点...', onTip);
    return _parallelSpeedTestApiAndImg(onTip: onTip);
  }

  Future<String?> getFastestDomain({void Function(String)? onTip}) async {
    try {
      String? url;
      if (_isProd) {
        _tip('正在测速节点...', onTip);
        url = await _fastestApiInBundle(_speedLists);
      } else {
        url = AppEnvConfig.instance.apiUrl;
      }
      AppEnvConfig.instance.apiUrl = url ?? AppEnvConfig.instance.apiUrl;
      changeBaseUrl();
      _tip(url != null && url.isNotEmpty ? '线路连接成功' : '未获取到可用线路', onTip);
      return url;
    } catch (e) {
      _tip('线路连接异常: $e', onTip);
      return null;
    }
  }

  Future<String?> getFastestImgDomain({void Function(String)? onTip}) async {
    try {
      String? url;
      if (_isProd) {
        url = await _fastestImgInBundle(_speedLists);
      }
      AppEnvConfig.instance.imageUrl = url ?? AppEnvConfig.instance.imageUrl;
      return url;
    } catch (_) {
      return null;
    }
  }

  void changeBaseUrl() => http_client.HttpClient.changeBaseUrl();

  Future<String?> checkFastestDomain(List<String> domains) async {
    if (domains.isEmpty) {
      return null;
    }
    try {
      return await _raceFastestSuccess(domains.map(pingDomain).toList());
    } catch (_) {
      return null;
    }
  }

  Future<String?> checkFastestPayDomain(
      List<String> domains, String subUrl) async {
    if (domains.isEmpty) {
      return null;
    }
    try {
      return await _raceFastestSuccess(
        domains.map((d) => pingPayDomain(d, subUrl)).toList(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<String?> checkFastestImgDomain(List<String> domains) async {
    if (domains.isEmpty) {
      return null;
    }
    try {
      return await _raceFastestSuccess(domains.map(pingImgDomain).toList());
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // HTTP：配置与 ping
  // ---------------------------------------------------------------------------

  Future<ConfigInfo?> queryConfigInfoByBrotli(
    String url, {
    void Function(String)? onTip,
  }) async {
    final dio = _insecureDio(responseType: ResponseType.bytes);
    try {
      final response = await dio.get(url);
      if (response.statusCode != HttpStatus.ok) {
        _tip('配置请求失败: ${response.statusCode}', onTip);
        return null;
      }
      _tip('解析配置数据...', onTip);
      final jsonString = brotli.decodeToString(response.data);
      final parsed =
          ConfigInfo.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
      _tip('配置解析成功', onTip);
      return parsed;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('queryConfigInfo DioException: $e');
      }
    } catch (e) {
      if (kDebugMode) {
        print('queryConfigInfo: $e');
      }
    }
    await Future.delayed(_timeoutDuration);
    return null;
  }

  Future<String?> pingDomain(String domain, {bool needWait = true}) async {
    try {
      final dio = _insecureDio();
      final response = await dio.get('$domain/member/ping');
      final code = response.statusCode;
      if (code != null && code >= 200 && code < 300) {
        return domain;
      }
    } catch (e) {
      if (kDebugMode) {
        print('pingDomain $domain $e');
      }
    }
    if (needWait) {
      await Future.delayed(_timeoutDuration);
    }
    return null;
  }

  Future<String?> pingPayDomain(String domain, String subUrl,
      {bool needWait = true}) async {
    try {
      final dio = _insecureDio();
      final response = await dio.post('$domain$subUrl');
      final code = response.statusCode;
      if (code != null && code >= 200 && code < 300) {
        return domain;
      }
    } catch (e) {
      if (kDebugMode) {
        print('pingDomain $domain$subUrl $e');
      }
    }
    if (needWait) {
      await Future.delayed(_timeoutDuration);
    }
    return null;
  }

  Future<String?> pingImgDomain(String domain, {bool needWait = true}) async {
    try {
      final dio = _insecureDio();
      final response = await dio.get(
        '$domain/ads/default_app.svg',
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.notFound) {
        return domain;
      }
    } catch (e) {
      if (kDebugMode) {
        print('pingImgDomain $domain $e');
      }
    }
    if (needWait) {
      await Future.delayed(_timeoutDuration);
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // 内部工具
  // ---------------------------------------------------------------------------

  bool get _isProd => AppEnvConfig.instance.envType == EnvType.prod;

  Duration get _timeoutDuration => Duration(milliseconds: timeout);

  void _tip(String msg, void Function(String)? onTip) {
    if (kDebugMode) {
      print('[DomainManager] $msg');
    }
    onTip?.call(msg);
  }

  /// 并行竞速：谁先**成功**（非 null）谁先返回，**不等待**其它请求结束。
  ///
  /// 仅当每一个都以 null/失败结束时，才在**最后一个**结束后返回 null。
  Future<T?> _raceFastestSuccess<T>(List<Future<T?>> futures) async {
    if (futures.isEmpty) {
      return null;
    }
    final completer = Completer<T?>();
    var pendingFailureOrNull = futures.length;
    for (final f in futures) {
      f.then((v) {
        if (completer.isCompleted) {
          return;
        }
        if (v != null) {
          completer.complete(v);
          return;
        }
        pendingFailureOrNull--;
        if (pendingFailureOrNull == 0) {
          completer.complete(null);
        }
      }, onError: (_) {
        if (completer.isCompleted) {
          return;
        }
        pendingFailureOrNull--;
        if (pendingFailureOrNull == 0) {
          completer.complete(null);
        }
      });
    }
    return completer.future;
  }

  /// 测速 / 拉配置：忽略证书 + 统一超时。
  Dio _insecureDio({ResponseType? responseType}) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: _timeoutDuration,
        receiveTimeout: _timeoutDuration,
        sendTimeout: _timeoutDuration,
        responseType: responseType,
      ),
    );
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      return HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        }
        ..connectionFactory =
            (Uri uri, String? proxyHost, int? proxyPort) async {
          return DirectIpConnectionFactory.create(
            uri: uri,
            proxyHost: proxyHost,
            proxyPort: proxyPort,
            cacheGetter: (host) => _resolvedDomainIpCache[host],
            cacheSetter: (host, ip) => _resolvedDomainIpCache[host] = ip,
            enableSystemLookup: true,
          );
        };
    };
    return dio;
  }
}
