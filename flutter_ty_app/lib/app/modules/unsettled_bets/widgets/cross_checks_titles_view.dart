import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/image_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-串关头部Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示交叉检查的标题信息，具有美观的背景和图标。
    - `CrossChecksTitlesView`：接收一个参数：
    - `information`：字符串类型，表示要显示的标题文本。
    - 返回一个容器，包含标题的背景样式、图标和文本。
    - 使用 `BoxDecoration` 设置背景颜色和圆角。
    - `ImageView`：显示图标（`duplex.png`）。
    - `Text`：展示传入的标题信息，使用指定的文本样式。

    】】】
 *
 */
class CrossChecksTitlesView extends StatelessWidget {
  const CrossChecksTitlesView({
    Key? key,
    required this.information,
    required this.odds,
  }) : super(key: key);

  ///串关标题
  final String information;

  ///赔率
  final String odds;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.r),
          topRight: Radius.circular(16.r),
        ),
        // color: BetsUtils.getColor(context.isDarkMode),
      ),
      padding: EdgeInsets.only(left: 6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(
            context.isDarkMode
                ? 'assets/images/bets/level_icon_night.png'
                : 'assets/images/bets/level_icon_daytime.png',
            width: 20.w,
            height: 20.h,
          ).marginOnly(
            right: 5.w,
          ),
          Text(
            information,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.8999999761581421)
                  : Color(0xFF303442),
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ).marginOnly(
            right: 5.w,
          ),
        ],
      ),
    );
  }
}
