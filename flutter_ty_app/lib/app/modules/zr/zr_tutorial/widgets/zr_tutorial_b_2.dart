import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_b_2_a.dart';
import '../../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  博牌牌例 庄博牌 ZrTutorialB2Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 博牌牌例 庄博牌 ZrTutorialB2Widget
    - ZrTutorialB2Widget
    ```
    ///庄博牌
    ZrTutorialB2Widget(
    isDark: isDark,
    title: title,
    ),
    ```
    】】】
 *
 */

class ZrTutorialB2Widget extends StatelessWidget {
  const ZrTutorialB2Widget({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_1_title2.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.8999999761581421)
                  : const Color(0xFF333333),
              fontSize: 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF433D3F) : const Color(0xFFF2F2F6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Container(
            margin:
                EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_0.tr,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents3.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: isDark ? const Color(0xFF332F33) : Colors.white,
          child: Container(
            margin:
                EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_1_contents1.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: isDark ? const Color(0xFF433D3F) : const Color(0xFFF2F2F6),
          child: Container(
            margin:
                EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_1_contents1.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: isDark ? const Color(0xFF332F33) : Colors.white,
          child: Container(
            margin:
                EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_1_contents1.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ZrTutorialB2AWidget(
          isDark: isDark,
          title: title,
        ),
      ],
    );
  }
}
