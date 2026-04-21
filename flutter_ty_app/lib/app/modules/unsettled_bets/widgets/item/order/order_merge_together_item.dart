import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../main.dart';
import '../../../../../global/ty_user_controller.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../utils/utils.dart';
import '../../../../settled_bets/settled_bets_logic.dart';
import '../../../await_bets/await_bets_logic.dart';
import '../../cross_checks_titles_view.dart';
import '../../early_redemption_details_view.dart';
import '../../early_settlement_feature_view.dart';
import '../../information_copy_view.dart';
import '../../information_time_view.dart';
import '../../multiple_together_view.dart';
import '../../rule_statement_view.dart' show RuleStatementView;

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-串关(已结算/未结算)item视图层 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示合并订单的详细信息，包括串关信息、状态、金额等，适用于不同的订单状态（未注单-未结算、已结算）。
    - `index`：当前项在列表中的索引。
    - `data`：包含合并订单数据的对象。
    - `type`：表示订单状态（0：未注单-未结算，1：已结算）。
    - `onTap`：可选的点击事件回调函数。
    - 创建包含合并订单信息的视图，使用多种子组件来展示不同的信息。
    - 创建一个包含串关数据的视图，使用 `MultipleTogetherView` 组件显示详细信息。
    - 创建一个包含合并订单详细信息的列，包括订单号、修改时间、总金额、盈利金额等。
    - 串关(已结算/未结算)item注单比分
    - 串关(已结算/未结算)item注单详情
    - 串关(已结算/未结算)item注单信息
    - 串关(已结算/未结算)item注单状态
    - 串关(已结算/未结算)item注单，串关列表展示和折叠
    - `getSeriesValue()`：获取串关系列值。
    - `getOrderNo()`：获取订单号。
    - `getModifyTime()`：获取修改时间。
    - `getOrderAmountTotal()`：获取订单总金额。
    - `getProfitAmountColor()`：获取盈利金额的颜色类型。
    - `getProfitAmount()`：获取盈利金额。
    - `getOrderStatus()`：获取订单状态。

    】】】
 *
 */

///（多）串一
class OrderMergeTogetherItem extends StatelessWidget {
  const OrderMergeTogetherItem({
    super.key,
    required this.index,
    required this.data,
    required this.type,
    this.onTap,
  });

  final VoidCallback? onTap;

  ///type  0: 未注单-未结算 ，1:已结算
  final int index, type;
  final GetH5OrderListDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          ///串关头部
          CrossChecksTitlesView(
            information: getSeriesValue(),
            odds: getOdds(),
          ),

          ///串关列表
          _mergeTogether(),

          ///串关注单详情
          _information(),

