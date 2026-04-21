import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../main.dart';
import '../../../../../../global/ty_user_controller.dart';
import '../../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../utils/vr_rank_icon_utils.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../shop_cart/shop_cart_util.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-单关(已结算/未结算)item视图层 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
 *
 */

///单关
class OrderIndividuallyItemUtils {
  ///判断单关是否展示提前结算信息的view
  static bool getExhibitEarlySettlement(GetH5OrderListDataRecordxData data) {
    ///只有已结算才有
    if (data.preSettle != null) {
      int preSettle = data.preSettle;
      if (preSettle == 1 || preSettle == 2 || preSettle >= 3) {
        return true;
      }
    }
    return false;
  }

  ///判断是否有提前结算功能
  static bool getEarlySettlementFeature(GetH5OrderListDataRecordxData data,
      int type) {
    ///只有未结注单才展示
    if (type == 0) {
      return data.exhibitEarlySettlement;
    }
    return false;
  }

  static String getHomeName(GetH5OrderListDataRecordxData data) {
    String homeName = '';
    if (data.detailList.isNotEmpty) {
      var matchInfo = data.detailList[0].matchInfo;
      if (matchInfo.contains(' VS ')) {
        homeName = matchInfo.split(' VS ')[0];
      } else if (matchInfo.contains(' v ')) {
        homeName = matchInfo.split(' v ')[0];
      }

      ///去除比分
      if (homeName.isNotEmpty &&
          homeName.contains("(") &&
          homeName.contains(")")) {
        homeName = homeName.split('(')[0];
      }
    }
    return homeName;
  }

  static String getAwayName(GetH5OrderListDataRecordxData data) {
    String awayName = '';
    if (data.detailList.isNotEmpty) {
      var matchInfo = data.detailList[0].matchInfo;
      if (matchInfo.contains(' VS ')) {
        awayName = matchInfo.split(' VS ')[1];
      } else if (matchInfo.contains(' v ')) {
        awayName = matchInfo.split(' v ')[1];
      }

      ///去除比分
      if (awayName.isNotEmpty &&
          awayName.contains("(") &&
          awayName.contains(")")) {
        awayName = awayName.split('(')[0];
      }
    }
    return awayName;
  }

