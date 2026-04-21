import 'dart:math';

import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/mix_bet/mix_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/vr_bet/vr_mix_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/vr_bet/vr_single_bet_controller.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../utils/vr_rank_icon_utils.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../combo_courage_bet/combo_courage_bet_controller.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_util.dart';
import 'count_down_widget.dart';

part 'bet_item_widget.part.dart';
part 'bet_item_widget.closed.part.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注项Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注项部件
      有2种状态：正常状态和盘口已关闭状态
      投注界面和投注结果界面都有显示投注项，所以该部件有2个数据来源：shopCartItem和orderDetailResp
      如果orderDetailResp!=null，表示为投注结果页面显示的投注项，优先使用投注返回数据orderDetailResp
      Vr投注项需显示排名图标，单独处理
    】】】
 *
 */
class BetItemWidget extends StatelessWidget {
  BetItemWidget(this.shopCartItem,
      {this.orderDetailResp,
      this.playOptionName,
      this.isParlay = false,
      Key? key})
      : super(key: key);
  final ShopCartItem shopCartItem;
  final BetResultOrderDetailRespList? orderDetailResp;
  final String? playOptionName;
  final bool isParlay;

  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Obx(() {
      return Container(
        margin: EdgeInsets.fromLTRB(14.w, 2.h, 14.w, 2.h),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: logic!.betStatus.value == ShopCartBetStatus.Normal &&
                  (shopCartItem.isColsed ||
                      (isParlay && !shopCartItem.canParlay))
              ? themeData.shopcartClosedContentBackgroundColor
              : themeData.shopcartContentBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (shopCartItem.isColsed &&
                      (logic!.betStatus.value == ShopCartBetStatus.Normal ||
                          logic!.betStatus.value == ShopCartBetStatus.Prebook))
                    ..._buildClosedItem(context)
                  else
                    ..._buildNormalItem(context),
                ],
              ),
            ),
            if (isParlay)
              Positioned(
                right: 0,
                bottom: 0,
                child: ImageView(
                  Get.isDarkMode
                      ? 'assets/images/shopcart/item_remove_light.png'
                      : 'assets/images/shopcart/item_remove_dark.png',
                  width: 30,
                  height: 20,
                  //boxFit: BoxFit.scaleDown,
                  onTap: () {
                    logic!.delShopCartItem(shopCartItem);
                  },
                ),
              ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildNormalItem(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    String orderDetailMarkScore = "";
    if (orderDetailResp != null && orderDetailResp!.sportId == '1') {
      orderDetailMarkScore =
          orderDetailResp!.scoreBenchmark.replaceAll(":", "-");
      if (orderDetailMarkScore.isNotEmpty) {
        orderDetailMarkScore = "($orderDetailMarkScore)";
      }
    }
    return [
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildPlayOption(context),
            ),
            const SizedBox(width: 12),
            _buildOddsValue(context),
          ],
        ),
      ),
      const SizedBox(height: 6),
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0XFF179CFF),
                      // Set the color of the bottom border
                      width: 2, // Set the width of the bottom border
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                if (shopCartItem.matchType == 2) ...[
                                  Text(
                                    '「${LocaleKeys.new_menu_1.tr}」',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF179CFF),
                                      fontSize: isIPad ? 16.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                //投注成功后的玩法名称用接口返回的
                                if (orderDetailResp != null)
                                  Text(
                                    orderDetailResp!.playName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: isIPad ? 16.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                else
                                  Text(
                                    shopCartItem.playName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: isIPad ? 16.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                const SizedBox(width: 2),
                                if (shopCartItem.sportId == '1') ...[
                                  Text(
                                    orderDetailResp != null
                                        ? orderDetailMarkScore
                                        : shopCartItem.markScore,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: isIPad ? 16.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                Text(
                                  '「${TYUserController.to.curOddsLabel(shopCartItem.oddsHsw).tr}」',
                                  style: TextStyle(
                                    color: const Color(0xFF179CFF),
                                    fontSize: isIPad ? 16.sp : 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (orderDetailResp == null)
                            if (isParlay && !shopCartItem.canParlay)
                              Text(
                                LocaleKeys.app_h5_bet_no_support_collusion.tr,
                                style: TextStyle(
                                  color: const Color(0xFFF53F3F),
                                  fontSize: isIPad ? 16.sp : 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            else
                              Obx(() {
                                final oddColor =
                                    shopCartItem.oddStateType.value ==
                                            OddStateType.oddUp
                                        ? const Color(0xFFF53F3F)
                                        : shopCartItem.oddStateType.value ==
                                                OddStateType.oddDown
                                            ? const Color(0xFF00B42A)
                                            : themeData.shopcartTextColor;
                                return Container(
                                  child: shopCartItem.oddStateType.value !=
                                              OddStateType.none &&
                                          shopCartItem
                                              .oddFinally.value.isNotEmpty
                                      ? Text(
                                          LocaleKeys.common_odds_change.tr,
                                          style: TextStyle(
                                            color: oddColor,
                                            fontSize: 12.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : null,
                                );
                              })
                          else if (orderDetailResp?.riskEvent != null &&
                              ShopCartUtil.showBetAgain(
                                  orderDetailResp!.riskEvent!))
                            Obx(() {
                              String riskEventReason;
                              if (orderDetailResp!.newHandicapHv.value !=
                                      orderDetailResp!.oldHandicapHv &&
                                  orderDetailResp!.newOddsValues.value !=
                                      orderDetailResp!.oddsValues) {
                                riskEventReason =
                                    LocaleKeys.bet_message_serial_can_rebet.tr;
                              } else if (orderDetailResp!.newOddsValues.value !=
                                  orderDetailResp!.oddsValues) {
                                riskEventReason =
                                    LocaleKeys.bet_message_order_odds_change.tr;
                              } else if (orderDetailResp!.newHandicapHv.value !=
                                  orderDetailResp!.oldHandicapHv) {
                                riskEventReason = LocaleKeys
                                    .bet_message_bet_order_place_num_change.tr;
                              } else {
                                riskEventReason = "";
                              }
                              return Container(
                                  child: Text(
                                riskEventReason,
                                style: TextStyle(
                                  color: const Color(0xFFF53F3F),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ));
                            }),
                        ],
                      ),
                    ),
                    ... _buildMatchInfo(context),
                    ... _buildLeagueName(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }


}
