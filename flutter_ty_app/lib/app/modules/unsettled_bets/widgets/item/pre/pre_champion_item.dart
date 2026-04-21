import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/ty_user_controller.dart';
import '../../../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../utils/utils.dart';
import '../../../../shop_cart/shop_cart_util.dart';
import '../../information_copy_view.dart';
import '../../information_important_view.dart';
import '../../information_line_view.dart';
import '../../information_time_view.dart';
import '../../information_title_view.dart';
import '../../modify_odds_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-冠军(预约中/已失效))item视图层 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示冠军订单的详细信息，包括赛事信息、投注信息、状态等，适用于不同的订单状态（未注单、已失效）。
    - `index`：当前项在列表中的索引。
    - `data`：包含订单数据的对象。
    - `type`：表示订单状态（0：未注单-预约中，1：已失效）。
    - 创建包含订单信息的视图，使用多个子组件来展示不同的信息。
    - 创建一个包含订单详细信息的列，包括订单号、时间、投注详情、投注金额、可赢金额等。
    - 冠军注单比分
    - 冠军注单详情
    - 冠军注单信息
    - 冠军注单状态
    - `getSportName()`：获取体育项目名称。
    - `getMatchName()`：获取比赛名称。
    - `getPlayName()`：获取玩法名称。
    - `getplayOptionName()`：获取投注选项及赔率。
    - `getOrderNo()`：获取订单号。
    - `getModifyTime()`：获取修改时间。
    - `getMarketType()`：获取市场类型。
    - `getMatchInfo()`：获取赛事信息。
    - `getOrderAmountTotal()`：获取订单总金额。
    - `getProfitAmount()`：获取可赢金额。
    - `getProfitAmountColor()`：获取可赢金额的颜色类型。
    - `getOrderStatus()`：获取订单状态。
    】】】
 *
 */

///冠军
class PreChampionItem extends StatelessWidget {
  const PreChampionItem({
    super.key,
    required this.index,
    required this.data,
    required this.type,
  });

