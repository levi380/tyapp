import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/title_view.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../main.dart';
import '../../../../../global/ty_user_controller.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../utils/utils.dart';
import '../../../../../utils/vr_rank_icon_utils.dart';
import '../../../../bet/widgets/rule_statement_view.dart';
import '../../../../settled_bets/settled_bets_logic.dart';
import '../../../../shop_cart/shop_cart_util.dart';
import '../../../await_bets/await_bets_logic.dart';

import '../../../unsettled_bets_logic.dart';
import '../../../utils/betsUtils.dart';
import '../../early_redemption_details_view.dart';
import '../../early_settlement_feature_view.dart';
import '../../information_copy_view.dart';
import '../../information_important_view.dart';
import '../../information_line_view.dart';
import '../../information_special_view.dart';
import '../../information_time_view.dart';
import '../../information_vr_view.dart';
import '../../record_match_info.dart';
import '../../title_special_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-单关(已结算/未结算)item视图层 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示单独订单的详细信息，包括赛事信息、投注信息、状态等，适用于不同的订单状态（未注单-未结算、已结算）。
    - `index`：当前项在列表中的索引。
    - `data`：包含订单数据的对象。
    - `getHomeName()`：获取主队名称。
    - `getAwayName()`：获取客队名称。
    - `getPlayName()`：获取玩法名称。
    - `getPlayOptions()`：获取玩法选项及赔率。
    - `getOrderNo()`：获取订单号。
    - `getModifyTime()`：获取修改时间。
    - `getMarketType()`：获取市场类型。
    - `getMatchInfo()`：获取赛事信息。
    - `getSettleScore()`：获取结算比分。
    - `gettleScore()`：获取当前比分。
    - `getOrderAmountTotal()`：获取订单总金额。
    - `getProfitAmount()`：获取可赢金额。
    - `getProfitAmountColor()`：获取可赢金额的颜色类型。
    - `getOrderStatus()`：获取订单状态。
    - `getScoreBenchmark()`：获取比分基准。
    - `getExhibitEarlySettlement()`：判断是否展示提前结算信息。
    - `getEarlySettlementFeature()`：判断是否有提前结算功能。
    】】】
 *
 */

