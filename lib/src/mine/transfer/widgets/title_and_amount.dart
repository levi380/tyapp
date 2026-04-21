import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget titleAndAmount(
  String title,
  String amount, {
  Key? key,
  bool? isRotating,
  Color? titleColor,
  Color? iconColor,
  String? titleIcon,
  String? titleIcon2,
  String? amountIcon,
  VoidCallback? onTitleIconTap,
  VoidCallback? onIconTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onTitleIconTap,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor ?? appnewColors.text4,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (titleIcon != null)
              Container(
                key: key,
                margin: EdgeInsets.only(left: 4.r),
                child: Image.asset(
                  titleIcon,
                  width: 12.r,
                  height: 12.r,
                ),
              ),
            if (titleIcon2 != null)
              GestureDetector(
                onTap: onIconTap,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 4.r),
                      child: _RotatingIcon(
                          icon: titleIcon2, isRotating: isRotating ?? false, iconColor: iconColor ?? Colors.white),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      GestureDetector(
        onTap: onIconTap,
        child: Row(
          children: [
            Text(
              amount,
              style: TextStyle(
                color: titleColor ?? appnewColors.text4,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (amountIcon != null)
              Container(
                margin: EdgeInsets.only(left: 4.r),
                child: _RotatingIcon(
                    icon: amountIcon, isRotating: isRotating ?? false, iconColor: iconColor ?? Colors.white),
              ),
          ],
        ),
      ),
    ],
  );
}

// 旋转图标组件
class _RotatingIcon extends StatefulWidget {
  final String icon;
  final bool isRotating;
  final Color? iconColor;

  const _RotatingIcon({
    required this.icon,
    required this.isRotating,
    required this.iconColor,
  });

  @override
  State<_RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<_RotatingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_RotatingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRotating && !oldWidget.isRotating) {
      _controller.repeat();
    } else if (!widget.isRotating && oldWidget.isRotating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(widget.icon, width: 12.r, height: 12.r, color: widget.iconColor ?? Colors.white),
    );
  }
}
