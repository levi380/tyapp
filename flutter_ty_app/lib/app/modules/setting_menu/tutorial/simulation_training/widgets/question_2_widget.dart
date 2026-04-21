import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/simulation_training/widgets/question_2_2_widget.dart';

import '../../../../../../generated/locales.g.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 大小球模拟训练 视图页面 第二题 Question2Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 大小球模拟训练 视图页面 第二题 Question1Widget
    - Question2Widget
    ```
    ///第二题
    Question2Widget(
      isDark: context.isDarkMode,
      question: controller.question2,
      select: controller.select,
      onSelect: (index) => controller.onSelect(index),
      nextQuestion: () => controller.nextQuestion(),
      onBack: () => controller.onBack(),
    ),
    ```
    】】】
 *
 */
class Question2Widget extends StatelessWidget {
  const Question2Widget({
    super.key,
    required this.isDark,
    required this.question,
    required this.select,
    required this.onSelect,
    this.nextQuestion,
    this.onBack,
  });

  final bool isDark;
  final bool question;
  final int select;
  final void Function(dynamic) onSelect;
  final VoidCallback? nextQuestion;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: question,
      child: Container(
        margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
        decoration: isDark
            ? BoxDecoration(
          color: Color(0xFF23252B),
          borderRadius: BorderRadius.all(
            Radius.circular(25.r),
          ),
        )
            : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25.r),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 18.h,
                    decoration: ShapeDecoration(
                      color: const Color(0x33AFAFAF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_single.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              : const Color(0xFF333333),
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  '2、${LocaleKeys.app_h5_handicap_tutorial_results_appear.tr}：${LocaleKeys.app_h5_handicap_tutorial_which_win_half.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ImageView(
                            'assets/images/icon/ml.png',
                            width: 48.w,
                            height: 48.w,
                          ),
                          Container(
                            height: 40.h,
                            margin: EdgeInsets.only(
                              top: 15.h,
                            ),
                            child: Text(
                              LocaleKeys
                                  .app_h5_handicap_tutorial_m_chesester_untied
                                  .tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                        .withValues(alpha:0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        width: 100.w,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                        .withValues(alpha:0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: context.isDarkMode
                                  ? Colors.white.withValues(alpha:0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                        .withValues(alpha:0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ImageView(
                            'assets/images/icon/cex.png',
                            width: 48.w,
                            height: 48.w,
                          ),
                          Container(
                            height: 40.h,
                            margin: EdgeInsets.only(
                              top: 15.h,
                            ),
                            child: Text(
                              LocaleKeys.app_h5_handicap_tutorial_chelsea.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                        .withValues(alpha:0.8999999761581421)
                                    : const Color(0xFF333333),
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
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => onSelect(1),
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: Color(0x33AFAFAF)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.app_h5_handicap_tutorial_big.tr
                                      .replaceAll('%s', '2/2.5'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8D8D8D),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      'assets/images/icon/t_up.png',
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    Container(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '1.99',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFF53F3F),
                                        fontSize: 18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          select == 1
                              ? Container(
                                  width: 130.w,
                                  height: 71.h,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF53F3F)
                                        .withValues(alpha:0.1),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2.w,
                                        color: const Color(0xFFF53F3F),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: ImageView(
                                          'assets/images/icon/s_wrong.png',
                                          width: 24.w,
                                          height: 24.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onSelect(2),
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: Color(0x33AFAFAF)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.app_h5_handicap_tutorial_small.tr
                                      .replaceAll('%s', '2/2.5'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8D8D8D),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      'assets/images/icon/t_down.png',
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    Container(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '1.98',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF00bd00),
                                        fontSize: 18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          select == 1 || select == 2
                              ? Container(
                                  width: 130.w,
                                  height: 71.h,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF179CFF)
                                        .withValues(alpha:0.1),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: select == 1 ? 1.w : 2.w,
                                        color: select == 1
                                            ? const Color(0x33AFAFAF)
                                            : const Color(0xFF179CFF),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: ImageView(
                                          'assets/images/icon/s_right.png',
                                          width: 24.w,
                                          height: 24.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Question22Widget(
                isDark: context.isDarkMode,
                question: question,
                select: select,
                nextQuestion: nextQuestion,
                onBack:onBack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