          ///提前结算
          _earlyRedemptionView(),
        ],
      ),
    );
  }

  // Widget _mergeTogether() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 12.w, right: 12.w),
  //     child: data.detailList.isNotEmpty
  //         ? Obx(
  //       ///串关数据列表
  //           () => MultipleTogetherView(
  //         detailList: data.detailList,
  //         onTap: onTap,
  //         Expand: data.isExpand.value,
  //         type: type,
  //       ).paddingOnly(top: 12.h, bottom: 4.h),
  //     )
  //         : Container(),
  //   );
  // }

  Widget _mergeTogether() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Visibility(
        visible: data.detailList.isNotEmpty,
        child: Obx(
          ///串关数据列表
          () => MultipleTogetherView(
            detailList: data.detailList,
            onTap: onTap,
            Expand: data.isExpand.value,
            type: type,
            managerCode: data.managerCode,
          ).paddingOnly(top: 0.h, bottom: 4.h),
        ),
      ),
    );
  }

  Widget _information() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Column(
        children: [
          InformationCopyView(
            information: LocaleKeys.app_h5_cathectic_bet_number.tr,
            outcome: getOrderNo(),
          ),
          InformationTimeView(
            information: LocaleKeys.bet_record_sort1.tr,
            dateTime: getModifyTime(),
            timeZone: getTimeZone(),
          ),
          InformationView(
            information: isPreBetAmount(),
            outcome: getOrderAmountTotal(),
            isAmount: true,
          ),
          InformationView(
            titleColorType: 2,
            InformationColorType: getProfitAmountColor(),
            information: type == 0
                ? LocaleKeys.app_h5_cathectic_winnable.tr
                : LocaleKeys.app_h5_cathectic_settle.tr,
            outcome: getProfitAmount(),
            isAmount: true,
          ),
          InformationView(
            information: LocaleKeys.app_h5_cathectic_bet_status.tr,
            outcome: getOrderStatus(),
            InformationColorType: getInformationColorType(),
          ),
        ],
      ),
    );
  }

  ///提前结算
  _earlyRedemptionView() {
    return Column(
      children: [
        ///提前兑现说明
        if (getEarlySettlementFeature() || getExhibitEarlySettlement())
          const RuleStatementView(),

        ///只有未注单才有，
        ///判断是否开启提前结算功能,提前结算功能的view（已结和未结都有）
        if (getEarlySettlementFeature())
          EarlySettlementFeatureView(
            index: index,
            data: data,
          ),

        ///提前结算,结算信息的view（已结和未结都有）
        if (getExhibitEarlySettlement())
          EarlyRedemptionDetailsView(
            data: data,
            index: index,
            onTap: () {
              if (type == 0) {
                /// 已结算提前兑现折叠
                Get.find<AwaitBetsLogic>().onPreSettleExpand(index);
              } else if (type == 1) {
                /// 已结算提前兑现折叠
                Get.find<SettledBetsLogic>().onPreSettleExpand(index);
              }
            },
          ),
      ],
    ).marginSymmetric(horizontal: 10.h);
  }

  ///只有已注单才有，判断单关是否展示提前结算信息的view
  bool getExhibitEarlySettlement() {
    if (data.preSettle != null) {
      int preSettle = data.preSettle;
      if (preSettle == 1 || preSettle == 2 || preSettle >= 3) {
        return true;
      }
    }
    return false;
  }

  ///只有未注单才有，判断是否有提前结算功能
  bool getEarlySettlementFeature() {
    ///只有未结注单才展示
    if (type == 0) {
      return data.exhibitEarlySettlement;
    }
    return false;
  }

  String getSeriesValue() {
    String seriesValue = '';
    seriesValue = LocaleKeys.new_menu_6.tr + " - " + data.seriesValue;
    return seriesValue;
  }

  String getOdds() {
    String Odds = '';
    Odds = data.odds;
    return "@" + Odds;
  }

  String getOrderNo() {
    String orderNo = '';
    orderNo = data.orderNo;
    return orderNo;
  }

  String getModifyTime() {
    String modifyTime = "";
    if (data.betTime.isNotEmpty) {
      modifyTime = TimeZoneUtils.convertTimeToTimestamp(
        data.betTime,
        isMilliseconds: true,
      ).toString().replaceAll("-", "/");
    }
    return modifyTime;
  }

  String getTimeZone() {
    String timeZone = "";

    ///当时已结算和iapd显示时区
    if (type == 1 || isIPad) {
      timeZone = TimeZoneUtils.getTimeZoneString();
    }
    return timeZone;
  }

  String isPreBetAmount() {
    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (type == 0 && data.preBetAmount != 0) {
      return LocaleKeys.app_betslip_remaining_capital.tr;
    }
    return LocaleKeys.bet_record_bet_val.tr;
  }

  String getOrderAmountTotal() {
    String orderAmountTotal = '';
    String managerCode = TYUserController.to.currCurrency();
    orderAmountTotal =
        "${formatNumber(data.orderAmountTotal.toString())} $managerCode";

    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (type == 0 && data.preBetAmount != 0) {
      orderAmountTotal =
          "${setAmount(data.preSettleBetAmount.toString())} $managerCode";
    } else {
      orderAmountTotal =
          "${setAmount(data.orderAmountTotal.toString())} $managerCode";
    }

    return orderAmountTotal;
  }

  /**
   * 注单状态颜色
   */
  int getProfitAmountColor() {
    int profitAmount = 0;
    //当是未注单-未结算就是蓝色
    if (type == 0) {
      return 2;
    }
    //已结注单，注单失败的时候
    if (data.orderStatus == '1') {
      int outcome = data.outcome;
      if (outcome == 4 || outcome == 5) {
        profitAmount = 2;
      }
    }
    return profitAmount;
  }

  /*
   *注单结算状态
   */
  String getProfitAmount() {
    String profitAmount = '';
    String managerCode = TYUserController.to.currCurrency();
    if (type == 0) {
      profitAmount =
          "${formatNumber(data.maxWinAmount.toString())} $managerCode";
    } else if (type == 1) {
      //只有已结注单才会展示  输赢状态
      String results = '';
      //已结注单，注单成功的时候
      if (data.orderStatus == '1') {
        int outcome = data.outcome;
        if (outcome == 2) {
          results = LocaleKeys.bet_record_bet_no_status02.tr;
        } else if (outcome == 3) {
          results = LocaleKeys.bet_record_bet_no_status03.tr;
        } else if (outcome == 4) {
          results = LocaleKeys.bet_record_bet_no_status04.tr;
        } else if (outcome == 5) {
          results = LocaleKeys.bet_record_bet_no_status05.tr;
        } else if (outcome == 6) {
          results = LocaleKeys.bet_record_bet_no_status06.tr;
        } else if (outcome == 7) {
          results = LocaleKeys.bet_record_bet_no_status07.tr;
        } else if (outcome == 8) {
          results = LocaleKeys.bet_record_bet_no_status08.tr;
        }
      } else {
        results = LocaleKeys.bet_record_bet_no_status17.tr;
      }

      //已结注单，注单失败的时候结算是0元
      if (data.orderStatus == '1') {
        profitAmount = results +
            '  ' +
            formatNumber(data.profitAmount.toString()) +
            " " +
            managerCode;
      } else {
        profitAmount = '0.00' + " " + managerCode;
      }
    }
    return profitAmount;
  }

  /*
   *注单状态
   */
  String getOrderStatus() {
    String orderStatus = '';
    String status = data.orderStatus;
    if (status == "0" || status == "1") {
      orderStatus = LocaleKeys.bet_record_successful_betting.tr;
    } else if (status == "2") {
      orderStatus = LocaleKeys.bet_record_invalid_bet.tr;
    } else if (status == "3") {
      orderStatus = LocaleKeys.bet_record_confirming.tr;
    } else if (status == "4") {
      orderStatus = LocaleKeys.bet_bet_err.tr;
    }
    return orderStatus;
  }

  /*
   *注单状态颜色
   */
  int getInformationColorType() {
    int informationColorTyp = 0;
    String Status = data.orderStatus;

    ///已结注单，并且失败的情况下
    if (type == 1 && Status.isEmpty && Status == "4") {
      informationColorTyp = 3;
    }
    return informationColorTyp;
  }
}
