import 'package:flutter_ty_app/app/modules/match_detail/states/season_statistic_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_team_vs_other_team_entity.dart';
import 'season_statistic_data_converter.dart';

/**
 * 本赛季统计业务逻辑服务类
 * 负责处理业务逻辑相关的数据处理和状态更新
 */
class SeasonStatisticBusinessService {
  /// 处理团队VS历史记录数据
  /// [state] 状态管理对象
  /// [analyzeTeamsList] 分析团队VS历史记录列表
  /// 更新state中的teamVsHistoryResult数据
  static void processTeamsVSInfoData(
    SeasonStatisticState state,
    List<AnalyzeTeamVsHistoryEntity> analyzeTeamsList,
  ) {
    state.analyzeTeamsList.value = analyzeTeamsList;
    state.teamVsHistoryResult["home"] =
        SeasonStatisticDataConverter.formatResult(analyzeTeamsList);
    // 客队数据是主队数据的反向
    (state.teamVsHistoryResult["away"] ?? {})["dogfall"] =
        (state.teamVsHistoryResult["home"] ?? {})["dogfall"];
    (state.teamVsHistoryResult["away"] ?? {})["lose"] =
        (state.teamVsHistoryResult["home"] ?? {})["win"];
    (state.teamVsHistoryResult["away"] ?? {})["win"] =
        (state.teamVsHistoryResult["home"] ?? {})["lose"];
  }

  /// 处理团队与其他团队的交手记录数据
  /// [state] 状态管理对象
  /// [home] 主队与其他团队的交手记录列表
  /// [away] 客队与其他团队的交手记录列表
  /// 更新state中的homeVSHistoryMap和awayVSHistoryMap数据
  static void processOtherTeamsVSInfoData(
    SeasonStatisticState state,
    List<StatisticsTeamVsOtherTeam> home,
    List<StatisticsTeamVsOtherTeam> away,
  ) {
    state.homeVSHistoryMap =
        SeasonStatisticDataConverter.caculatorResult(home);
    state.awayVSHistoryMap =
        SeasonStatisticDataConverter.caculatorResult(away);
    state.home = home;
    state.away = away;
  }
}

