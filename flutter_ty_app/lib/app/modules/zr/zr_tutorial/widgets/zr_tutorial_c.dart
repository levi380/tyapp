import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_c_a.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';

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

class ZrTutorialCWidget extends StatelessWidget {
  const ZrTutorialCWidget({
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
        margin:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h, bottom: 30.h),
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
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xFF333333),
                    fontSize: 18.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                color:
                    isDark ? const Color(0xFF4A4346) : const Color(0xFFF2F2F6),
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
                        top: 10.w,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/1.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/2.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/3.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/4.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/5.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/6.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/7.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/8.png',
                              width: 30.w,
                              height: 50.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ImageView(
                              'assets/images/icon/help/9.png',
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
                        LocaleKeys.zr_cp_footer_menu_zr_zrtext_2_contents0.tr,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.5)
                              : const Color(0xFF8D8D8D),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ZrTutorialCAWidget(
                      isDark: isDark,
                      title: title,
                    )
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
