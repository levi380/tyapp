import 'dart:async';

import 'package:dio/dio.dart';

import 'cache_store.dart';
import 'swr_config.dart';
import 'swr_log.dart';

/// 可取消的请求函数
typedef SwrFetcher<T> = Future<T> Function(CancelToken cancelToken);

class _InFlight<T> {
  final Future<T> future;
  final CancelToken token;
  _InFlight(this.future, this.token);
}

class SwrManager {
  final SwrOptions defaultOptions;
  final ICacheStore cache;

  SwrManager({
    required this.defaultOptions,
    required this.cache,
  });

  final Map<String, _InFlight> _inflight = {};

  String _k(String box, String key) => '$box::$key';

  /// 读取缓存并返回 T（通过 fromRaw 解码）
  Future<T?> getCache<T>(
    String box,
    String key, {
    required T Function(dynamic raw) fromRaw,
  }) async {
    final e = await cache.get(box, key);
    if (e == null) {
      swrLog('未命中缓存：$box/$key', emoji: '🔎');
      return null;
    }
    swrLog('命中缓存：$box/$key ts=${e.tsMs}');
    try {
      return fromRaw(e.raw);
    } catch (err) {
      swrWarn('缓存解码失败，忽略该条：$box/$key');
      return null;
    }
  }

  /// 写入缓存（通过 toRaw 编码）
  Future<void> setCache<T>(
    String box,
    String key,
    T data, {
    required dynamic Function(T data) toRaw,
  }) async {
    final raw = toRaw(data);
    final entry = CacheEntry(raw, DateTime.now().millisecondsSinceEpoch);
    await cache.set(box, key, entry);
  }

  /// 是否过期（仅看 L2 ts；按需可改）
  Future<bool> isExpired(
    String box,
    String key,
    Duration? ttl,
  ) async {
    if (ttl == null) return false;
    final e = await cache.get(box, key);
    if (e == null) return true;
    final now = DateTime.now().millisecondsSinceEpoch;
    return now - e.tsMs > ttl.inMilliseconds;
  }

  Future<void> invalidate(String box, String key) async {
    await cache.remove(box, key);
  }

  // —— 去重 + 取消 —— //

  Future<T> dedup<T>(
    String box,
    String key,
    SwrFetcher<T> fetcher, {
    bool forceNew = false,
  }) {
    final k = _k(box, key);
    final cur = _inflight[k];

    if (cur != null && !forceNew) {
      swrLog('加入在途请求（去重）：$k');
      return cur.future.then((v) => v as T);
    }

    if (cur != null && forceNew) {
      swrLog('取消在途请求（forceNew）：$k');
      cur.token.cancel('forceNew');
      _inflight.remove(k);
    }

    final token = CancelToken();
    final fut = fetcher(token);
    _inflight[k] = _InFlight<T>(fut, token);

    return fut.whenComplete(() {
      final still = _inflight[k];
      if (identical(still?.future, fut)) {
        _inflight.remove(k);
      }
    });
  }

  // bool _isCancelled(Object err) {
  //   if (err is DioException) {
  //     return err.type == DioExceptionType.cancel; // Dio 4
  //   }
  //   if (err is DioException) {
  //     return err.type == DioExceptionType.cancel; // Dio 5
  //   }
  //   return false;
  // }

  Future<T?> _safeReadCache<T>(
    Future<T?> Function() reader,
    String box,
    String key,
  ) async {
    try {
      final fb = await reader();
      if (fb != null) {
        swrLog('使用缓存兜底：$box/$key', emoji: '⚓');
      } else {
        swrLog('缓存兜底为空：$box/$key', emoji: '🫙');
      }
      return fb;
    } catch (e) {
      swrWarn('缓存兜底读取失败：$box/$key');
      return null;
    }
  }

  /// 主动取消某资源在途请求
  void cancelInflight(String box, String key) {
    final k = _k(box, key);
    final cur = _inflight[k];
    if (cur != null) {
      swrLog('手动取消在途请求：$k');
      cur.token.cancel('manual-cancel');
      _inflight.remove(k);
    }
  }
}
