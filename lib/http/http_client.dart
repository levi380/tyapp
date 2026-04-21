import 'dart:convert' as json;
import 'dart:io';
import 'dart:io' as io;

import 'package:cbor/cbor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/http/direct_ip_connection_factory.dart';
import 'package:filbet/http/doh/doh_manager.dart';
import 'package:filbet/http/http_config.dart';
import 'package:filbet/http/http_parse.dart';
import 'package:filbet/http/http_response.dart' as http_response;
import 'package:filbet/http/http_transformer.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:filbet/utils/device_util.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

late final Dio dio;
final cborCodec = CborSimpleCodec();

class HttpClient {
  HttpClient._();

  /// HTTP header values only allow visible ASCII characters.
  static String _sanitizeHeaderValue(String? value,
      {String fallback = 'unknown'}) {
    final raw = (value ?? '').trim();
    if (raw.isEmpty) return fallback;
    final safe = raw.replaceAll(RegExp(r'[^\x20-\x7E]'), '');
    return safe.isEmpty ? fallback : safe;
  }

  static void init({HttpConfig? dioConfig}) async {
    dio = Dio(
      BaseOptions(
        baseUrl: dioConfig?.baseUrl ?? "",
        connectTimeout: const Duration(seconds: 10),
        // 连接超时时间
        receiveTimeout: const Duration(seconds: 10),
        // 响应超时时间
        responseType: ResponseType.bytes,
        //配置请求参数cbor序列化
        requestEncoder: (request, options) {
          if (options.data is Map) {
            return cborCodec.encode(options.data);
            // return encodeToCbor(options.data);
          }
          return options.data;
        },
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      return io.HttpClient()
        ..badCertificateCallback =
            (io.X509Certificate cert, String host, int port) {
          return true;
        }
        ..connectionFactory =
            (Uri uri, String? proxyHost, int? proxyPort) async {
          return DirectIpConnectionFactory.create(
            uri: uri,
            proxyHost: proxyHost,
            proxyPort: proxyPort,
            cacheGetter: (host) => _domainIpMap[host],
            cacheSetter: (host, ip) => _domainIpMap[host] = ip,
            enableSystemLookup: true,
          );
        };
    };

    dio.interceptors.add(_headerInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
  }

  static void changeBaseUrl() {
    try {
      dio.options.baseUrl = AppEnvConfig.instance.apiUrl;
    } catch (e) {
      debugPrint('$e');
    }
  }

  static InterceptorsWrapper _headerInterceptor() {
    return InterceptorsWrapper(
      onResponse: (response, handler) {
        // 处理响应数据
        return handler.next(decryptResponse(response));
      },
      onError: (DioException e, handler) {
        // 处理错误
        return handler.next(e);
      },
    );
  }

  // 解密
  static dynamic decryptResponse(response) {
    try {
      final decoded = cborCodec.decode(response.data!);
      response.data = decoded;
    } catch (e) {
      //解密异常
      e.toString();
    }
    return response;
  }

  static Future<Map<String, dynamic>> _commonHeader({
    required Map<String, dynamic> header,
  }) async {
    try {
      var token = SpStorage.jwtToken;

      if (token != null) {
        header['t'] = token;
      }

      final appLanguage = SpStorage.getAppLocalLanguage();
      Language languagemodel =
          appLanguage.isEmpty ? Language.zh_cn : Language.fromAbbr(appLanguage);

      final hasUserService = Get.isRegistered<UserService>();

      if (hasUserService) {
        if (UserService.to.state.isRegularUser) {
          header['currency'] = 101;
        } else {
          header['currency'] = 101;
        }
      } else {
        header['currency'] = 101;
      }

      String language = languagemodel.code;

      final deviceId = await DeviceUtil.getDeviceIdentifier();

      header['lang'] = language;

      header['d'] = Platform.isAndroid ? '26' : "27";
      header['v'] = AppEnvConfig.instance.version;
      header['did'] = deviceId;
      const String appFlavor = String.fromEnvironment('BRAND');
      header['brand'] =
          appFlavor.isNotEmpty && appFlavor != 'filbet' ? appFlavor : 'h5';
      header['User-Agent'] = _sanitizeHeaderValue(
        await DeviceUtil.getDeviceModel(),
      );
    } catch (_) {
      // LogUtil.v("Dio请求获取token失败，UserInfo还没有初始化，不需要使用，不影响");
    }
    return header;
  }

  static final Map<String, String> _domainIpMap = <String, String>{};

  static Uri? _baseUri() {
    final base = dio.options.baseUrl.trim();
    if (base.isNotEmpty) {
      try {
        return Uri.parse(base);
      } catch (_) {}
    }
    final appBase = AppEnvConfig.instance.apiUrl.trim();
    if (appBase.isNotEmpty) {
      try {
        return Uri.parse(appBase);
      } catch (_) {}
    }
    return null;
  }

  static Uri? _resolveAbsoluteUri(String uri, {Uri? baseUri}) {
    final input = uri.trim();
    if (input.isEmpty) {
      return null;
    }
    try {
      final parsed = Uri.parse(input);
      if (parsed.hasScheme && parsed.host.isNotEmpty) {
        return parsed;
      }
      if (baseUri == null) {
        return null;
      }
      return baseUri.resolveUri(parsed);
    } catch (_) {
      return null;
    }
  }

  static Future<void> _warmupDomainIpForUri(String uri) async {
    final raw = uri.trim();
    final baseUri = _baseUri();
    final absolute = _resolveAbsoluteUri(raw, baseUri: baseUri);
    if (absolute == null || absolute.host.isEmpty) {
      return;
    }

    String dohHost = absolute.host;
    try {
      final parsed = Uri.parse(raw);
      final isRelative = !(parsed.hasScheme && parsed.host.isNotEmpty);
      if (isRelative && baseUri != null && baseUri.host.isNotEmpty) {
        dohHost = baseUri.host;
      }
    } catch (_) {}

    if (dohHost.isEmpty || InternetAddress.tryParse(dohHost) != null) {
      return;
    }

    try {
      final answer = await DohManager.instance.resolveFastestIp(dohHost);
      final resolvedIp = answer?.data?.trim() ?? '';
      if (resolvedIp.isEmpty || resolvedIp == dohHost) {
        return;
      }

      _domainIpMap[dohHost] = resolvedIp;
    } catch (_) {
      return;
    }
  }

  static Future<http_response.HttpResponse> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer,
      bool showNetworkError = true}) async {
    try {
      var headers = await _commonHeader(header: {});
      await _warmupDomainIpForUri(uri);

      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return handleResponse(response, httpTransformer: httpTransformer);
    } catch (e) {
      debugPrint("object123456 e=$e");
      if (e is DioException) {
        return handleDioException(
          e,
          httpTransformer: httpTransformer,
        );
      }

      return handleException(
        e,
        httpTransformer: httpTransformer,
      );
    }
  }

