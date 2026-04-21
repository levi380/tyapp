import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';

import 'package:flutter_ty_app/main.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-865e55c5-ff96-400e-9c5b-fa97bce48a09-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票设置菜单 开关小组件  CpSwitchWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票设置菜单 开关小组件   CpSwitchWidget
    - CpSwitchWidget
    ```
    CpSwitchWidget(
      title: LocaleKeys.footer_menu_theme.tr,
      isDark: controller.isDarkMode,
      switchA: LocaleKeys.footer_menu_daytime.tr,
      switchAParameter: controller.themeStyle,
      switchAOnTap: () => controller.onThemeStyle(1),
      switchB: LocaleKeys.footer_menu_night.tr,
      switchBParameter: controller.themeStyle,
      switchBOnTap: () => controller.onThemeStyle(2),
      dividing: true,
      bigFontSize: false,
    )
    ```
    】】】
 *
 */
class CpSwitchWidget extends StatelessWidget {
  const CpSwitchWidget({
    super.key,
    required this.title,
    required this.isDark,
    required this.switchA,
    required this.switchAParameter,
    this.switchAOnTap,
    required this.switchB,
    required this.switchBParameter,
    this.switchBOnTap,
    required this.dividing,
    this.disableSwitch,
    required this.bigFontSize,
  });

  final bool isDark;
  final bool dividing;
  final String title;
  final String switchA;
  final int switchAParameter;
  final VoidCallback? switchAOnTap;
  final bool? disableSwitch;

  final String switchB;
  final int switchBParameter;
  final VoidCallback? switchBOnTap;
  final bool bigFontSize;

  @override
  Widget build(BuildContext context) {

    TextPainter textPainterA = TextPainter(
      text: TextSpan(
        text: switchA,
        style: TextStyle(
          color: isDark
              ? CpState.switchWidgetTextUnselColorDark
              : switchAParameter == 1
              ? CpState.switchWidgetTextSelColorLight
              : CpState.switchWidgetTextUnselColorLight,
          fontSize: bigFontSize ? 12.sp.scale : 12.sp,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainterA.layout();
    TextPainter textPainterB = TextPainter(
      text: TextSpan(
        text: switchB,
        style: TextStyle(
          color: isDark
              ? CpState.switchWidgetTextUnselColorDark
              : switchAParameter == 1
              ? CpState.switchWidgetTextSelColorLight
              : CpState.switchWidgetTextUnselColorLight,
          fontSize: bigFontSize ? 12.sp.scale : 12.sp,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainterB.layout();
    double textWidth = max(textPainterA.width + 20.w,textPainterB.width + 20.w);
    textWidth = min(textWidth,isIPad ? 150.w:70.w);

    return Container(
      height: CpState.powerSwitchHeight,
      color:
          isDark ? CpState.amountRangeBgColorDark : Colors.white,
      child: Container(
        margin: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
        ),
        decoration: dividing == true
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? CpState.powerSwitchBorderColorDark
                        : CpState.powerSwitchBorderColorLight,
                    width: 0.50.h,
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: isIPad ? 200.w : 150.w,
              child:Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDark
                      ? CpState.amountRangeTitleColorDark
                      : CpState.amountRangeTitleColorLight,
                  fontSize:  bigFontSize ? 14.sp.scale : 14.sp,
                ),
              ) ,
            )
            ,
            Stack(
                children: [
              Container(
                alignment: Alignment.center,
                height: 36.h,
                decoration: ShapeDecoration(
                  color: isDark
                      ? CpState.amountRangeBgColorDark
                      : CpState.switchWidgetInnerBgColorLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isIPad ? 30.r : 18.r),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: switchAOnTap,
                        child: Container(
                          alignment: Alignment.center,
                          height: 32.h,
                          decoration: switchAParameter == 1
                              ? ShapeDecoration(
                                  color: isDark
                                      ? CpState.switchWidgetSelBgColorDark
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              : null,
                          child: Container(
                            width: textWidth,
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: AutoSizeText(
                              switchA,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isDark
                                    ? CpState.switchWidgetTextUnselColorDark
                                    : switchAParameter == 1
                                        ? CpState.switchWidgetTextSelColorLight
                                        : CpState.switchWidgetTextUnselColorLight,
                                fontSize:  bigFontSize ? 12.sp.scale : 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: switchBOnTap,
                        child: Container(
                          alignment: Alignment.center,
                          height: 32.h,
                          decoration: switchBParameter == 2
                              ? ShapeDecoration(
                                  color: isDark
                                      ? CpState.switchWidgetSelBgColorDark
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              : null,
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            width: textWidth,
                            child: AutoSizeText(
                              switchB,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isDark
                                    ? CpState.switchWidgetTextUnselColorDark
                                    : switchBParameter == 2
                                        ? CpState.switchWidgetTextSelColorLight
                                        : CpState.switchWidgetTextUnselColorLight,
                                fontSize: bigFontSize ? 12.sp.scale : 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (disableSwitch == true)
                Positioned.fill(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: isDark
                          ? CpState.switchWidgetDisableColorDark
                          : CpState.switchWidgetDisableColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
            ]),
          ],
        ),
      ),
    );
  }
}
