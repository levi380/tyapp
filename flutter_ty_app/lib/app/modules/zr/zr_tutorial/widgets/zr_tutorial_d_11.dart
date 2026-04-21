
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../generated/locales.g.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  玩法判定 庄天牌&闲天牌 ZrTutorialD11Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 玩法判定 庄天牌&闲天牌 ZrTutorialD11Widget
    - ZrTutorialD11Widget
    ```
    ///11.庄天牌&闲天牌
    ZrTutorialD11Widget(
    isDark: isDark,
    ),
    ```
    】】】
 *
 */
class ZrTutorialD11Widget extends StatelessWidget {
  const ZrTutorialD11Widget({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 50.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents35.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.8999999761581421)
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
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents36.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          height: 110.h,
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents2.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha:0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                width: 0.5.w,
                color: isDark
                    ? Colors.white.withValues(alpha:0.07999999821186066)
                    : const Color(0xFFE4E6ED),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/10.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/8.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, right: 5.w),
                        child: Text(
                          '=',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '8${LocaleKeys.zr_cp_footer_menu_zr_point.tr}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/7.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/10.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, right: 5.w),
                        child: Text(
                          '=',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '7${LocaleKeys.zr_cp_footer_menu_zr_point.tr}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents37.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          height: 110.h,
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents2.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha:0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                width: 1.w,
                color: isDark
                    ? Colors.white.withValues(alpha:0.07999999821186066)
                    : const Color(0xFFE4E6ED),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/10.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/7.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, right: 5.w),
                        child: Text(
                          '=',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '7${LocaleKeys.zr_cp_footer_menu_zr_point.tr}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/9.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ImageView(
                          'assets/images/icon/help/10.png',
                          width: 30.w,
                          height: 50.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, right: 5.w),
                        child: Text(
                          '=',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize:16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          '9${LocaleKeys.zr_cp_footer_menu_zr_point.tr}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
