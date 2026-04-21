import 'dart:async';

import 'package:get/get.dart';

import 'refresh_coordinator.dart';
import 'swr_log.dart';

class WindowPollingOptions {
  final Duration hiInterval;
  final Duration? loInterval;
  final int paddingPages;
  final bool emitCacheOnHiTick;
  final bool emitCacheOnLoTick;
  final double visibleThreshold;
  final Duration enterDebounce;
  final Duration minEnterCooldown;
  final Duration stalenessBudgetHi;

  /// 新增：进入可见区后，必须在这段时间“无可见度变化”才触发 enter 校准
  /// 也就是“滑动停止”判定时间。
  final Duration enterIdleAfter;

  const WindowPollingOptions({
    this.hiInterval = const Duration(seconds: 8),
    this.loInterval = const Duration(seconds: 30),
    this.paddingPages = 1,
    this.emitCacheOnHiTick = false,
    this.emitCacheOnLoTick = false,
    this.visibleThreshold = 0.35,
    this.enterDebounce = const Duration(milliseconds: 120),
    this.minEnterCooldown = const Duration(seconds: 3),
    this.stalenessBudgetHi = const Duration(seconds: 4),
    this.enterIdleAfter =
        const Duration(milliseconds: 450),
  });

  WindowPollingOptions copyWith({
    Duration? hiInterval,
    Duration? loInterval,
    int? paddingPages,
    bool? emitCacheOnHiTick,
    bool? emitCacheOnLoTick,
    double? visibleThreshold,
    Duration? enterDebounce,
    Duration? minEnterCooldown,
    Duration? stalenessBudgetHi,
    Duration? enterIdleAfter,
  }) {
    return WindowPollingOptions(
      hiInterval: hiInterval ?? this.hiInterval,
      loInterval: loInterval ?? this.loInterval,
      paddingPages: paddingPages ?? this.paddingPages,
      emitCacheOnHiTick: emitCacheOnHiTick ?? this.emitCacheOnHiTick,
      emitCacheOnLoTick: emitCacheOnLoTick ?? this.emitCacheOnLoTick,
      visibleThreshold: visibleThreshold ?? this.visibleThreshold,
      enterDebounce: enterDebounce ?? this.enterDebounce,
      minEnterCooldown: minEnterCooldown ?? this.minEnterCooldown,
      stalenessBudgetHi: stalenessBudgetHi ?? this.stalenessBudgetHi,
      enterIdleAfter: enterIdleAfter ?? this.enterIdleAfter,
    );
  }
}

typedef GetPageRc<T> = RefreshCoordinator<List<T>>? Function(int page);

class WindowRefresher<T> {
  final WindowPollingOptions options;
  final GetPageRc<T> getRc;

  final RxSet<int> _hiPages = <int>{}.obs; // 高频页集合
  final RxSet<int> _knownPages = <int>{}.obs; // 已知页集合
  int? _centerPage;

  Timer? _hiTimer;
  Timer? _loTimer;
  bool _running = false;

  final Map<int, Timer> _debouncers = {};
  final Map<int, DateTime> _lastEnterAt = {};
  final Map<int, double> _lastVisibleFrac = {};

  // ★ 新增：enter 互斥锁（避免同一页同时触发多次 enter 校准）
  final Set<int> _enterBusyPages = <int>{};

  // ★ 新增：全局“滚动空闲”判定定时器（无任何可见度变化一段时间才触发 enter）
  Timer? _scrollIdleTimer;

  final String label;
  static int _seq = 0;
  final int _id = ++_seq;

  WindowRefresher({
    required this.options,
    required this.getRc,
    this.label = 'WR', // 👈 可传 controllerTag
  });

  // ============ 外部 API ============

  void markKnownPage(int page) => _knownPages.add(page);
  void markKnownPages(Iterable<int> pages) => _knownPages.addAll(pages);

  /// 只围绕 center±paddingPages 构建窗口，且必须是“已知页”
  void focusOn(int centerPage) {
    _centerPage = centerPage;
    final start = (centerPage - options.paddingPages).clamp(1, 1 << 30);
    final end = (centerPage + options.paddingPages).clamp(1, 1 << 30);

    final next = <int>{};
    for (var p = start; p <= end; p++) {
      if (_knownPages.contains(p)) next.add(p);
    }

    final changed = next.difference(_hiPages).isNotEmpty ||
        _hiPages.difference(next).isNotEmpty;

    if (changed) {
      _hiPages
        ..clear()
        ..addAll(next);
      swrLog('窗口更新：中心页=$centerPage 高频页=${_hiPages.toList()} 🔭');
    }
  }

