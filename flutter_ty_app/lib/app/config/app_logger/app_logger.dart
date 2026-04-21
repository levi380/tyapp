import 'dart:convert';
import 'package:flutter/foundation.dart';


/// 项目级日志工具
///
/// 设计目标：
/// 1. Debug 可用，Release 不输出
/// 2. 防止大对象 / 高频 log 卡断点
/// 3. 统一入口，方便后期治理
///
class AppLogger {
  AppLogger._();

  /// 是否开启日志（Debug / Profile 可开）
  static bool enableLog = kDebugMode;

  /// 单条日志最大长度（防止 IDE 卡死）
  static const int _maxLength = 800;

  /// 普通日志
  static void debug(
      String message, {
        String? tag,
      }) {
    if (!enableLog) return;
    _print('DEBUG', message, tag);
  }

  /// 警告日志
  static void warn(
      String message, {
        String? tag,
      }) {
    if (!enableLog) return;
    _print('WARN', message, tag);
  }

  /// 错误日志（推荐 catch 用）
  static void error(
      Object error, {
        StackTrace? stackTrace,
        String? tag,
      }) {
    if (!enableLog) return;

    final msg = StringBuffer()
      ..writeln(error.toString());

    if (stackTrace != null) {
      msg.writeln(stackTrace.toString());
    }

    _print('ERROR', msg.toString(), tag);
  }

  /// 安全打印对象（Map / List / Entity）
  static void json(
      Object? data, {
        String? tag,
      }) {
    if (!enableLog) return;
    if (data == null) {
      _print('JSON', 'null', tag);
      return;
    }

    try {
      final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
      _print('JSON', jsonStr, tag);
    } catch (e) {
      _print('JSON', data.toString(), tag);
    }
  }

  /// 内部统一输出
  static void _print(String level, String msg, String? tag) {
    final prefix =
        '[${DateTime.now().toIso8601String()}][$level]${tag != null ? '[$tag]' : ''} ';

    /// 超长裁剪，防止 IDE 卡死
    if (msg.length > _maxLength) {
      msg = msg.substring(0, _maxLength) + '...<truncated>';
    }

    debugPrint(prefix + msg, wrapWidth: 1024);
  }
}
