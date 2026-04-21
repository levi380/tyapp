import 'dart:async';

///
/// 节流函数：节流是控制函数在一定时间内只允许执行一次，如果函数在这个时间段内被多次调用，
/// 只会在设定的时间间隔到期后执行一次。
/// 适用于：持续触发的事件，如滚动事件、鼠标移动事件等。
///
/// 原理：
/// 在一段时间内，只执行一次函数，即使在时间内多次触发，也只能在规定时间结束后，才可以重新执行。
///
/// 适用场景：
/// 1. 持续触发的事件，如滚动事件、鼠标移动事件等。
/// 2. 控制动画刷新频率，确保动画流畅但不会过度执行。
///

typedef EasyThrottleCallback = void Function();

/// 节流操作器
class _EasyThrottleOperation {
  final EasyThrottleCallback callback;
  final Timer timer;
  final EasyThrottleCallback? onAfter;

  _EasyThrottleOperation({
    required this.callback,
    required this.timer,
    this.onAfter,
  });
}

class EasyThrottle {
  /// 节流操作集合
  static Map<String, _EasyThrottleOperation> _operations = {};

  /// 节流函数
  static bool throttle(
      String tag, Duration duration, EasyThrottleCallback onExecute,
      {EasyThrottleCallback? onAfter}) {

    /// 如果已经存在节流操作，则直接返回
    if (_operations.containsKey(tag)) {
      return true;
    }

    /// 在一段时间内，只执行一次函数
    _operations[tag] = _EasyThrottleOperation(
      callback: onExecute,
      timer: Timer(duration, () {
        _operations[tag]?.timer.cancel();
        _EasyThrottleOperation remove = _operations.remove(tag)!;

        remove.onAfter?.call();
      }),
      onAfter: onAfter,
    );

    onExecute();

    return false;
  }

  /// 取消节流操作
  static void cancel(String tag) {
      _operations[tag]?.timer.cancel();
      _operations.remove(tag);
  }

  /// 取消所有节流操作
  static void cancelAll() {
    _operations.forEach((key, value) {
      value.timer.cancel();
    });

    _operations.clear();
  }

  /// 获取节流操作数量
  static int count() {
    return _operations.length;
  }
}
