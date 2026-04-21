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
import '../../rule_statement_view.dart';



class PreMergeTogetherItem extends StatelessWidget {
  const PreMergeTogetherItem({
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
          _body(context),
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
          _earlyRedemptionView().marginSymmetric(
            horizontal: 10.h,
          ),
        ],
      ),
    );
  }

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
            outcome: getSettlementStatus(),
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
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      width: 256.w,
      height: 180.h,
      decoration: ShapeDecoration(
        color: context.isDarkMode ? const Color(0xFF1E2029) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x4C000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.app_h5_cathectic_kind_tips.tr,
                  style: TextStyle(
                    color: Color(context.isDarkMode ? 0xFFE9E9EA : 0xFF303442),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.h, right: 10.h),
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.app_h5_cathectic_confirm_cancel_reservation.tr,
                    style: TextStyle(
                      color: const Color(0xFF7981A4),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 44.h,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Color(context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).pop(),
                    },
                    child: Text(
                      LocaleKeys.common_cancel.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            Color(context.isDarkMode ? 0xFF67696F : 0xFFAFB3C8),
                        fontSize: 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 44.h,
                  width: 1.w,
                  color: Color(context.isDarkMode ? 0xFF272931 : 0xFFF3FAFF),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => {
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.common_ok.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(
                              context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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


  /*
   *注单结算状态
   */
  String getSettlementStatus() {
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

  /**
   * 注单状态颜色
   */
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
    if (type == 1) {
      if (["2", "4"].contains(Status)) {
        informationColorTyp = 3;
      }
    }
    return informationColorTyp;
  }
}
