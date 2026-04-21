import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBottomSheetContentWrapperWithTitle({
  required String title,
  required Widget child,
  double? hieght,
  EdgeInsetsGeometry? padding,
  Color? color,
  bool isHighLight = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          color: color ?? appnewColors.text2,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 10.h),
      buildBottomSheetContentBorderWrapper(child, isHighLight: isHighLight, height: hieght, padding: padding),
    ],
  );
}

Widget buildBottomSheetContentPaddingWrapper(Widget child) {
  return Padding(
    padding: EdgeInsets.all(20.w),
    child: child,
  );
}

Widget buildBottomSheetContentBorderWrapper(
  Widget child, {
  bool isHighLight = false,
  EdgeInsetsGeometry? padding,
  Color? bgColor,
  double? height,
}) {
  if (child is IgnoreContentContainerBackgroundWidget) {
    return child;
  }
  return Container(
    height: height ?? 76.h,
    padding: padding ?? EdgeInsets.fromLTRB(10.w, 10.h, 20.w, 10.h),
    decoration: BoxDecoration(
      color: bgColor ?? appColors.bgListItemBgBlueColor,
      borderRadius: BorderRadius.circular(12.r),
      border: isHighLight
          ? Border.all(
              color: appColors.borderMain2Color,
              width: 1.w,
            )
          : null,
    ),
    child: child,
  );
}
