import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/analysis/analysis_data_model.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../../../app/modules/login/login_head_import.dart';

/**
 * 数据处理服务类
 * 负责赛事数据的计算、处理和转换
 */
class MatchDataProcessorService {
  /**
   * 根据score_type查找列表中的项
   * @param score_type 分数类型
   * @param tempList 临时列表
   * @return 找到的项，如果未找到返回null
   */
  static NewAnalyzeMatchResultItem? findItemByScoreType(
      String score_type, List<NewAnalyzeMatchResultItem> tempList) {
    NewAnalyzeMatchResultItem? result;
    for (NewAnalyzeMatchResultItem item in tempList) {
      if (item.score_type == score_type) {
        result = item;
        break;
      }
    }
    return result;
  }

  /**
   * 获取危险进攻数据
   * ['S104','S8','S105'], 全场
   * ['S1041','S811','S1051'], 90分钟
   * ['S1042','S812','S1052'], 加时赛
   * @param list 分数类型列表
   * @param match 赛事实体
   * @return 分析结果项列表
   */
  static List<NewAnalyzeMatchResultItem> getDanger(
      List<String> list, MatchEntity? match) {
    List<NewAnalyzeMatchResultItem> tempList = [];
    tempList.add(NewAnalyzeMatchResultItem(
        list[0], LocaleKeys.match_result_attack.tr, ""));
    tempList.add(NewAnalyzeMatchResultItem(
        list[1], LocaleKeys.match_result_dangerous_offense.tr, ""));
    tempList.add(NewAnalyzeMatchResultItem(
        list[2], LocaleKeys.match_result_ball_possession.tr, ""));
    for (String score_type in list) {
      for (String data in match?.msc ?? []) {
        if (!data.contains(score_type)) {
          continue;
        }
        if (data.split("|").length <= 1) {
          continue;
        }
        String k = data.split("|")[0];
        String odds = data.split("|")[1];
        // 解析主客队比分，格式为"主队:客队"
        num home = ((odds.split(":").length > 1)
                ? (num.tryParse(odds.split(":")[0]) ?? 0)
                : 0)
            .toDouble();
        num away = (odds.split(":").length > 1)
            ? (double.tryParse(odds.split(":")[1]) ?? 0)
            : 0;

        NewAnalyzeMatchResultItem? item = findItemByScoreType(k, tempList);
        if (((home + away) != 0)) {
          item?.home = home;
          item?.away = away;

          // S104表示进攻，计算主队比例；其他计算客队比例
          if (score_type == "S104") {
            item?.proportion = ((double.tryParse((item.home.toDouble() /
                                ((item.home + item.away) == 0
                                    ? 1
                                    : (item.home + item.away)))
                            .toStringAsFixed(2)) ??
                        0) *
                    100)
                .truncate();
          } else {
            item?.proportion = ((double.tryParse((item.away.toDouble() /
                                ((item.home + item.away) == 0
                                    ? 1
                                    : (item.home + item.away)))
                            .toStringAsFixed(2)) ??
                        0) *
                    100)
                .truncate();
          }
        }
      }
    }
    return tempList;
  }

  /**
   * 根据列表查找新的分析结果项
   * @param list 分析结果项列表
   * @param match 赛事实体
   * @param isProportion 是否计算比例
   * @return 新的分析结果项列表
   */
  static List<NewAnalyzeMatchResultItem> findNewAnalyzeMatchResultItemByList(
      List<NewAnalyzeMatchResultItem> list, MatchEntity? match,
      {bool? isProportion = false}) {
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemList = [];
    for (NewAnalyzeMatchResultItem item in list) {
      for (String data in match?.msc ?? []) {
        if (!data.contains(item.score_type)) {
          continue;
        }
        if (data.split("|").length <= 1) {
          continue;
        }
        String odds = data.split("|")[1];
        // 解析主客队比分，格式为"主队:客队"
        num home = ((odds.split(":").length > 1)
                ? (num.tryParse(odds.split(":")[0]) ?? 0)
                : 0)
            .toDouble();
        num away = (odds.split(":").length > 1)
            ? (double.tryParse(odds.split(":")[1]) ?? 0)
            : 0;
        if (((home + away) != 0)) {
          item.home = home;
          item.away = away;
        }

        // 如果需要计算比例，计算客队占比百分比
        if (isProportion == true) {
          item.proportion = ((double.tryParse((item.away.toDouble() /
                              ((item.home + item.away) == 0
                                  ? 1
                                  : (item.home + item.away)))
                          .toStringAsFixed(2)) ??
                      0) *
                  100)
              .truncate();
        }
        newAnalyzeMatchResultItemList.add(item);
        break;
      }
    }

    return newAnalyzeMatchResultItemList;
  }

