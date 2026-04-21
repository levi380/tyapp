// ignore_for_file: unused_element
import 'dart:convert';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:filbet/http/default_http_transformer.dart';
import 'package:filbet/http/http_exceptions.dart';
import 'package:filbet/http/http_response.dart';
import 'package:filbet/http/http_transformer.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:get/get.dart' hide Response;

/// 统一入口：有 HTTP 响应时走 [handleResponse]；无响应（超时、断网等）时走 Dio 异常映射。
HttpResponse handleDioException(
  DioException exception, {
  HttpTransformer? httpTransformer,
}) {
  final resp = exception.response;
  if (resp != null) {
    return handleResponse(resp, httpTransformer: httpTransformer);
  }
  return HttpResponse.failureFromError(_dioExceptionToHttpException(exception));
}

HttpResponse handleResponse(
  Response? response, {
  HttpTransformer? httpTransformer,
}) {
  httpTransformer ??= DefaultHttpTransformer.getInstance();

  if (response == null) {
    return HttpResponse.failureFromError(
      NetworkException(message: '网络请求失败，请检查网络后重试'),
    );
  }

  if (_isRequestSuccess(response.statusCode)) {
    try {
      final hresponse = httpTransformer.parse(response);
      if (hresponse.status == false && hresponse.error?.message == 'token') {
        UserService.to.logout();
        if (Get.currentRoute == Routes.SPLASH) {
          // TODO: route?
        } else {
          AppNavigator.gotohome();
        }
      }
      return hresponse;
    } catch (e) {
      return HttpResponse.failureFromError(
        UnknownException(_parseThrowableMessage(e)),
      );
    }
  }

  final failure = _extractHttpLayerFailure(response);
  return HttpResponse.failure(
    errorMsg: failure.message,
    errorCode: failure.code,
  );
}

/// 将业务 / 通用 `code` 字段安全转为 int，避免 [int.parse] 抛错导致二次异常。
int coverCodeToErrorCode(dynamic code) {
  if (code == null) return -1;
  if (code is int) return code;
  if (code is String) {
    final t = code.trim();
    if (t.isEmpty) return -1;
    return int.tryParse(t) ?? -1;
  }
  return -1;
}

HttpResponse handleException(
  Object exception, {
  HttpTransformer? httpTransformer,
}) {
  if (exception is DioException) {
    // 与 [handleDioException] 一致：有响应体时走 HTTP 层解析（含非 2xx 的 JSON/HTML 安全处理）
    return handleDioException(
      exception,
      httpTransformer: httpTransformer,
    );
  }
  if (exception is HttpException) {
    return HttpResponse.failureFromError(exception);
  }
  if (exception is Exception) {
    return HttpResponse.failureFromError(
      UnknownException(_parseThrowableMessage(exception)),
    );
  }
  // 不将 Object.toString() 当作用户可见文案，避免技术堆栈/类型名
  return HttpResponse.failureFromError(UnknownException());
}

Future<void> changePublicKey() async {}

/// 请求成功：2xx
bool _isRequestSuccess(int? statusCode) {
  return statusCode != null && statusCode >= 200 && statusCode < 300;
}

class _HttpLayerFailure {
  const _HttpLayerFailure({required this.message, required this.code});

  final String message;
  final int code;
}

_HttpLayerFailure _extractHttpLayerFailure(Response response) {
  final statusCode = response.statusCode;
  final fromBody = _extractErrorPayload(response.data);
  final msg = _nonEmpty([
        fromBody.message,
        response.statusMessage,
        _defaultMessageForStatusCode(statusCode),
      ]) ??
      '请求失败';
  final parsedCode = coverCodeToErrorCode(fromBody.code);
  final code =
      parsedCode != -1 ? parsedCode : (statusCode ?? -1);
  return _HttpLayerFailure(message: msg, code: code);
}

/// 从 Dio 响应体中尽量解析出服务端文案与业务 code（兼容 Map / JSON 字符串 / 其它）。
({String? message, dynamic code}) _extractErrorPayload(dynamic data) {
  final map = _tryCoerceToStringKeyMap(data);
  if (map == null) {
    return (message: null, code: null);
  }
  final message = _messageFromErrorMap(map);
  final code = map['code'] ?? map['statusCode'] ?? map['error_code'];
  return (message: message, code: code);
}

