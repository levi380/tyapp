import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import '../../../../generated/locales.g.dart';

/**
 * 盘面工具类
 * 
 * 提供盘面相关的工具方法，包括：
 * - 比赛状态判断
 * - 键值转换
 * - 数据查找
 */

/**
 * 获取比赛状态
 * 
 * 判断比赛是否为滚球状态
 * 
 * @param ms 比赛状态码
 * @return 返回1表示滚球状态，0表示非滚球状态
 */
int getMatchStatus(int ms) {
  // 为滚球的所有状态
  List<int> allMs = [1, 2, 7, 10, 110];
  // 非滚球
  int isPlay = 0;
  // 进行中,暂停,延迟,比赛中断,即将开赛
  if (allMs.contains(ms)) {
    isPlay = 1;
  }
  return isPlay;
}

/**
 * 转换键值
 * 
 * 将数据源键值转换为显示用的键值
 * 
 * @param tempKey 原始键值
 * @return 转换后的键值
 */
String convertKey(String tempKey) {
  String key = tempKey;
  if (tempKey.startsWith("L01_")) {
    key = tempKey.replaceFirst("L01_", "");
  }
  if (tempKey.startsWith("T01_")) {
    key = tempKey.replaceFirst("T01_", "");
  }

  if (tempKey == "N01") {
    key = "IM";
  }
  if (tempKey == "N02") {
    key = "FB";
  }
  return key;
}

/**
 * 根据ID查找匹配的MatchHps对象
 * 
 * @param oddinfo 盘口信息列表
 * @param id 盘口ID
 * @return 匹配的MatchHps对象，未找到返回null
 */
MatchHps? findMatchHpsById(List<MatchHps> oddinfo, int id) {
  MatchHps? result;
  for (MatchHps item in oddinfo) {
    if (item.chpid == "$id") {
      result = item;
      break;
    }
  }
  return result;
}

/**
 * 计算Tab选项
 * 
 * 根据玩法ID返回对应的Tab选项列表
 * 
 * @param playId 玩法ID
 * @return Tab选项列表，每个选项包含name和value
 */
List<Map<String, String>> computedTabs(int playId) {
  List<Map<String, String>> result = [];
  switch (playId) {
    // 全场独赢  主 客  平
    case 1:
    case 17:
      result = [
        {"name": LocaleKeys.list_win1.tr, "value": "1"},
        {"name": LocaleKeys.list_dogfall.tr, "value": "X"},
        {"name": LocaleKeys.list_win2.tr, "value": "2"},
      ];
      break;
    // 全场大小  大 小
    case 2:
    case 18:
      result = [
        {"name": LocaleKeys.analysis_big.tr, "value": "Over"},
        {"name": LocaleKeys.analysis_small.tr, "value": "Under"}
      ];
      break;
    // 全场让球    主队赔率 客队赔率
    case 4:
    case 19:
      result = [
        {
          "name": LocaleKeys.app_h5_handicap_tutorial_home_team.tr,
          "value": "1"
        },
        {
          "name": LocaleKeys.ouzhou_bet_col_bet_col_4_bet_col_2.tr,
          "value": "2"
        }
      ];
      break;
    default:
      break;
  }

  return result;
}

/**
 * 获取计算后的Tab选项
 * 
 * 根据当前玩法ID返回对应的Tab选项列表（用于走势图）
 * 
 * @param playId 玩法ID
 * @return Tab选项列表
 */
List<Map<String, String>> getComputedTabs(int playId) {
  List<Map<String, String>> arr = [];
  switch (playId) {
    case 1:
    case 17:
      arr = [
        {"name": LocaleKeys.bet_home_win.tr, "value": "1"},
        {"name": LocaleKeys.list_dogfall.tr, "value": "X"},
        {"name": LocaleKeys.bet_away_win.tr, "value": "2"},
      ];
      break;
    // 全场大小  大 小
    case 2:
    case 18:
      arr = [
        {"name": LocaleKeys.bet_home_win.tr, "value": "Over"},
        {"name": LocaleKeys.analysis_big.tr, "value": "Under"}
      ];
      break;
    // 全场让球    主队赔率 客队赔率
    case 4:
    case 19:
      arr = [
        {
          "name": LocaleKeys.app_h5_handicap_tutorial_home_team.tr,
          "value": "1"
        },
        {
          "name": LocaleKeys.app_h5_handicap_tutorial_away_team.tr,
          "value": "2"
        }
      ];
      break;
    default:
      break;
  }
  return arr;
}

/**
 * 查找后续有效值
 * 
 * 从指定索引开始查找列表中第一个非空且大于0的值
 * 
 * @param list 数值列表
 * @param index 起始索引
 * @return 找到的有效值，未找到返回0
 */
double findAfterValue(List<double?> list, int index) {
  double result = 0;
  for (int i = index; i < list.length; i++) {
    if (list[i] != null && ((list[i] ?? 0) > 0)) {
      result = list[i] ?? 0;
      break;
    }
  }
  return result;
}

