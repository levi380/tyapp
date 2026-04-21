import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/show_all_single_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/single_together_new_view.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/vr_rank_icon_utils.dart';
import '../../bet_ty_cp_zr/ty/bets/unsettled/unsettled_bets_logic.dart';
import '../../login/login_head_import.dart';
import '../utils/betsUtils.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)串关列表Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能展示多个串关投注的详细信息，支持展开和折叠功能。
    - `MultipleTogetherView`：接收四个参数：
    - `detailList`：包含投注详情的列表。
    - `onTap`：点击展开/折叠的回调函数。
    - `Expand`：布尔值，指示当前是否展开。
    - `type`：整数类型，表示当前的类型。
    - 返回一个 `Column`，包含多个投注的视图。
    - `getMultipleTogether` 方法根据 `Expand` 状态和 `detailList` 的长度决定显示的条目数量。
    - 当条目超过 3 条时，提供一个展开/折叠的功能。
    - 使用 `SingleTogetherView` 显示每个投注的详细信息，包括市场值、赔率、玩法名称、比赛信息等。
    - 根据投注的状态设置显示样式，如顶部和底部的线条类型。
    】】】
 *
 */
class MultipleTogetherView extends StatelessWidget {
  const MultipleTogetherView({
    Key? key,
    required this.detailList,
    this.onTap,
    required this.Expand,
    required this.type,
    required this.managerCode,
  }) : super(key: key);

