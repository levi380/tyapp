import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 圆形勾选外观：14.r，选中蓝边框 / 未选中灰边框
class CheckView extends StatelessWidget {
  const CheckView({
    super.key,
    required this.value,
    this.onTap,
    this.selectedBorderColor = const Color(0xFF179EFA),
    this.unselectedBorderColor = const Color(0xff9FA5B5),
    this.borderWidth,
  });

  final bool value;
  final VoidCallback? onTap;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: 14.r,
      height: 14.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(
          color: value ? selectedBorderColor : unselectedBorderColor,
          width: borderWidth ?? 4.r,
        ),
      ),
    );
    if (onTap == null) return box;
    return GestureDetector(
      onTap: onTap,
      child: box,
    );
  }
}
