
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/season_stats_p_b_bean_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_team_vs_other_team_entity.dart';

import 'package:flutter_ty_app/app/modules/match_detail/models/analysis/analysis_model.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/// 本赛季统计数据转换器
/// 负责处理数据转换、计算和格式化逻辑
class SeasonStatisticDataConverter {
  /// 创建默认的赛季持续时间数据Bean列表
  /// 返回包含6个默认数据项的列表
  static List<ListSaishiDurationDataBean> createDefaultDataBeans() {
    return [
      ListSaishiDurationDataBean(
        LocaleKeys.analysis_football_matches_over_1_5.tr,
        "0",
        "0",
        Icons.ac_unit,
        img: "assets/images/bets/analyze_bet_head_icon1.png",
        contentTitle: LocaleKeys.analysis_football_matches_contentTitle7.tr +
            "\n" +
            LocaleKeys.analysis_football_matches_contentTitle8.tr,
      ),
      ListSaishiDurationDataBean(
        LocaleKeys.analysis_football_matches_over_2_5.tr,
        "0",
        "0",
        Icons.ac_unit,
        img: "assets/images/bets/analyze_bet_head_icon1.png",
        contentTitle: LocaleKeys.analysis_football_matches_contentTitle9.tr +
            "\n" +
            LocaleKeys.analysis_football_matches_contentTitle10.tr,
      ),
      ListSaishiDurationDataBean(
        LocaleKeys.analysis_k_all_scores.tr,
        "0",
        "0",
        Icons.ac_unit,
        img: "assets/images/bets/analyze_bet_head_icon2.png",
        contentTitle: LocaleKeys.analysis_football_matches_contentTitle11.tr +
            "\n" +
            LocaleKeys.analysis_football_matches_contentTitle12.tr,
      ),
      ListSaishiDurationDataBean(
        LocaleKeys.analysis_football_matches_average_goals_scored.tr,
        "0",
        "0",
        Icons.ac_unit,
        img: "assets/images/bets/analyze_bet_head_icon3.png",
        contentTitle: LocaleKeys.analysis_football_matches_contentTitle13.tr +
            "\n" +
            LocaleKeys.analysis_football_matches_contentTitle14.tr,
      ),
      ListSaishiDurationDataBean(
        LocaleKeys.football_playing_way_penalty_cards.tr,
        "0",
        "0",
        Icons.ac_unit,
        img: "assets/images/bets/analyze_bet_head_icon4.png",
        contentTitle: LocaleKeys.analysis_football_matches_contentTitle15.tr +
            "\n" +
            LocaleKeys.analysis_football_matches_contentTitle16.tr,
      ),
      ListSaishiDurationDataBean(
        LocaleKeys.footer_menu_corner_kick.tr,
        "0",
        "0",
        Icons.ac_unit,
        img: "assets/images/bets/analyze_bet_head_icon5.png",
        contentTitle: LocaleKeys.analysis_football_matches_contentTitle17.tr +
            "\n" +
            LocaleKeys.analysis_football_matches_contentTitle18.tr,
      ),
    ];
  }

  /// 转换赛季统计数据Bean实体
  /// [dataBeans] 数据Bean列表，将被更新
  /// [index] 索引位置，0表示主队，1表示客队
  /// [seasonStatsPBBeanEntity] 赛季统计数据实体
  static void convertSeasonStatsPBBeanEntity(
    List<ListSaishiDurationDataBean> dataBeans,
    int index,
    SeasonStatsPBBeanEntity? seasonStatsPBBeanEntity,
  ) {
    if (index == 0) {
      // 主队数据
      dataBeans[0].name2 = "${seasonStatsPBBeanEntity?.percentThanOne ?? 0}%";
      dataBeans[1].name2 = "${seasonStatsPBBeanEntity?.percentThanTwo ?? 0}%";
      dataBeans[2].name2 = "${seasonStatsPBBeanEntity?.percentThanThree ?? 0}%";
      dataBeans[3].name2 = "${seasonStatsPBBeanEntity?.averageGoal ?? 0}";
      dataBeans[4].name2 = "${seasonStatsPBBeanEntity?.averageCard ?? 0}";
      dataBeans[5].name2 = "${seasonStatsPBBeanEntity?.averageCorner ?? 0}";
    } else {
      // 客队数据
      dataBeans[0].name3 = "${seasonStatsPBBeanEntity?.percentThanOne ?? 0}%";
      dataBeans[1].name3 = "${seasonStatsPBBeanEntity?.percentThanTwo ?? 0}%";
      dataBeans[2].name3 = "${seasonStatsPBBeanEntity?.percentThanThree ?? 0}%";
      dataBeans[3].name3 = "${seasonStatsPBBeanEntity?.averageGoal ?? 0}";
      dataBeans[4].name3 = "${seasonStatsPBBeanEntity?.averageCard ?? 0}";
      dataBeans[5].name3 = "${seasonStatsPBBeanEntity?.averageCorner ?? 0}";
    }
  }

  /// 计算胜平负结果
  /// [analyzeTeamsList] 分析团队VS历史记录列表
  /// 返回包含胜、平、负次数的Map
  static Map<String, int> formatResult(
    List<AnalyzeTeamVsHistoryEntity> analyzeTeamsList,
  ) {
    Map<String, int> obj = {"win": 0, "dogfall": 0, "lose": 0};
    for (AnalyzeTeamVsHistoryEntity item in analyzeTeamsList) {
      if (item.result == 2) {
        // 平局
        obj["dogfall"] = (obj["dogfall"] ?? 0) + 1;
      } else if (item.result == 3) {
        // 负
        obj["lose"] = (obj["lose"] ?? 0) + 1;
      } else if (item.result == 4) {
        // 胜
        obj["win"] = (obj["win"] ?? 0) + 1;
      }
    }
    return obj;
  }

  /// 计算团队与其他团队的交手结果统计
  /// [data] 团队与其他团队的交手记录列表
  /// 返回包含胜、平、负次数的Map
  static Map<String, int> caculatorResult(
    List<StatisticsTeamVsOtherTeam>? data,
  ) {
    Map<String, int> vsHistoryMap = {};
    vsHistoryMap["success"] = 0;
    vsHistoryMap["lose"] = 0;
    vsHistoryMap["flat"] = 0;
    for (StatisticsTeamVsOtherTeam item in data ?? []) {
      if (item.result == 4) {
        // 胜
        vsHistoryMap["success"] = (vsHistoryMap["success"] ?? 0) + 1;
      } else if (item.result == 2) {
        // 平
        vsHistoryMap["flat"] = (vsHistoryMap["flat"] ?? 0) + 1;
      } else if (item.result == 3) {
        // 负
        vsHistoryMap["lose"] = (vsHistoryMap["lose"] ?? 0) + 1;
      }
    }
    return vsHistoryMap;
  }
}