Map<String, dynamic>? _tryCoerceToStringKeyMap(dynamic data) {
  if (data == null) return null;
  if (data is Map<String, dynamic>) return data;
  if (data is Map) {
    try {
      return data.map((k, v) => MapEntry(k.toString(), v));
    } catch (_) {
      return null;
    }
  }
  if (data is List<int>) {
    try {
      final text = utf8.decode(data, allowMalformed: true).trim();
      if (text.isEmpty) return null;
      return _tryCoerceToStringKeyMap(text);
    } catch (_) {
      return null;
    }
  }
  if (data is String) {
    final s = data.trim();
    if (s.isEmpty) return null;
    try {
      final decoded = jsonDecode(s);
      return _tryCoerceToStringKeyMap(decoded);
    } catch (_) {
      return null;
    }
  }
  return null;
}

String? _messageFromErrorMap(Map<String, dynamic> map) {
  for (final key in const [
    'message',
    'msg',
    'error',
    'detail',
    'error_description',
    'reason',
    'errorMessage',
    'errors',
  ]) {
    final v = map[key];
    if (v == null) continue;
    if (v is String && v.trim().isNotEmpty) return v.trim();
    if (v is num) return v.toString();
    if (v is List) {
      final parts = v
          .map((e) {
            if (e is String) return e.trim();
            if (e is Map) {
              return _messageFromErrorMap(
                e.map((k, dynamic x) => MapEntry(k.toString(), x)),
              );
            }
            return e?.toString();
          })
          .whereType<String>()
          .where((s) => s.isNotEmpty)
          .toList();
      if (parts.isNotEmpty) return parts.join('；');
    }
    if (v is Map) {
      final nested = _messageFromErrorMap(
        v.map((k, dynamic e) => MapEntry(k.toString(), e)),
      );
      if (nested != null) return nested;
    }
  }
  return null;
}

String? _nonEmpty(List<String?> candidates) {
  for (final c in candidates) {
    if (c != null && c.trim().isNotEmpty) return c.trim();
  }
  return null;
}

String _defaultMessageForStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return '请求无效';
    case 401:
      return '未授权，请重新登录';
    case 403:
      return '服务器拒绝执行';
    case 404:
      return '资源不存在';
    case 405:
      return '请求方法不被允许';
    case 408:
      return '请求超时';
    case 409:
      return '请求冲突';
    case 413:
      return '请求体过大';
    case 415:
      return '不支持的媒体类型';
    case 422:
      return '请求参数无法处理';
    case 429:
      return '请求过于频繁，请稍后再试';
    case 500:
      return '服务器内部错误';
    case 502:
      return '网关错误';
    case 503:
      return '服务暂时不可用';
    case 504:
      return '网关超时';
    default:
      if (statusCode == null) return '请求失败';
      return '请求失败（HTTP $statusCode）';
  }
}

String _parseThrowableMessage(Object e) {
  if (e is FormatException) {
    return '响应数据格式错误';
  }
  if (e is TypeError) {
    return '响应数据与客户端解析不匹配';
  }
  return e.toString();
}

HttpException _dioExceptionToHttpException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return NetworkException(
        message: error.message ?? '连接服务器超时，请检查网络后重试',
      );
    case DioExceptionType.sendTimeout:
      return NetworkException(
        message: error.message ?? '发送数据超时，请稍后重试',
      );
    case DioExceptionType.receiveTimeout:
      return NetworkException(
        message: error.message ?? '接收数据超时，请稍后重试',
      );
    case DioExceptionType.badCertificate:
      return NetworkException(
        message: '安全证书校验失败，请检查网络环境',
      );
    case DioExceptionType.connectionError:
      return _mapConnectionError(error);
    case DioExceptionType.cancel:
      return CancelException(error.message ?? '请求已取消');
    case DioExceptionType.badResponse:
      return _mapBadResponse(error);
    case DioExceptionType.unknown:
      return _mapUnknownDioError(error);
  }
}

