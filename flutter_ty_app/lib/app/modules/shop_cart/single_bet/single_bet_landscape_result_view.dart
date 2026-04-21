

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_type.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/format/common/module/format-currency.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../model/shop_cart_item.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全屏投注结果Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全屏投注结果弹窗
      适配横屏，屏幕高度较小
    】】】
 *
 */
class SingleBetLandscapeResultView extends StatelessWidget {
  SingleBetLandscapeResultView({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController!;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            _buildBetItem(),
            _buildOrderWidget(logic.orderRespList.safeFirst??BetResultOrderDetailRespList()),
            _buildConfirmButton(),
            const SizedBox(height: 20,)
          ]
    );
  }

  Widget _buildBetItem() {
    ShopCartItem shopCartItem = logic.itemList.safeFirst!;
    BetResultOrderDetailRespList? orderDetailResp = logic.orderRespList.safeFirst;
    String orderDetailMarkScore = "";
    if(orderDetailResp!=null && orderDetailResp.sportId == '1'){
      orderDetailMarkScore = orderDetailResp.scoreBenchmark.replaceAll(":", "-");
      if(orderDetailMarkScore.isNotEmpty){
        orderDetailMarkScore = "($orderDetailMarkScore)";
      }
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.04),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          height: 16,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF127DCC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          orderDetailResp!.playOptionName,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha:0.9),
                            fontSize: 14.0.scale,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 6),
                        if (shopCartItem.matchType == 2) ...[
                          Text(
                            '[${LocaleKeys.new_menu_1.tr}]',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF179CFF),
                              fontSize: 12.0.scale,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 2),
                        ],
                        Text(
                          orderDetailResp.playName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha:0.9),
                            fontSize: 12.0.scale,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                        const SizedBox(width: 2),
                        if(shopCartItem.sportId == 1)
                          ...[
                            Text(
                              shopCartItem.markScore,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha:0.9),
                                fontSize: 12.0.scale,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                            const SizedBox(width: 2),
                          ],
                        Text(
                          '[${TYUserController.to.curOddsLabel(shopCartItem.oddsHsw).tr}]',
                          style: TextStyle(
                            color: const Color(0xFF179CFF),
                            fontSize: 12.0.scale,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //if((orderDetailResp.matchInfo??'').isNotEmpty)
                  if (shopCartItem.home.isNotEmpty) //与BetItemWidget判断一致
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child:FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              //如果在playOptionName后面已经显示比分（orderDetailMarkScore），则这里把末尾的比分去掉
                              orderDetailMarkScore.isNotEmpty?orderDetailResp.matchInfo.replaceFirst(RegExp(r'\(\d+-\d+\)$'), ''):orderDetailResp.matchInfo,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha:0.9),
                                fontSize: 12.0.scale,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child:FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            shopCartItem.tidName,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha:0.9),
                              fontSize: 12.0.scale,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '@',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.9),
                    fontSize: 14.0.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,

                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  orderDetailResp.oddsValues,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.9),
                    fontSize: 16.0.scale,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700,

                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

  Widget _buildOrderWidget(BetResultOrderDetailRespList betResultOrder) {
    double betMoney = (double.tryParse(betResultOrder.betMoney)??0.0)/100;
    double maxWinMoney = (double.tryParse(betResultOrder.maxWinMoney)??0.0)/100;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child:Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.bet_bet_val.tr,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.5),
                    fontSize: 12.0.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                TYFormatCurrency.formatCurrency(betMoney),
                style: TextStyle(
                  color: Colors.white.withValues(alpha:0.9),
                  fontSize: 16.0.scale,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.bet_bet_win.tr,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.5),
                    fontSize: 12.0.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                TYFormatCurrency.formatCurrency(maxWinMoney),
                style: TextStyle(
                  color: Colors.white.withValues(alpha:0.9),
                  fontSize: 16.0.scale,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.bet_order_no.tr,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.5),
                    fontSize: 12.0.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                betResultOrder.orderNo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha:0.9),
                  fontSize: 12.0.scale,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(){
    return Container(
      margin: const EdgeInsets.fromLTRB(14,0,14,0),
      height: 40,
      decoration: ShapeDecoration(
        color: const Color(0xFF127DCC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: (){
          logic.clearData();
          logic.closeBet();
        },
        child:Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child:Obx(() {
                String titleText;
                switch(logic.betStatus.value){
                  case ShopCartBetStatus.Success:
                    titleText = LocaleKeys.app_h5_bet_bet_confirm.tr;
                    break;
                  case ShopCartBetStatus.PartSuccess:
                    titleText = LocaleKeys.app_h5_bet_part_success.tr;
                    break;
                  case ShopCartBetStatus.Invalid://TODO 盘口已失效
                  case ShopCartBetStatus.Failure:
                    titleText = LocaleKeys.bet_bet_err.tr;
                    break;
                  case ShopCartBetStatus.Betting:
                    titleText = LocaleKeys.bet_bet_loading.tr;
                    break;
                  default:
                  // TODO: Handle this case.
                    titleText = LocaleKeys.app_h5_bet_confirm.tr;
                    break;

                }
                return Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                );
              }
              ),
            ),
          ],
        ),
      ),
    );
  }
}