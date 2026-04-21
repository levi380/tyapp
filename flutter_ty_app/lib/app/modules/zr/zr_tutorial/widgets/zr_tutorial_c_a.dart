
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../generated/locales.g.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  点数计算 ZrTutorialCWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 点数计算 ZrTutorialCWidget
    - ZrTutorialCWidget
    ```
    ///点数计算
    ZrTutorialCWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),
    ```
    】】】
 *
 */

class ZrTutorialCAWidget extends StatelessWidget {
  const ZrTutorialCAWidget({
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
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 2.w),
                child: ImageView(
                  'assets/images/icon/help/10.png',
                  width: 30.w,
                  height: 50.h,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 2.w),
                child: ImageView(
                  'assets/images/icon/help/11.png',
                  width: 30.w,
                  height: 50.h,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 2.w),
                child: ImageView(
                  'assets/images/icon/help/12.png',
                  width: 30.w,
                  height: 50.h,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 2.w),
                child: ImageView(
                  'assets/images/icon/help/13.png',
                  width: 30.w,
                  height: 50.h,
                ),
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
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_2_contents1.tr,
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
          height: 150.h,
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_2_contents2.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white.withValues(alpha:0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize:  14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      width: 0.5.w,
                      color: isDark
                          ? Colors.white.withValues(alpha:0.07999999821186066)
                          : const Color(0xFFE4E6ED),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: ImageView(
                            'assets/images/icon/help/13.png',
                            width: 30.w,
                            height: 50.h,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ImageView(
                            'assets/images/icon/help/2.png',
                            width: 30.w,
                            height: 50.h,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Transform.rotate(
                            angle: 1.57,
                            child: ImageView(
                              'assets/images/icon/help/9.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '=',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '1${LocaleKeys.zr_cp_footer_menu_zr_point.tr}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize: 16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: ImageView(
                            'assets/images/icon/help/10.png',
                            width: 30.w,
                            height: 50.h,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ImageView(
                            'assets/images/icon/help/11.png',
                            width: 30.w,
                            height: 50.h,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Transform.rotate(
                            angle: 1.57,
                            child: ImageView(
                              'assets/images/icon/help/12.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '=',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '0${LocaleKeys.zr_cp_footer_menu_zr_point.tr}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: ImageView(
                            'assets/images/icon/help/10.png',
                            width: 30.w,
                            height: 50.h,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize: 16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ImageView(
                            'assets/images/icon/help/11.png',
                            width: 30.w,
                            height: 50.h,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Transform.rotate(
                            angle: 1.57,
                            child: ImageView(
                              'assets/images/icon/help/13.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            '=',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize: 16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '0${LocaleKeys.zr_cp_footer_menu_zr_point.tr}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  .withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize:  16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              )

            ],
          ),
        ),
      ],
    );
  }
}
