import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/utils/amount_util.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_theme.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注额输入Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注额输入部件
      输入提示显示投注范围
      如果账户余额为0，则输入提示显示请先充值
    】】】
 *
 */
class BetInputWidget extends StatelessWidget {
  BetInputWidget(this.textEditingController, this.focusNode, this.minValue,
      this.maxValue, this.backgroundColor,
      {this.focusColor,
      this.unfocusColor,
      this.showCurrency,
      this.height = 44,
      this.textAlign,
      this.borderRadius = 12,
      this.paddingHorizontal = 12,
      this.enabled = true,
      Key? key})
      : super(key: key);
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String minValue;
  final String maxValue;
  final Color backgroundColor;
  final Color? focusColor;
  final Color? unfocusColor;
  final bool? showCurrency;
  final TextAlign? textAlign;
  final double borderRadius;
  final double height;
  final double paddingHorizontal;
  final bool enabled;

  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    String hint =
        '${LocaleKeys.app_h5_bet_limit.tr} ${AmountUtil.toAmountSplit(double.parse(minValue).toStringAsFixed(2))}-${AmountUtil.toAmountSplit(double.parse(maxValue).toStringAsFixed(2))}';
    TextStyle hintStyle = TextStyle(
      color: themeData.shopcartTintColor,
      fontSize: 14.sp,
      fontFamily: 'Akrobat',
      fontWeight: FontWeight.w700,
    );
    if (TYUserController.to.balanceAmount.value <= 0) {
      hint = LocaleKeys.bet_message_m_0402035.tr;
      hintStyle = TextStyle(
        color: themeData.shopcartTintColor,
        fontSize: 12.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w500,
      );
    }
    return Container(
        height: height.h,
        padding:
            EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: enabled
                ? backgroundColor
                : themeData.shopcartClosedContentBackgroundColor,
            border:
                focusNode.hasFocus && logic!.showKeyBoard && focusColor != null
                    ? Border.all(
                        color: focusColor!,
                      )
                    : (unfocusColor != null
                        ? Border.all(
                            color: unfocusColor!,
                          )
                        : null)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                enabled: enabled,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700),
                //autofocus: true,
                textAlign: textAlign ?? TextAlign.start,
                enableInteractiveSelection: false,
                showCursor: true,
                readOnly: true,
                cursorColor: Colors.blue,
                // cursorHeight导致安卓光标不居中
                cursorHeight: Platform.isIOS ? 16.sp : null,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  hintText: hint,
                  hintStyle: hintStyle,
                ),
              ),
            ),
            if (showCurrency == true)
              Text(
                TYUserController.to.currCurrency(),
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ));
  }
}