  /**
   * 根据分数类型查找新的结果项
   * [score_type] 分数类型（如S104、S8等）
   * [match] 赛事实体
   * [isProportion] 是否计算比例，默认为false
   * [icon] 图标名称
   * [title] 标题文本
   * 返回找到的结果项，如果未找到返回null
   */
  static NewAnalyzeMatchResultItem? findNewResultItemByScoreType(
      String score_type, MatchEntity? match,
      {bool? isProportion = false, String? icon, String? title}) {

    NewAnalyzeMatchResultItem? item;
    for (String data in match?.msc ?? []) {
      if (!data.contains(score_type)) {
        continue;
      }
      if (data.split("|").length <= 1) {
        continue;
      }

      String k = data.split("|")[0];
      if (k != score_type) {
        continue;
      }
      // 创建新的分析结果项
      item = NewAnalyzeMatchResultItem(score_type, title ?? "", icon ?? "");

      // 解析主客队比分
      String odds = data.split("|")[1];
      num home = ((odds.split(":").length > 1)
              ? (num.tryParse(odds.split(":")[0]) ?? 0)
              : 0)
          .toDouble();
      num away = (odds.split(":").length > 1)
          ? (double.tryParse(odds.split(":")[1]) ?? 0)
          : 0;
      if (((home + away) != 0)) {
        item.home = home;
        item.away = away;
      }

      // 如果需要计算比例，计算客队占比百分比
      if (isProportion == true) {
        item.proportion = ((double.tryParse((item.away.toDouble() /
                            ((item.home + item.away) == 0
                                ? 1
                                : (item.home + item.away)))
                        .toStringAsFixed(2)) ??
                    0) *
                100)
            .truncate();
      }
    }
    return item;
  }

  /**
   * 根据分数类型查找分析结果项
   * @param list 分析结果项列表
   * @param scoreType 分数类型
   * @return 找到的项，如果未找到返回null
   */
  static NewAnalyzeMatchResultItem? findNewAnalyzeMatchResultItemByScoreType(
      List<NewAnalyzeMatchResultItem> list, String scoreType) {
    NewAnalyzeMatchResultItem? item1;
    for (NewAnalyzeMatchResultItem item in list) {
      if (item.score_type == scoreType) {
        item1 = item;
        break;
      }
    }
    return item1;
  }

  /**
   * 根据类型获取数据Item
   * @param match 赛事实体
   * @param scoreTypeList 分数类型列表
   * @param iconList 图标列表
   * @param titleList 标题列表
   * @return 分析结果项列表
   */
  static List<NewAnalyzeMatchResultItem> getBallDataMatch(
      MatchEntity? match, List<String> scoreTypeList,
      {List<String>? iconList, List<String>? titleList}) {
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemList = [];
    for (int i = 0; i < scoreTypeList.length; i++) {
      String item = scoreTypeList[i];
      String? icon;
      String? title;
      if (iconList != null && iconList.isNotEmpty && i < iconList.length) {
        icon = iconList[i];
      }

      if (titleList != null && titleList.isNotEmpty && i < titleList.length) {
        title = titleList[i];
      }

      NewAnalyzeMatchResultItem? s1082Item =
          findNewResultItemByScoreType(item, match, icon: icon, title: title);
      if (s1082Item != null) {
        newAnalyzeMatchResultItemList.add(s1082Item);
      }
    }
    return newAnalyzeMatchResultItemList;
  }

  /**
   * 计算圆形数据
   * 汇总并计算各项统计数据
   * @param arr 分析结果项数组
   * @param match 赛事实体
   * @param fourList 预期进球列表（用于更新S801和S802数据）
   * @return 处理后的列表
   */
  static List<NewAnalyzeMatchResultItem> sumCircleNumber(
      List<NewAnalyzeMatchResultItem> arr, MatchEntity? match,
      {List<NewAnalyzeMatchResultItem>? fourList}) {
    List<NewAnalyzeMatchResultItem> tempList = [];
    if (match?.msc.isEmpty == true) {
      tempList.addAll(arr);
      return tempList;
    }

    for (NewAnalyzeMatchResultItem item in arr) {
      for (String data in match?.msc ?? []) {
        if (!data.contains(item.score_type)) {
          continue;
        }
        if (data.split("|").length <= 1) {
          continue;
        }
        String odds = data.split("|")[1];
        num home = ((odds.split(":").length > 1)
                ? (num.tryParse(odds.split(":")[0]) ?? 0)
                : 0)
            .toDouble();
        num away = (odds.split(":").length > 1)
            ? (double.tryParse(odds.split(":")[1]) ?? 0)
            : 0;
        if (((home + away) != 0)) {
          item.home = home;
          item.away = away;
        }

        // 根据score_type计算比例：某些类型计算客队比例，某些类型计算主队比例
        // S8(危险进攻)、S105(控球率)、S1088(三分命中率)、S111(罚球命中率) 计算客队比例
        if (["S8", "S105", "S1088", "S111"].contains(item.score_type)) {
          item.proportion = ((double.tryParse((item.away.toDouble() /
                              ((item.home + item.away) == 0
                                  ? 1
                                  : (item.home + item.away)))
                          .toStringAsFixed(2)) ??
                      0) *
                  100)
              .truncate();
        } 
        // S104(进攻)、S1101(射门)、S18(射正)、S17(射偏)、S19、S107(两分球)、S110(罚球)、S108(三分球) 计算主队比例
        else if ([
          "S104",
          "S1101",
          "S18",
          "S17",
          "S19",
          "S107",
          "S110",
          "S108"
        ].contains(item.score_type)) {
          item.proportion = ((double.tryParse((item.home.toDouble() /
                              ((item.home + item.away) == 0
                                  ? 1
                                  : (item.home + item.away)))
                          .toStringAsFixed(2)) ??
                      0) *
                  100)
              .truncate();
        } 
        // S801表示预期进球XG，S802表示预期进球
        else if (["S801"].contains(item.score_type) && fourList != null && fourList.isNotEmpty) {
          fourList[0].home = item.home;
          fourList[0].away = item.away;
        } else if (["S802"].contains(item.score_type) && fourList != null && fourList.length > 1) {
          fourList[1].home = item.home;
          fourList[1].away = item.away;
        }
        tempList.add(item);
        break;
      }
    }
    return tempList;
  }
}

