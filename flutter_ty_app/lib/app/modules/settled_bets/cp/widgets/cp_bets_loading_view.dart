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
    【【【 AUTO_PARAGRAPH_TITLE 彩票追号记录加载Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，是一个无状态组件，用于显示加载状态的视图，通常在数据加载时使用。该组件包含一个加载图像和相应的加载文本。
    - Container: 设置顶部内边距。
    - Column: 垂直排列加载图像和加载文本。
    - ImageView: 显示加载图像，路径为 `assets/images/bets/loading.png`，支持宽高设置。
    - Text: 显示加载文本，内容通过国际化处理获取。
    】】】
 *
 */
class CpBetsLoadingView extends StatelessWidget {
  const CpBetsLoadingView({
    super.key,
  });

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
            'assets/images/bets/loading.png',
            width: 180.w,
            height: 180.h,
          ).marginOnly(
            bottom: 8.h,
          ),
          Text(
            LocaleKeys.app_h5_cathectic_data_loading.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.6000000238418579)
                  : const Color(0xFFAFB3C8),
              fontSize:  12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
