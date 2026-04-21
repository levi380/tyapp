import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../main.dart';
import '../../../extension/color_extension.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单串关展示优惠盘口还是常规盘口Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于注单串关展示优惠盘口还是常规盘口信息。
    - `HandicapInformationView`：接收两个参数：
    - `oddFinally`：字符串类型，表示需要展示赔率的信息。
    - `eov`：字符串类型，表示需要展示优惠盘口赔率的信息。
    - 根据当前主题模式（暗黑模式或亮色模式）设置文本颜色。
    - 返回一个赔率盘口 `Container`：
    】】】
 *
 */
class HandicapInformationView extends StatelessWidget {
  const HandicapInformationView({
    Key? key,
    required this.oddFinally,
    required this.eov,
  }) : super(key: key);
  final String oddFinally, eov;

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();
    if (eov.isNotEmpty) {
      ///优惠盘口
      widget = Container(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 2.h,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFFD1EBFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "@",
              style: TextStyle(
                color: Color(
                  context.isDarkMode ? 0xFF127DCC : 0xFF179CFF,
                ),
                // color: const Color(0xFF303442).withValues(alpha:0.8),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ).marginOnly(right: 2.h),
            Text(
              eov,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xFF303442).withValues(alpha: 0.6),
                fontSize: 13.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough,
                height: 1.4,
              ),
            ).marginOnly(right: 1.5.h),
            ImageView(
              'assets/images/bets/preferential_icon.png',
              width: 10.w,
              height: 10.h,
            ).marginOnly(right: 1.5.h),
            Text(
              oddFinally,
              style: TextStyle(
                color: const Color(0xFF303442),
                fontSize: 13.sp,
                fontFamily: 'Akrobat',
                height: 1.4,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ).marginOnly(right: 1.5.h),
            ImageView(
             // context.isDarkMode
             //     ? 'assets/images/bets/preferential_odds_night.png'
             //     : 'assets/images/bets/preferential_odds_daytime.png',
              'assets/images/icon/up.png',
              width: 16.w,
              height: 16.h,
            ),
          ],
        ),
      );
    } else {
      ///常规盘口
      widget = Text(
        oddFinally,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: isFootballBasketballTemplate ? HexColor(footballBasketballTemplateThemeColor) :Color(
            context.isDarkMode ? 0xFF127DCC : 0xFF179CFF,
          ),
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w500,
        ),
      );
    }
    return widget;
  }
}
