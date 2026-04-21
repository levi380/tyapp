import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/title_special_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/modify_odds_view.dart';

import '../../../../../../../generated/locales.g.dart';

import '../../../../../../global/ty_user_controller.dart';

import '../../../../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../../utils/utils.dart';

import '../../../../../login/login_head_import.dart';
import '../../../../../shop_cart/shop_cart_util.dart';

import '../../../../../unsettled_bets/widgets/information_copy_view.dart';
import '../../../../../unsettled_bets/widgets/information_important_view.dart';
import '../../../../../unsettled_bets/widgets/information_line_view.dart';

import '../../../../../unsettled_bets/widgets/information_time_view.dart';
import '../../../../../unsettled_bets/widgets/information_view.dart';
import '../../../../../unsettled_bets/widgets/information_vr_view.dart';
import '../../ty_bets_logic.dart';
import '../../widgets/title_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-单关(预约中/已失效)item视图层 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示预注单的详细信息，包括赛事信息、赔率、状态等，适用于不同的订单状态（未注单、已失效）。
    - `index`：当前项在列表中的索引。
    - `data`：包含预注单数据的对象。
    - `type`：表示订单状态（0：未注单-预约中，1：已失效）。
    - 创建包含预注单信息的视图，使用多种子组件来展示不同的信息。
    - 根据 `sportId` 决定标题的显示方式，展示不同的标题组件。
    - 创建一个包含预注单详细信息的列，包括状态、时间、赔率等。
    - 单关(预约中/已失效)item注单比分
    - 单关(预约中/已失效)item注单详情
    - 单关(预约中/已失效)item注单信息
    - 单关(预约中/已失效)item注单状态
    - 单关(预约中/已失效)item注单预约中，修改订单视图
    - `getHomeName()`：获取主队名称。
    - `getAwayName()`：获取客队名称。
    - `getPlayName()`：获取玩法名称。
    - `getPlayOptions()`：获取玩法选项及赔率。
    - `getOrderNo()`：获取订单号。
    - `getModifyTime()`：获取修改时间。
    - `getMarketType()`：获取市场类型。
    - `getMatchInfo()`：获取赛事信息。
    - `getOrderAmountTotal()`：获取订单总金额。
    - `getMaxWinAmount()`：获取最大赢利金额。
    - `getOrderStatus()`：获取订单状态。
    】】】
 *
 */

///单关
class PreIndividuallyItem extends StatelessWidget {
  const PreIndividuallyItem({
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
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.only(
        top: 8.h,
        left: 12.w,
        right: 12.w,
        bottom: 16.h,
      ),
      child: Column(
        children: [
          ///标题头部
          _titleview(),

          ///赔率信息
          _handicapInformation(),

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
      return TitleView(
        information: getHomeName(),
        outcome: getAwayName(),
      );
    }
  }

  ///展示常规盘口信息
  Widget _handicapInformation() {
    return InkWell(
      onTap: () => {
        ///（4325需求开发），发版本可以先屏蔽需求上线了，在打开
        Get.find<TyBetsLogic>().getExistMatchResult(
            data.detailList[0].matchId,
            data.detailList[0].playOptionsId,
            data.detailList[0].sportId,
            data.detailList[0].beginTime),
      },
      child: InformationImportantView(
        information: getPlayName(),
        outcome: getPlayOptions(),
        scoreBenchmark: getScoreBenchmark(),
      ),
    );
  }

  Widget _information() {
    return Column(
      children: [
        ///注单说明
        getInformationWidget(),
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

  String getPlayOptions() {
    String playOptions = "";
    if (data.detailList.isNotEmpty) {
      ///100自选波胆
      if (data.seriesType == '100') {
        var playOptionList = data.detailList[0].playOptionName.split("/");
        ShopCartUtil.sortComboCourage(playOptionList);
        playOptions =
            playOptionList.join("/ ") + ' @' + data.detailList[0].oddFinally;
      } else {
        ///盘口调整
        if (data.detailList[0].originalMarketValue.isNotEmpty) {
          if (data.detailList[0].playOptionName.isNotEmpty &&
              data.detailList[0].playOptionName.contains(" ")) {
            var split = data.detailList[0].playOptionName.split(" ")[0];

            String originalMarketValue =
                split + " " + data.detailList[0].originalMarketValue;
            playOptions =
                originalMarketValue + " @" + data.detailList[0].oddFinally;
          } else {
            playOptions =
                "${data.detailList[0].playOptionName} @${data.detailList[0].oddFinally}";
          }
        } else {
          playOptions =
              "${data.detailList[0].playOptionName} @${data.detailList[0].oddFinally}";
        }
      }
    }
    return playOptions;
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

  ///vr体育的单号
  String getBatchNo() {
    String batchNo = '';
    if (data.detailList.isNotEmpty) {
      int sportId = data.detailList[0].sportId;

      ///vr体育6种，vr足球，vr篮球 vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
      if ([1001, 1004, 1009, 1010, 1011, 1002].contains(sportId)) {
        String prepare = data.detailList[0].batchNo;
        if (prepare.isNotEmpty) {
          ///vr足球和vr篮球没有带期，其它4种带了，要删除在拼，不然国际化有问题
          if (prepare.contains('期')) {
            prepare = prepare.replaceAll('期', '');
          }
          batchNo = prepare + LocaleKeys.bet_record_period.tr;
        }
      }
    }
    return batchNo;
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
    maxWinAmount =
        formatNumber(data.maxWinAmount.toString()) + " " + managerCode;
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
