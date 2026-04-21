
import 'dart:async';
import 'dart:math';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:get/get.dart';

extension SafeUpdateExtensions on GetxController {
  /// 安全刷新，防止页面销毁后数据请求返回后刷新界面
  void safeUpdate([List<Object>? ids, bool condition = true]) {
    if (isClosed) {
      AppLogger.debug("页面销毁 刷新取消");
      return;
    }
    update(ids, condition);
  }
}

/// 安全执行工具类：把常用的 try/catch、超时、重试等统一封装，减少业务层样板代码
class SafeRun {
  /// 同步执行：异常时返回 fallback（可选上报）
  static T? sync<T>(
    T Function() action, {
    T? fallback,
    bool logError = false,
    String? logTag,
  }) {
    try {
      return action();
    } catch (e, s) {
      if (logError) {
        AppLogger.debug('${logTag ?? 'SafeRun.sync'} error: $e\n$s');
      }
      return fallback;
    }
  }

  /// 异步执行：异常时返回 fallback（可选上报）
  static Future<T?> async<T>(
    Future<T> Function() action, {
    T? fallback,
    bool logError = false,
    String? logTag,
  }) async {
    try {
      return await action();
    } catch (e, s) {
      if (logError) {
        AppLogger.debug('${logTag ?? 'SafeRun.async'} error: $e\n$s');
      }
      return fallback;
    }
  }

  /// 超时控制：超时后抛 TimeoutException 或返回 onTimeout
  static Future<T> withTimeout<T>(
    Future<T> future,
    Duration timeout, {
    T Function()? onTimeout,
  }) {
    return future.timeout(timeout, onTimeout: onTimeout);
  }

  /// 忽略 Future 错误：避免未 await 的 Future 触发控制台红字
  static void ignore(Future<void> future, {bool logError = false, String? logTag}) {
    future.catchError((e, s) {
      if (logError) {
        AppLogger.debug('${logTag ?? 'SafeRun.ignore'} error: $e\n$s');
      }
    });
  }

  /// 重试：按策略执行，满足 shouldRetry 才会继续
  static Future<T> retry<T>(
    Future<T> Function(int attempt) action, {
    RetryPolicy policy = const RetryPolicy(),
  }) async {
    Object? lastError;
    StackTrace? lastStack;

    for (int attempt = 1; attempt <= policy.maxAttempts; attempt++) {
      try {
        final fut = action(attempt);
        if (policy.perAttemptTimeout == null) {
          return await fut;
        }
        return await withTimeout(fut, policy.perAttemptTimeout!);
      } catch (e, s) {
        lastError = e;
        lastStack = s;

        final should = policy.shouldRetry(e, attempt);
        if (!should || attempt >= policy.maxAttempts) {
          if (policy.logError) {
            AppLogger.debug('${policy.logTag ?? 'SafeRun.retry'} give up: $e\n$s');
          }
          break;
        }

        final delay = policy.delayForAttempt(attempt);
        if (delay > Duration.zero) {
          await Future.delayed(delay);
        }
      }
    }

    Error.throwWithStackTrace(lastError ?? Exception('retry failed'), lastStack ?? StackTrace.current);
  }
}

/// 重试策略：次数、延迟、抖动、是否重试等配置
class RetryPolicy {
  const RetryPolicy({
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 200),
    this.maxDelay = const Duration(seconds: 3),
    this.jitterRatio = 0.2,
    this.backoff = BackoffStrategy.exponential,
    this.perAttemptTimeout,
    this.logError = false,
    this.logTag,
    this.shouldRetry = RetryPolicy._defaultShouldRetry,
  });

  /// 最大尝试次数（包含首次）
  final int maxAttempts;

  /// 基础延迟（第 2 次开始才会等待）
  final Duration baseDelay;

  /// 最大延迟（防止指数退避过大）
  final Duration maxDelay;

  /// 抖动比例：0.2 表示在 [-20%, +20%] 范围随机浮动
  final double jitterRatio;

  /// 退避策略
  final BackoffStrategy backoff;

  /// 每次尝试的超时（不设置则不超时）
  final Duration? perAttemptTimeout;

  /// 是否打印错误日志（默认关闭，避免污染日志）
  final bool logError;

  /// 日志 tag
  final String? logTag;

  /// 是否继续重试
  final bool Function(Object error, int attempt) shouldRetry;

  Duration delayForAttempt(int attempt) {
    if (attempt <= 1) return Duration.zero;

    Duration raw;
    switch (backoff) {
      case BackoffStrategy.fixed:
        raw = baseDelay;
        break;
      case BackoffStrategy.linear:
        raw = Duration(milliseconds: baseDelay.inMilliseconds * (attempt - 1));
        break;
      case BackoffStrategy.exponential:
        final factor = 1 << (attempt - 2);
        raw = Duration(milliseconds: baseDelay.inMilliseconds * factor);
        break;
    }

    final capped = raw > maxDelay ? maxDelay : raw;
    return _applyJitter(capped, jitterRatio);
  }

  static bool _defaultShouldRetry(Object error, int attempt) {
    if (error is TimeoutException) return true;
    if (error is FormatException) return false;
    return true;
  }

  static Duration _applyJitter(Duration d, double ratio) {
    if (ratio <= 0) return d;
    final rnd = Random();
    final delta = (rnd.nextDouble() * 2 - 1) * ratio;
    final ms = d.inMilliseconds;
    final withJitter = (ms * (1 + delta)).round();
    return Duration(milliseconds: withJitter.clamp(0, ms * 10));
  }
}

enum BackoffStrategy { fixed, linear, exponential }