///单关
class OrderIndividuallyItem extends StatelessWidget {
  const OrderIndividuallyItem({super.key, required this.index, required this.data, required this.type,});
  ///type  0: 未注单-未结算 ，1:已结算
  final int index, type;final GetH5OrderListDataRecordxData data;

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
      padding: EdgeInsets.only(top: 8.h, left: 12.w, right: 12.w, bottom: 16.h),
      child: Column(
        children: [
          ///球队标题
          _titleview(),
          ///赛事赔率
          _handicapInformation(),
          ///赛事信息
          _information(),
          ///赛事提前结算
          _earlyRedemptionView(),
        ],
      ),
    );
  }

  ///球队标题
  Widget _titleview() {
    int sportId = 0;
    if (data.detailList.isNotEmpty) {
      sportId = data.detailList[0].sportId;
    }

    ///单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车，标题头部不一样
    if ([1009, 1010, 1011, 1002].contains(sportId)) {
      return TitleSpecialView(
        information: data.detailList[0].batchNo,
      );
    } else {
      return TitleView(information: getHomeName(), outcome: getAwayName(), appointmentMarking: getPreOrder(),
      );
    }
  }

  ///赛事信息
  Widget _information() {
    return Column(
      children: [
        ///注单说明
        InformationLineView(iconUrl:BetsUtils.getBetResultIcon(data.detailList[0].betResult), information: getMatchInfo(), batchNo: getBatchNo(), multiLine: false,
        ),
        ///投注单号
        InformationCopyView(information: LocaleKeys.app_h5_cathectic_bet_number.tr, outcome: getOrderNo(),
        ),
        ///投注时间
        InformationTimeView(information: LocaleKeys.bet_record_sort1.tr, dateTime: getModifyTime(), timeZone: getTimeZone(), dish: getMarketType(),
        ),
        ///赛事比分
        if (type == 0)Obx(() {
          if (AwaitBetsLogic.to.matchInfoList.isNotEmpty) {return RecordMatchInfo(data: data, matchInfoList: AwaitBetsLogic.to.matchInfoList,);} else {return Container();}
        }),
        ///只有已结算，才有结果比分
        if (type == 1 && gettleScore().isNotEmpty)
          InformationLineView(
            information: getSettleScore(),
          ),

        ///投注额度，或者未算本金
        InformationView(information: isPreBetAmount(), outcome: getOrderAmountTotal(), isAmount: true,
        ),

        ///可赢额
        InformationView(titleColorType: 2, InformationColorType: getProfitAmountColor(), information: type == 0 ? LocaleKeys.app_h5_cathectic_winnable.tr : LocaleKeys.app_h5_cathectic_settle.tr, outcome: getProfitAmount(), isAmount: true,
        ),
        ///注单状态
        InformationView(information: LocaleKeys.app_h5_cathectic_bet_status.tr, outcome: getOrderStatus(), InformationColorType: getInformationColorType(),
        ),
      ],
    );
  }

  ///提前结算
  _earlyRedemptionView() {
    return Column(
      children: [
        ///提前兑现说明
        if (getEarlySettlementFeature() || getExhibitEarlySettlement())const RuleStatementView(),

        ///只有未注单才有，
        ///判断是否开启提前结算功能,提前结算功能的view（已结和未结都有）
        if (getEarlySettlementFeature())EarlySettlementFeatureView(index: index, data: data,
          ),

        ///提前结算,结算信息的view（已结和未结都有）
        if (getExhibitEarlySettlement())
          EarlyRedemptionDetailsView(data: data, index: index, onTap: () {
              if (type == 0)  {
                /// 已结算提前兑现折叠
                Get.find<AwaitBetsLogic>().onPreSettleExpand(index);}else if (type == 1)  {
                /// 已结算提前兑现折叠
                Get.find<SettledBetsLogic>().onPreSettleExpand(index);
              }
            },
          ),
      ],
    );
  }

  ///注单说明
  Widget getInformationWidget() {
    String batchNo = getBatchNo();

    ///vr赛事
    if (batchNo.isNotEmpty) {
      return InformationVrView(
        information: getMatchInfo(),
        batchNo: batchNo,
      );
    }
    //常规赛事
    return InformationLineView(
      information: getMatchInfo(),
      multiLine: false,
    );
  }

  ///展示优惠盘口还是常规盘口信息
  Widget _handicapInformation() {
    Widget widget = Container();

    String eov = data.detailList[0].eov;
    if (eov.isEmpty) {
      ///常规盘口
      widget = InformationImportantView(
        information: getPlayName(),
        outcome: getPlayOptions(),
        scoreBenchmark: getScoreBenchmark(),
        vrIcons: getVrIcon(),
      );
    } else {
      ///优惠盘口
      widget = InformationSpecialView(
        information: getPlayName(),
        outcome: getSpecial(),
        scoreBenchmark: getScoreBenchmark(),
        oddFinally: getOddFinally(),
        eov: getEov(),
      );
    }
    return InkWell(
      onTap: () => {
        ///（4325需求开发），发版本可以先屏蔽需求上线了，在打开
        ///未结算
        if (type == 0)
          {
            Get.find<UnsettledBetsLogic>().getExistMatchResult(
                data.detailList[0].matchId,
                data.detailList[0].playOptionsId,
                data.detailList[0].sportId,
                data.detailList[0].beginTime,
                dataSourceCode: data.detailList[0].dataSourceCode),
          }
        else if (type == 1)
          {
            ///已结算
            Get.find<SettledBetsLogic>().getExistMatchResult(
                data.detailList[0].matchId,
                data.detailList[0].playOptionsId,
                data.detailList[0].sportId,
                data.detailList[0].beginTime,
                dataSourceCode: data.detailList[0].dataSourceCode),
          }
      },
      child: widget,
    );
  }

  ///判断单关是否展示提前结算信息的view
  bool getExhibitEarlySettlement() {
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
  bool getEarlySettlementFeature() {
    ///只有未结注单才展示
    if (type == 0) {
      return data.exhibitEarlySettlement;
    }
    return false;
  }

  String getHomeName() {
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

  String getAwayName() {
    String awayName = '';
    if (data.detailList.isNotEmpty) {var matchInfo = data.detailList[0].matchInfo;if (matchInfo.contains(' VS ')) {awayName = matchInfo.split(' VS ')[1];} else if (matchInfo.contains(' v ')) {awayName = matchInfo.split(' v ')[1];}

      ///去除比分
      if (awayName.isNotEmpty && awayName.contains("(") && awayName.contains(")")) {awayName = awayName.split('(')[0];
      }
    }
    return awayName;
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

  bool getPreOrder() {
    if (data.preOrder != null) {if (data.preOrder == 1) {return true;}}return false;
  }

  String getPlayOptions() {
    String playOptionsOddFinally = '';
    if (data.detailList.isNotEmpty) {
      ///100自选波胆
      if (data.seriesType == '100') {var playOptionList = data.detailList[0].playOptionName.split("/");ShopCartUtil.sortComboCourage(playOptionList);playOptionsOddFinally = playOptionList.join("/ ") + ' @' + data.detailList[0].oddFinally;
      } else {String marketValue = data.detailList[0].marketValue + " ";int sportId = data.detailList[0].sportId;String playOptions = data.detailList[0].playOptions;
        ///当多个vr 体育排名图标显示的时候marketValue不需要显示
        if ([1009, 1010, 1011, 1002].contains(sportId) && playOptions.isNotEmpty && playOptions.contains("/")) {marketValue = "";}playOptionsOddFinally = "${marketValue}@${data.detailList[0].oddFinally}";}}return playOptionsOddFinally;}

  String getSpecial() {
    String playOptionsOddFinally = '';
    if (data.detailList.isNotEmpty) {
      ///100自选波胆
      if (data.seriesType == '100') {var playOptionList = data.detailList[0].playOptionName.split("/");ShopCartUtil.sortComboCourage(playOptionList);playOptionsOddFinally = playOptionList.join("/ ");} else {String marketValue = data.detailList[0].marketValue + " ";int sportId = data.detailList[0].sportId;String playOptions = data.detailList[0].playOptions;
        ///当多个vr 体育排名图标显示的时候marketValue不需要显示
        if ([1009, 1010, 1011, 1002].contains(sportId) && playOptions.isNotEmpty && playOptions.contains("/")) {marketValue = "";}playOptions = "${marketValue}@${data.detailList[0].oddFinally}";
      }
    }
    return playOptionsOddFinally;
  }
  ///注单赔率
  String getOddFinally() {String oddFinally = '';oddFinally = data.detailList[0].oddFinally;return oddFinally;}
  ///注单优惠赔率
  String getEov() {String eov = '';eov = data.detailList[0].eov;return eov;}

  String getOrderNo() {String orderNo = '';orderNo = data.orderNo;return orderNo;}
  String getModifyTime() {String modifyTime = "";if (data.betTime.isNotEmpty) {
      /// print("时区-----"+index.toString()+"--------"+parse.toString());
      modifyTime = TimeZoneUtils.convertTimeToTimestamp(data.betTime, isMilliseconds: true,).toString().replaceAll("-", "/");}return modifyTime;
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
    String marketType = '';String keType = data.detailList[0].marketType;marketType = getOrderMarketType(keType);if (marketType.isNotEmpty) {marketType = '(' + marketType + ')';}return marketType;
  }

  String getMatchInfo() {
    String matchInfo = '';
    if (data.detailList.isNotEmpty) {matchInfo = "[${data.detailList[0].sportName}] ${data.detailList[0].matchName}";
      ///比分样式调整
      if (matchInfo.isNotEmpty && matchInfo.contains("(") && matchInfo.contains(")")) {matchInfo = matchInfo.replaceAll("(", " ").replaceAll(':', '-').replaceAll(")", "");}
    }return matchInfo;
  }

  ///vr体育的单号
  String getBatchNo() {
    ///vr体育6种，vr足球，vr篮球 vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
    String batchNo = '';
    if (data.detailList.isNotEmpty) {
      int sportId = data.detailList[0].sportId;

      /// vr足球，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
      if ([1001, 1009, 1010, 1011, 1002].contains(sportId)) {String prepare = data.detailList[0].batchNo;if (prepare.isNotEmpty) {
          ///vr足球和vr篮球没有带期，其它4种带了，要删除在拼，不然国际化有问题
          if (prepare.contains('期')) {prepare = prepare.replaceAll('期', '');}batchNo = prepare + LocaleKeys.bet_record_period.tr;
      }
        ///vr篮球
      } else if (sportId == 1004) {String matchDay = data.detailList[0].matchDay;if (matchDay.isNotEmpty && matchDay.contains('期')) {var split = matchDay.split('期')[0];if (split.isNotEmpty) {batchNo = split + LocaleKeys.bet_record_period.tr;}}}}
    return batchNo;
  }

  String getSettleScore() {
    String settleScore = '';
    if (data.detailList.isNotEmpty) {
      settleScore = '${LocaleKeys.bet_record_score_result.tr} ${data.detailList[0].settleScore}';
    }
    return settleScore;
  }

  String gettleScore() {String settleScore = '';if (data.detailList.isNotEmpty) {settleScore = data.detailList[0].settleScore;
  }
  return settleScore;
  }

  String isPreBetAmount() {
    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (type == 0 && data.preBetAmount != 0) {return LocaleKeys.app_betslip_remaining_capital.tr;}return LocaleKeys.bet_record_bet_val.tr;
  }

  String getOrderAmountTotal() {String orderAmountTotal = '';String managerCode = TYUserController.to.currCurrency();orderAmountTotal = "${formatNumber(data.orderAmountTotal.toString())} $managerCode";
    ///未结注单，后台注单已经确认，注单已经提前结算过
    if (type == 0 && data.preBetAmount != 0) {orderAmountTotal = "${setAmount(data.preSettleBetAmount.toString())} $managerCode";} else {orderAmountTotal = "${setAmount(data.orderAmountTotal.toString())} $managerCode";}return orderAmountTotal;
  }

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
        int outcome = data.outcome;if (outcome == 2) {results = LocaleKeys.bet_record_bet_no_status02.tr;} else if (outcome == 3) {results = LocaleKeys.bet_record_bet_no_status03.tr;} else if (outcome == 4) {results = LocaleKeys.bet_record_bet_no_status04.tr;} else if (outcome == 5) {results = LocaleKeys.bet_record_bet_no_status05.tr;} else if (outcome == 6) {results = LocaleKeys.bet_record_bet_no_status06.tr;} else if (outcome == 7) {results = LocaleKeys.bet_record_bet_no_status07.tr;} else if (outcome == 8) {results = LocaleKeys.bet_record_bet_no_status08.tr;}
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

  int getProfitAmountColor() {
    int profitAmount = 0;
    //当是未注单-未结算就是蓝色
    if (type == 0) {return 2;}
    //已结注单，注单失败的时候
    if (data.orderStatus == '1') {int outcome = data.outcome;if (outcome == 4 || outcome == 5) {profitAmount = 2;}}
    return profitAmount;
  }

  String getOrderStatus() {
    String orderStatus = '';String Status = data.orderStatus;if (Status == "0" || Status == "1") {orderStatus = LocaleKeys.bet_record_successful_betting.tr;} else if (Status == "2") {orderStatus = LocaleKeys.bet_record_invalid_bet.tr;} else if (Status == "3") {orderStatus = LocaleKeys.bet_record_confirming.tr;} else if (Status == "4") {orderStatus = LocaleKeys.bet_bet_err.tr;}return orderStatus;
  }

  int getInformationColorType() {
    int informationColorTyp = 0;String Status = data.orderStatus;
    ///已结注单，在注单无效和失败的情况下
    if (type == 1 && ["2", "4"].contains(Status)) {informationColorTyp = 3;}return informationColorTyp;
  }
  getScoreBenchmark() {
    String scoreBenchmark = '';
    if (data.detailList.isNotEmpty && data.detailList[0].scoreBenchmark.isNotEmpty) {String benchmark = data.detailList[0].scoreBenchmark.replaceAll(':', '-');scoreBenchmark = "${LocaleKeys.bet_record_settle_num.tr} $benchmark";}return scoreBenchmark;
  }
  ///vr图标
  List<String> getVrIcon() {
    int sportId = 0;String playOptions = "";List<String> rankIcons = [];if (data.detailList.isNotEmpty) {sportId = data.detailList[0].sportId;}if (data.detailList.isNotEmpty) {playOptions = data.detailList[0].playOptions;}
    ///单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
    if ([1009, 1010, 1011, 1002].contains(sportId) && playOptions.isNotEmpty) {List<String> result = playOptions.split('/');if (result.isNotEmpty) {for (int i = 0; i < result.length; i++) {rankIcons.add(VrRankIconUtils.getRankIcon(sportId, result[i], acceptNoValue: true));}}}return rankIcons;
  }
}
