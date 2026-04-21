import 'dart:async';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

/// 赛事倒计时辅助类
/// 负责处理赛事开始倒计时的计算和定时器管理
class MatchCountdownHelper {
  /// 定时器实例
  Timer? _timer;
  
  /// 赛事实体
  final MatchEntity? match;
  
  /// 是否已挂载（用于判断Widget是否还存在）
  final bool Function() isMounted;
  
  /// 是否正在滚动（用于判断是否需要更新）
  final bool Function() isScrolling;
  
  /// 状态更新回调
  final void Function() onStateUpdate;
  
  /// 赛事开始倒计时时间（分钟）
  String longTime = "";
  
  /// 赛事开赛时间倒计时是否显示
  bool startTime = true;

  /// 构造函数
  /// [match] 赛事实体
  /// [isMounted] 判断Widget是否已挂载的回调
  /// [isScrolling] 判断是否正在滚动的回调
  /// [onStateUpdate] 状态更新回调
  MatchCountdownHelper({
    required this.match,
    required this.isMounted,
    required this.isScrolling,
    required this.onStateUpdate,
  });

  /// 初始化倒计时事件
  /// 计算赛事开始倒计时时间并启动定时器
  void initEvent() {
    // 当前时间戳
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;

    int mgt = int.tryParse(match?.mgt ?? "0") ?? 0;
    // 赛事开始时间 - 当前时间 小于一小时并且大于0时为true
    bool startTimeTemp =
        (mgt - nowTimeStamp) < 3600 * 1000 && (mgt - nowTimeStamp) > 0;

    // 赛事开始倒计时时间(整数，单位：分钟)
    int longTimeTemp = (mgt - nowTimeStamp) / 1000 ~/ 60;

    // 赛事开赛时间倒计时为0的时候 让倒计时显示为1分钟
    if (longTimeTemp == 0) {
      longTimeTemp += 1;
    }

    startTime = startTimeTemp;

    // 计算出来的倒计时时间赋值给变量显示在页面上
    longTime = longTimeTemp.toString();

    /// 初始化定时器
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!isMounted() || isScrolling()) {
        return;
      }
      
      int now = DateTime.now().millisecondsSinceEpoch;
      int mgt = int.tryParse(match?.mgt ?? "0") ?? 0;
      
      // 判断赛事开始时间-当前时间 小于0的时候 清除定时器
      if (mgt - now < 0) {
        timer.cancel();
        // 不显示倒计时
        startTime = false;
        // 此时同步更新match_stage组件的时间
        Bus.getInstance().emit(EventType.matchNoStart, null);
      }
      
      // 计算新的倒计时时间（分钟）
      int newLongTime = ((mgt - now) / 1000 / 60).floor();
      if (newLongTime == 0) {
        newLongTime += 1;
      }
      longTime = newLongTime.toString();
      
      // 触发状态更新
      onStateUpdate();
    });
  }

  /// 取消定时器
  /// 在Widget销毁时调用，释放资源
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}