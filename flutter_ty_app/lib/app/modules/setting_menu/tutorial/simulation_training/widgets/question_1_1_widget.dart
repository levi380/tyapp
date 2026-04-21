import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 大小球模拟训练 视图页面 第一题 Question1Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 大小球模拟训练 视图页面 第一题 Question1Widget
    - Question1Widget
    ```
    ///第一题
    Question1Widget(
    isDark: context.isDarkMode,
    question: controller.question1,
    select: controller.select,
    onSelect: (index) => controller.onSelect(index),
    nextQuestion: () => controller.nextQuestion(),
    ),

    ```
    】】】
 *
 */
class Question11Widget extends StatelessWidget {
  const Question11Widget({
    super.key,
    required this.isDark,
    required this.select,
    this.nextQuestion,
  });

  final bool isDark;
  final int select;
  final VoidCallback? nextQuestion;

  @override
  Widget build(BuildContext context) {
    return select == 1
        ? Container(
      margin: EdgeInsets.only(
        top: 30.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: ImageView(
              'assets/images/icon/a_wrong.png',
              width: 40.w,
              height: 40.w,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            child: Text(
              LocaleKeys.app_h5_handicap_tutorial_not_master.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white
                    .withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF333333),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            child: Text(
              LocaleKeys
                  .app_h5_handicap_tutorial_questionsData_1_note_1
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white
                    .withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF333333),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(
              10.h,
            ),
            child: HtmlWidget(
              LocaleKeys.app_questionsData_1_note_2.tr,
              textStyle: TextStyle(
                color: context.isDarkMode
                    ? Colors.white
                    .withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF333333),
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
            color: context.isDarkMode
                ? Colors.white
                .withValues(alpha: 0.07999999821186066)
                : const Color(0xFFFBFBFB),
            height: 1.h,
          ),
          InkWell(
            onTap: nextQuestion,
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.app_h5_handicap_tutorial_next.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF179CFF),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        : select == 2
        ? Container(
      margin: EdgeInsets.only(
        top: 30.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: ImageView(
              'assets/images/icon/a_right.png',
              width: 40.w,
              height: 40.w,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            child: Text(
              LocaleKeys
                  .app_h5_handicap_tutorial_red_list.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(
                    alpha: 0.8999999761581421)
                    : const Color(0xFF333333),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            child: Text(
              LocaleKeys
                  .app_h5_handicap_tutorial_questionsData_1_note_1
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(
                    alpha: 0.8999999761581421)
                    : const Color(0xFF333333),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(
              10.h,
            ),
            child: HtmlWidget(
              LocaleKeys.app_questionsData_1_note_2.tr,
              textStyle: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(
                    alpha: 0.8999999761581421)
                    : const Color(0xFF333333),
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
            color: context.isDarkMode
                ? Colors.white
                .withValues(alpha: 0.07999999821186066)
                : const Color(0xFFFBFBFB),
            height: 1.h,
          ),
          InkWell(
            onTap: nextQuestion,
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.app_h5_handicap_tutorial_next.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF179CFF),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        : Container();
  }
}