  bool _suspended = false;

  /// 页锚可见度变化
  void onVisibility({required int page, required double fraction}) {
    if (_suspended) return;
    final prev = _lastVisibleFrac[page] ?? 0.0;
    _lastVisibleFrac[page] = fraction;

    // 只要有可见度事件，就重置全局“滚动空闲”定时器
    _armScrollIdleTimer();

    // 上穿阈值：先对齐窗口；不要立刻打接口，交给“滚动空闲”触发
    if (prev < options.visibleThreshold &&
        fraction >= options.visibleThreshold) {
      focusOn(page);
      // 不再直接 _tryEnterFetch(page);
    }
  }

  void start() {
    if (_running) {
      swrLog('[$label#$_id] start() ignored, already running');
      return;
    }
    _running = true;
    _suspended = false;
    swrLog('[$label#$_id] start ✅');

    _hiTimer = Timer.periodic(options.hiInterval, (_) async {
      if (!_running || _suspended) return;
      if (_hiPages.isEmpty) return;
      swrLog('[$label#$_id] 高频 tick：${_hiPages.toList()} ⏱️');
      for (final p in _hiPages) {
        final rc = getRc(p);
        if (rc == null) continue;
        if (options.emitCacheOnHiTick) {
          final cached = await rc.swr
              .getCache<List<T>>(rc.box, rc.key, fromRaw: rc.fromRaw);
          if (cached != null) rc.data.value = cached;
        }
        // 高频轮询一律不取消在途，交给 SWR 去重
        unawaited(rc.revalidate(source: 'hiPoll', cancelInflight: false));
      }
    });

    if (options.loInterval != null) {
      _loTimer = Timer.periodic(options.loInterval!, (_) async {
        if (!_running || _suspended) return;
        final loPages = _knownPages.difference(_hiPages);
        if (loPages.isEmpty) return;
        swrLog('[$label#$_id] 低频 tick：${loPages.toList()} 🐢');
        for (final p in loPages) {
          final rc = getRc(p);
          if (rc == null) continue;
          if (options.emitCacheOnLoTick) {
            final cached = await rc.swr
                .getCache<List<T>>(rc.box, rc.key, fromRaw: rc.fromRaw);
            if (cached != null) rc.data.value = cached;
          }
          unawaited(rc.revalidate(source: 'loPoll', cancelInflight: false));
        }
      });
    }
  }

  /// 重置窗口状态（用于查询条件变化）
  void reset() {
    _hiPages.clear();
    _knownPages.clear();
    _centerPage = null;

    for (var t in _debouncers.values) {
      t.cancel();
    }
    _debouncers.clear();
    _lastEnterAt.clear();
    _lastVisibleFrac.clear();
  }

  void dispose() {
    _running = false;
    _hiTimer?.cancel();
    _loTimer?.cancel();
    _scrollIdleTimer?.cancel();
    for (var t in _debouncers.values) {
      t.cancel();
    }
  }

  // ============ 内部 ============

  void _armScrollIdleTimer() {
    _scrollIdleTimer?.cancel();
    _scrollIdleTimer = Timer(options.enterIdleAfter, () {
      // 只有当前可见度足够高的页，才触发 Enter 校准
      // （遍历 _lastVisibleFrac 找出符合条件的）
      final candidates = <int>[];
      _lastVisibleFrac.forEach((page, frac) {
        if (frac >= options.visibleThreshold) {
          candidates.add(page);
        }
      });

      if (candidates.isNotEmpty) {
        swrLog('滚动空闲（${options.enterIdleAfter.inMilliseconds}ms），触发校准：$candidates');
        for (final p in candidates) {
          _tryEnterFetch(p);
        }
      }
    });
  }

  Future<void> _tryEnterFetch(int page) async {
    // 互斥锁 check
    if (_enterBusyPages.contains(page)) return;

    final now = DateTime.now();
    final last = _lastEnterAt[page];
    if (last != null && now.difference(last) < options.minEnterCooldown) {
      return; // 冷却中
    }

    _lastEnterAt[page] = now;
    _enterBusyPages.add(page);

    try {
      final rc = getRc(page);
      if (rc != null) {
        // 进入视野：可以考虑 cancelInflight=true 强插队
        // 或者 false，让它去重
        await rc.revalidate(source: 'enter', cancelInflight: true);
      }
    } finally {
      _enterBusyPages.remove(page);
    }
  }
}
