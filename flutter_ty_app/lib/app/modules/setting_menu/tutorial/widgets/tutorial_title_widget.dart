
import 'package:flutter_ty_app/app/config/getx_navigation.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 头部小组件  TutorialTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程  头部小组件  TutorialTitleWidget
    - TutorialTitleWidget
    ```
      ///头部小组件
      TutorialTitleWidget(
        title1: LocaleKeys.footer_menu_rangqiu.tr +
        LocaleKeys.app_h5_handicap_tutorial_introdution.tr,
        title2: LocaleKeys.app_h5_handicap_tutorial_big_small_ball.tr +
        LocaleKeys.app_h5_handicap_tutorial_introdution.tr,
        scrollController: controller.scrollController,
        isDark: context.isDarkMode,
        onTutorial: (Tutorial) => controller.onTutorial(Tutorial),
        tutorial: controller.tutorial,
      )
    ```
    】】】
 *
 */
class TutorialTitleWidget extends StatelessWidget {
  const TutorialTitleWidget({
    super.key,
    required this.title1,
    required this.title2,
    required this.scrollController,
    required this.isDark,
    required this.onTutorial,
    required this.tutorial,
  });

  final String title1;
  final String title2;
  final dynamic scrollController;
  final bool isDark;
  final void Function(dynamic) onTutorial;
  final int tutorial;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: () => Get_TY.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => onTutorial(0),
                        child: Text(
                          title1,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            color: context.isDarkMode
                                ? tutorial == 0
                                    ? Colors.white
                                        .withValues(alpha:0.8999999761581421)
                                    : Colors.white.withValues(alpha:0.5)
                                : tutorial == 0
                                    ? const Color(0xFF333333)
                                    : const Color(0xFF8D8D8D),
                            fontSize: tutorial == 0 ? 18.sp : 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () => onTutorial(1),
                        child: Text(
                          title2,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            color: context.isDarkMode
                                ? tutorial == 1
                                    ? Colors.white
                                        .withValues(alpha:0.8999999761581421)
                                    : Colors.white.withValues(alpha:0.5)
                                : tutorial == 1
                                    ? const Color(0xFF333333)
                                    : const Color(0xFF8D8D8D),
                            fontSize: tutorial == 1 ? 18.sp : 16.sp ,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                width: 10.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
