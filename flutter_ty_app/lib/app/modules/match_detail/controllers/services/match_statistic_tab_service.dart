import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_tab_switch_entity.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/extension/get_x_extension.dart';
import '../../models/match_detail_tab.dart';
import '../../widgets/container/match_statistics/analyze_battle_array/basketball_battle_array_page.dart';
import '../../widgets/container/match_statistics/analyze_battle_array/football_battle_array_page.dart';
import '../../widgets/container/match_statistics/analyze_battle_array/match_statistic_item_chart_page.dart';
import '../../widgets/container/match_statistics/component/basket_ball_fundamentals_view.dart';
import '../../widgets/container/match_statistics/component/season_statistic_page.dart';
import '../../widgets/container/match_statistics/component/history_performance_page.dart';
import '../../widgets/container/match_statistics/component/head_on_confrontation_view.dart';
import '../../widgets/container/match_statistics/component/basket_ball_technical_statistics_view.dart';
import '../statistic/battle_array_controller.dart';
import '../statistic/history_performance_controller.dart';

/**
 * 统计Tab初始化服务类
 * 负责根据权限配置和赛事类型动态创建tab列表
 */
class MatchStatisticTabService {
  /**
   * 初始化Tab列表
   * [tag] 比赛ID
   * [statisticsTabSwitchEntity] 权限配置实体
   * [matchEntity] 赛事实体
   * [fetchFrontFight] 获取正面交手数据的回调函数
   * [fetchBasketballTechnical] 获取篮球技术统计数据的回调函数
   * 返回Tab列表
   */
  static List<MatchDetailTab> initTabs({
    required String tag,
    StatisticsTabSwitchEntity? statisticsTabSwitchEntity,
    MatchEntity? matchEntity,
    required Future<void> Function({required bool isElectronicFootball})
        fetchFrontFight,
    required Future<void> Function() fetchBasketballTechnical,
  }) {
    List<MatchDetailTab> tabs = [];

    // 电子足球赛事：不走权限验证，直接显示正面交手和历史表现
    if (matchEntity?.isC01FootBall ?? false) {
      // 正面交手
      tabs.add(MatchDetailTab(
        LocaleKeys.analysis_football_matches_head_to_head.tr,
        DetailTabType.statisticsHeadToHead,
        (tag) => HeadOnConfrontationView(tag: tag),
        fetchData: () => fetchFrontFight(isElectronicFootball: true),
      ));

      // 历史表现
      tabs.add(MatchDetailTab(
        LocaleKeys.analysis_historical_performance.tr,
        DetailTabType.statisticsHistoricalPerformance,
        (tag) => HistoryPerformancePage(tag: tag, isElectronicFootball: true),
        fetchData: () {
          return Get.findOrNull<HistoryPerformanceController>(tag: tag)
              ?.initExtraData();
        },
      ));
    } else {
      // 普通赛事：根据权限配置显示不同的tab
      // 是否显示技术统计（仅篮球）
      if (statisticsTabSwitchEntity?.statistics?.technicalStats == "1" &&
          matchEntity?.csid == "2") {
        tabs.add(MatchDetailTab(
          LocaleKeys.app_h5_detail_technical_statistics.tr,
          DetailTabType.statisticsTechnicalStats,
          (tag) => BasketBallTechnicalStatisticsView(tag: tag),
          fetchData: fetchBasketballTechnical,
        ));
      }

      // 是否显示阵容（足球和篮球）
      if (statisticsTabSwitchEntity?.statistics?.lineup == "1") {
        tabs.add(MatchDetailTab(
          LocaleKeys.analysis_football_matches_line_up.tr,
          DetailTabType.statisticsLineup,
          (tag) => matchEntity?.csid == "2"
              ? BasketballBattleArrayPage(tag: tag)
              : FootballBattleArrayPage(tag: tag),
          fetchData: () => Get.findOrNull<BattleArrayController>(tag: tag)
              ?.requestMatchLineUpList(index: 1),
        ));
      }

      // 是否显示正面交手（仅足球）
      if (statisticsTabSwitchEntity?.statistics?.headToHead == "1" &&
          matchEntity?.csid == "1") {
        tabs.add(MatchDetailTab(
          LocaleKeys.analysis_football_matches_head_to_head.tr,
          DetailTabType.statisticsHeadToHead,
          (tag) => MatchStatisticItemChartPage(tag: tag),
          fetchData: () => fetchFrontFight(isElectronicFootball: false),
        ));
      }

      // 是否显示历史表现（仅足球）
      if (statisticsTabSwitchEntity?.statistics?.historicalPerformance == "1" &&
          matchEntity?.csid == "1") {
        tabs.add(MatchDetailTab(
          LocaleKeys.analysis_historical_performance.tr,
          DetailTabType.statisticsHistoricalPerformance,
          (tag) => HistoryPerformancePage(tag: tag, isElectronicFootball: false),
          fetchData: () {
            return Get.findOrNull<HistoryPerformanceController>(tag: tag)
                ?.initExtraData();
          },
        ));
      }

      // 是否显示本赛季数据（足球和篮球）
      if (statisticsTabSwitchEntity?.statistics?.currentSeasonStats == "1") {
        tabs.add(MatchDetailTab(
          LocaleKeys.analysis_this_season_data.tr,
          DetailTabType.statisticsCurrentSeasonStats,
          (tag) => matchEntity?.csid == "1"
              ? SeasonStatisticPage(tag: tag)
              : BasketBallFundamentalsView(tag: tag),
        ));
      }
    }

    return tabs;
  }
}

