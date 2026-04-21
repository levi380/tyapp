import 'package:flutter_ty_app/app/config/swr/swr_config.dart';

/// 常用场景的 SWR 预设参数
class SwrPresets {
  SwrPresets._();

  /// 统一 UI 列表类轮询：10s 一次；每个 tick 先发缓存再校准网络。
  static const SwrOptions uiList10s = SwrOptions(
    ttl: Duration(minutes: 10),
    revalidateAfter: Duration(seconds: 10),
    pollInterval: Duration(seconds: 10),
    lifecycleAware: true,
    networkAware: true,
    pollStrategy: PollStrategy.swrOnFirstTick,
  );

  ///  强实时（5s 轮询）。常用于“滚球列表/盘口”
  static const SwrOptions realtime5s = SwrOptions(
    ttl: Duration(seconds: 10),
    revalidateAfter: Duration(seconds: 2),
    pollInterval: Duration(seconds: 5),
    lifecycleAware: true,
    networkAware: true,
    pollStrategy: PollStrategy.networkOnly,
  );

  ///  常规实时（8s 轮询）——兼顾实时/功耗
  static const SwrOptions realtime8sBalanced = SwrOptions(
    ttl: Duration(seconds: 30),
    revalidateAfter: Duration(seconds: 5),
    pollInterval: Duration(seconds: 8),
    lifecycleAware: true,
    networkAware: true,
    pollStrategy: PollStrategy.swrOnFirstTick,
  );
}
