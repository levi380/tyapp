import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/information_title_view.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../main.dart';
import '../../../../../../global/ty_user_controller.dart';
import '../../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../shop_cart/shop_cart_util.dart';
import '../../../../../unsettled_bets/utils/betsUtils.dart';
import '../../../../../unsettled_bets/widgets/information_copy_view.dart';
import '../../../../../unsettled_bets/widgets/information_important_view.dart';
import '../../../../../unsettled_bets/widgets/information_line_view.dart';

import '../../../../../unsettled_bets/widgets/information_time_view.dart';
import '../../../../../unsettled_bets/widgets/information_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-冠军(已结算/未结算)item视图层 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示冠军订单的详细信息，包括赛事信息、投注信息、状态等，适用于不同的订单状态（未注单-未结算、已结算）。
    - `index`：当前项在列表中的索引。
    - `data`：包含订单数据的对象。
    - `type`：表示订单状态（0：未注单-未结算，1：已结算）。
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
class OrderChampionItem extends StatelessWidget {
  const OrderChampionItem({
    super.key,
    required this.index,
    required this.data,
    required this.type,
  });

  ///type  0: 未注单-未结算 ，1:已结算
  final int index, type;
  final GetH5OrderListDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.r,
          ),
        ),
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white,
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
          ///按照开云的不要不要标题头部
          InformationTitleView(
            appointmentMarking: getPreOrder(),
          ),

          //盘口信息
          InformationImportantView(
            information: getPlayName(),
            outcome: getplayOptionName(),
          ),

          //注单信息
          _information(),
        ],
      ),
    );
  }

  /**
   * 注单信息
   */
  Widget _information() {
    return Column(
      children: [
        ///投注详情
        InformationLineView(
          iconUrl:
              BetsUtils.getBetResultIcon(data.detailList[0].betResult),
          information: getMatchInfo(),
          multiLine: false,
        ),

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
          dish: getMarketType(),
        ),

        ///投注额
        InformationView(
          information: LocaleKeys.bet_record_bet_val.tr,
          outcome: getOrderAmountTotal(),
          isAmount: true,
        ),

        ///可赢额
        InformationView(
          titleColorType: 2,
          InformationColorType: getProfitAmountColor(),
          information: type == 0
              ? LocaleKeys.app_h5_cathectic_winnable.tr
              : LocaleKeys.app_h5_cathectic_settle.tr,
          outcome: getProfitAmount(),
          isAmount: true,
        ),

        ///注单状态
        InformationView(
          information: LocaleKeys.app_h5_cathectic_bet_status.tr,
          outcome: getOrderStatus(),
          InformationColorType: getInformationColorType(),
        ),
      ],
    );
  }

  String getSportName() {
    String sportNam = "";
    if (data.detailList.isNotEmpty) {
      sportNam = "[${data.detailList[0].sportName}]";
    }
    return sportNam;
  }

  String getMatchName() {
    String matchName = "";
    if (data.detailList.isNotEmpty) {
      matchName = data.detailList[0].matchName;
    }
    return matchName;
  }

  ///  是不是预约注单成功的冠军
  bool getPreOrder() {
    if (data.preOrder != null) {
      if (data.preOrder == 1) {
        return true;
      }
    }
    return false;
  }

  String getPlayName() {
    String playName = "";
    if (data.detailList.isNotEmpty) {
      String matchType = "";
      int chType = data.detailList[0].matchType;
      String langCode = data.langCode;
      matchType = getBetType(chType, langCode);
      playName = '$matchType  ${data.detailList[0].playName}';
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

    if (data.modifyTime.isNotEmpty) {
      modifyTime = TimeZoneUtils.convertTimeToTimestamp(data.modifyTime,
              isMilliseconds: true)
          .toString()
          .replaceAll("-", "/");
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

  String getProfitAmount() {
    String profitAmount = '';
    String managerCode = TYUserController.to.currCurrency();
    if (type == 0) {
      profitAmount =
          formatNumber(data.maxWinAmount.toString()) + " " + managerCode;
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

  String getOrderStatus() {
    String orderStatus = "";
    String Status = data.orderStatus;
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
