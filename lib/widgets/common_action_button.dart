import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommonActionButton extends StatefulWidget {
  final Widget content;
  final bool isActive;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const CommonActionButton({
    super.key,
    required this.content,
    required this.isActive,
    this.onPressed,
    this.height = 44.0,
    this.width = double.infinity,
    this.borderRadius,
  });

  static CommonActionButton confirm(bool isActive,
      {VoidCallback? onPressed, String? content, BorderRadius? borderRadius}) {
    return CommonActionButton(
        content: Text(
          content ?? '提交'.tr,
          style: TextStyle(
            color: appColors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        isActive: isActive,
        onPressed: onPressed,
        borderRadius: borderRadius);
  }

  @override
  State<CommonActionButton> createState() => _CommonActionButtonState();
}

class _CommonActionButtonState extends State<CommonActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isActive ? widget.onPressed : null,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: widget.isActive
              ? LinearGradient(
                  colors: [
                    appnewColors.bg,
                    appnewColors.bg,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : LinearGradient(
                  colors: [
                    Color(0xFF9DBFFA),
                    Color(0xFF9DBFFA),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: widget.content,
      ),
    );
  }
}
