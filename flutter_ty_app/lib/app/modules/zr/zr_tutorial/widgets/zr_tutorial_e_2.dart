import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_e_2_a.dart';

import '../../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  赔率表 ZrTutorialE2Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赔率表 ZrTutorialE2Widget
    - ZrTutorialE2Widget
    ```
    ZrTutorialE2Widget(
    isDark: isDark,
    title: title,
    )
    ```
    】】】
 *
 */

class ZrTutorialE2Widget extends StatelessWidget {
  const ZrTutorialE2Widget({
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents32.tr,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '1:40',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents34.tr,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '1:4',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents36.tr,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '1:1.6',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents38.tr,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          '1:1',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                    .withValues(alpha: 0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          LocaleKeys
                              .zr_cp_footer_menu_zr_zrtext_4_contents40.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                    .withValues(alpha: 0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents41.tr,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '1:8',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents43.tr,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          LocaleKeys
                              .zr_cp_footer_menu_zr_zrtext_4_contents44.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                    .withValues(alpha: 0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          height: 10.h,
                        ),
                        Text(
                          LocaleKeys
                              .zr_cp_footer_menu_zr_zrtext_4_contents45.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                    .withValues(alpha: 0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ZrTutorialE2AWidget(isDark: isDark, title: title),
      ],
    );
  }
}
