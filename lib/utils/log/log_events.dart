/// 构造 `events` 数组中的单条事件（`timestamp` 为 Unix 秒）。
class LogEvents {
  LogEvents._();

  static Map<String, dynamic> codeError({
    required String message,
    String? stack,
    String? eventId,
    String level = 'error',
    int? timestamp,
  }) {
    return {
      'eventType': 'code_error',
      'eventId': 'e1',
      'level': level,
      'timestamp': timestamp ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000),
      'message': message,
      if (stack != null) 'stack': stack,
    };
  }

  static Map<String, dynamic> apiError({
    required String url,
    required String method,
    required int status,
    required int durationMs,
    String? eventId,
    String level = 'error',
    int? timestamp,
  }) {
    return {
      'eventType': 'api_error',
      'eventId': 'e2',
      'level': level,
      'timestamp': timestamp ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000),
      'request': {
        'url': url,
        'method': method,
      },
      'response': {
        'status': status,
        'durationMs': durationMs,
      },
    };
  }

  /// 自定义事件，需自行提供 `eventType` 等字段。
  static Map<String, dynamic> custom(Map<String, dynamic> event) => event;
}
