import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';


import '../../../db/app_cache.dart';
import '../widgets/auto_accept_widget.dart';
import '../widgets/bet_button_widget.dart';
import '../widgets/bet_input_widget.dart';
import '../widgets/bet_slide_widget.dart';
import '../widgets/number_keyboard.dart';
import '../../../widgets/image_view.dart';
import '../../../../generated/locales.g.dart';
import '../model/shop_cart_type.dart';
import 'single_bet_controller.dart';
import '../widgets/shop_cart_head.dart';
import '../widgets/bet_item_widget.dart';
import 'single_bet_result_view.dart';
import './single_prebook/single_prebook_view.dart';
/*
* 投注弹窗
* */
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 单关投注Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 单关投注弹窗
    】】】
 *
 */
class SingleBetComponent<T extends BaseBetController> extends StatelessWidget {
  SingleBetComponent({Key? key}) : super(key: key);

  final  logic = ShopCartController.to.currentBetController as SingleBetController;
  final state = ShopCartController.to.state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logic.itemCount > 0 && logic.state.showShopCart.value) {
        return Stack(
            children: [
              //灰色背景
              GestureDetector(
                onTap: () {
                  logic.closeBet();
                },
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  color: Colors.black.withValues(alpha:0.6),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: 1.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildCloseButton(),
                          Obx(() {
                              if (logic.betStatus.value ==
                                  ShopCartBetStatus.Normal) {
                                return _buildBetView(context);
                              }else if (logic.betStatus.value == ShopCartBetStatus.Betting
                                  ||  logic.betStatus.value == ShopCartBetStatus.Success
                                  || logic.betStatus.value == ShopCartBetStatus.Failure
                                  || logic.betStatus.value == ShopCartBetStatus.Prebooking
                                  || logic.betStatus.value == ShopCartBetStatus.PrebookSuccess
                                  || logic.betStatus.value == ShopCartBetStatus.PrebookCancel) {
                                return SingleBetResultView();
                              }else if (logic.betStatus.value == ShopCartBetStatus.Prebook) {
                                return SinglePrebookView(logic.itemList.first,logic.betStatus,logic.orderRespList);
                              }else{
                                return Container();
                              }
                            }
                          ),
                        ],
                      )
                  )
              )

            ]
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        logic.closeBet();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        //child: const ImageView('assets/images/shopcart/icon_close_white.svg', width: 28,height: 28),
          child:Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: Get.theme.shopcartCloseButtonColor,
              borderRadius: BorderRadius.circular(14),
            ),
              child:const Icon(Icons.close_outlined,color:Colors.white,size: 20,),
          )
      ),
    );
  }

  Widget _buildBetView(BuildContext context) {
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
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            ShopCartHead(LocaleKeys.app_h5_bet_odd.tr, logic.itemList.firstWhereOrNull((e)=>e.discountOdds>0)!=null),
            BetItemWidget(logic.itemList.first),
            _buildInputWidget(context),
            GetBuilder<T>(
                id: "keyboard",
                init: logic as T,
                builder: (controller) {
                  if(controller.showKeyBoard) {
                    return NumberKeyboard(
                        currentValue: controller.amountController.text,
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
                          controller.keyboardVisiable( false);
                        },
                        onMaxValue: (){
                          controller.maxInputText();
                        },
                        onQuickValue: (myText) {
                          controller.replaceText(myText);
                        },
                        quickValues: logic.userCvoMoney,
                    );
                  }else{
                    return Container();
                  }
                }
            ),
            AutoAcceptWidget(),
            _buildBetButton(context),
          ]
      )
    );
  }

  Widget _buildInputWidget(BuildContext context){
    ThemeData themeData = Theme.of(context);
    return GetBuilder<T>(
        id: "input",
        init: logic as T,
        builder: (controller)
        {
          return Container(
            margin: EdgeInsets.fromLTRB(14.w, 6.h,14.w,0),
            child: Row(
              children: [
                Expanded(
                    child: BetInputWidget(
                      logic.amountController, logic.amountFocusNode,
                      logic.minValue, logic.maxValue,
                      themeData.shopcartContentBackgroundColor,
                      showCurrency: true,


                    )
                ),
                //判断是否有预约
                // 目前只支持欧赔和亚赔
                // 优惠赔率不支持预约
                if(state.prebookOidList.contains(logic.itemList.first.playOptionsId)
                    && ['EU','HK'].contains(TYUserController.to.curOddsValue(logic.itemList.first.oddsHsw))
                    && logic.itemList.first.discountOdds == 0
                )
                  ...[SizedBox(width: 8.w,),
                    InkWell(
                      child: Container(
                          alignment: Alignment.center,
                          width: 96.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF179CFF),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageView('assets/images/shopcart/add_event.png',
                                color: Colors.white,
                                width: 20.sp,
                              ),
                              const SizedBox(width: 4,),
                              Flexible(child: Text(LocaleKeys.bet_bet_book_confirm.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              ),
                            ],
                          )
                      ),
                      onTap: () {
                        logic.goPrebook();
                      },
                    )
                  ],
              ],
            ),
          );
        }
    );
  }

  Widget _buildBetButton(BuildContext context){
    ThemeData themeData = Theme.of(context);
    bool isParlayDisable = logic.itemList.safeFirst?.canParlay == false;
    String betParlay;
    // String? language = StringKV.language.get();
    betParlay = LocaleKeys.app_h5_bet_parlay.tr;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child:Row(
          children: (BoolKV.slideBet.get() ?? true)?[
              Expanded(
                child: BetSlideWidget(),
              ),
            const SizedBox(width: 8,),
            InkWell(
              onTap: isParlayDisable?null:(){
                logic.goParlay();
              },
              child: Container(
                width: 50.h,
                height: 50.h,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: isParlayDisable?themeData.shopcartButtonDisableBackgroundColor:themeData.shopcartParlayChangeBackgroundColor,
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
            ),
          ]:[
            Expanded(
              child: BetButtonWidget(),
            ),
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
        )
    );
  }
}
