import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 大小球攻略  小组件  BigAndSmallBallWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程  大小球攻略 小组件  BigAndSmallBallWidget
    - BigAndSmallBallWidget
    ```
    /// 子布局
    BigAndSmallBallWidget(
      isDark: context.isDarkMode,
      title:LocaleKeys.app_h5_handicap_tutorial_ball.tr.replaceAll('%s', '3'),
      subTitle: LocaleKeys.app_h5_handicap_tutorial_note_17.tr,
      lTitle:LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '3'),
      lSubTitle: LocaleKeys.app_h5_handicap_tutorial_return_principal.tr,
      lSubTitleColor: const Color(0x19AFAFAF),
      lSubTitleTextColor: const Color(0xFFAFAFAF),
      cTitle: '3',
      cSubTitle:LocaleKeys.app_h5_handicap_tutorial_handicapData_condition_1.tr,
      rTitle:LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '3'),
      rSubTitle: LocaleKeys.app_h5_handicap_tutorial_return_principal.tr,
      rSubTitleColor: const Color(0x19AFAFAF),
      rSubTitleTextColor: const Color(0xFFAFAFAF),
    )
    ```
    】】】
 *
 */

class BigAndSmallBallWidget extends StatelessWidget {
  const BigAndSmallBallWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.subTitle,
    required this.lTitle,
    required this.lSubTitle,
    required this.lSubTitleColor,
    required this.lSubTitleTextColor,
    required this.cTitle,
    required this.cSubTitle,
    required this.rTitle,
    required this.rSubTitle,
    required this.rSubTitleColor,
    required this.rSubTitleTextColor,
  });

  final bool isDark;
  final String title;
  final String subTitle;
  final String lTitle;
  final String lSubTitle;
  final Color lSubTitleColor;
  final Color lSubTitleTextColor;
  final String cTitle;
  final String cSubTitle;
  final String rTitle;
  final String rSubTitle;
  final Color rSubTitleColor;
  final Color rSubTitleTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
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
                  ? Colors.white.withValues(alpha:0.07999999821186066)
                  : const Color(0xFFFBFBFB),
              margin: EdgeInsets.only(
                top: 12.h,
              ),
              height: 1.h,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? const Color.fromRGBO(255, 255, 255, 0.4)
                      : const Color(0xFF8D8D8D),
                  fontSize:13.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 4.h,
                      ),
                      child: Text(
                        lTitle,
                        textAlign: TextAlign.center,
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
                      margin: EdgeInsets.only(top: 10.h),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: lSubTitleColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: Color(0x19F53F3F)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 2.h,
                          bottom: 2.h,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          lSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: lSubTitleTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 80.w,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        child: Text(
                          cTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xFF333333),
                            fontSize: 32.sp,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 4.h,
                        ),
                        child: Text(
                          cSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withValues(alpha:0.4000000059604645)
                                : const Color(0xFFAFAFAF),
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 4.h,
                      ),
                      child: Text(
                        rTitle,
                        textAlign: TextAlign.center,
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
                      margin: EdgeInsets.only(top: 10.h),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: rSubTitleColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50.w,
                            color: const Color(0x1900B42A),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 2.h,
                          bottom: 2.h,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          rSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: rSubTitleTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
