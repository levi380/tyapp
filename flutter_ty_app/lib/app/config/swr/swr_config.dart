/// 轮询时的行为
enum PollStrategy {
  networkOnly, // 只打网络（推荐）
  swrOnFirstTick, // 第一次 tick 先发缓存再打网络
  swrEachTick, // 每次 tick 都先发缓存（一般不建议）
}

class SwrOptions {
  /// 本地缓存有效期（超过则视为过期）
  final Duration? ttl;

  /// 打开页面时距上次校验超过该值则主动校验（可选）
  final Duration? revalidateAfter;

  /// 轮询间隔（null 则不轮询）
  final Duration? pollInterval;

  /// 跟随前后台（前台才轮询/拉取）
  final bool lifecycleAware;

  /// 跟随网络（离线不拉取，返网自动校准）
  /// ⚠ 目前 RefreshCoordinator 里未使用该开关，如需生效请在 revalidate/startPolling 里加判断
  final bool networkAware;

  /// 轮询策略
  final PollStrategy pollStrategy;

  /// 自定义相等判断（可用于避免 emit 同值）
  final bool Function(dynamic, dynamic)? equals;

  const SwrOptions({
    this.ttl,
    this.revalidateAfter,
    this.pollInterval,
    this.lifecycleAware = true,
    this.networkAware = false,
    this.pollStrategy = PollStrategy.networkOnly,
    this.equals,
  });

  SwrOptions copyWith({
    Duration? ttl,
    Duration? revalidateAfter,
    Duration? pollInterval,
    bool? lifecycleAware,
    bool? networkAware,
    PollStrategy? pollStrategy,
    bool Function(dynamic, dynamic)? equals,
  }) {
    return SwrOptions(
      ttl: ttl ?? this.ttl,
      revalidateAfter: revalidateAfter ?? this.revalidateAfter,
      pollInterval: pollInterval ?? this.pollInterval,
      lifecycleAware: lifecycleAware ?? this.lifecycleAware,
      networkAware: networkAware ?? this.networkAware,
      pollStrategy: pollStrategy ?? this.pollStrategy,
      equals: equals ?? this.equals,
    );
  }
}
