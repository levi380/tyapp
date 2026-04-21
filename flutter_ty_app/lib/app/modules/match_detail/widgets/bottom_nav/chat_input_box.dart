import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../widgets/image_view.dart';

/// 聊天输入框
class ChatInputBox extends StatelessWidget {
  const ChatInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 0.5.sw - 18.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      margin: EdgeInsets.only(right: 12.w),
      decoration: ShapeDecoration(
        color: Get.theme.chatInputBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(
            Get.isDarkMode
                ? 'assets/images/detail/dialog-icon-night.png'
                : 'assets/images/detail/dialog-icon.png',
            width: 20.w,
            height: 20.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Text(
              LocaleKeys.app_function_under_development.tr,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Get.isDarkMode
                    ? const Color.fromRGBO(255, 255, 255, 0.2)
                    : const Color.fromRGBO(201, 205, 219, 1),
                fontSize: (12.sp),
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
