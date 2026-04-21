import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/combo_courage_bet/combo_courage_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

import '../shop_cart_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 自选波胆悬浮文字Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自选波胆悬浮文字部件
    自选波胆投注框收敛时显示。点击展开投注框。
    】】】
 *
 */
class ShopCartTip extends StatelessWidget {
  ShopCartTip({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Stack(
      children: [
        Positioned(
          bottom:52.h + 16 + 41.sp,
          right: 0,
          child: _buildCloseButton(),
        ),
        Positioned(
          bottom:52.h,
          child:GestureDetector(
            onTap: () {
              if((logic?.itemCount??0) >= 3) {
                // 显示投注界面
                logic?.showBet(queryAmount: true);
              }
            },
            // 自选波胆悬浮UI
            child:
            Container(
              width: 1.sw,
              height: 16 + 41.sp,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: ShapeDecoration(
                color: (logic?.itemCount??0) >= 3?Color(0xFF7BB9F7): themeData.shopcartBackgroundColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: themeData.shopcartTipBoderColor),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x1E7981A4),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child:
              Obx(() {
                String joinOptions = LocaleKeys.bet_bet_join_options.tr;
                String oddFinally = logic?.itemList.safeFirst?.oddFinally.value??"";
                // String boldRate = ConfigController.to.accessConfig.value.boldRate;
                //if(oddFinally.isNotEmpty && (double.tryParse(oddFinally)??0) < (double.tryParse(boldRate)??0))
                if(logic is ComboCourageBetController && (logic as ComboCourageBetController).isOddsTooLow())
                {
                  joinOptions = LocaleKeys.bet_bet_odds_too_low.tr;
                  oddFinally = "--";
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    if ((logic?.itemCount ?? 0) >= 3 &&
                        (logic?.itemList.safeFirst?.oddFinally.value
                            .isNotEmpty ?? true))
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '@',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: oddFinally,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                    if((logic?.itemCount ?? 0) >= 3)
                      Text(
                        joinOptions,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    else
                      Text(
                        LocaleKeys.bet_bet_min_options.tr.replaceAll("{num}", "3"),
                        style: TextStyle(
                          color: Color(0xFFAFB3C8),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                );
              }),
            ),




          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        logic?.clearData();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          //child: const ImageView('assets/images/shopcart/icon_close_white.svg', width: 28,height: 28),
          child:Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: Get.theme.shopcartTipCloseButtonColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child:const Icon(Icons.close_outlined,color:Colors.white,size: 20,),
          )
      ),
    );
  }
}
