import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_type.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../shop_cart_util.dart';
import '../widgets/bet_item_widget.dart';
import '../widgets/bet_order_widget.dart';
import '../widgets/gradient_loading_indicator.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 单关投注结果Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 单关投注结果弹窗
    】】】
 *
 */
class SingleBetResultView extends StatelessWidget {
  SingleBetResultView({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController!;

  @override
  Widget build(BuildContext context) {
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          _buildResultHead(context),
          BetItemWidget(
            logic.itemList.first,
            orderDetailResp: logic.orderRespList.safeFirst,
          ),
          BetOrderWidget(
              logic.orderRespList.safeFirst ?? BetResultOrderDetailRespList()),
          _buildConfirmButton(context),

      ]),
    );
  }

  Widget _buildResultHead(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Obx(() {
            String titleImage;
            String titleText;
            switch (logic.betStatus.value) {
              case ShopCartBetStatus.Success:
                titleText = LocaleKeys.app_h5_bet_bet_confirm.tr;
                titleImage =
                'assets/images/shopcart/tandem_success2.png';
                break;
              case ShopCartBetStatus.PartSuccess:
                titleText = LocaleKeys.app_h5_bet_part_success.tr;
                titleImage =
                'assets/images/shopcart/tandem_success2.png';
                break;
              case ShopCartBetStatus.Invalid: //TODO 盘口已失效
              case ShopCartBetStatus.PrebookCancel:
              case ShopCartBetStatus.Failure:
                titleImage = 'assets/images/shopcart/tandem_failed2.png';
                titleText = LocaleKeys.app_h5_bet_bet_error.tr;

                break;
              case ShopCartBetStatus.PrebookSuccess:
                titleImage =
                'assets/images/shopcart/tandem_success2.png';
                titleText = LocaleKeys.pre_record_booked.tr;
                break;
              case ShopCartBetStatus.Prebooking:
                titleImage = 'assets/images/shopcart/tandem_success2.png';
                titleText = LocaleKeys.pre_record_booking.tr;
                break;
              case ShopCartBetStatus.Betting:
              default:
              // TODO: Handle this case.
                titleImage =
                'assets/images/shopcart/tandem_success2.png';
                titleText = LocaleKeys.bet_bet_loading.tr;
                break;
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(logic.betStatus.value == ShopCartBetStatus.Betting || logic.betStatus.value == ShopCartBetStatus.Prebooking)
                  SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child:GradientLoadingIndicator(
                         strokeWidth: 2.0,
                         color: Colors.blue,
                      )
                  )
                else
                  ImageView(
                    titleImage,
                    width: 20.sp,
                    height: 20.sp,
                  ),
                const SizedBox(width: 12),
                Text(
                  titleText,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: themeData.shopcartTextColor,
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),

              ],
            );
          }),
        ),
        if(logic.betStatus.value == ShopCartBetStatus.PrebookSuccess)
          ...[
            Text(
              LocaleKeys.pre_record_booked_tips.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF179CFF),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
          ],
      ],
    );

  }

  Widget _buildConfirmButton(BuildContext context){
    ThemeData themeData = Theme.of(context);
    BetResultOrderDetailRespList betResultOrder = logic.orderRespList.safeFirst?? BetResultOrderDetailRespList();
    bool isButtonDiabled = logic.betStatus.value == ShopCartBetStatus.Betting || logic.betStatus.value == ShopCartBetStatus.Prebooking;
    return Column(
      children: [
        if(betResultOrder.riskEvent!=null)
          if(!ShopCartUtil.showBetAgain(betResultOrder.riskEvent!))
            ...[
              //显示失败原因
              Container(
                margin: EdgeInsets.fromLTRB(14, 10,14,0),
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical:  10),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: themeData.shopcartReasonBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                width: double.infinity,
                child:Text(betResultOrder.riskEvent!.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themeData.shopcartReasonColor,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                )
            ),
              _buildFinishButton(context,LocaleKeys.app_h5_bet_confirm.tr,Color(0xFF179CFF),Colors.white,false),
            ]
        else
          ...[
            //接受变化
            Container(
              margin: const EdgeInsets.fromLTRB( 14, 12,14,0),
              height: 48,
              //constraints: BoxConstraints(maxWidth: 375.w),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: ShapeDecoration(
                color: const Color(0xFF179CFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: InkWell(
                onTap: () {
                  //logic.acceptBetAgain();
                  logic.doBet(betAgain: true);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.bet_agree_change.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //取消投注
            _buildFinishButton(context,LocaleKeys.bet_record_cancel_bet.tr,themeData.shopcartContentBackgroundColor,Color(0XFF179CFF),false),
          ]
        else
          _buildFinishButton(context,LocaleKeys.app_h5_bet_confirm.tr,isButtonDiabled || logic.betStatus.value == ShopCartBetStatus.Failure
              ?themeData.shopcartButtonDisableBackgroundColor
              :Color(0xFF179CFF),Colors.white,isButtonDiabled),

      ],
    );
  }

  Widget _buildFinishButton(BuildContext context,String finishWord,Color backgroundColor,Color textColor,bool isButtonDiabled){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      height: 48,
      //constraints: BoxConstraints(maxWidth: 375.w),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: () {
          if(!isButtonDiabled){
            logic.clearData();
            logic.closeBet();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                finishWord,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
