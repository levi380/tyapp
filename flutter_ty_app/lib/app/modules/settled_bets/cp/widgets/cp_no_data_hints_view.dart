import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../widgets/image_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票追号记录无数据Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，在没有数据时向用户展示相应的提示信息，提升用户体验。
    - `type`：指示提示的类型，决定显示的文本内容。
    -  构造方法
    - `required this.type`：必需的参数，用于确定显示的提示信息。
    - build
    - 构建 UI 界面，包含一张图片和对应的提示文本。
    - 根据 `type` 的值选择不同的提示文本。
    - ImageView：
    - 根据当前主题（深色或浅色模式）加载不同的提示图片。
    - Text：
    - 显示提示信息，文本内容根据 `type` 的值进行调整。

    】】】
 *
 */
class CpNoDataHintsView extends StatelessWidget {
  const CpNoDataHintsView({super.key, required this.type});

  final int type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30.h,
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
            type == 0
                ? LocaleKeys.app_h5_cathectic_no_data_unsettle.tr
                : LocaleKeys.app_h5_cathectic_no_data_settle.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:
                      0.5,
                    )
                  : const Color(0xFF7981A3),
              fontSize:  12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
