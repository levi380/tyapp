import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'swr_config.dart';
import 'swr_log.dart';
import 'swr_manager.dart';

typedef FromRaw<T> = T Function(dynamic raw);
typedef ToRaw<T> = dynamic Function(T data);

enum SwrStatus { idle, loading, success, error }

class SwrState<T> {
  final SwrStatus status;
  final T? data;
  final String? error;

  const SwrState({
    this.status = SwrStatus.idle,
    this.data,
    this.error,
  });

  bool get isLoading => status == SwrStatus.loading;
  bool get hasError => status == SwrStatus.error;
  bool get hasData => data != null;
}

class RefreshCoordinator<T> with WidgetsBindingObserver {
  final SwrManager swr;

  T? _lastGood;

  final String box;
  final String key;
  final SwrFetcher<T> fetcher;
  final SwrOptions options;
  final FromRaw<T> fromRaw;
  final ToRaw<T> toRaw;
  final Function(T data)? onSuccess;

  /// 暴露到 UI
  final Rx<T?> data = Rx<T?>(null);
  final RxBool loading = false.obs;
  final RxString error = ''.obs;

  Stream<SwrState<T>> get stream {
    // Manually combine streams to avoid Rx.combineLatest dependency issues
    return Stream<SwrState<T>>.multi((controller) {
      void update() {
        final d = data.value;
        final l = loading.value;
        final e = error.value;
        SwrStatus s = SwrStatus.idle;
        if (l) {
          s = SwrStatus.loading;
        } else if (e.isNotEmpty) {
          s = SwrStatus.error;
        } else if (d != null) {
          s = SwrStatus.success;
        }
        if (!controller.isClosed) {
          controller.add(SwrState<T>(status: s, data: d, error: e.isEmpty ? null : e));
        }
      }

      // Initial emit
      update();

      final sub1 = data.listen((_) => update());
      final sub2 = loading.listen((_) => update());
      final sub3 = error.listen((_) => update());

      controller.onCancel = () {
        sub1.cancel();
        sub2.cancel();
        sub3.cancel();
      };
    });
  }

  Timer? _poller;
  bool _disposed = false;

  int _commitGate = 0;
  bool _didEmitCacheOnPoll = false;
  bool _isForeground = true;

  /// 防止轮询 tick 重叠
  bool _tickBusy = false;

  /// ===== 合并去抖：新增状态 =====
  Timer? _revalCoalesceTimer;
  final List<Completer<void>> _revalWaiters = <Completer<void>>[];
  /// 合并窗口内是否出现过 cancelInflight
  bool _coalesceNeedCancel = false;
  /// 合并周期内（第一次需要 cancel 时）记录 gate 快照
  int? _coalesceGate;
  /// 合并后的“最后一次”source
  String? _coalesceSource;

  // 默认合并窗口（可按需调整）
  static const Duration _defaultCoalesceWindow = Duration(milliseconds: 120);

