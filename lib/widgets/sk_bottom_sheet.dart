import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SKBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final Color? bgColor;
  final Widget? closeButton;
  final void Function()? onClose; //close button action
  final double? top; //close button top position
  final double? left; //close button right position
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? titlePadding;
  final AlignmentGeometry? alignment;
  final double? maxHeight;

  const SKBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.closeButton,
    this.onClose,
    this.top,
    this.bgColor,
    this.left,
    this.padding,
    this.titlePadding,
    this.alignment,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final left1 = left ?? 10.w;
    final right1 = left ?? 24.w;
    final top1 = top ?? 24.h;
    final close = closeButton != null
        ? Positioned(
            left: left1,
            top: top1,
            child: GestureDetector(
                onTap: () {
                  if (onClose != null) {
                    onClose!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: closeButton),
          )
        : Positioned(
            right: right1,
            top: top1,
            child: GestureDetector(
              onTap: () {
                if (onClose != null) {
                  onClose!();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Image.asset(
                Assets.popupClose,
                fit: BoxFit.fill,
                width: 16.w,
                height: 16.w,
              ),
            ),
          );
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight ?? double.infinity),
      decoration: BoxDecoration(
        color: bgColor ?? appColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: padding ?? EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      titlePadding ?? EdgeInsets.symmetric(horizontal: 12.h),
                  child: Align(
                    alignment: alignment ?? Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: appColors.textMainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                content,
              ],
            ),
          ),
          close,
        ],
      ),
    );
  }
}
