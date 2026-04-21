import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/results_multiple_together_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/cross_checks_titles_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_time_view.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:get/get.dart';
import '../../../../../../generated/locales.g.dart';

import '../../../../../global/ty_user_controller.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../utils/utils.dart';
import '../../../../unsettled_bets/widgets/information_copy_view.dart';
import '../../../../unsettled_bets/widgets/information_view.dart';
import '../../../widgets/results_early_redemption_details_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-998323de-6c52-4771-a2e1-96f8fe57bb0f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果体育注单-串关(已结算/未结算)item视图层 】】】
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
    this.onTap,
  });

  final VoidCallback? onTap;

  final int index;
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

          ///判断单关是否展示提前结算信息的view
          if (getExhibitEarlySettlement())
            ResultsEarlyRedemptionDetailsView(
              data: data,
              index: index,
            ).marginSymmetric(horizontal: 10.h),
        ],
      ),
    );
  }

  /**
   * 串关列表
   */
  Widget _mergeTogether() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Visibility(
        visible: data.detailList.isNotEmpty,
        child: Obx(
          ///串关数据列表
          () => ResultsMultipleTogetherView(
            detailList: data.detailList,
            onTap: onTap,
            Expand: data.isExpand.value,
          ).paddingOnly(top: 4.h, bottom: 4.h),
        ),
      ),
    );
  }

   /*
    *注单信息，时间，金额，状态.....
    */
  Widget _information() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Column(
        children: [
          ///投注单号
          InformationCopyView(
            information: LocaleKeys.app_h5_cathectic_bet_number.tr,
            outcome: getOrderNo(),
          ),

          ///投注时间
          InformationTimeView(
            information: LocaleKeys.bet_record_sort1.tr,
            dateTime: getModifyTime(),
            timeZone: getTimeZone(),
          ),

          ///投注额度
          InformationView(
            information: LocaleKeys.bet_record_bet_val.tr,
            outcome: getOrderAmountTotal(),
            isAmount: true,
          ),

          ///可赢额
          InformationView(
            titleColorType: 2,
            InformationColorType: getProfitAmountColor(),
            information: LocaleKeys.app_h5_cathectic_settle.tr,
            outcome: getProfitAmount(),
            isAmount: true,
          ),

          ///注单状态
          InformationView(
            information: LocaleKeys.app_h5_cathectic_bet_status.tr,
            outcome: getOrderStatus(),
          ),
        ],
      ),
    );
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

    timeZone = TimeZoneUtils.getTimeZoneString();

    return timeZone;
  }

  String getOrderAmountTotal() {
    String orderAmountTotal = '';
    String managerCode = TYUserController.to.currCurrency();
    orderAmountTotal =
        "${setAmount(data.orderAmountTotal.toString())} $managerCode";
    return orderAmountTotal;
  }

  int getProfitAmountColor() {
    int profitAmount = 0;

    //已结注单，注单失败的时候
    if (data.orderStatus == '1') {
      int outcome = data.outcome;
      if (outcome == 4 || outcome == 5) {
        profitAmount = 2;
      }
    }
    return profitAmount;
  }

  String getProfitAmount() {
    String profitAmount = '';
    String managerCode = TYUserController.to.currCurrency();

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
          setAmount(data.profitAmount.toString()) +
          " " +
          managerCode;
    } else {
      profitAmount = '0.00' + " " + managerCode;
    }

    return profitAmount;
  }

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
}
