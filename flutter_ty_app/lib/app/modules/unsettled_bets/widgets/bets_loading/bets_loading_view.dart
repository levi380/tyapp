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
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-加载Loading 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示加载状态，通常在数据请求过程中显示，包含加载图标和提示文本。
    - `key`：可选的键，用于标识此组件。
    - 无特定属性，所有内容均在构建方法中定义。
    - `BuildContext context`：构建上下文。
    - **功能**：
    - 创建一个包含加载图像和文本的视图。
    - 根据设备类型（iPad 或其他）动态调整高度。
    】】】
 *
 */
class BetsLoadingView extends StatelessWidget {
  const BetsLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: isIPad ? 380.h : 280.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          color: Color(
            context.isDarkMode ? 0xFF1E2029 : 0xFFF2F2F6,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageView(
              'assets/images/bets/loading.png',
              width: 180.w,
              height: 180.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              LocaleKeys.app_h5_cathectic_data_loading.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.6000000238418579)
                    : const Color(0xFFAFB3C8),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
