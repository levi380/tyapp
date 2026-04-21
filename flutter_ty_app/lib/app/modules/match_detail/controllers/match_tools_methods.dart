import 'package:flutter/services.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../global/data_store_controller.dart';
import '../../../global/ty_user_controller.dart';
import '../../../utils/format_date_util.dart';
import '../../../utils/format_score_util.dart';
import '../../../utils/format_score_util3.dart';
import '../../../utils/match_util.dart';
import '../../../utils/sport.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../login/login_head_import.dart';
import '../../quick_bet/quick_bet_controller.dart';
import '../extension/detail_api_service.dart';

/// 判断是否为中立场
/// [match] 赛事实体
/// 返回true表示是中立场，false表示非中立场
/// 注意：网球、羽毛球、斯诺克、乒乓球、沙滩排球不判断中立场
bool isMidField(MatchEntity? match) {
  int csid = int.tryParse(match?.csid ?? "") ?? 0;
  int mng = match?.mng ?? 0;
  if (![
    SportData.sportCsid_5,
    SportData.sportCsid_10,
    SportData.sportCsid_7,
    SportData.sportCsid_8,
    SportData.sportCsid_13
  ].contains(csid) &&
      mng == 1) {
    return true;
  }
  return false;
}

/// 获取队伍名称
/// [type] 队伍类型，1为主队，2为客队
/// [match] 赛事实体
/// 返回队伍名称，使用不换行空格替换普通空格
String getTeamName({int type = 1, MatchEntity? match}) {
  if (match == null) {
    return "";
  }
  return getTeamNameOrigin(type: type, match: match)
      .replaceAllMapped(RegExp(r' '), (m) => '\u00A0'); // 用不換行空格替換普通空格
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 获取队伍名称 1主队 2客队
    】】】
 *
 */
String getTeamNameOrigin({int type = 1, required MatchEntity match}) {
  if (type == 1) {
    String mhn = match.mhn;
    if (mhn.contains("/")) {
      List<String> mhnList = mhn.split(" / ");
      return "${mhnList.safe(0) ?? ""}/${mhnList.safe(1) ?? ""}";
    } else {
      return mhn;
    }
  } else {
    String man = match.man;
    if (man.contains("/")) {
      List<String> manList = man.split(" / ");
      return "${manList.safe(0) ?? ""}/${manList.safe(1) ?? ""}";
    } else {
      return man;
    }
  }
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛事分析】】】
    【【【 AUTO_PARAGRAPH_TITLE 统计主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 获取双对赛事名称
    】】】
 *
 */
List<String> getDoubleTeamName({int type = 1, required MatchEntity match}) {
  if (type == 1) {
    String mhn = match.mhn;
    if (mhn.contains("/")) {
      List<String> mhnList = mhn.split(" / ");
      return ['${mhnList.safe(0) ?? ""}', '/${mhnList.safe(1) ?? ""}'];
    } else {
      return [mhn];
    }
  } else {
    String man = match.man;
    if (man.contains("/")) {
      List<String> manList = man.split(" / ");
      return ['${manList.safe(0) ?? ""}', '/${manList.safe(1) ?? ""}'];
    } else {
      return [man];
    }
  }
}

/// 获取比分VS格式字符串
/// [msc] 比分数据列表
/// 从S1|格式的比分中提取并转换为"vs"格式
String getMsc(List<String> msc, {String vFlag = "v"}) {
  String result = "";
  for (var item in msc) {
    if (item.contains('S1|')) {
      result = item.split('|')[1].split(':').join(' $vFlag ');
      continue;
    }
  }
  return result;
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛事分析】】】
    【【【 AUTO_PARAGRAPH_TITLE 统计主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 是否展示精彩回放
    】】】
 *
 */
bool needShowReplay(MatchEntity? match) {
  final replayInfo = TYUserController.to.userInfo.value?.merchantEventSwitchVO;

  // 默认展示统计
  const virtualSports = ['BE', 'C01', 'OD', 'O01'];
  int configValue = replayInfo?.configValue.toInt() ?? 0;
  int eventSwitch = replayInfo?.eventSwitch.toInt() ?? 0;
  if (configValue < 1 || eventSwitch < 1) {
    return false;
  }

  if (!['1', '90'].contains(match?.csid)) {
    return false;
  }

  if (match?.cds != null && virtualSports.contains(match?.cds)) {
    return false;
  }

  return true;
}

// 红牌比分
Map<String, int> s11Score(MatchEntity match) {
  final score = {'home': 0, 'away': 0};
  List<String> msc = match.msc;
  for (final item in msc) {
    if (item.contains('|')) {
      final parts = item.split('|');
      if (parts.length >= 2 && parts[0] == 'S11') {
        final scoreParts = parts[1].split(':');
        if (scoreParts.length == 2) {
          score['home'] = int.tryParse(scoreParts[0]) ?? 0;
          score['away'] = int.tryParse(scoreParts[1]) ?? 0;
          break; // 找到就退出循环
        }
      }
    }
  }

  return score;
}

/// 判断是否进入加时赛
/// [match] 赛事实体
/// 加时赛阶段：32(加时开始)、41(加时上半场)、42(加时下半场)、33(加时中场休息)、110(加时结束)
/// 注意：不包括点球阶段(34、50、120)
bool isOvertime(MatchEntity? match) {
  return ["32", "41", "42", "33", "110"].contains(match?.mmp);
}

/// 更新默认比分数据
/// [str] 比分字符串，格式为"S1|1:0"
/// [mid] 赛事ID
/// 如果该比分类型不存在，则添加到赛事的msc列表中
setNativeDetailData(String str, String mid) {
  MatchEntity? matchEntity = DataStoreController.to.getMatchById(mid);

  // 判断是否有相应赛事
  List<String> arrMsc = [];
  List<String> msc = matchEntity?.msc ?? [];
  for (String item in msc) {
    arrMsc.add(item.split("|")[0]);
  }
  if (!arrMsc.contains(str.split("|")[0]) && matchEntity != null) {
    matchEntity.msc.add(str);

    /// 更新比分 数据仓库
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DataStoreController.to.updateMatch(matchEntity);
    });
  }
}

/// 局间比分显示逻辑：滚球阶段ms=1并且对应赛种才显示
/// ms 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
/// 4--冰球, 5--网球, 7--斯诺克, 8--乒乓球, 9--排球, 10--羽毛球, 13--沙滩排球,14--橄榄球, 15--曲棍球, 16--水球 37 板球
///  A代表ACE，就是俗称的发球直接得分！
bool showMatchBetweenScore(MatchEntity match) {
  List<String> msc = match.msc;
  if ([
    SportData.sportCsid_3,
    SportData.sportCsid_4,
    SportData.sportCsid_5,
    SportData.sportCsid_7,
    SportData.sportCsid_6,
    SportData.sportCsid_8,
    SportData.sportCsid_9,
    SportData.sportCsid_10,
    SportData.sportCsid_13,
    SportData.sportCsid_14,
    SportData.sportCsid_15,
    SportData.sportCsid_16,
    SportData.sportCsid_37,
  ].contains(match.csid.toInt()) &&
      match.ms == 1 &&
      msc.isNotEmpty &&
      match.mmp != "999") {
    return true;
  }
  return false;
}

/// 判断是否显示比赛中断标识（足球）
/// [match] 赛事实体
/// 当csid为1(足球)且mmp为80(比赛暂停)时返回true
bool showMatchInterrupted(MatchEntity match) {
  if ([SportData.sportCsid_1].contains(match.csid.toInt()) &&
      match.mmp == "80") {
    return true;
  }
  return false;
}

/// 处理屏幕方向变化
/// [controller] 详情控制器
/// [orientation] 屏幕方向
/// 横屏时进入全屏模式，竖屏时退出全屏模式
void handleOrientation(MatchDetailController controller,
    Orientation orientation) {
  if (orientation == Orientation.landscape) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    controller.detailState.fullscreen.value = true;
    QuickBetController.to.setFullScreen(true);
    controller.cancelFirstFullBetGuild();
  } else if (orientation == Orientation.portrait) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    controller.detailState.fullscreen.value = false;
    QuickBetController.to.setFullScreen(false);
  }
}

