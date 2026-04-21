
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/analysis/analysis_data_model.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../match_data_controller.dart';
import '../match_detail_controller.dart';
import '../match_tools_methods.dart';
import 'match_data_processor.dart';

/**
 * 分析数据初始化模块
 * 负责初始化分析相关的数据结构
 */
extension MatchDataAnalyzeInitializer on MatchDataController {
  /**
   * 初始化分析数据
   * 清空并初始化足球和篮球的统计数据列表
   */
  void initAnalyzeData() {
    state.football_ring_statistics.clear();
    state.basketball_ring_statistics.clear();

    state.football_card_corner_list.clear();
    state.basketball_card_corner_list.clear();

    state.football_progress_graph.clear();
    state.basketball_progress_graph.clear();

    state.ring_statistics.clear();
    state.four_statistics.clear();
    state.card_corner_list.clear();
    state.progress_graph.clear();

    // 加时赛判断
    MatchEntity? match =
        Get.find<MatchDetailController>(tag: tag).detailState.match;

    state.showOvertime = isOvertime(match);
    if (state.showOvertime) {
      initOverlayTime(match);
    }

    state.analyzeMatchResultData = AnalyzeNewMatchResultData();

    // 初始化足球环形统计数据：S104(进攻)、S8(危险进攻)、S105(控球率)
    state.football_ring_statistics.add(NewAnalyzeMatchResultItem(
        "S104", LocaleKeys.match_result_attack.tr, ""));

    state.football_ring_statistics.add(NewAnalyzeMatchResultItem(
        "S8", LocaleKeys.match_result_dangerous_offense.tr, ""));
    state.football_ring_statistics.add(NewAnalyzeMatchResultItem(
        "S105", LocaleKeys.match_result_ball_possession.tr, ""));

    // 初始化足球四项统计数据：S801(预期进球XG)、S802(预期进球)
    state.four_statistics.add(NewAnalyzeMatchResultItem(
        "S801", LocaleKeys.analysis_football_matches_expected_goals_xg.tr, ""));
    state.four_statistics.add(NewAnalyzeMatchResultItem(
        "S802", LocaleKeys.analysis_football_matches_expected_goals.tr, ""));

    // 初始化篮球环形统计数据：S1088(三分命中率)、S1235(投篮命中率)、S111(罚球命中率)
    state.basketball_ring_statistics.add(NewAnalyzeMatchResultItem(
        "S1088", LocaleKeys.match_result_three_point_shooting.tr, ""));
    state.basketball_ring_statistics.add(NewAnalyzeMatchResultItem(
        "S1235", LocaleKeys.match_result_Field_goal_percentage.tr, ""));
    state.basketball_ring_statistics.add(NewAnalyzeMatchResultItem(
        "S111", LocaleKeys.match_result_Free_throw_percentage.tr, ""));

    // 初始化足球角球红黄牌数据：S12(黄牌)、S11(红牌)、S5(角球)
    state.football_card_corner_list.add(NewAnalyzeMatchResultItem(
        "S12", LocaleKeys.match_result_yellow_card.tr, "yellow_card"));
    state.football_card_corner_list.add(NewAnalyzeMatchResultItem(
        "S11", LocaleKeys.match_result_red_card.tr, "red_card"));
    state.football_card_corner_list.add(NewAnalyzeMatchResultItem(
        "S5", LocaleKeys.football_playing_way_corner.tr, ""));

    // 初始化篮球犯规和暂停数据：S106(犯规数)、S109(剩余暂停)
    state.basketball_card_corner_list.add(NewAnalyzeMatchResultItem(
        "S106", LocaleKeys.match_result_Fouls.tr, "whistle_img"));
    state.basketball_card_corner_list.add(NewAnalyzeMatchResultItem(
        "S109", LocaleKeys.match_result_Remaining_pause.tr, "time_out_img"));

    // 初始化足球进度图数据：S18(射正)、S17(射偏)
    state.football_progress_graph.add(NewAnalyzeMatchResultItem(
        "S18", LocaleKeys.match_result_shoot_right.tr, ""));
    state.football_progress_graph.add(NewAnalyzeMatchResultItem(
        "S17", LocaleKeys.match_result_shot_off.tr, ""));

    // 初始化篮球进度图数据：S108(三分球得分)、S107(两分球得分)、S110(罚球得分)
    state.basketball_progress_graph.add(NewAnalyzeMatchResultItem(
        "S108", LocaleKeys.match_result_Three_pointer.tr, ""));
    state.basketball_progress_graph.add(NewAnalyzeMatchResultItem(
        "S107", LocaleKeys.match_result_Two_pointer.tr, ""));
    state.basketball_progress_graph.add(NewAnalyzeMatchResultItem(
        "S110", LocaleKeys.match_result_Free_throw.tr, ""));

    // 根据赛事类型（篮球csid=="2"或足球）设置对应的统计数据
    if (match?.csid == "2") {
      // 篮球赛事：使用篮球统计数据
      state.ring_statistics = state.basketball_ring_statistics;
      state.card_corner_list = state.basketball_card_corner_list;
      state.progress_graph = state.basketball_progress_graph;
      // 添加篮球环形统计数据
      state.analyzeMatchResultData.ring_statistics.add(
          NewAnalyzeMatchResultItem(
              "S1088", LocaleKeys.match_result_three_point_shooting.tr, ""));
      state.analyzeMatchResultData.ring_statistics.add(
          NewAnalyzeMatchResultItem(
              "S1235", LocaleKeys.match_result_Field_goal_percentage.tr, ""));
      state.analyzeMatchResultData.ring_statistics.add(
          NewAnalyzeMatchResultItem(
              "S111", LocaleKeys.match_result_Free_throw_percentage.tr, ""));

      // 添加篮球角球犯规数据
      state.analyzeMatchResultData.card_corner_list.add(
          NewAnalyzeMatchResultItem(
              "S106", LocaleKeys.match_result_Fouls.tr, "whistle_img"));
      state.analyzeMatchResultData.card_corner_list.add(
          NewAnalyzeMatchResultItem("S109",
              LocaleKeys.match_result_Remaining_pause.tr, "time_out_img"));

      // 添加篮球进度图数据
      state.analyzeMatchResultData.progress_graph.add(NewAnalyzeMatchResultItem(
          "S108", LocaleKeys.match_result_Three_pointer.tr, ""));
      state.analyzeMatchResultData.progress_graph.add(NewAnalyzeMatchResultItem(
          "S107", LocaleKeys.match_result_Two_pointer.tr, ""));
      state.analyzeMatchResultData.progress_graph.add(NewAnalyzeMatchResultItem(
          "S110", LocaleKeys.match_result_Free_throw.tr, ""));
    } else {
      // 足球赛事：使用足球统计数据
      state.ring_statistics = state.football_ring_statistics;
      state.card_corner_list = state.football_card_corner_list;
      state.progress_graph = state.football_progress_graph;
      // 添加足球环形统计数据
      state.analyzeMatchResultData.ring_statistics.add(
          NewAnalyzeMatchResultItem(
              "S8", LocaleKeys.match_result_dangerous_offense.tr, ""));
      state.analyzeMatchResultData.ring_statistics.add(
          NewAnalyzeMatchResultItem(
              "S105", LocaleKeys.match_result_ball_possession.tr, ""));

      // 添加足球角球红黄牌数据
      state.analyzeMatchResultData.card_corner_list.add(
          NewAnalyzeMatchResultItem(
              "S12", LocaleKeys.match_result_yellow_card.tr, "yellow_card"));
      state.analyzeMatchResultData.card_corner_list.add(
          NewAnalyzeMatchResultItem(
              "S11", LocaleKeys.match_result_red_card.tr, "red_card"));
      state.analyzeMatchResultData.card_corner_list.add(
          NewAnalyzeMatchResultItem(
              "S5", LocaleKeys.match_result_corner.tr, ""));

      // 添加足球进度图数据
      state.analyzeMatchResultData.progress_graph.add(NewAnalyzeMatchResultItem(
          "S104", LocaleKeys.match_result_attack.tr, ""));
      state.analyzeMatchResultData.progress_graph.add(NewAnalyzeMatchResultItem(
          "S1101", LocaleKeys.match_result_shot.tr, ""));
      state.analyzeMatchResultData.progress_graph.add(NewAnalyzeMatchResultItem(
          "S18", LocaleKeys.match_result_shoot_right.tr, ""));
      state.analyzeMatchResultData.progress_graph.add(NewAnalyzeMatchResultItem(
          "S17", LocaleKeys.match_result_shot_off.tr, ""));
    }
  }

  /**
   * 初始化数据
   * 初始化分析数据并获取数据
   */
  void initData() async {
    initAnalyzeData();
    getData();
  }
}

