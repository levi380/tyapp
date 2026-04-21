import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';

import 'package:flutter_ty_app/main.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5a7d82aa-a062-4061-ad30-cc1cd2482bdc-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 文字带选中按钮开关组件 MenuSwitchWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 文字带选中按钮开关组件 MenuSwitchWidget
    ```
    ///文字带选中按钮开关组件
    MenuSwitchWidget(
      title: LocaleKeys.app_h5_filter_font_size.tr,
      isDark: controller.isDarkMode,
      switchA: LocaleKeys.app_h5_filter_default.tr,
      switchAParameter: controller.fontSize,
      switchAOnTap: () => controller.onFontSize(1),
      switchB: LocaleKeys.app_h5_filter_enlarge.tr,
      switchBParameter: controller.fontSize,
      switchBOnTap: () => controller.onFontSize(2),
      dividing: true,
      bigFontSize: true,
    )
    ```
    】】】
 *
 */
class MenuSwitchWidget extends StatelessWidget {
  const MenuSwitchWidget({
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
              ? Colors.white.withValues(alpha:0.5)
              : switchAParameter == 1
              ? const Color(0xff7981A4)
              : Colors.white,
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
              ? Colors.white.withValues(alpha:0.5)
              : switchAParameter == 1
              ? const Color(0xff7981A4)
              : Colors.white,
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
      height: 48.h,
      color:
          isDark ? Colors.white.withValues(alpha:0.03999999910593033) : Colors.white,
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
                        ? Colors.white.withValues(alpha:0.07999999821186066)
                        : const Color(0xFFF2F2F6),
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
                      ? Colors.white.withValues(alpha:0.8999999761581421)
                      : const Color(0xFF303442),
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
                      ? Colors.white.withValues(alpha:0.03999999910593033)
                      : const Color(0xFF7981A3),
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
                                      ? Colors.white
                                          .withValues(alpha:0.20000000298023224)
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
                                    ? Colors.white.withValues(alpha:0.5)
                                    : switchAParameter == 1
                                        ? const Color(0xff7981A4)
                                        : Colors.white,
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
                                      ? Colors.white
                                          .withValues(alpha:0.20000000298023224)
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
                                    ? Colors.white.withValues(alpha:0.5)
                                    : switchBParameter == 2
                                        ? const Color(0xff7981A4)
                                        : Colors.white,
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
                          ? Colors.white12.withValues(alpha:0.10000000298023224)
                          : Colors.white.withValues(alpha:.5),
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
