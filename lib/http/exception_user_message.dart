import 'dart:async';
import 'dart:io' as io;

import 'package:filbet/http/http_exceptions.dart';

/// 将任意 [error] 转为可展示给用户的短句；[HttpException] 使用其友好 [HttpException.message]（不会露出类型名）。
String exceptionMessageForUser(Object? e) {
  if (e == null) {
    return '网络异常，请稍后再试';
  }
  if (e is HttpException) {
    return e.message;
  }
  if (e is String) {
    final t = e.trim();
    if (t.isNotEmpty) {
      return t;
    }
  }
  if (e is FormatException) {
    return '数据格式异常，请稍后再试';
  }
  if (e is TypeError) {
    return '数据与预期不一致，请稍后再试';
  }
  if (e is StateError) {
    return '当前状态无法完成该操作，请稍后再试';
  }
  if (e is TimeoutException) {
    return '请求超时，请检查网络后重试';
  }
  if (e is io.SocketException) {
    return '网络连接异常，请检查网络后重试';
  }
  if (e is io.HttpException) {
    return e.message;
  }
  if (e is Exception) {
    return '操作未成功，请稍后再试';
  }
  if (e is Error) {
    return '系统繁忙，请稍后再试';
  }
  return '操作未成功，请稍后再试';
}

/// [text] 为空、null 或仅空白时使用 [defaultMessage]（用于接口 message 为空的兜底）。
String nonEmptyMessageOr(
  String? text, {
  String defaultMessage = '操作未成功，请重试',
}) {
  if (text == null) {
    return defaultMessage;
  }
  final t = text.trim();
  if (t.isEmpty) {
    return defaultMessage;
  }
  return t;
}
