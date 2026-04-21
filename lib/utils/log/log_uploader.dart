import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:filbet/constants/log.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:filbet/utils/device_util.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// 客户端日志上传：`type` 为应用名（[PackageInfo.appName]），组装 envelope 后 `POST` JSON。
class LogUploader {
  LogUploader._();

  static const String kSchemaVersion = '1.0';

  /// 日志服务根地址（不含末尾 `/`）
  static const String kLogBaseUrl = 'https://waoah.com';

  /// 日志上报路径（与 [kLogBaseUrl] 拼接）
  static const String kLogUploadPath = '/frontend/logs';

  static const Duration _defaultTimeout = Duration(seconds: 15);

  static Dio? _dio;

  /// 日志专用 [Dio]（单例，忽略证书校验）。
  static Dio get dio {
    return _dio ??= _createDio();
  }

  static Dio _createDio() {
    final d = Dio(
      BaseOptions(
        baseUrl: kLogBaseUrl,
        connectTimeout: _defaultTimeout,
        receiveTimeout: _defaultTimeout,
        responseType: ResponseType.json,
        validateStatus: (s) => s != null && s >= 200 && s < 300,
      ),
    );
    if (kDebugMode) {
      d.interceptors.add(PrettyDioLogger(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }
    d.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
    return d;
  }

  static String _envString() {
    switch (AppEnvConfig.instance.envType) {
      case EnvType.prod:
        return 'prod';
      case EnvType.uat:
        return 'uat';
      case EnvType.fat:
        return 'fat';
      case EnvType.dev:
        return 'dev';
    }
  }

  static Future<String> _userAgent() async {
    try {
      final os = await DeviceUtil.getSystemVersion();
      final model = await DeviceUtil.getDeviceModel();
      return '$model; $os';
    } catch (_) {
      return 'unknown';
    }
  }

  static Future<Map<String, dynamic>> buildPayload({
    required List<Map<String, dynamic>> events,
  }) async {
    final pkg = await PackageInfo.fromPlatform();
    final ua = await _userAgent();
    final did = await DeviceUtil.getDeviceIdentifier();

    var username = '';
    var userId = '';
    if (Get.isRegistered<UserService>()) {
      final s = UserService.to.state;
      username = s.nicknamelabel;
      userId = s.uid;
    }

    return {
      'type': pkg.appName,
      'schemaVersion': kSchemaVersion,
      'app': {
        'name': pkg.appName,
        'env': _envString(),
        'version': pkg.version,
      },
      'device': {
        'userAgent': ua,
      },
      'user': {
        'username': username,
        'userId': userId,
        'anonymousId': did,
        'ip': Log.ip,
        'address': Log.address,
      },
      'events': events,
    };
  }

  /// 上报日志（请求 [kLogBaseUrl] + [kLogUploadPath]）。
  ///
  /// 返回 `true` 表示 HTTP 2xx。
  static Future<bool> upload(
    List<Map<String, dynamic>> events, {
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) async {
    if (events.isEmpty) {
      if (kDebugMode) {
        debugPrint('[SpLogUploader] skip: empty events');
      }
      return false;
    }
    final payload = await buildPayload(events: events);
    final body = jsonEncode(payload);
    try {
      final res = await dio.post<String>(
        kLogUploadPath,
        data: body,
      );
      return res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300;
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[SpLogUploader] failed: $e\n$st');
      }
      return false;
    }
  }
}
