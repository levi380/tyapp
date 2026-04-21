import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';

import 'package:flutter_ty_app/app/modules/shop_cart/mix_bet/mix_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../db/app_cache.dart';

import '../../../../widgets/image_view.dart';
import '../../shop_cart_controller.dart';
import '../../widgets/bet_button_widget.dart';
import '../../widgets/bet_input_widget.dart';
import '../../widgets/bet_item_widget.dart';
import '../../widgets/bet_slide_widget.dart';
import '../../widgets/number_keyboard.dart';


import '../../widgets/prebook_handicap_widget.dart';
import '../../widgets/prebook_odd_widget.dart';
import '../../widgets/shop_cart_head.dart';
import 'single_prebook_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 预约投注Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 预约投注弹窗
    】】】
 *
 */
class SinglePrebookView extends StatelessWidget {
  const SinglePrebookView(this.shopCartItem,this.shopCartBetStatus,this.orderResp,{Key? key}) : super(key: key);

  final shopCartItem;
  final shopCartBetStatus;
  final orderResp;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SinglePrebookController>(
      init: SinglePrebookController(shopCartItem,shopCartBetStatus,orderResp),
        builder: (logic)
    {
      ThemeData themeData = Theme.of(context);
      return Container(
          padding: EdgeInsets.only(bottom: 30),
          decoration: ShapeDecoration(
            color: themeData.shopcartBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShopCartHead(LocaleKeys.app_h5_bet_odd.tr,logic.itemList.firstWhereOrNull((e)=>e.discountOdds>0)!=null),
                BetItemWidget(logic.itemList.first),
                _buildInputWidget(context,logic),

                ///预约盘口
                if(logic.canBookHandicap())
                  PrebookHandicapWidget(),
                PrebookOddWidget(logic.oddsController,logic.oddsFocusNode),
                GetBuilder<SinglePrebookController>(
                    id: "keyboard",
                    builder: (controller) {
                      if (controller.showKeyBoard) {
                        return NumberKeyboard(
                            currentValue: controller.prebookAmountController.text,
                            onTextInput: (myText) {
                              controller.insertText(myText);
                            },
                            onTextSet: (myText) {
                              controller.replaceText(myText);
                            },
                            onBackspace: () {
                              controller.backspace();
                            },
                            onCollapse: () {
                              controller.keyboardVisiable(false);
                            },
                            onMaxValue: () {
                              controller.maxInputText();
                            },
                            onQuickValue: (myText) {
                              //快捷金额先聚焦到金额输入框
                              controller.prebookFocusNode.requestFocus();
                              //等待prebookFocusNode完成listen调用
                              Future.delayed(Duration(milliseconds: 200),(){
                                if(controller.amountController == controller.prebookAmountController) {
                                  controller.replaceText(myText);
                                }
                              });
                            },
                            quickValues: logic.userCvoMoney,
                        );
                      } else {
                        return Container();
                      }
                    }
                ),
                _buildBetButton(context,logic),
              ]
          )
      );
    });
  }

  Widget _buildInputWidget(BuildContext context,SinglePrebookController logic){
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.fromLTRB(14.w,6.h,14.w,8.h),
      child:Row(
        children: [
          Expanded(
              child: GetBuilder<SinglePrebookController>(
                  id: "input",
                  builder: (controller) {
                    return BetInputWidget(logic.prebookAmountController,logic.prebookFocusNode,
                      logic.minValueAmount,logic.maxValueAmount,
                      themeData.shopcartContentBackgroundColor,
                      showCurrency: true,
                    );
                  }
              )
          ),
          SizedBox(width: 8.w,),
          InkWell(
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                width: 96.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: themeData.shopcartBackgroundColor,
                  border: Border.all(
                    color: const Color(0xFF179CFF),
                  ),
                ),
                child: Text(
                  LocaleKeys.app_h5_bet_cancel_appoint.tr,
                    overflow:TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF179CFF),
                      fontSize: 16.sp,
                      height: 1.0,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),

                ),
            ),
            onTap: (){
              logic.cancelPrebook();
            },
          )
        ],
      ),
    );
  }

  Widget _buildBetButton(BuildContext context,SinglePrebookController logic){
    ThemeData themeData = Theme.of(context);
    bool isParlayDisable = logic.itemList.safeFirst?.canParlay == false;
    String betParlay;
    String? language = StringKV.language.get();
    if(language=="CN" || language=="TW"){
      betParlay = LocaleKeys.app_h5_bet_parlay.tr;
    }else{
      betParlay = "P";
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child:Row(
          children: (BoolKV.slideBet.get() ?? true)?[

              Expanded(
                child: BetSlideWidget(isPrebook: true),
              ),
            const SizedBox(width: 8,),
            if(ShopCartController.to.currentBetController is MixBetController)
              const SizedBox(width: 2,)
            else
              Container(
                width: 50.h,
                height: 50.h,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: themeData.shopcartParlayChangeBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.h),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    '+${betParlay}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isParlayDisable?Colors.white:const Color(0xFF179CFF),
                      fontSize: 18.h,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ]:[
            Expanded(
              child: BetButtonWidget(isPrebook: true),
            ),
            if(!(ShopCartController.to.currentBetController is MixBetController))
              ...[
                const SizedBox(width: 8,),
                InkWell(
                  child: Container(
                      alignment: Alignment.center,
                      width: 96.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isParlayDisable?themeData.shopcartButtonDisableBackgroundColor:themeData.shopcartParlayChangeBackgroundColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageView('assets/images/shopcart/add_event.png',
                            color: isParlayDisable?Colors.white:const Color(0xFF179CFF),
                            width: 20.sp,
                          ),
                          const SizedBox(width: 4,),
                          Flexible(child: Text(betParlay,
                            style: TextStyle(
                              color: isParlayDisable?Colors.white:const Color(0xFF179CFF),
                              fontSize: 16.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ),
                        ],
                      )
                  ),
                  onTap: isParlayDisable?null:(){
                    logic.goParlay();
                  },
                ),
              ],
          ],
        )
    );
  }
}
