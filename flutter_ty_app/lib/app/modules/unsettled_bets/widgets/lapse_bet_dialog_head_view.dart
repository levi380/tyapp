import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/utils.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-未结算统计Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于显示包含统计数据的对话框头部。
    - **statistics**: 一个字符串列表，包含三个统计数据项。
    - 构建组件的 UI，包括一行显示三个统计项和分隔符。
    - `title`: 显示的标题。
    - `number`: 显示的数字。
    - **功能**: 返回一个包含标题和数字的列，使用 `Expanded` 使其自适应宽度。
    - **功能**: 返回一个分隔符，使用 `Container` 设置宽度和高度，背景色根据主题变化。
    - `_titleTextStyle`: 定义标题文本的样式。
    - `_numberTextStyle`: 定义数字文本的样式。
    - 使用 `Get.isDarkMode` 判断当前主题，动态设置颜色。
    - 文本样式包括字体、大小和粗细等属性。
    】】】
 *
 */
class LapseBetDialogHeadView extends StatelessWidget {
  final List<String> statistics;

  const LapseBetDialogHeadView({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _single(
            LocaleKeys.app_total_bets.tr,
          statistics[0],
          ),
          _div(),
          _single(
            LocaleKeys.app_stake.tr,
            formatNumber(statistics[1]),
          ),
        ],
      ),
    );
  }

  Widget _single(String title, String number) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withValues(alpha:
                        0.5,
                      )
                    : const Color(
                        0xFF7981A4,
                      ),
                fontSize: 10.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginZero.marginOnly(
                  bottom: 2.h,
                ),
            Text(
              number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withValues(alpha:0.9)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(alpha:
                0.08,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }
}
