import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';

/// 简单的无数据展示页,仅文字
class SimpleNoData extends StatelessWidget {
  SimpleNoData({
    super.key,
    this.content,
  });

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50.w,
      child: Text(
        (content ?? LocaleKeys.common_no_data.tr),
        style: TextStyle(
            fontSize: isIPad ? (14.sp) : 10.sp,
            color: AppColor.tabSelectTextColor),
      ),
    );
  }
}
