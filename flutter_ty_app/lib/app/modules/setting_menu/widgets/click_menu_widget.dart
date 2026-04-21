import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'dart:math';
import '../../../../main.dart';
import '../../../global/ty_user_controller.dart';
import '../../../widgets/image_view.dart';
import '../../shop_cart/shop_cart_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5a7d82aa-a062-4061-ad30-cc1cd2482bdc-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 一键投注 ClickMenuWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 一键投注 ClickMenuWidget
    】】】
 *
 */
class ClickMenuWidget extends StatelessWidget {
  const ClickMenuWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.isDark,
    required this.fastBetAmount,
    required this.dividing,
    this.enabled = true,
    required this.bigFontSize,

    required this.switchA,
    required this.switchOn,
    this.switchAOnTap,
    required this.switchB,
    this.switchBOnTap,
    this.setting,
  });

  final bool isDark;
  final bool dividing;
  final String title;
  final int fastBetAmount;
  final VoidCallback? onTap;
  final bool enabled;
  final bool bigFontSize;

  final String switchA;
  final bool switchOn;
  final VoidCallback? switchAOnTap;
  final String switchB;
  final VoidCallback? switchBOnTap;
  final VoidCallback? setting;

  @override
  Widget build(BuildContext context) {
    TextPainter textPainterA = TextPainter(
      text: TextSpan(
        text: switchA,
        style: TextStyle(
          color: isDark
              ? Colors.white.withValues(alpha:0.5)
              : switchOn
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
              : switchOn
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

    return InkWell(
      onTap: switchOn ? setting : null,
      child: Container(
        height: 48.h,
        color: isDark
            ? Colors.white.withValues(alpha:0.03999999910593033)
            : Colors.white,
        child: Container(
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
          margin: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 130.w,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: enabled
                        ? (isDark
                            ? Colors.white.withValues(alpha:0.8999999761581421)
                            : const Color(0xFF303442))
                        : (isDark
                            ? Colors.white.withValues(alpha:0.30000001192092896)
                            : const Color(0xFFAFB3C8)),
                    fontSize: bigFontSize ? 14.sp.scale : 14.sp,
                    fontFamily: 'PingFang SC',
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(switchOn == true)
                  InkWell(
                    onTap: setting,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            toAmountSplit(fastBetAmount.toStringAsFixed(2)),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white: const Color(0xFF303442) /* text-color-text */,
                              fontSize: bigFontSize ? 12.sp.scale : 12.sp,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          width: 2.w,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                              TYUserController.to.currCurrency(),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white : const Color(0xFF303442) /* text-color-text */,
                              fontSize: bigFontSize ? 12.sp.scale : 12.sp,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          width: 5.w,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: ImageView(
                            "assets/images/icon/edits_icon.png",
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),

                  Container(
                    alignment: Alignment.center,
                    height: 36.h,
                    decoration: ShapeDecoration(
                      color:
                      ShopCartController.to.isParlayMode() ?
                      Colors.grey.withValues(alpha:0.4) :
                      isDark
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
                              decoration: switchOn
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
                                        : switchOn
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
                              decoration: switchOn == false
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
                                        : switchOn == false
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String toAmountSplit(String num) {
    String numStr = (num).toString();

    if (numStr.contains('.')) {
      List<String> parts = numStr.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
        (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    } else {
      return numStr.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
        (match) => '${match.group(1)},',
      );
    }
  }
}
