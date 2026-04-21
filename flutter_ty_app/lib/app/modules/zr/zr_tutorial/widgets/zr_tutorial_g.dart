
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  注意事项 ZrTutorialGWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 注意事项 ZrTutorialGWidget
    - ZrTutorialGWidget
    ```
    ///注意事项
    ZrTutorialGWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),
    ```
    】】】
 *
 */

class ZrTutorialGWidget extends StatelessWidget {
  const ZrTutorialGWidget({
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
                color: isDark
                    ? const Color(0xFF4A4346)
                    : const Color(0xFFF2F2F6),
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
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_6_0.tr,
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
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_6_1.tr,
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
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_6_2.tr,
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
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_6_3.tr,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
