import 'package:get/get.dart';

import 'refresh_coordinator.dart';
import 'swr_config.dart';
import 'swr_manager.dart';

mixin SwrMixin on GetxController {
  final List<RefreshCoordinator> _coords = [];

  /// 绑定一个 SWR 协调器并自动托管生命周期
  RefreshCoordinator<T> attachSwr<T>({
    required SwrManager swr,
    required String box,
    required String key,
    required SwrFetcher<T> fetcher,
    required FromRaw<T> fromRaw,
    required ToRaw<T> toRaw,
    SwrOptions? options,
  }) {
    final c = RefreshCoordinator<T>(
      swr: swr,
      box: box,
      key: key,
      fetcher: fetcher,
      options: options ?? swr.defaultOptions,
      fromRaw: fromRaw,
      toRaw: toRaw,
    );
    _coords.add(c);
    return c;
  }

  /// 暴露批量“暂停所有轮询”的能力（可在离开场馆时调用）
  void pauseAllSwrPolling() {
    for (final c in _coords) {
      c.pausePolling();
    }
  }

  /// 暴露批量“恢复所有轮询”的能力（可在返回场馆时调用）
  void resumeAllSwrPolling() {
    for (final c in _coords) {
      c.resumePolling();
    }
  }

  /// （可选）批量触发一次校准
  Future<void> revalidateAll({bool cancelInflight = false}) async {
    for (final c in _coords) {
      await c.revalidate(
        source: 'revalidateAll',
        cancelInflight: cancelInflight,
      );
    }
  }

  @override
  void onClose() {
    for (final c in _coords) {
      c.dispose();
    }
    _coords.clear();
    super.onClose();
  }
}

/// 如果你更喜欢“控制器类”的方式，也可以直接继承这个基类
abstract class SwrController extends GetxController with SwrMixin {}