  static Future<http_response.HttpResponse> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer,
      bool showNetworkError = true}) async {
    try {
      // 检查网络连接状态，特别是处理代理开启但WIFI关闭的情况
      // bool isConnected =
      //     await NetworkCheckUtil.instance.checkNetworkConnection();
      // if (!isConnected) {
      //   // 如果网络连接异常，显示提示并抛出NetworkException
      //   if (showNetworkError) {
      //     NetworkCheckUtil.instance.showNetworkErrorDialog();
      //   }
      //   throw NetworkException(message: "networkError".tr);
      // }

      var headers = await _commonHeader(header: {});
      await _warmupDomainIpForUri(uri);

      // 请求options判断
      if (options != null) {
        options.headers = headers;
      } else {
        options = Options(headers: headers);
      }

      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return handleResponse(response, httpTransformer: httpTransformer);
    } catch (e) {
      if (e is DioException) {
        return handleDioException(
          e,
          httpTransformer: httpTransformer,
        );
      }

      return handleException(
        e,
        httpTransformer: httpTransformer,
      );
    }
  }

  static String jsondata(data) {
    String saveTemp = json.jsonEncode(data);
    return saveTemp;
  }

  static Future<String?> downloadImage(
    String url,
    String savePath,
  ) async {
    try {
      var headers = await _commonHeader(header: {});
      await _warmupDomainIpForUri(url);
      await dio.download(
        url,
        savePath,
        options: Options(headers: headers),
      );
      return savePath;
    } catch (_) {
      return null;
    }
  }

  /// 创建
  static CancelToken? createCancelToken(String context, String url) {
    CancelToken? cancelToken;
    cancelToken = CancelToken();
    String key = '${context.hashCode}_$url';
    _cancelTokens[key] = cancelToken;
    return cancelToken;
  }

  ///主动取消请求，如页面销毁
  static void cancelRequest(String context) {
    _cancelTokens.removeWhere((key, value) {
      if (key.startsWith("${context.hashCode}_") &&
          !_cancelTokens[key]!.isCancelled) {
        _cancelTokens[key]?.cancel();
      }
      return key.startsWith("${context.hashCode}_");
    });
  }

  /// 移除结束的CancelToken
  static void removeCancel(CancelToken cancelToken) {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
    _cancelTokens.removeWhere((_, value) => identical(value, cancelToken));
  }

  static final Map<String, CancelToken> _cancelTokens = <String, CancelToken>{};

  static int currentTime() {
    DateTime currentTime = DateTime.now();
    int timestamp = currentTime.millisecondsSinceEpoch;
    return timestamp;
  }
}
