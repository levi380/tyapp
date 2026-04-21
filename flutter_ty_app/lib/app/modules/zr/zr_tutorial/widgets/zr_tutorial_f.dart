

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  游戏特点 ZrTutorialFWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 游戏特点 ZrTutorialFWidget
    - ZrTutorialFWidget
    ```
    ///游戏特点
    ZrTutorialFWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),
    ```
    】】】
 *
 */

class ZrTutorialFWidget extends StatelessWidget {
  const ZrTutorialFWidget({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w,top: 16.h,bottom: 30.h),
        decoration: isDark
            ? BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.r)),
          image: DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                'assets/images/icon/tutorial_background_darks.png',
              ),
            ),
            fit: BoxFit.cover,
          ),
        )
            : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25.r),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 12.h, bottom: 24.h),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha:0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 18.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                color: isDark ? const Color(0xFF4A4346) : const Color(0xFFF2F2F6),
                margin: EdgeInsets.only(
                  top: 12.h,
                ),
                height: 1.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_5_0.tr,
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
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_5_1.tr,
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
                    Get.locale!.toLanguageTag().contains('zh-CN')|| Get.locale!.toLanguageTag().contains('zh-TW') ?
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_1.tr,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white.withValues(alpha:0.5)
                                  : const Color(0xFF8D8D8D),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 20.w,
                            height: 20.h,
                            margin: EdgeInsets.only(
                              left: 2.h,
                              right: 5.h,
                            ),
                            padding: EdgeInsets.all(5.r),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2.w, color: const Color(0xFF179CFF)),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: const ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.73, -0.68),
                                  end: Alignment(-0.73, 0.68),
                                  colors: [Color(0xFFF4D7A6), Color(0xFFE5C18A)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Text(
                            LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_2.tr,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white.withValues(alpha:0.5)
                                  : const Color(0xFF8D8D8D),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 20.w,
                            height: 20.h,
                            margin: EdgeInsets.only(
                              left: 5.h,
                              right: 5.h,
                            ),
                            padding: EdgeInsets.all(5.r),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2.w, color: const Color(0xFFF53F3F)),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: const ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.73, -0.68),
                                  end: Alignment(-0.73, 0.68),
                                  colors: [Color(0xFFF4D7A6), Color(0xFFE5C18A)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                            LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_3.tr,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white.withValues(alpha:0.5)
                                  : const Color(0xFF8D8D8D),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),)
                        ],
                      ),
                    ):
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_1.tr,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white.withValues(alpha:0.5)
                                  : const Color(0xFF8D8D8D),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.h,
                                margin: EdgeInsets.only(
                                  left: 2.h,
                                  right: 5.h,
                                ),
                                padding: EdgeInsets.all(5.r),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2.w, color: const Color(0xFF179CFF)),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                                child: Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: const ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.73, -0.68),
                                      end: Alignment(-0.73, 0.68),
                                      colors: [Color(0xFFF4D7A6), Color(0xFFE5C18A)],
                                    ),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Text(
                                LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_2.tr,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white.withValues(alpha:0.5)
                                      : const Color(0xFF8D8D8D),
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                width: 20.w,
                                height: 20.h,
                                margin: EdgeInsets.only(
                                  left: 5.h,
                                  right: 5.h,
                                ),
                                padding: EdgeInsets.all(5.r),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2.w, color: const Color(0xFFF53F3F)),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                                child: Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: const ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.73, -0.68),
                                      end: Alignment(-0.73, 0.68),
                                      colors: [Color(0xFFF4D7A6), Color(0xFFE5C18A)],
                                    ),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Container(
                              alignment: Alignment.centerLeft,
                                width: 180.w,
                                child: Text(
                                  LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_3.tr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white.withValues(alpha:0.5)
                                        : const Color(0xFF8D8D8D),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_7.tr,
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
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_4.tr,
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
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_5.tr,
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
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_7_6.tr,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
