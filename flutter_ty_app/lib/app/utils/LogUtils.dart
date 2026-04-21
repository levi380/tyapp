import 'dart:developer' as developer;

import '../modules/login/login_head_import.dart';

class LogUtils {
  /// 开发环境下的日志输出级别
  static const _kDevLogLevel = LogLevel.verbose;

  /// 生产环境下的日志输出级别
  static const _kProdLogLevel = LogLevel.warning;

  /// 当前的日志输出级别
  static LogLevel _currentLogLevel = kDebugMode ? _kDevLogLevel : _kProdLogLevel;

  /// 设置当前的日志输出级别
  static set logLevel(LogLevel level) {
    _currentLogLevel = level;
  }

  /// 获取当前的日志输出级别
  static LogLevel get logLevel => _currentLogLevel;

  /// 输出 Verbose 级别的日志
  static void v(String tag, String message) {
    _log(LogLevel.verbose, tag, message);
  }

  /// 输出 Debug 级别的日志
  static void d(String tag, String message) {
    _log(LogLevel.debug, tag, message);
  }

  /// 输出 Info 级别的日志
  static void i(String tag, String message) {
    _log(LogLevel.info, tag, message);
  }

  /// 输出 Warning 级别的日志
  static void w(String tag, String message) {
    _log(LogLevel.warning, tag, message);
  }

  /// 输出 Error 级别的日志
  static void e(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, tag, message, error, stackTrace);
  }

  /// 输出日志的内部实现
  static void _log(LogLevel level, String tag, String message, [Object? error, StackTrace? stackTrace]) {
    if (_currentLogLevel == level) {
      switch (level) {
        case LogLevel.verbose:
          developer.log(message, name: tag, level: 0);
          break;
        case LogLevel.debug:
          developer.log(message, name: tag, level: 2);
          break;
        case LogLevel.info:
          developer.log(message, name: tag, level: 4);
          break;
        case LogLevel.warning:
          developer.log(message, name: tag, level: 6);
          break;
        case LogLevel.error:
          developer.log(message, name: tag, level: 8, error: error, stackTrace: stackTrace);
          break;
      }
    }
  }
}

/// 日志输出级别
enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
}
