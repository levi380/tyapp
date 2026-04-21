import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/format/common/module/format-currency.dart';
import '../shop_cart_controller.dart';
import '../single_bet/single_prebook/single_prebook_controller.dart';

class BetButtonWidget extends StatefulWidget {
  BetButtonWidget({this.profitOrTotal = 1, this.isPrebook = false, Key? key}) : super(key: key);
  final int profitOrTotal; //1单关显示可盈，2串关显示合计
  final bool isPrebook;

  @override
  _BetButtonState createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButtonWidget> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale?.languageCode ?? "zh";
    if (languageCode == 'ru') {
      return _buildEllipsis(context);
    } else {
      return _buildNormal(context);
    }
  }

  Widget _buildNormal(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //用isPrebook来区分预约投注
    final logic = widget.isPrebook
        ? Get.find<SinglePrebookController>()
        : ShopCartController.to.currentBetController;
    return Obx(() {
      List<Color> colors = [const Color(0XFF179CFF), const Color(0XFF45B0FF)];
      if (isProcessing) {
        //点击效果
        colors = [
          themeData.shopcartButtonDisableBackgroundColor,
          themeData.shopcartButtonDisableBackgroundColor
        ];
      }
      bool isSpecialState = logic!.isSpecialState;
      //double inputAmount = logic!.inputTotal;
      if (isSpecialState) {
        colors = [
          themeData.shopcartButtonDisableBackgroundColor,
          themeData.shopcartButtonDisableBackgroundColor
        ];
      }
      // else if(inputAmount == 0){
      //   colors = [
      //     themeData.shopcartButtonDisableBackgroundColor,
      //     themeData.shopcartButtonDisableBackgroundColor
      //   ];
      // }
      double oddFinally = double.tryParse(logic.itemList.safeFirst?.oddFinally.value ?? "0)") ?? 0.0;
      bool isNotNegativeOdd = oddFinally > -0.000001;
      return InkWell(
          onTap: () async {
            if(isSpecialState) return;
            if (!isProcessing) {
              setState(() {
                isProcessing = true;
              });
              bool result = await logic.doBet();
              if (!result) {
                setState(() {
                  isProcessing = false;
                });
              }
            }
          },
          child: Container(
              padding: EdgeInsets.all(3.h),
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.h),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  height: 44.h,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                if (!isSpecialState)
                                  Text( widget.isPrebook
                                      ? LocaleKeys.bet_bet_book_confirm.tr
                                      : LocaleKeys.app_betting_now.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                else
                                  Text(
                                    logic.specialStateReason,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                const SizedBox( width: 4, ),
                                if (!isSpecialState)
                                  Opacity(
                                    opacity: 0.60,
                                    child: Obx(() {
                                      if (widget.profitOrTotal == 1) {
                                        double profitAmount = logic.profitAmount(0);
                                        if (isNotNegativeOdd) {
                                          String winTotal = TYFormatCurrency.formatCurrency(profitAmount);
                                          return RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: LocaleKeys.app_h5_bet_bet_win.tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontFamily: 'PingFang SC',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: winTotal,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontFamily: 'Akrobat',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ]));
                                        } else {
                                          double betAmount = ((profitAmount.abs()) * 100).ceilToDouble() / 100;
                                          String inputTotal = TYFormatCurrency.formatCurrency(betAmount);
                                          String winTotal =
                                          TYFormatCurrency.formatCurrency(logic.inputTotal);
                                          return Column(
                                              mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.baseline, // 根据文本基线对齐
                                                  textBaseline: TextBaseline.alphabetic, // 设置基线对齐方式
                                                  children: [
                                                    Text(
                                                      LocaleKeys.app_place_bet.tr,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      inputTotal,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Akrobat',
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.baseline, // 根据文本基线对齐
                                                  textBaseline: TextBaseline.alphabetic, // 设置基线对齐方式
                                                  children: [
                                                    Text(
                                                      LocaleKeys.app_h5_bet_bet_win.tr,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      winTotal,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Akrobat',
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ]);
                                        }
                                      } else {
                                        String inputTotal =
                                        TYFormatCurrency.formatCurrency(
                                            logic.inputTotal);
                                        return RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: LocaleKeys.bet_sum.tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: inputTotal,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Akrobat',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ]));
                                      }
                                    }),
                                  ),
                              ],
                            ),
                          )),
                    ],
                  ))));
    });
  }

  Widget _buildEllipsis(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //用isPrebook来区分预约投注
    final logic = widget.isPrebook
        ? Get.find<SinglePrebookController>()
        : ShopCartController.to.currentBetController;
    return Obx(() {
      List<Color> colors = [const Color(0XFF179CFF), const Color(0XFF45B0FF)];
      if (isProcessing) {
        //去掉点击效果
        //colors = [const Color(0xFF026DBC), const Color(0xFF026DBC)];
      }
      bool isSpecialState = logic!.isSpecialState;
      //double inputAmount = logic!.inputTotal;
      if (isSpecialState) {
        colors = [
          themeData.shopcartButtonDisableBackgroundColor,
          themeData.shopcartButtonDisableBackgroundColor
        ];
      }
      // else if(inputAmount == 0){
      //   colors = [
      //     themeData.shopcartButtonDisableBackgroundColor,
      //     themeData.shopcartButtonDisableBackgroundColor
      //   ];
      // }
      double oddFinally = double.tryParse(logic.itemList.safeFirst?.oddFinally.value ?? "0)") ?? 0.0;
      bool isNotNegativeOdd = oddFinally > -0.000001;
      return InkWell(
          onTap: () async {
            if (!isProcessing) {
              setState(() {
                isProcessing = true;
              });
              setState(() {
                isProcessing = false;
              });
            }
          },
          child: Container(
              padding: EdgeInsets.all(3.h),
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.h),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  height: 44.h,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: isNotNegativeOdd
                              ? CrossAxisAlignment.baseline
                              : CrossAxisAlignment.center, // 根据文本基线对齐
                          textBaseline: isNotNegativeOdd ? TextBaseline.alphabetic : null,
                          children: [
                            if (!isSpecialState)
                              Text(
                                widget.isPrebook
                                    ? LocaleKeys.bet_bet_book_confirm.tr
                                    : LocaleKeys.app_betting_now.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            else
                              Expanded(
                                  child: Text(
                                    logic.specialStateReason,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                              )),
                            const SizedBox( width: 4, ),
                            if (!isSpecialState)
                              Expanded(
                                child: Opacity(
                                  opacity: 0.60,
                                  child: Obx(() {
                                    if (widget.profitOrTotal == 1) {
                                      double profitAmount =logic.profitAmount(0);
                                      if (isNotNegativeOdd) {
                                        String winTotal = TYFormatCurrency.formatCurrency(profitAmount);
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.baseline, // 根据文本基线对齐
                                          textBaseline: TextBaseline.alphabetic, // 设置基线对齐方式
                                          children: [
                                            Flexible(
                                              child: Text(
                                                LocaleKeys.app_h5_bet_bet_win.tr,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              winTotal,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontFamily: 'Akrobat',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        double betAmount = ((profitAmount.abs()) * 100).ceilToDouble() /100;
                                        String inputTotal = TYFormatCurrency.formatCurrency(betAmount);
                                        String winTotal = TYFormatCurrency.formatCurrency(logic.inputTotal);
                                        return Column(
                                            mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.baseline, // 根据文本基线对齐
                                                textBaseline: TextBaseline.alphabetic, // 设置基线对齐方式
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      LocaleKeys.app_place_bet.tr,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    inputTotal,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontFamily: 'Akrobat',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.baseline, // 根据文本基线对齐
                                                textBaseline: TextBaseline.alphabetic, // 设置基线对齐方式
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      LocaleKeys.app_h5_bet_bet_win.tr,
                                                      overflow:TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    winTotal,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontFamily: 'Akrobat',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]);
                                      }
                                    } else {
                                      String inputTotal = TYFormatCurrency.formatCurrency(logic.inputTotal);
                                      return Row(
                                          // 根据文本基线对齐
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          // 设置基线对齐方式
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                LocaleKeys.bet_sum.tr,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              inputTotal,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontFamily: 'Akrobat',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ]);
                                    }
                                  }),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ))));
    });
  }
}