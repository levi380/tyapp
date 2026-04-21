import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

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

class ZrTutorialE2AWidget extends StatelessWidget {
  const ZrTutorialE2AWidget({
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents46.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents47.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents48.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents49.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents50.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents51.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents52.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents53.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents54.tr,
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
          color: isDark ? const Color(0xFF433D3F) : const Color(0xFFF2F2F6),
          child: Container(
            margin:
                EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents55.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents56.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents57.tr,
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
                        Text(
                          LocaleKeys
                              .zr_cp_footer_menu_zr_zrtext_4_contents58.tr,
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
                        Text(
                          LocaleKeys
                              .zr_cp_footer_menu_zr_zrtext_4_contents59.tr,
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
                        Text(
                          LocaleKeys
                              .zr_cp_footer_menu_zr_zrtext_4_contents60.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents61.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents62.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents63.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents64.tr,
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
                              .zr_cp_footer_menu_zr_zrtext_4_contents65.tr,
                          textAlign: TextAlign.start,
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
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF332F33) : Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
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
                      LocaleKeys.zr_cp_footer_menu_zr_zrtext_4_contents66.tr,
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
                          '1:25',
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
                        Container(
                          height: 10,
                        ),
                        Text(
                          '1:25',
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
      ],
    );
  }
}
