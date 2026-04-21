import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-currency.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/combo_courage_bet/combo_courage_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 单关投注注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 单关投注注单部件
      显示注单号、投注时间等
    】】】
 *
 */
class BetOrderWidget extends StatelessWidget {
  BetOrderWidget(this.betResultOrder, {Key? key}) : super(key: key);

  final BetResultOrderDetailRespList betResultOrder;
  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    double betMoney = (double.tryParse(betResultOrder.betMoney) ?? 0.0) / 100;
    double maxWinMoney =
        (double.tryParse(betResultOrder.maxWinMoney) ?? 0.0) / 100;
    if (logic is ComboCourageBetController) {
      //自选波胆seriesOrderRespList上的maxWinAmount正确，betResultOrder.maxWinMoney需乘以100
      maxWinMoney = double.tryParse(
              logic?.seriesOrderRespList.safeFirst?.maxWinAmount ?? '') ??
          maxWinMoney * 10000;
      maxWinMoney = maxWinMoney / 100;
    }
    String betVal = LocaleKeys.bet_bet_val.tr;
    String betOrderNo = LocaleKeys.bet_order_no.tr;
    if (logic?.betStatus.value == ShopCartBetStatus.Prebooking ||
        logic?.betStatus.value == ShopCartBetStatus.PrebookSuccess ||
        logic?.betStatus.value == ShopCartBetStatus.PrebookCancel) {
      betVal = LocaleKeys.app_h5_bet_reserve_win.tr;
      betOrderNo = LocaleKeys.app_bet_reservation.tr;
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        padding: const EdgeInsets.all(12),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: themeData.shopcartContentBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    betVal,
                    style: TextStyle(
                      color: themeData.shopcartLabelColor,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  TYFormatCurrency.formatCurrency(betMoney),
                  style: TextStyle(
                    color: themeData.shopcartTextColor,
                    fontSize: 16.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  TYUserController.to.currCurrency(),
                  style: TextStyle(
                    color: themeData.shopcartLabelColor,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
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
                      color: themeData.shopcartLabelColor,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  TYFormatCurrency.formatCurrency(maxWinMoney),
                  style: TextStyle(
                    color: themeData.shopcartTextColor,
                    fontSize: 16.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  TYUserController.to.currCurrency(),
                  style: TextStyle(
                    color: themeData.shopcartLabelColor,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
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
                    betOrderNo,
                    style: TextStyle(
                      color: themeData.shopcartLabelColor,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  betResultOrder.orderNo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themeData.shopcartLabelColor,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
