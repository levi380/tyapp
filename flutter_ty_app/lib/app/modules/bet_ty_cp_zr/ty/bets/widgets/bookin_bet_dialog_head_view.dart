import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/rounded_triangleicon_view.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/image_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-预约统计Widget 】】】
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
class BookinBetDialogHeadView extends StatelessWidget {
  const BookinBetDialogHeadView({
    Key? key,
    required this.statistics,
    required this.isOpenTips,
    required this.onTap,
  }) : super(key: key);
  final List<String> statistics;
  final bool isOpenTips;
  final VoidCallback onTap;

  bool get _isSpecial => [
        'zh',
        'ko',
        'ar',
        'hi',
      ].contains(Get.locale?.languageCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _single(
            LocaleKeys.app_total_bookings.tr,
            statistics[0],
          ).expanded(flex: 8),
          _div(),
          _single(
            LocaleKeys.app_total_revenue.tr,
            formatNumber(statistics[1]),
          ).expanded(flex: 8),
          _div(),
          _singleSpecial(
            context,
            LocaleKeys.app_estimated_profit.tr,
            formatNumber(statistics[2]),
          ).expanded(flex: 9),
        ],
      ),
    );
  }

  Widget _single(String title, String number) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10.h,
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.isDarkMode
                  ? Colors.white.withValues(
                      alpha: 0.5,
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
                  ? Colors.white.withValues(alpha: 0.9)
                  : const Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          ).marginZero.marginOnly(
                bottom: 5.h,
              ),
        ],
      ),
    );
  }

  Widget _singleSpecial(BuildContext context, String title, String number) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _statisticsSpecialStyles(context, title),
            Text(
              number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withValues(alpha: 0.9)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w700,
              ),
            ).marginZero.marginOnly(
                  bottom: 5.h,
                ),
          ],
        ),
      ),
    );
  }

  /*
   *统计提示框多语言适配
   */
  Widget _statisticsSpecialStyles(BuildContext context, String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: _isSpecial
              ? Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? Colors.white.withValues(
                            alpha: 0.5,
                          )
                        : const Color(
                            0xFF7981A4,
                          ),
                    fontSize: 10.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Container(
                  width: 60.w,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? Colors.white.withValues(
                              alpha: 0.5,
                            )
                          : const Color(
                              0xFF7981A4,
                            ),
                      fontSize: 10.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        ).marginOnly(top: 10.h, right: 1.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///提示框图标
            Container(
              height: 8.h,
              child: isOpenTips
                  ? RoundedTriangleIconView(
                      size: 7.h, // 图标大小
                      color: Colors.black.withValues(
                          alpha: context.isDarkMode ? 0.95 : 0.9), // 图标颜色
                    )
                  : Container(),
            ),
            Container(
              height: 2.h,
            ),

            ///警号图标
            ImageView(
              'assets/images/shopcart/icon_exclamation_mark2.png',
              width: 13.h,
              color: Get.theme.shopcartLabelColor,
            ),
          ],
        ),
      ],
    );
  }

  /*
  *分割线
   */
  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(
                alpha: 0.08,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }
}