  final bool Expand;
  final VoidCallback? onTap;
  final detailList;
  final int type;
  final int managerCode;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: getMultipleTogether(),
    );
  }

  List<Widget> getMultipleTogether() {
    List<Widget> listSingleTogetherView = [];
    /**
     * 串关折叠开关
     * 当超过3条以上如果开关打开，就显示所有条目
     * 不超过3条，不用判断开关是否打开，显示全部
     */
    if (detailList.isNotEmpty) {
      int length = 0;
      if (Expand || detailList.length < 4) {
        length = detailList.length;
      } else {
        length = 3;
      }

      for (int i = 0; i < length; i++) {
        GetH5OrderListDataRecordxDataDetailList datadetailList = detailList[i];

        /// topType:0  是不显示头部的线条
        /// topType:1  显示头部的线条
        int topType = 1;

        /// bottomType:0  不显示线条
        /// bottomType:1  显示实线蓝色线条
        /// bottomType:2  显示虚线蓝色线条
        int bottomType = 1;
        if (i == 0) {
          topType = 0;
        }
        if (length - 1 == i) {
          if (!Expand) {
            if (detailList.length < 4) {
              bottomType = 0;
            } else {
              bottomType = 2;
            }
          } else {
            bottomType = 0;
          }
        }

        ///获取子条目数据
        listSingleTogetherView.add(
          _singleTogetherNewView(datadetailList,topType,bottomType),
        );
      }
    }

    ///当大于3个串才有展开折叠功能
    if (detailList.length > 3) {
      listSingleTogetherView.add(ShowAllSingleView(
        onTap: onTap,
        Expand: Expand,
      ));
    }
    return listSingleTogetherView;
  }


  _singleTogetherNewView(GetH5OrderListDataRecordxDataDetailList datadetailList, int topType, int bottomType) {
    if (type ==0){

      final logic = Get.find<UnsettledBetsLogic>();

      return Obx(() {
        return SingleTogetherNewView(
          type: type,
          marketValue: getMarketValue(datadetailList),
          oddFinally: getOddFinally(datadetailList),
          matchName: getMatchName(datadetailList),
          playName: getPlayName(datadetailList),
          matchInfo: getMatch(datadetailList),
          settleScore: setSettleScore(datadetailList),
          betResult: setBetResult(datadetailList),
          betResultColor: setBetResultColor(datadetailList),
          sportName: getSportName(datadetailList),
          eov: getEov(datadetailList),
          topType: topType,
          bottomType: bottomType,
          scoreBenchmark: getScoreBenchmark(datadetailList),
          vrRankIconUrl: getVrRankIconUrl(datadetailList),
          iconUrl: BetsUtils.getBetResultIcon(datadetailList.betResult),
          datadetailList: datadetailList,
          managerCode: managerCode,
          matchInfoList: logic.state.matchInfoList.value,
          beginTime: getBeginTime(datadetailList),
        );
      });
    }else{
      return  SingleTogetherNewView(
        type: type,
        marketValue: getMarketValue(datadetailList),
        oddFinally: getOddFinally(datadetailList),
        matchName: getMatchName(datadetailList),
        playName: getPlayName(datadetailList),
        matchInfo: getMatch(datadetailList),
        settleScore: setSettleScore(datadetailList),
        betResult: setBetResult(datadetailList),
        betResultColor: setBetResultColor(datadetailList),
        sportName: getSportName(datadetailList),
        eov: getEov(datadetailList),
        topType: topType,
        bottomType: bottomType,
        scoreBenchmark: getScoreBenchmark(datadetailList),
        vrRankIconUrl: getVrRankIconUrl(datadetailList),
        iconUrl:
        BetsUtils.getBetResultIcon(datadetailList.betResult),
        datadetailList: datadetailList,
        managerCode: managerCode,
        beginTime: getBeginTime(datadetailList),
      );
    }

  }


  ///vr图标
  List<String> getVrRankIconUrl(
      GetH5OrderListDataRecordxDataDetailList datadetailList) {
    int sportId = 0;
    String playOptions = "";
    List<String> rankIcons = [];

    // if (datadetailList != null) {
    //   sportId = datadetailList.sportId;
    // }
    sportId = datadetailList.sportId;

    // if (datadetailList != null) {
    //   playOptions = datadetailList.playOptions;
    // }
      playOptions = datadetailList.playOptions;
    ///单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
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

  String getMarketValue(
      GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String marketValue = '';
    marketValue = datadetailList.marketValue;
    return marketValue;
  }

  ///注单优惠赔率
  String getEov(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String eov = '';
    if (datadetailList.eov.isNotEmpty) {
      eov = datadetailList.eov;
    }
    return eov;
  }

  String getOddFinally(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String oddFinally = '';
    oddFinally = datadetailList.oddFinally;
    return oddFinally;
  }


  getMatchName(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String matchName = '';
    matchName = datadetailList.matchName;
    int sportId = datadetailList.sportId;

    ///vr足球，vr篮球
    if (type == 1 && [1001, 1004].contains(sportId)) {
      matchName =
          matchName + " "+datadetailList.batchNo + LocaleKeys.bet_record_period.tr;
    }

    return matchName;
  }

  String getPlayName(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String playName = '';
    String matchType = '';
    playName = datadetailList.playName;

    int sportId = datadetailList.sportId;

    ///4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车 105无畏契约
    if ([1009, 1010, 1011, 1002,105].contains(sportId)) {
      matchType = datadetailList.sportName;
    } else {
      int chType = datadetailList.matchType;
      if (chType == 1) {
        matchType = LocaleKeys.matchtype_1.tr;
      } else if (chType == 2) {
        matchType = LocaleKeys.new_menu_1.tr;
      } else if (chType == 3) {
        matchType = LocaleKeys.new_menu_4.tr;
      }
    }

    ///无畏契约
    if (sportId == 105) {
      int chType = datadetailList.matchType;
      String match = '';
      if (chType == 1) {
        match = LocaleKeys.matchtype_1.tr + " ";
      } else if (chType == 2) {
        match = LocaleKeys.new_menu_1.tr + " ";
      } else if (chType == 3) {
        match = LocaleKeys.new_menu_4.tr + " ";
      }
      return "「" + matchType + "」" + match + playName;
    }

    if (matchType.isNotEmpty) {
      return "「" + matchType + "」" + playName;
    }
    return playName;
  }

  String getMatch(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String matchInfo = '';
    int sportId = datadetailList.sportId;

    ///4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
    if ([1009, 1010, 1011, 1002].contains(sportId)) {
      matchInfo= LocaleKeys.common_virtual_sports.tr;
    } else if (datadetailList.homeName.isNotEmpty &&
        datadetailList.awayName.isNotEmpty) {
      matchInfo = datadetailList.homeName + " VS " + datadetailList.awayName;
    }
    //  matchInfo = datadetailList.matchInfo;
    //  if (matchInfo.isNotEmpty&&matchInfo.contains(" v ")){
    //    matchInfo=matchInfo.replaceAll(" v ", );
    //  }
    return matchInfo;
  }

  String setSettleScore(
      GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String settleScore = '';
    settleScore = datadetailList.settleScore;
    if (settleScore.isEmpty) {
      return "";
    }
    return LocaleKeys.bet_record_score_result.tr + " " + settleScore;
  }

  bool setBetResultColor(
      GetH5OrderListDataRecordxDataDetailList datadetailList) {
    int result = datadetailList.betResult;
    return (result == 4 || result == 5);
  }

  String setBetResult(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    // 'bet_record_bet_no_status00': '未结算',
    // 'bet_record_bet_no_status02': '走水',
    // 'bet_record_bet_no_status03': '输',
    // 'bet_record_bet_no_status04': '赢',
    // 'bet_record_bet_no_status05': '赢半',
    // 'bet_record_bet_no_status06': '输半',
    // 'bet_record_bet_no_status07': '比赛取消',
    // 'bet_record_bet_no_status08': '比赛延期',
    // 'bet_record_bet_no_status11': '比赛延迟',
    // 'bet_record_bet_no_status12': '比赛中断',
    // 'bet_record_bet_no_status15': '比赛放弃',
    String betResult = '';
    int result = datadetailList.betResult;
    if (result == 0) {
      // betResult = LocaleKeys.bet_record_bet_no_status00.tr;
      betResult = LocaleKeys.bet_record_bet_no_status17.tr;
    } else if (result == 2) {
      betResult = LocaleKeys.bet_record_account.tr +
          " " +
          LocaleKeys.bet_record_bet_no_status02.tr;
      // betResult = LocaleKeys.bet_record_bet_no_status02.tr;
    } else if (result == 3) {
      betResult = LocaleKeys.bet_record_account.tr +
          " " +
          LocaleKeys.bet_record_bet_no_status03.tr;
      // betResult = LocaleKeys.bet_record_bet_no_status03.tr;
    } else if (result == 4) {
      betResult = LocaleKeys.bet_record_account.tr +
          " " +
          LocaleKeys.bet_record_bet_no_status04.tr;
      // betResult = LocaleKeys.bet_record_bet_no_status04.tr;
    } else if (result == 5) {
      betResult = LocaleKeys.bet_record_account.tr +
          " " +
          LocaleKeys.bet_record_bet_no_status05.tr;
      // betResult = LocaleKeys.bet_record_bet_no_status05.tr;
    } else if (result == 6) {
      betResult = LocaleKeys.bet_record_account.tr +
          " " +
          LocaleKeys.bet_record_bet_no_status06.tr;
      // betResult = LocaleKeys.bet_record_bet_no_status06.tr;
    } else if (result == 7) {
      betResult = LocaleKeys.bet_record_bet_no_status07.tr;
    } else if (result == 8) {
      betResult = LocaleKeys.bet_record_bet_no_status08.tr;
    } else if (result == 11) {
      betResult = LocaleKeys.bet_record_bet_no_status11.tr;
    } else if (result == 12) {
      betResult = LocaleKeys.bet_record_bet_no_status12.tr;
    } else if (result == 13) {
    } else if (result == 15) {
      betResult = LocaleKeys.bet_record_bet_no_status15.tr;
    } else if (result == 16) {
      betResult = LocaleKeys.bet_record_bet_no_status16.tr;
    } else if (result == 17) {
      betResult = LocaleKeys.bet_record_bet_no_status17.tr;
    }
    return betResult;
  }

  String getSportName(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String sportName = '';
    String matchType = '';
    String marketType = "";

    int chType = datadetailList.matchType;
    if (chType == 1) {
      matchType = LocaleKeys.matchtype_1.tr;
    } else if (chType == 2) {
      matchType = LocaleKeys.new_menu_1.tr;
    } else if (chType == 3) {
      matchType = LocaleKeys.new_menu_4.tr;
    }

    String scoreBenchmark = '';

    if (datadetailList.scoreBenchmark.isNotEmpty) {
      scoreBenchmark = " (" + datadetailList.scoreBenchmark + ")";
    }

    String keType = datadetailList.marketType;
    if (keType == "EU") {
      if (Get.locale?.languageCode == 'zh') {
        marketType = "[${LocaleKeys.odds_EU.tr}]";
      } else {
        marketType = "[${Locales.en_GB['odds_EU']}]";
      }
    } else if (keType == "GB") {
      if (Get.locale?.languageCode == 'zh') {
        marketType = "[${LocaleKeys.odds_GB.tr}]";
      } else {
        marketType = "[${Locales.en_GB['odds_GB']}]";
      }
    } else if (keType == "HK") {
      if (Get.locale?.languageCode == 'zh') {
        marketType = "[${LocaleKeys.odds_HK.tr}]";
      } else {
        marketType = "[${Locales.en_GB['odds_HK']}]";
      }
    } else if (keType == "ID") {
      if (Get.locale?.languageCode == 'zh') {
        marketType = "[${LocaleKeys.odds_ID.tr}]";
      } else {
        marketType = "[${Locales.en_GB['odds_ID']}]";
      }
    } else if (keType == "MY") {
      if (Get.locale?.languageCode == 'zh') {
        marketType = "[${LocaleKeys.odds_MY.tr}]";
      } else {
        marketType = "[${Locales.en_GB['odds_MY']}]";
      }
    } else if (keType == "US") {
      if (Get.locale?.languageCode == 'zh') {
        marketType = "[${LocaleKeys.odds_US.tr}]";
      } else {
        marketType = "[${Locales.en_GB['odds_US']}]";
      }
    }
    sportName = datadetailList.sportName +
        ' ' +
        matchType +
        ' ' +
        datadetailList.playName +
        scoreBenchmark +
        ' ' +
        marketType;

    return sportName;
  }

  getScoreBenchmark(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String scoreBenchmark = '';
    if (datadetailList.scoreBenchmark.isNotEmpty) {
      String benchmark = datadetailList.scoreBenchmark.replaceAll(':', '-');
      scoreBenchmark = LocaleKeys.bet_record_settle_num.tr + " " + benchmark;
    }
    return scoreBenchmark;
  }

  /*
   * 开赛时间
   */
  getBeginTime(GetH5OrderListDataRecordxDataDetailList datadetailList) {
    String beginTime = "";
    if (type == 0) {
      String modifyTime = "";
      String timeZone = "";
      if (datadetailList.beginTime.isNotEmpty) {
        modifyTime = TimeZoneUtils.convertTimeToTimestamp(
          datadetailList.beginTime,
          isMilliseconds: true,
        ).toString();

        timeZone = TimeZoneUtils.getTimeZoneString();

        // 检查字符串是否符合预期的格式
        RegExp regExp = RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$');

        ///截取年和秒，优化单需要这么干 ，优化单100257
        if (modifyTime.length > 15 && regExp.hasMatch(modifyTime)) {
          modifyTime = modifyTime.substring(5, modifyTime.length - 3);
        } else {
          modifyTime = "";
        }

        if (modifyTime.isNotEmpty || timeZone.isNotEmpty) {
          beginTime = modifyTime + " " + "(" + timeZone + ")";
        }
      }
    }
    return beginTime;
  }
}
