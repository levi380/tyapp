/// 防抖是指在事件触发后，等待一定时间，如果在这段时间内没有再触发事件，那么就执行该事件处理。如果在时间段内继续触发事件，则重新开始计时。适合用于短时间内多次触发的场景，如输入框内容变化、按钮点击。
/// 原理：
/// 事件被触发后，等待一段时间，如果没有再次触发事件，才执行该操作。
/// 如果在等待时间内再次触发事件，则重新计时。

// 适用场景：

// 防止输入框输入时频繁触发搜索请求，优化输入查询。
// 按钮点击事件，防止短时间内多次点击，减少重复请求。

import 'dart:async';

typedef EasyDebounceCallback = void Function();

/// 防抖操作器
class _EasyDebounceOperation {
  final EasyDebounceCallback callback;
  final Timer timer;

  _EasyDebounceOperation({
    required this.callback,
    required this.timer,
  });
}

class EasyDebounce {
  /// 防抖操作集合
  static Map<String, _EasyDebounceOperation> _operations = {};

  /// 防抖函数
  static void debounce(
      String tag, Duration duration, EasyDebounceCallback onExecute) {
        /// 时间为0时，直接执行
    if (duration == Duration.zero) {
      _operations[tag]?.timer.cancel();
      _operations.remove(tag);
      onExecute();
    } else {
      /// 如果已经存在防抖操作，则取消之前的计时器
      _operations[tag]?.timer.cancel();
      /// 重新开始新的计时器
      _operations[tag] = _EasyDebounceOperation(
        callback: onExecute,
        timer: Timer(duration, () {
          _operations[tag]?.timer.cancel();
          _operations.remove(tag);
          onExecute();
        }),
      );
    }
  }

  /// 触发防抖操作
  static void fire(String tag) {
    _operations[tag]?.callback();
  }

 /// 取消防抖操作
  static void cancel(String tag) {
    _operations[tag]?.timer.cancel();
    _operations.remove(tag);
  }

  /// 取消所有防抖操作
  static void cancelAll() {
    _operations.forEach((key, value) {
      value.timer.cancel();
    });
    _operations.clear();
  }

  /// 获取防抖操作数量
  static int count() {
    return _operations.length;
  }
}
