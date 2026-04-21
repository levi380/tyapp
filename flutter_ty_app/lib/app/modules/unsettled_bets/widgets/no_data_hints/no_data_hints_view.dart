import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';

import '../../../../widgets/image_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-注单无数据Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于在没有数据时提供提示信息，适用于不同的状态和类型。
    - `type`：表示当前状态（未结算、预约中、已失效、已结注单）。
    - `orderType`：表示订单类型（体育、真人、彩票），默认为 0。
    - `type`：状态类型，取值范围为 0 到 3。
    - `orderType`：订单类型，取值范围为 0 到 2。
    - 根据 `type` 获取对应的提示信息。
    - 创建一个包含提示信息和图像的视图。
    - 根据 `orderType` 设置不同的 padding 和背景样式。
    - 用于居中对齐内容。
    - 根据设备类型设置高度。
    - 设置宽度为无限大，提供 padding 和背景样式。
    - 包含一个图像和一段文本，文本样式根据暗模式和亮模式进行调整。
    】】】
 *
 */

class NoDataHintsView extends StatelessWidget {
  const NoDataHintsView({
    super.key,
    required this.type,
    this.orderType = 0,
  });

  ///0 ：未结算
  ///1 : 预约中
  ///2 : 已失效
  ///3 : 已结注单
  final int type;

  ///0体育 1真人 2彩票
  final int orderType;

  @override
  Widget build(BuildContext context) {
    var prompt = [
      LocaleKeys.app_h5_cathectic_no_data_unsettle.tr,
      LocaleKeys.app_h5_cathectic_no_data_pre.tr,
      LocaleKeys.app_h5_cathectic_no_data_invalid.tr,
      LocaleKeys.app_h5_cathectic_no_data_settle.tr
    ][type];

    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: isIPad ? 380.h : 280.h,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(
            top: orderType == 1 || orderType == 2 ? 30.h : 40.h, bottom: 30.h),
        decoration: orderType == 1 || orderType == 2
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    16.r,
                  ),
                  bottomRight: Radius.circular(
                    16.r,
                  ),
                ),
                color: Get.isDarkMode
                    ? Colors.transparent
                    : const Color(
                        0xFFF2F2F6,
                      ),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              context.isDarkMode
                  ? 'assets/images/bets/nobetrecord_night.png'
                  : 'assets/images/bets/nobetrecord_day.png',
              width: 180.w,
              height: 180.h,
            ),
            Text(
              prompt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.5)
                    : const Color(0xFF7981A3),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