/// 判断是否为电竞比分
/// [match] 赛事实体
/// 当mmp(比赛阶段)与总比分不匹配时，表示正在计分中
bool eSportsScoring(MatchEntity match) {
  bool scoring = false;
  // 如果是电竞，则进行比分判定处理
  if (MatchUtil.isEsport(match)) {
    int mmp = int.tryParse(match.mmp) ?? 1;
    int home = FormatScore.formatTotalScore(match, 0);
    int away = FormatScore.formatTotalScore(match, 1);
    if (mmp != (home + away + 1)) {
      scoring = true;
    }
  }
  return scoring;
}

/// 判断置顶悬浮条是否展示比分
/// [match] 赛事实体
/// 当比赛状态为进行中(1、2、3、4)或电竞比赛进行中时返回true
bool isTopShowScore(MatchEntity match) {
  int ms = match.ms;

  if ([
    SportData.sportMs_1,
    SportData.sportMs_2,
    SportData.sportMs_3,
    SportData.sportMs_4
  ].contains(ms) ||
      // 或者电竞详情时
      ((MatchUtil.isEsport(match)) && ms > 0)) {
    return true;
  } else {
    return false;
  }
}


///@description 角球 红牌 黄牌
///@param {Undefined}
///@return {Array} 角球 红牌 黄牌数
// 角球
//       corner_kick: S555,
//       // 红牌
//       red_card: S11001,
//       // 黄牌
//       yellow_card: S12001,
//       // 点球
//       penalty_kick: S10,
//       // 上半场
//       first_half: S2,
//       // 全场比分
//       full_court: S1,
//       // 加时赛 角球
//       corner_kick_overtime: S500,
//       // 加时赛 红牌
//       red_card_overtime: S503,
//       // 加时赛 黄牌
//       yellow_card_overtime: S506,
//       // 加时赛全场比分
//       score_overtime: S7,
//       // 点球大战比分
//       score_penalty_kick: S170,
//       // 加时赛点球分数
//       score_penalty_kick_overtime: S509,
//       // 加时赛上半场分数
//       score_first_half_overtime: S701,
List<String> footballScoreStatusArray(MatchEntity match) {
  List<String> msc = List.from(match.msc);

  // 比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
  msc.sort((a, b) {
    String? numIndexA = a.split("|")[0];
    String? numIndexB = b.split("|")[0];
    int numA = numIndexA != "" ? int.parse(numIndexA.substring(1)) : 0;
    int numB = numIndexB != "" ? int.parse(numIndexB.substring(1)) : 0;
    return numA.compareTo(numB);
  });

  // 常规赛角球、红牌、黄牌   加时赛角球、红牌、黄牌
  List<String> scoreArr = [
    '0:0',
    '0:0',
    '0:0',
    '0:0',
    '0:0',
    '0:0',
  ];
  // 循环取出接口返回的比分里面的角球、红牌和黄牌数
  msc.forEach((item) {
    String? numIndex = item.split("|")[0];
    String? score = item.split("|")[1];
    if (numIndex == 'S555') {
      scoreArr[0] = score;
    } else if (numIndex == 'S11001') {
      scoreArr[1] = score;
    } else if (numIndex == 'S12001') {
      scoreArr[2] = score;
    } else if (numIndex == 'S500') {
      scoreArr[3] = score;
    } else if (numIndex == 'S503') {
      scoreArr[4] = score;
    } else if (numIndex == 'S506') {
      scoreArr[5] = score;
    }
  });
  return scoreArr;
}