  RefreshCoordinator({
    required this.swr,
    required this.box,
    required this.key,
    required this.fetcher,
    required this.options,
    required this.fromRaw,
    required this.toRaw,
    this.onSuccess,
  }) {
    if (options.lifecycleAware) {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  bool get disposed => _disposed;

  /// ================= 基本流程 ================= //

  Future<void> firstLoad() async {
    if (_disposed) return;
    final cached = await swr.getCache<T>(box, key, fromRaw: fromRaw);
    if (cached != null) {
      // 标记为缓存数据
      if (cached is List<dynamic>) {
         for (var item in cached) {
           // 动态检查是否有 isFromCache 属性并设置
           try {
             (item as dynamic).isFromCache = true;
           } catch (_) {}
         }
      }
      _emitIfChanged(cached);
      swrLog('首次加载：发出缓存 $box/$key', emoji: '⚡');
    }
    await revalidate(source: 'firstLoad');
  }

  /// 做合并去抖：
  /// - 多次调用在 120ms 内会被合并成一次真正请求；
  /// - 任何一次传了 cancelInflight=true，会立即取消在途并 gate++（只执行一次），合并后的实际请求不再重复 gate++；
  /// - 想要“立刻执行”（比如手动刷新），传 coalesce=Duration.zero。
  Future<void> revalidate({
    String source = 'poll',
    bool cancelInflight = false,
    Duration? coalesce,
  }) async {
    if (_disposed) return;

    final window = coalesce ?? _defaultCoalesceWindow;

    /// —— 需要合并：把多次调用折叠到一个定时器里 —— //
    if (window.inMilliseconds > 0) {
      /// 只要某次需要 cancelInflight，就立刻取消在途并 gate++，记录 gate 快照
      if (cancelInflight && !_coalesceNeedCancel) {
        _coalesceNeedCancel = true;
        _coalesceGate = (++_commitGate);
        try {
          swr.cancelInflight(box, key);
        } catch (_) {}
        swrLog('Gate++（合并周期内）$box/$key gate=${_coalesceGate}', emoji: '🚧');
      }

      // 记住“最后一次”的 source（方便定位日志）
      _coalesceSource = source;

      // 把调用方的 Future 合并：实际执行后统一 complete
      final c = Completer<void>();
      _revalWaiters.add(c);

      // 重置定时器：窗口内所有调用合并
      _revalCoalesceTimer?.cancel();
      _revalCoalesceTimer = Timer(window, () async {
        final mergedSource = _coalesceSource ?? 'merged';
        final forcedGate = _coalesceGate; // 若存在，说明已 gate++
        final needCancel = _coalesceNeedCancel; // 仅用于日志

        // 清理周期状态，避免下一轮误用
        _revalCoalesceTimer = null;
        _coalesceSource = null;
        _coalesceNeedCancel = false;
        _coalesceGate = null;

        try {
          await _performRevalidate(
            source: mergedSource,
            forcedGate: forcedGate,
            // 如果已经 gate++ 过，就不再二次 gate++。传 false 即可。
            cancelInflight: false,
            mergedByDebounce: true,
            mergedHadCancel: needCancel,
          );
          for (final w in _revalWaiters) {
            if (!w.isCompleted) w.complete();
          }
        } catch (e, st) {
          for (final w in _revalWaiters) {
            if (!w.isCompleted) w.completeError(e, st);
          }
        } finally {
          _revalWaiters.clear();
        }
      });

      return c.future;
    }

    // —— 不合并：立刻执行（比如手动刷新或明确传 0 窗口） —— //
    return _performRevalidate(
      source: source,
      cancelInflight: cancelInflight,
      forcedGate: null,
      mergedByDebounce: false,
      mergedHadCancel: false,
    );
  }

  Future<void> _performRevalidate({
    required String source,
    required bool cancelInflight,
    required bool mergedByDebounce,
    required bool mergedHadCancel,
    int? forcedGate,
  }) async {
    if (_disposed) return;

    swrLog(
      '准备校准(${mergedByDebounce ? 'merged/$source' : source}${mergedHadCancel ? '|cancel' : ''})：$box/$key',
      emoji: '🛰️',
    );

    if (!_isForeground && options.lifecycleAware) {
      swrLog('跳过校准（后台）：$box/$key', emoji: '⏸️');
      return;
    }

    // 如果之前在合并窗口内已经做过 gate++，这里复用那个 gate；否则按正常逻辑决定是否 gate++
    final localGate = (forcedGate != null)
        ? forcedGate
        : (cancelInflight ? (_commitGate += 1) : _commitGate);
    if (forcedGate == null && cancelInflight) {
      try {
        swr.cancelInflight(box, key);
      } catch (_) {}
      swrLog('Gate++（即时）$box/$key gate=$localGate', emoji: '🚧');
    }

    try {
      loading.value = true;

      final fresh = await swr.dedup<T>(
        box,
        key,
        (cancel) => fetcher(cancel),
        forceNew: false,
      );

      if (_disposed) return;

      if (localGate != _commitGate) {
        swrWarn('丢弃过期结果（gate 变化）：$box/$key');
        return;
      }

      _emitIfChanged(fresh);
      _lastGood = fresh;
      await swr.setCache<T>(box, key, fresh, toRaw: toRaw);
      error.value = '';
      swrLog(
        '校准完成(${mergedByDebounce ? 'merged/$source' : source})：$box/$key',
        emoji: '✅',
      );
    } catch (e, st) {
      error.value = e.toString();
      swrErr(e, st);
    } finally {
      loading.value = false;
    }
  }

  Future<void> manualRefresh() =>
      // 手动刷新：不合并，立即执行（coalesce=Duration.zero）
      revalidate(
          source: 'manual', cancelInflight: true, coalesce: Duration.zero);

  // ================= 轮询 ================= //

  bool get isPolling => _poller != null;

  void startPolling() {
    _stopPolling();
    final interval = options.pollInterval;
    if (interval == null || interval.inMilliseconds <= 0) return;

    _didEmitCacheOnPoll = false;

    _poller = Timer.periodic(interval, (_) async {
      if (_disposed) return;
      if (options.lifecycleAware && !_isForeground) return;

      // 防重入：避免 tick 重叠造成“看起来没刷新”
      if (_tickBusy) return;
      _tickBusy = true;
      try {
        final needEmitCache =
            options.pollStrategy == PollStrategy.swrEachTick ||
                (options.pollStrategy == PollStrategy.swrOnFirstTick &&
                    !_didEmitCacheOnPoll);

        if (needEmitCache) {
          final cached = await swr.getCache<T>(box, key, fromRaw: fromRaw);
          if (cached != null) {
            _emitIfChanged(cached);
            swrLog('轮询 tick：先发缓存 $box/$key', emoji: '⚡');
          }
          _didEmitCacheOnPoll = true;
        }

        await revalidate(source: 'poll');
      } finally {
        _tickBusy = false;
      }
    });

    swrLog('开始轮询：$box/$key 每 ${interval.inSeconds}s', emoji: '⏱️');
  }

  void stopPolling() => _stopPolling();
  void pausePolling() => _stopPolling();

  void resumePolling() {
    if (isPolling) return;
    startPolling();
  }

  void _stopPolling() {
    _poller?.cancel();
    _poller = null;
  }

  // ================= Lifecycle ================= //

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isForeground = (state == AppLifecycleState.resumed);
    if (_isForeground) {
      if (options.revalidateAfter != null) {
        revalidate(source: 'resume');
      }
      return;
    }
    if (state == AppLifecycleState.paused) {
      _stopPolling();
    }
  }

  // ================= 内部 ================= //

  void _emitIfChanged(T next) {
    final cur = data.value;
    swrLog('准备发出新值 $box/$key', emoji: '📤');

    if (options.equals != null) {
      if (options.equals!(cur, next)) return;
    } else {
      // 默认 ==
      if (cur == next) return;
    }

    data.value = next;
    if (onSuccess != null) {
      onSuccess!(next);
    }
  }

  void dispose() {
    _disposed = true;
    _stopPolling();
    WidgetsBinding.instance.removeObserver(this);
    // 自动取消在途
    swr.cancelInflight(box, key);
  }
}
