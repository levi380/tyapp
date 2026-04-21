import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:filbet/http/doh/doh_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class _AnswerCacheEntry {
  _AnswerCacheEntry(this.answer, this.expiresAt);

  final Answer answer;
  final DateTime expiresAt;
}

class DohManager {
  DohManager._();

  static final DohManager instance = DohManager._();

  static const String tencentHost = 'https://doh.pub/resolve';
  static const String aliHost = 'https://223.5.5.5/resolve';
  static const String kMemberPingPath = '/member/ping';

  final List<Uri> _providers = <Uri>[
    Uri.parse(tencentHost),
    Uri.parse(aliHost),
  ];

  final Duration _timeout = const Duration(seconds: 6);
  final Map<String, _AnswerCacheEntry> _answerCache =
      <String, _AnswerCacheEntry>{};

  late final Dio _resolveDio = Dio(
    BaseOptions(
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      sendTimeout: _timeout,
      responseType: ResponseType.plain,
    ),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

  /// 并行请求两个 DoH provider，取出所有 IPv4 后，再通过 `/member/ping` 竞速返回最快 IP。
  Future<Answer?> resolveFastestIp(String domain) async {
    final host = domain.trim();
    if (host.isEmpty) {
      return null;
    }

    final cached = _getCachedAnswer(host);
    if (cached != null) {
      return cached;
    }

    final results = await Future.wait(
      _providers.map((Uri provider) => _resolveIps(provider, host)),
    );
    final ips = _mergeIps(results);
    if (ips.isEmpty) {
      return null;
    }
    final fastest = await _raceFastestPing(host, ips);
    if (fastest == null) {
      return null;
    }
    _cacheAnswer(host, fastest);
    return fastest;
  }

  Future<List<Answer>> _resolveIps(Uri provider, String domain) async {
    try {
      final uri = provider.replace(
        queryParameters: <String, String>{
          'name': domain,
          'type': 'A',
        },
      );
      final response = await _resolveDio.getUri(uri);
      if (response.statusCode != HttpStatus.ok) {
        return <Answer>[];
      }

      return _parseIps(response.data);
    } on DioException {
      return <Answer>[];
    }
  }

  List<Answer> _parseIps(String body) {
    try {
      final decoded = jsonDecode(body);
      final model = DohModel.fromJson(decoded);
      final answers = model.answer ?? <Answer>[];
      return answers.where((Answer item) => item.type == 1).toList();
    } catch (_) {
      return <Answer>[];
    }
  }

  List<Answer> _mergeIps(List<List<Answer>> results) {
    final seen = <String>{};
    final merged = <Answer>[];
    for (final ips in results) {
      for (final ip in ips) {
        final key = ip.data?.trim() ?? '';
        if (key.isEmpty) {
          continue;
        }
        if (seen.add(key)) {
          merged.add(ip);
        }
      }
    }
    return merged;
  }

  Answer? _getCachedAnswer(String domain) {
    final hit = _answerCache[domain];
    if (hit == null) {
      return null;
    }
    if (!hit.expiresAt.isAfter(DateTime.now())) {
      _answerCache.remove(domain);
      return null;
    }
    return hit.answer;
  }

  void _cacheAnswer(String domain, Answer answer) {
    final ttlSeconds = answer.TTL?.toInt() ?? 0;
    if (ttlSeconds <= 0) {
      return;
    }
    _answerCache[domain] = _AnswerCacheEntry(
      answer,
      DateTime.now().add(Duration(seconds: ttlSeconds)),
    );
  }

  Future<Answer?> _raceFastestPing(String domain, List<Answer> ips) async {
    if (ips.isEmpty) {
      return null;
    }

    final completer = Completer<Answer?>();
    final remaining = <int>[ips.length];

    for (final ip in ips) {
      unawaited(
        _pingMember(domain, ip).then(
          (bool ok) => _settleFastestPing(
            completer,
            remaining,
            ok ? ip : null,
          ),
          onError: (_) => _settleFastestPing(completer, remaining, null),
        ),
      );
    }

    return completer.future;
  }

  void _settleFastestPing(
    Completer<Answer?> completer,
    List<int> remaining,
    Answer? ip,
  ) {
    if (completer.isCompleted) {
      return;
    }
    if (ip != null) {
      completer.complete(ip);
      return;
    }
    remaining[0]--;
    if (remaining[0] == 0) {
      completer.complete(null);
    }
  }

  Future<bool> _pingMember(String domain, Answer ip) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        sendTimeout: _timeout,
      ),
    )..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          return HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) {
              return true;
            }
            ..connectionFactory =
                (Uri uri, String? proxyHost, int? proxyPort) async {
              if (proxyHost != null && proxyPort != null) {
                return Socket.startConnect(proxyHost, proxyPort);
              }
              if (ip.data == null || ip.data!.isEmpty) {
                final fallbackPort = uri.hasPort
                    ? uri.port
                    : (uri.isScheme('https')
                        ? HttpClient.defaultHttpsPort
                        : HttpClient.defaultHttpPort);
                return Socket.startConnect(uri.host, fallbackPort);
              }

              final targetPort = uri.hasPort
                  ? uri.port
                  : (uri.isScheme('https')
                      ? HttpClient.defaultHttpsPort
                      : HttpClient.defaultHttpPort);

              if (uri.isScheme('https')) {
                final tcpTask = await Socket.startConnect(
                  InternetAddress(ip.data!),
                  targetPort,
                );
                final secureFuture = tcpTask.socket.then(
                  (Socket plain) => SecureSocket.secure(
                    plain,
                    host: domain,
                    onBadCertificate: (X509Certificate _) => true,
                  ),
                );
                return ConnectionTask.fromSocket<Socket>(
                  secureFuture,
                  tcpTask.cancel,
                );
              }
              return Socket.startConnect(InternetAddress(ip.data!), targetPort);
            };
        },
      );
    try {
      if (ip.data == null || ip.data!.isEmpty) {
        return false;
      }
      final response = await dio.getUri(
        Uri(
          scheme: 'https',
          host: domain,
          path: kMemberPingPath,
        ),
      );
      final code = response.statusCode;
      return code != null && code >= 200 && code < 300;
    } on DioException {
      return false;
    } finally {
      dio.close();
    }
  }
}
