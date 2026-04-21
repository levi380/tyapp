import 'package:filbet/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDecoration {
  static BoxDecoration bgWhiteWithShadow({
    double radius = 10.0,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius.r),
      color: appColors.white,
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? appColors.shadowColor,
          offset: Offset(0, 2.h),
          blurRadius: 4.r,
          spreadRadius: 0,
        ),
      ],
    );
  }
}