HttpException _mapConnectionError(DioException error) {
  final underlying = error.error;
  if (underlying is io.SocketException) {
    return NetworkException(
      message: '网络连接失败：${underlying.message}',
    );
  }
  if (underlying is io.HandshakeException) {
    return NetworkException(
      message: '安全握手失败：${underlying.message}',
    );
  }
  if (underlying is io.HttpException) {
    return NetworkException(message: underlying.message);
  }
  return NetworkException(
    message: error.message ?? '网络连接异常，请稍后重试',
  );
}

HttpException _mapUnknownDioError(DioException error) {
  final underlying = error.error;
  if (underlying is io.SocketException) {
    return NetworkException(
      message: '网络异常：${underlying.message}',
    );
  }
  if (underlying is io.HttpException) {
    return NetworkException(message: underlying.message);
  }
  final msg = error.message;
  if (msg != null && msg.trim().isNotEmpty) {
    return UnknownException(msg);
  }
  return UnknownException(underlying?.toString() ?? '未知错误');
}

HttpException _mapBadResponse(DioException error) {
  final resp = error.response;
  final statusCode = resp?.statusCode;
  final fromBody = resp != null ? _extractErrorPayload(resp.data) : (message: null, code: null);
  final serverMsg = fromBody.message;
  final fallback = error.message;

  HttpException withMessage(String primary, [String? secondary]) {
    final text = _nonEmpty([serverMsg, primary, secondary]) ?? '请求失败';
    return _httpExceptionForStatusCode(statusCode, text);
  }

  switch (statusCode) {
    case 400:
      return withMessage('请求语法错误');
    case 401:
      return UnauthorisedException(
        message: _nonEmpty([serverMsg, '没有权限']) ?? '没有权限',
        code: statusCode?.toString() ?? '401',
      );
    case 403:
      return withMessage('服务器拒绝执行');
    case 404:
      return withMessage('无法连接服务器或资源不存在');
    case 405:
      return withMessage('请求方法被禁止');
    case 408:
      return withMessage('请求超时');
    case 409:
      return withMessage('请求冲突');
    case 413:
      return withMessage('请求体过大');
    case 415:
      return withMessage('不支持的媒体类型');
    case 422:
      return withMessage('请求参数无法处理');
    case 429:
      return withMessage('请求过于频繁，请稍后再试');
    case 500:
      return BadServiceException(
        message: _nonEmpty([serverMsg, '服务器内部错误']) ?? '服务器内部错误',
        code: statusCode,
      );
    case 502:
      return BadServiceException(
        message: _nonEmpty([serverMsg, '无效的请求']) ?? '无效的请求',
        code: statusCode,
      );
    case 503:
      return BadServiceException(
        message: _nonEmpty([serverMsg, '服务暂时不可用']) ?? '服务暂时不可用',
        code: statusCode,
      );
    case 504:
      return BadServiceException(
        message: _nonEmpty([serverMsg, '网关超时']) ?? '网关超时',
        code: statusCode,
      );
    case 505:
      return UnauthorisedException(
        message: _nonEmpty([serverMsg, '不支持该 HTTP 协议版本']) ??
            '不支持该 HTTP 协议版本',
        code: statusCode?.toString() ?? '505',
      );
    default:
      if (statusCode != null && statusCode >= 500) {
        return BadServiceException(
          message: _nonEmpty([serverMsg, fallback, '服务器错误']) ?? '服务器错误',
          code: statusCode,
        );
      }
      if (statusCode != null && statusCode >= 400) {
        return BadRequestException(
          message: _nonEmpty([
                serverMsg,
                fallback,
                _defaultMessageForStatusCode(statusCode),
              ]) ??
              '请求失败',
          code: statusCode,
        );
      }
      return UnknownException(
        _nonEmpty([serverMsg, fallback]) ?? '未知错误',
      );
  }
}

HttpException _httpExceptionForStatusCode(int? statusCode, String message) {
  if (statusCode != null && statusCode >= 500) {
    return BadServiceException(message: message, code: statusCode);
  }
  if (statusCode != null && statusCode >= 400) {
    return BadRequestException(message: message, code: statusCode);
  }
  return UnknownException(message);
}
