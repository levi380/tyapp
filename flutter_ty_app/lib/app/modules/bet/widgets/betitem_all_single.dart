import 'dart:math';
import 'package:flutter_ty_app/app/extension/num_extension.dart';

import 'package:flutter_ty_app/app/modules/bet/widgets/rule_statement_view.dart' show RuleStatementView;
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';


import '../../../../generated/locales.g.dart';
import '../../../core/constant/common/module/keyword.dart';
import '../../../services/models/res/all_order_list_entity.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../../utils/utils.dart';
import '../../unsettled_bets/widgets/information_vr_icon_view.dart';
import 'information_eov_view.dart';
import 'betitem_cp_number_time_mixin.dart';
import 'early_settlement_feature_view.dart';
import '../controllers/bet_record_controller.dart';

part 'betitem_all_single.part.dart';
/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 单关投注注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 单关投注注单，注单类型为全部时显示
    】】】
 *
 */
class BetItemAllSingle extends StatelessWidget with BetItemCpNumberTimeMixin {
  BetItemAllSingle(this.orderItem,this.isExpanded,this.h5OrderItem,this.index,{super.key});
  final AllOrderListList orderItem;
  final bool isExpanded;
  final GetH5OrderListDataRecordxData? h5OrderItem;
  final int index;
  final logic = Get.find<BetRecordController>();

  @override
  Widget build(BuildContext context) {
    if(!isExpanded){
      return _buildItemNormal(context);
    }else{
      return _buildItemExpanded(context);
    }
  }

  Widget _buildItemNormal(BuildContext context){
    ThemeData themeData = Theme.of(context);
    String eov = orderItem.orderMixExtendVOList.safeFirst?.eov ?? "";
    String matchInfo = orderItem.orderMixExtendVOList.safeFirst?.matchInfo??'';
    if ([1009, 1010, 1011, 1002].contains(orderItem.orderMixExtendVOList.safeFirst?.sportId??0)){
      //matchInfo = orderItem.orderMixExtendVOList.safeFirst?.batchNo??"";
      matchInfo = LocaleKeys.common_virtual_sports.tr;
    }
    return Container(
      decoration: ShapeDecoration(
        color: themeData.betItemBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: InkWell(
        onTap: (){
          logic.changeExpanded(exapnd: !isExpanded,orderId: orderItem.orderNo);
        },
        child:Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child:Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ImageView(context.isDarkMode
                                      ? 'assets/images/bets/level_icon_night.png'
                                      : 'assets/images/bets/level_icon_daytime.png', width: 12.w),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child:Text(
                                      matchInfo,
                                      style: TextStyle(
                                        color: themeData.betItemTitleColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              )

                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                getOrderStatus(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: getOrderStatusColor(context),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              ImageView('assets/images/bets/right_expand.png', width: 14.w,color: themeData.betItemExpandColor,),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ),

                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Row(
                        children:[
                          InformationVrIconView(vrIcons: logic.betTylogic.getVrIcon(orderItem.orderMixExtendVOList.safeFirst?.sportId??0,orderItem.orderMixExtendVOList.safeFirst?.playOptions??'')),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  '${orderItem.orderMixExtendVOList.safeFirst?.marketValue??""}',
                                  style: TextStyle(
                                    color: themeData.betItemTextColor,
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(width:4.w),
                                if (eov.isEmpty)
                                  Text(
                                    '@${orderItem.orderMixExtendVOList.safeFirst?.odds??""}',
                                    style: TextStyle(
                                      color: themeData.betItemTextColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  )
                                else
                                  InformationEovView(oddFinally: orderItem.orderMixExtendVOList.safeFirst?.odds??"",eov: eov,),
                              ],
                            )



                          ),
                        ]
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  ///提前结算
  Widget _earlyRedemptionView() {
    return Column(children: [
      ///提前兑现说明
      if (getEarlySettlementFeature() || getExhibitEarlySettlement()) ...[

        const RuleStatementView(),

        SizedBox(height: 4.h),
      ],

      ///提前结算功能
      if (getEarlySettlementFeature())
        EarlySettlementFeatureView(
          data: h5OrderItem!,
          index: index,
        ),

      ///产品要求，4260需求回退，暂时不上线，等待通知......
      ///提前结算,结算信息的view（已结和未结都有）
     //if (getExhibitEarlySettlement())
     //  EarlyRedemptionDetailsView(
     //    data: h5OrderItem!,
     //    index: index,
     //    onTap: () {
     //      /// 提前兑现折叠
     //      logic.betTylogic.onPreSettleExpand(index);
     //    },
     //  ),
    ]);
  }

  String getOrderStatus() {
    String orderStatus = '';
    String Status = orderItem.orderStatus.toString();
    if (Status == "0" || Status == "1") {
      orderStatus = LocaleKeys.bet_record_successful_betting.tr;
    } else if (Status == "2") {
      orderStatus = LocaleKeys.bet_record_invalid_bet.tr;
    } else if (Status == "3") {
      orderStatus = LocaleKeys.bet_record_confirming.tr;
    } else if (Status == "4") {
      orderStatus = LocaleKeys.bet_bet_err.tr;
    }
    return orderStatus;
  }

  Color getOrderStatusColor(BuildContext context){
    ThemeData themeData = Theme.of(context);
    Color orderStatusColor = themeData.betItemTabSelectedColor;
    String Status = orderItem.orderStatus.toString();
    if (Status == "4") {
      orderStatusColor = themeData.betItemTyStatusErrorColor;
    }
    return orderStatusColor;
  }

  ///只有未注单才有，判断是否有提前结算功能
  bool getEarlySettlementFeature() {
    ///只有已结注单才展示
    if (h5OrderItem?.orderStatus == '0') {
      return h5OrderItem!.exhibitEarlySettlement;
    }
    return false;
  }

  ///判断单关是否展示提前结算信息的view
  bool getExhibitEarlySettlement() {
    ///只有结算才有
    if (h5OrderItem?.preSettle != null) {
      int preSettle = h5OrderItem?.preSettle;
      if (preSettle == 1 || preSettle == 2 || preSettle >= 3) {
        return true;
      }
    }
    return false;
  }

  String isPreBetAmount() {
    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (orderItem.orderCashOutInVO?.preBetAmount != 0) {
      return LocaleKeys.app_betslip_remaining_capital.tr;
    }
    return LocaleKeys.bet_record_bet_val.tr;
  }

  String getOrderAmountTotal() {
    String orderAmountTotal = '';

    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (orderItem.orderCashOutInVO?.preBetAmount != 0) {
      orderAmountTotal =
          setAmount(orderItem.orderCashOutInVO!.preSettleBetAmount.toString());
    } else {
      orderAmountTotal = orderItem.betAmount;
    }
    return orderAmountTotal;
  }
}
