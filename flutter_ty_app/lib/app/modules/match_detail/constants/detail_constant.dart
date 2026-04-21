import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../utils/sport.dart';
import '../../home/logic/other_player_name_to_playid.dart';

/// 置顶悬浮条高度
double obtyAppbarHeight = 44.h;
double obtyBottomHeight = 52.h;
double obtyHeaderBottomHeight = (isIPad ? 68.h : 50.h);

/// GetBuildId
const String matchSelectGetBuildId = "matchSelectGetBuildId";
const String matchBetModeTabGetBuildId = "matchBetModeTabGetBuildId";
const String matchBetMainTabGetBuildId = "matchBetMainTabGetBuildId";
const String matchOddsInfoGetBuildId = "matchOddsInfoGetBuildId";
const String matchLiveGetBuildId = "matchLiveGetBuildId";

/// 动画直播比例
const double obtyAnimateRatio = 980 / 556;

const Map<String, dynamic> createObj = {
  'id': 9999914,
  'label': 'NEW',
  'marketName': '创造玩法',
  'orderNo': '',
};

const Map<String, List<String>> pidObj = {
  playIdConfig.hpsCorner: ['585', '77'], // 角球类
  playIdConfig.hpsPenalty: ['177'], // 点球大战
  playIdConfig.hpsPromotion: ['322'], // 晋级
  playIdConfig.hpsOvertime: ['176'], // 加时进球
  playIdConfig.hpsPunish: ['178', '1000000283'], // 罚牌
  playIdConfig.hps15Minutes: ['115'], // 十五分钟玩法
  playIdConfig.hpsOutright: ['322'], // 冠军
  playIdConfig.hpsTCorner: ['314'], // 加时赛角球
  playIdConfig.hpsTPunish: ['315'], // 加时赛罚牌
  playIdConfig.hpsBetBuilder: ['9999914'], // 加时赛罚牌
};

/// z01动画直播比例
double obtyAnimateZ01Ratio = isIPad ? (430 / 170) : (430 / 206);

/**
 * 支持全屏投注的赛事
 * @return {*}
 */
/*
  1：足球
  2：篮球
  5：网球
  3：棒球
  9：排球
  8：乒乓球
  7：斯诺克
  4：冰球
  10：羽毛球
  6：美式足球
  37：板球
  11：手球
  12：拳击、格斗
  13：沙滩排球
  14：联合橄榄球
  15：曲棍球
  16：水球
  * */
final fullBetMatchList = [
  SportData.sportCsid_1,
  SportData.sportCsid_2,
  SportData.sportCsid_5,
  SportData.sportCsid_3,
  SportData.sportCsid_9,
  SportData.sportCsid_8,
  SportData.sportCsid_7,
  SportData.sportCsid_4,
  SportData.sportCsid_10,
  SportData.sportCsid_6,
  SportData.sportCsid_37,
  SportData.sportCsid_11,
  SportData.sportCsid_12,
  SportData.sportCsid_13,
  SportData.sportCsid_14,
  SportData.sportCsid_15,
  SportData.sportCsid_16
];

//增值赔率玩法集ID
const String ADDED_ODDS_CATEGORY_ID = "99999";