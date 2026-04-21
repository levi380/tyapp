import 'dart:math';

import 'package:flutter_ty_app/app/core/format/common/module/format-currency.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';

import '../../../../generated/locales.g.dart';
import '../shop_cart_controller.dart';
import '../single_bet/single_prebook/single_prebook_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 滑动投注按钮Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 滑动投注按钮部件
    滑块滑动到底触发投注接口，否则回弹原位
    按钮上显示投注金额或可赢金额
    】】】
 *
 */
///投注滑块
class BetSlideWidget extends StatefulWidget {
  BetSlideWidget({this.profitOrTotal = 1, this.isPrebook = false, Key? key})
      : super(key: key);
  final int profitOrTotal; //1单关显示可盈，2串关显示合计
  final bool isPrebook;

  @override
  _BetSlideState createState() => _BetSlideState();
}

class _BetSlideState extends State<BetSlideWidget> {
  double _positionX = 0.0;
  bool _isCompleted = false;
  bool _betting = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //用isPrebook来区分预约投注
    final logic = widget.isPrebook
        ? Get.find<SinglePrebookController>()
        : ShopCartController.to.currentBetController;
    return Obx(() {
      List<Color> colors = [const Color(0XFF179CFF), const Color(0XFF45B0FF)];

      bool isSpecialState = logic!.isSpecialState;
      if (isSpecialState || _betting) {
        colors = [
          themeData.shopcartButtonDisableBackgroundColor,
          themeData.shopcartButtonDisableBackgroundColor
        ];
      }
      return Align(
          alignment: Alignment.center,
          child: Container(
              padding: EdgeInsets.all(3.h),
              height: 50.h,
              constraints: BoxConstraints(maxWidth: 375.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.h),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                double containerWidth = min(constraints.maxWidth, 375.w);
                double oddFinally = double.tryParse(
                        logic.itemList.safeFirst?.oddFinally.value ?? "0)") ??
                    0.0;
                bool isNotNegativeOdd = oddFinally > -0.000001;
                return GestureDetector(
                    onHorizontalDragUpdate: !isSpecialState
                        ? (details) {
                            if (!_isCompleted) {
                              setState(() {
                                // 更新按钮位置
                                _positionX += details.primaryDelta!;
                                _positionX =
                                    _positionX.clamp(0, containerWidth - 44.h);

                                // 判断是否拖到最右边，执行事件
                                if (_positionX >= containerWidth - 44.h - 0.1) {
                                  _isCompleted = true;
                                }
                              });
                            }
                          }
                        : null,
                    onHorizontalDragEnd: (details) async {
                      // 手势结束时，如果已完成，执行事件
                      if (_isCompleted) {
                        // 执行你的事件
                        if (!_betting) {
                          _betting = true;
                          setState(() {
                            //_positionX = 0;
                          });
                          bool result = await logic.doBet();
                          _betting = false;
                          if (!result) {
                            setState(() {
                              _positionX = 0;
                            });
                            _isCompleted = false;
                          }
                        }
                      } else {
                        setState(() {
                          _positionX = 0;
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(44.h + 4, 0, 14, 0),
                            height: 44.h,
                            //width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: isNotNegativeOdd
                                        ? CrossAxisAlignment.baseline
                                        : CrossAxisAlignment.center, // 根据文本基线对齐
                                    textBaseline: isNotNegativeOdd
                                        ? TextBaseline.alphabetic
                                        : null, // 设置基线对齐方式
                                    children: [
                                      if (!isSpecialState)
                                        Text(
                                          widget.isPrebook
                                              ? LocaleKeys
                                                  .bet_bet_book_confirm.tr
                                              : LocaleKeys.app_betting.tr,
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
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      if (!isSpecialState)
                                        Expanded(
                                          child: Opacity(
                                            opacity: 0.60,
                                            child: Obx(() {
                                              if (widget.profitOrTotal == 1) {
                                                double profitAmount = logic.profitAmount(0);
                                                if (isNotNegativeOdd) {
                                                  String winTotal = TYFormatCurrency.formatCurrency(profitAmount);
                                                  return Row(
                                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                                    // 设置基线对齐方式
                                                    textBaseline:TextBaseline.alphabetic,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          LocaleKeys.app_h5_bet_bet_win.tr,
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
                                                  double betAmount =
                                                      ((profitAmount.abs()) * 100).ceilToDouble() / 100;
                                                  String inputTotal = TYFormatCurrency.formatCurrency(betAmount);
                                                  String winTotal =TYFormatCurrency.formatCurrency(logic.inputTotal);
                                                  return Column(
                                                      mainAxisAlignment:MainAxisAlignment.center, // 垂直居中
                                                      children: [
                                                        Expanded(
                                                            child: Row(
                                                              crossAxisAlignment:CrossAxisAlignment.baseline, // 根据文本基线对齐
                                                              textBaseline: TextBaseline.alphabetic, // 设置基线对齐方式
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    LocaleKeys.app_place_bet.tr,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 1,
                                                                    style:TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 14.sp,
                                                                      fontFamily: 'PingFang SC',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),

                                                                  ),
                                                                ),
                                                                const SizedBox( width: 4),
                                                                Text(
                                                                  inputTotal,
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 14.sp,
                                                                    fontFamily:'Akrobat',
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ],
                                                        )),
                                                        Expanded(
                                                            child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.baseline, // 根据文本基线对齐
                                                          textBaseline: TextBaseline.alphabetic, // 设置基线对齐方式
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                LocaleKeys.app_h5_bet_bet_win.tr,
                                                                overflow:TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 14.sp,
                                                                  fontFamily: 'PingFang SC',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox( width: 4),
                                                            Text(
                                                              winTotal,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14.sp,
                                                                fontFamily:'Akrobat',
                                                                fontWeight:FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ))
                                                      ]);
                                                }
                                              } else {
                                                String inputTotal =TYFormatCurrency.formatCurrency(logic.inputTotal);
                                                return Row(
                                                    // 根据文本基线对齐
                                                    crossAxisAlignment:CrossAxisAlignment.baseline,
                                                    // 设置基线对齐方式
                                                    textBaseline:TextBaseline.alphabetic,
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
                                                          fontWeight:FontWeight.w600,
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
                                Row(
                                  children: [
                                    Opacity(
                                      opacity: 0.20,
                                      child: ImageView(
                                          'assets/images/shopcart/arrow_right_3.svg',
                                          width: 12.h),
                                    ),
                                    Opacity(
                                      opacity: 0.40,
                                      child: ImageView(
                                          'assets/images/shopcart/arrow_right_3.svg',
                                          width: 12.h),
                                    ),
                                    Opacity(
                                      opacity: 0.70,
                                      child: ImageView(
                                          'assets/images/shopcart/arrow_right_3.svg',
                                          width: 12.h),
                                    )
                                  ],
                                )
                              ],
                            )),
                        Positioned(
                            left: _positionX,
                            child: Container(
                              width: 44.h,
                              height: 44.h,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Opacity(
                                      opacity: 0.20,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 44.h,
                                        height: 44.h,
                                        decoration: ShapeDecoration(
                                          color: Colors.white.withValues(alpha: 0.8),
                                          shape: const OvalBorder(),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0xCC000000),
                                              blurRadius: 20,
                                              offset: Offset(0, 6),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 3.h,
                                    top: 3.h,
                                    child: Container(
                                      width: 38.h,
                                      height: 38.h,
                                      decoration: ShapeDecoration(
                                        color: isSpecialState
                                            ? themeData.shopcartButtonSlideDisableColor
                                            : Colors.white.withValues(alpha: 0.96),
                                        shape: const OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 12.h,
                                    top: 12.h,
                                    child: Opacity(
                                      opacity: 0.80,
                                      child: Container(
                                        width: 20.h,
                                        height: 20.h,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: 20.h,
                                                height: 20.h,
                                                clipBehavior: Clip.antiAlias,
                                                decoration:
                                                    const BoxDecoration(),
                                                child: ImageView(
                                                    'assets/images/shopcart/arrow_right1.png',
                                                    color: isSpecialState
                                                        ? const Color(
                                                            0xffC9CDDB)
                                                        : null,
                                                    width: 14.h,
                                                    height: 14.h,
                                                    boxFit: BoxFit.contain),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ));
              })));
    });
  }
}
