import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../bottom_wait_list_widget/widget/simple_circular_progress_bar.dart';

/// VR 体育赛事倒计时及轮次显示组件
///
/// 用于在 VR 赛事列表中展示当前赛事的剩余时间和轮次信息。
/// 包含一个圆形的倒计时进度条和一个底部的轮次提示标签。
class VrSportingEventTime extends StatelessWidget {
  /// 进度条颜色，默认为黄色
  final Color? progressColor;

  /// 进度条背景颜色，默认为半透明黑色
  final Color? backColor;

  /// 当前轮次
  final int round;

  /// 组件尺寸（进度条直径），默认为 60
  final double size;

  /// 倒计时文字大小，默认为 10.sp
  final double? valueSize;

  /// 轮次文字大小
  final double? roundSize;

  /// 构造函数
  ///
  /// [round] 为必填参数，表示当前是第几轮。
  /// [size] 控制整体圆形进度条的大小。
  const VrSportingEventTime({
    super.key,
    required this.round,
    this.progressColor,
    this.backColor,
    this.size = 60,
    this.valueSize,
    this.roundSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCircularTimer(),
        SizedBox(height: 18.w),
        _buildRoundLabel(),
      ],
    );
  }

  /// 构建圆形倒计时进度条
  Widget _buildCircularTimer() {
    return SimpleCircularProgressBar(
      mergeMode: true,
      maxValue: 59, // 假设倒计时最大为 59 秒
      size: size,
      backStrokeWidth: 2,
      backColor: backColor ?? Colors.black26,
      progressStrokeWidth: 2,
      progressColors: [
        progressColor ?? Colors.yellow,
      ],
      onGetText: (double value) {
        return Text(
          '00:${value.toInt().toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: valueSize ?? 10.sp.scale,
            color: progressColor ?? Colors.yellow,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }

  /// 构建底部轮次标签
  Widget _buildRoundLabel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.black26,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
      child: Text(
        '第 $round 轮',
        style: TextStyle(
          color: Colors.white,
          fontSize: roundSize ?? 12.sp.scale,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
