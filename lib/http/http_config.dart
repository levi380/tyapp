import 'package:dio/dio.dart';

/// dio 配置项
class HttpConfig {
  final String? baseUrl;
  final String? proxy;
  final String? cookiesPath;
  final List<Interceptor>? interceptors;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;
  final Map<String, dynamic>? headers;

  HttpConfig({
    this.baseUrl,
    this.headers,
    this.proxy,
    this.cookiesPath,
    this.interceptors,
    this.connectTimeout = 30000 * 5,
    this.sendTimeout = Duration.millisecondsPerMinute,
    this.receiveTimeout = 30000 * 5,
  });

// static DioConfig of() => Get.find<DioConfig>();
}