/// 赛事阶段显示内容 下部分 字体
double getMatchStageBottomContentFontSize(int ms, bool startTime) {
  // 赛事未开赛
  if (ms == 0) {
    // 即将开赛的赛事不显示日期
    if (startTime) {
      // 距离开赛时间小于一个小时 显示倒计时 (分钟)
      return isIPad ? 16.sp : 12.sp;
    } else {
      // 显示HH：mm
      return isIPad ? 40.sp : 30.sp;
    }
  }
  // 赛前切滚球 ms = 110时：显示即将开赛
  else if (ms == 110) {
    return isIPad ? 16.sp : 12.sp;
  } else if ([1, 2, 3, 4].contains(ms)) {
    // 显示比分
    return isIPad ? 40.sp : 30.sp;
  }
  return isIPad ? 40.sp : 30.sp;
}

/// 赛事阶段显示内容 下部分(比赛时间or开赛时间)
String matchStageContentBottom(MatchEntity match, bool startTime,
    String longTime) {
  int ms = match.ms;
  // 赛事未开赛
  if (ms == SportData.sportMs_0) {
    // 即将开赛的赛事不显示日期
    if (startTime) {
      // 距离开赛时间小于一个小时 显示倒计时 (分钟)
      return LocaleKeys.list_after_time_start.tr.replaceAll("{0}", longTime);
    } else {
      // 格式化显示HH:MM
      return FormatDate.formatHHMM(TimeZoneUtils.convertTimeToTimestamp(
          match.mgt,
          isMilliseconds: true,
          returnMilliseconds: true))
          .toString();
    }
  }
  // 赛前切滚球 ms = 110时：显示即将开赛
  else if (ms == SportData.sportMs_110) {
    return "ms_$ms".tr;
  } else if ([
    SportData.sportMs_1,
    SportData.sportMs_2,
    SportData.sportMs_3,
    SportData.sportMs_4
  ].contains(ms)) {
    ///比分位置  新增 电竞比分判定中
    if (eSportsScoring(match)) {
      return LocaleKeys.mmp_eports_scoring.tr;
    }

    /// 显示比分
    return "${FormatScore3.formatDetailScore(match, 0)} - ${FormatScore3
        .formatDetailScore(match, 1)}";
  }
  return "";
}