  static String getPlayName(GetH5OrderListDataRecordxData data) {
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

  static bool getPreOrder(GetH5OrderListDataRecordxData data) {
    if (data.preOrder != null) {
      if (data.preOrder == 1) {
        return true;
      }
    }
    return false;
  }


  static String getSpecial(GetH5OrderListDataRecordxData data) {
    String playOptionsOddFinally = '';
    if (data.detailList.isNotEmpty) {
      ///100自选波胆
      if (data.seriesType == '100') {
        var playOptionList = data.detailList[0].playOptionName.split("/");
        ShopCartUtil.sortComboCourage(playOptionList);
        playOptionsOddFinally = playOptionList.join("/ ");
      } else {
        String marketValue = data.detailList[0].marketValue + " ";
        int sportId = data.detailList[0].sportId;
        String playOptions = data.detailList[0].playOptions;

        ///当多个vr 体育排名图标显示的时候marketValue不需要显示
        if ([1009, 1010, 1011, 1002].contains(sportId) &&
            playOptions.isNotEmpty &&
            playOptions.contains("/")) {
          marketValue = "";
        }

        playOptionsOddFinally = marketValue;
      }
    }
    return playOptionsOddFinally;
  }

  ///注单赔率
  static String getOddFinally(GetH5OrderListDataRecordxData data) {
    String oddFinally = '';
    oddFinally = data.detailList[0].oddFinally;
    return oddFinally;
  }

  ///注单优惠赔率
  static String getEov(GetH5OrderListDataRecordxData data) {
    String eov = '';
    eov = data.detailList[0].eov;
    return eov;
  }

  static String getPlayOptions(GetH5OrderListDataRecordxData data) {
    String playOptionsOddFinally = '';
    if (data.detailList.isNotEmpty) {
      ///100自选波胆
      if (data.seriesType == '100') {
        var playOptionList = data.detailList[0].playOptionName.split("/");
        ShopCartUtil.sortComboCourage(playOptionList);
        playOptionsOddFinally =
            playOptionList.join("/ ") + ' @' + data.detailList[0].oddFinally;
      } else {
        String marketValue = data.detailList[0].marketValue + " ";
        int sportId = data.detailList[0].sportId;
        String playOptions = data.detailList[0].playOptions;

        ///当多个vr 体育排名图标显示的时候marketValue不需要显示
        if ([1009, 1010, 1011, 1002].contains(sportId) &&
            playOptions.isNotEmpty &&
            playOptions.contains("/")) {
          marketValue = "";
        }

        playOptionsOddFinally =
        "${marketValue}@${data.detailList[0].oddFinally}";
      }
    }
    return playOptionsOddFinally;
  }

  static String getOrderNo(GetH5OrderListDataRecordxData data) {
    String orderNo = '';
    orderNo = data.orderNo;
    return orderNo;
  }

  static String getModifyTime(GetH5OrderListDataRecordxData data) {
    String modifyTime = "";
    if (data.betTime.isNotEmpty) {
      /// print("时区-----"+index.toString()+"--------"+parse.toString());
      modifyTime = TimeZoneUtils.convertTimeToTimestamp(
        data.betTime,
        isMilliseconds: true,
      ).toString().replaceAll("-", "/");
    }
    return modifyTime;
  }

  static String getTimeZone(GetH5OrderListDataRecordxData data, int type) {
    String timeZone = "";

    ///当时已结算和iapd显示时区
    if (type == 1 || isIPad) {
      timeZone = TimeZoneUtils.getTimeZoneString();
    }
    return timeZone;
  }

  static String getMarketType(GetH5OrderListDataRecordxData data) {
    String marketType = '';
    String keType = data.detailList[0].marketType;
    marketType = getOrderMarketType(keType);
    if (marketType.isNotEmpty) {
      marketType = '(' + marketType + ')';
    }
    return marketType;
  }

  static String getMatchInfo(GetH5OrderListDataRecordxData data) {
    String matchInfo = '';
    if (data.detailList.isNotEmpty) {
      matchInfo =
      "[${data.detailList[0].sportName}] ${data.detailList[0].matchName}";

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

  ///vr体育的单号
  static String getBatchNo(GetH5OrderListDataRecordxData data) {
    ///vr体育6种，vr足球，vr篮球 vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
    String batchNo = '';
    if (data.detailList.isNotEmpty) {
      int sportId = data.detailList[0].sportId;

      /// vr足球，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
      if ([1001, 1009, 1010, 1011, 1002].contains(sportId)) {
        String prepare = data.detailList[0].batchNo;
        if (prepare.isNotEmpty) {
          ///vr足球和vr篮球没有带期，其它4种带了，要删除在拼，不然国际化有问题
          if (prepare.contains('期')) {
            prepare = prepare.replaceAll('期', '');
          }
          batchNo = prepare + LocaleKeys.bet_record_period.tr;
        }

        ///vr篮球
      } else if (sportId == 1004) {
        String matchDay = data.detailList[0].matchDay;
        if (matchDay.isNotEmpty && matchDay.contains('期')) {
          var split = matchDay.split('期')[0];
          if (split.isNotEmpty) {
            batchNo = split + LocaleKeys.bet_record_period.tr;
          }
        }
      }
    }
    return batchNo;
  }

  static String getSettleScore(GetH5OrderListDataRecordxData data) {
    String settleScore = '';
    if (data.detailList.isNotEmpty) {
      settleScore =
      '${LocaleKeys.bet_record_score_result.tr} ${data.detailList[0]
          .settleScore}';
    }
    return settleScore;
  }

  static String gettleScore(GetH5OrderListDataRecordxData data) {
    String settleScore = '';
    if (data.detailList.isNotEmpty) {
      settleScore = data.detailList[0].settleScore;
    }
    return settleScore;
  }

  static String isPreBetAmount(GetH5OrderListDataRecordxData data, int type) {
    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (type == 0 && data.preBetAmount != 0) {
      return LocaleKeys.app_betslip_remaining_capital.tr;
    }
    return LocaleKeys.bet_record_bet_val.tr;
  }

  static String getOrderAmountTotal(GetH5OrderListDataRecordxData data,
      int type) {
    String orderAmountTotal = '';
    String managerCode = TYUserController.to.currCurrency();

    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (type == 0 && data.preBetAmount != 0) {
      orderAmountTotal =
      "${formatNumber(data.preSettleBetAmount.toString())} $managerCode";
    } else {
      orderAmountTotal =
      "${formatNumber(data.orderAmountTotal.toString())} $managerCode";
    }
    return orderAmountTotal;
  }

  static String getProfitAmount(GetH5OrderListDataRecordxData data, int type) {
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

  static int getProfitAmountColor(GetH5OrderListDataRecordxData data,
      int type) {
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

  static String getOrderStatus(GetH5OrderListDataRecordxData data) {
    String orderStatus = '';
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

  static int getInformationColorType(GetH5OrderListDataRecordxData data,
      int type) {
    int informationColorTyp = 0;
    String Status = data.orderStatus;

    ///已结注单，在注单无效和失败的情况下
    if (type == 1 && ["2", "4"].contains(Status)) {
      informationColorTyp = 3;
    }

    return informationColorTyp;
  }

  static getScoreBenchmark(GetH5OrderListDataRecordxData data) {
    String scoreBenchmark = '';
    if (data.detailList.isNotEmpty &&
        data.detailList[0].scoreBenchmark.isNotEmpty) {
      String benchmark = data.detailList[0].scoreBenchmark.replaceAll(':', '-');
      scoreBenchmark = "${LocaleKeys.bet_record_settle_num.tr} $benchmark";
    }
    return scoreBenchmark;
  }

  /*
  *vr图标
   */
  static List<String> getVrIcon(GetH5OrderListDataRecordxData data) {
    int sportId = 0;
    String playOptions = "";
    List<String> rankIcons = [];

    if (data.detailList.isNotEmpty) {
      sportId = data.detailList[0].sportId;
    }
    if (data.detailList.isNotEmpty) {
      playOptions = data.detailList[0].playOptions;
    }

    /*
    *单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
     */
    if ([1009, 1010, 1011, 1002].contains(sportId) && playOptions.isNotEmpty) {
      List<String> result = playOptions.split('/');
      if (result.isNotEmpty) {
        for (int i = 0; i < result.length; i++) {
          rankIcons.add(VrRankIconUtils.getRankIcon(sportId, result[i],
              acceptNoValue: true));
        }
      }
    }
    return rankIcons;
  }
}