  ///type  0: 未注单-预约中，1:未注单-已失效
  final int index, type;
  final GetH5PreBetOrderlistDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.r,
          ),
        ),
        color:
            context.isDarkMode ? Colors.white.withValues(alpha: 0.04) : Colors.white,
      ),
      margin: EdgeInsets.only(
        bottom: 10.h,
      ),
      padding: EdgeInsets.only(
        top: 8.h,
        left: 12.w,
        right: 12.h,
        bottom: 16.w,
      ),
      child: Column(
        children: [
          ///标题头部
          InformationTitleView(),

          ///赔率信息
          InformationImportantView(
            information: getPlayName(),
            outcome: getplayOptionName(),
          ),

          ///赛事信息
          _information(),

          ///只有预约中才会有修改赔率
          if (type == 0)
            ModifyOddsView(
              index: index,
              data: data,
            ),
        ],
      ),
    );
  }

  Widget _information() {
    return Column(
      children: [
        InformationLineView(
          information: getMatchInfo(),
          multiLine: false,
        ),
        InformationCopyView(
          information: type == 0
              ? LocaleKeys.app_bet_reservation.tr
              : LocaleKeys.app_h5_cathectic_bet_number.tr,
          outcome: getOrderNo(),
        ),
        InformationTimeView(
          information: type == 0
              ? LocaleKeys.app_h5_cathectic_bet_reservatio_time.tr
              : LocaleKeys.bet_record_sort1.tr,
          dateTime: getModifyTime(),
          timeZone: TimeZoneUtils.getTimeZoneString(),
          dish: getMarketType(),
        ),
        InformationView(
          information: type == 0
              ? LocaleKeys.app_h5_bet_reserve_win.tr
              : LocaleKeys.bet_record_bet_val.tr,
          outcome: getOrderAmountTotal(),
          isAmount: true,
        ),
        InformationView(
          titleColorType: 2,
          InformationColorType: 2,
          information: LocaleKeys.app_h5_cathectic_winnable.tr,
          outcome: getMaxWinAmount(),
          isAmount: true,
        ),
        InformationView(
          information: LocaleKeys.app_h5_cathectic_bet_status.tr,
          outcome: getOrderStatus(),
          InformationColorType: type == 0 ? 0 : 3,
        ),
      ],
    );
  }

  String getPlayName() {
    String playName = '';
    if (data.detailList.isNotEmpty) {
      String matchType = '';
      int chType = data.detailList[0].matchType;
      String langCode = data.langCode;
      matchType = getBetType(chType, langCode);
      playName = '$matchType ${data.detailList[0].playName}';
    }

    return playName;
  }

  String getplayOptionName() {
    String playOptionName = "";

    ///100自选波胆
    if (data.detailList.isNotEmpty) {
      if (data.seriesType == '100') {
        var playOptionList = data.detailList[0].playOptionName.split("/");
        ShopCartUtil.sortComboCourage(playOptionList);
        playOptionName =
            playOptionList.join("/ ") + ' @' + data.detailList[0].oddFinally;
      } else {
        playOptionName =
            "${data.detailList[0].playOptionName} @${data.detailList[0].oddFinally}";
      }
    }
    return playOptionName;
  }

  String getOrderNo() {
    String orderNo = "";
    orderNo = data.orderNo;
    return orderNo;
  }

  String getModifyTime() {
    String modifyTime = "";
    String timeString = "";
    if (type == 0) {
      timeString = data.modifyTime;
    } else {
      timeString = data.betTime;
    }
    if (timeString.isNotEmpty) {
      modifyTime = TimeZoneUtils.convertTimeToTimestamp(
        timeString,
        isMilliseconds: true,
      ).toString().replaceAll("-", "/");
    }
    return modifyTime;
  }

  String getMarketType() {
    String marketType = '';
    String keType = data.detailList[0].marketType;
    marketType = getOrderMarketType(keType);
    if (marketType.isNotEmpty) {
      marketType = '(' + marketType + ')';
    }
    return marketType;
  }

  String getMatchInfo() {
    String matchInfo = "";
    if (data.detailList.isNotEmpty) {
      matchInfo = "[" +
          data.detailList[0].sportName +
          "] " +
          data.detailList[0].matchName;

      ///比分样式调整
      if (matchInfo.isNotEmpty &&
          matchInfo.contains("(") &&
          matchInfo.contains(")")) {
        matchInfo = matchInfo
            .replaceAll("(", " ")
            .replaceAll(':', '-')
            .replaceAll(")", "");
      }
    }
    return matchInfo;
  }

  String getOrderAmountTotal() {
    String orderAmountTotal = "";
    String managerCode = TYUserController.to.currCurrency();
    orderAmountTotal =
        formatNumber(data.orderAmountTotal.toString()) + " " + managerCode;
    return orderAmountTotal;
  }

  String getMaxWinAmount() {
    String maxWinAmount = "";
    String managerCode = TYUserController.to.currCurrency();
    maxWinAmount = formatNumber(data.maxWinAmount.toString()) + " " + managerCode;
    return maxWinAmount;
  }

  String getOrderStatus() {
    String orderStatus = "";
    int Status = data.preOrderStatus;
    if (Status == 2 || Status == 3) {
      orderStatus = LocaleKeys.pre_record_booked_fail.tr;
    } else if (Status == 4) {
      orderStatus = LocaleKeys.pre_record_canceled.tr;
    } else {
      orderStatus = LocaleKeys.pre_record_booking.tr;
    }
    return orderStatus;
  }

  getScoreBenchmark() {
    String scoreBenchmark = '';
    if (data.detailList.isNotEmpty &&
        data.detailList[0].scoreBenchmark.isNotEmpty) {
      String benchmark = data.detailList[0].scoreBenchmark.replaceAll(':', '-');
      scoreBenchmark = LocaleKeys.bet_record_settle_num.tr + " " + benchmark;
    }
    return scoreBenchmark;
  }
}
