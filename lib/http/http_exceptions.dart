class HttpException implements Exception {
  final String? _message;

  /// 面向用户展示的文案。空或 null 时**不再**用类型名（避免 Toast 出现 "BadRequestException"），而用语义化中文。
  String get message {
    if (_message != null) {
      final t = _message!.trim();
      if (t.isNotEmpty) return t;
    }
    if (this is BadResponseException) {
      return '服务返回了无法识别内容，请稍后再试';
    }
    if (this is NetworkException) {
      return '网络异常，请稍后再试';
    }
    if (this is BadServiceException) {
      return '服务繁忙或异常，请稍后再试';
    }
    if (this is UnauthorisedException) {
      return '未授权，请重新登录';
    }
    if (this is BadRequestException) {
      return '请求未通过校验，请检查后再试';
    }
    if (this is UnknownException) {
      return '操作未成功，请稍后再试';
    }
    if (this is CancelException) {
      return '请求已取消';
    }
    return '服务暂时不可用，请稍后再试';
  }

  final int? _code;

  int get code => _code ?? -1;

  HttpException([this._message, this._code]);

  @override
  String toString() {
    // return "code:$code--message=$message";
    return message;
  }
}

/// 客户端请求错误
class BadRequestException extends HttpException {
  BadRequestException({String? message, int? code}) : super(message, code);
}

/// 服务端响应错误
class BadServiceException extends HttpException {
  BadServiceException({String? message, int? code}) : super(message, code);
}

class UnknownException extends HttpException {
  UnknownException([super.message]);
}

class CancelException extends HttpException {
  CancelException([super.message]);
}

class NetworkException extends HttpException {
  NetworkException({String? message, int? code}) : super(message, code);
}

/// 401
class UnauthorisedException extends HttpException {
  UnauthorisedException({String? message, String? code = "401"})
      : super(message);
}

class BadResponseException extends HttpException {
  dynamic data;

  BadResponseException([this.data]) : super();
}
