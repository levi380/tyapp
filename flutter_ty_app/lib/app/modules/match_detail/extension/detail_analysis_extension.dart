import 'dart:async';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_tab_extension.dart';

import '../../../services/api/analyze_detail_api.dart';
import '../../../services/models/res/statistics_tab_switch_entity.dart';
import '../../home/controllers/home_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3af2ca03-74cb-42ce-9b45-a0ed51b2a891 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛事分析开关】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事分析开关逻辑】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 接口每30秒刷新一次开关接口
    - 检查积分开关 points.knockoutStage == "1" || points.leaguePoints == "1"
    - 检查赛事分析盘面 marketView.expectedAnalysis == "1" ||
    marketView.matchArticles == "1" ||
    marketView.trend == "1"
    - 检查统计开关 statistics.currentSeasonStats == "1" ||
    statistics.headToHead == "1" ||
    statistics.historicalPerformance == "1" ||
    statistics.lineup == "1" ||
    statistics.technicalStats == "1"
    - 检查数据开关 早盘关闭 statsData.data == "1" ||
    statsData.event == "1" ||
    statsData.playBack == "1") &&
    TyHomeController.to.homeState.menu.mi != 3
    】】】
 *
 */
extension DetailAnalysisExtension on MatchDetailController {
  /// 赛事及分析开关  30秒刷新
  Future<void> initAnalysisSwitch() async {

    await _fetchAnalysisData();

    // 每30秒执行一次
    detailState.analysisTimer?.cancel();
    detailState.analysisTimer =
        Timer.periodic(const Duration(seconds: 30), (timer) async {
      await _fetchAnalysisData();
    });
  }

  Future<void> _fetchAnalysisData() async {


    try {
      final res = await AnalyzeDetailApi.instance()
          .statisticsTabSwitch(detailState.mId);
      if (!res.success || res.data == null) return;




      final entity = res.data!;
      // 如果是篮球  并且 是pd
      detailState.statisticsTabSwitchEntity = entity;

      setTabController();
    } catch (e) {
      AppLogger.debug("赛事分析开关请求失败：${e.toString()}");
    }
  }

  // 检查积分开关
  bool checkPoints() {
    StatisticsTabSwitchPoints? points =
        detailState.statisticsTabSwitchEntity?.points;
    return points != null &&
        (points.knockoutStage == "1" || points.leaguePoints == "1"
        // || points.pointType == "1"  // 【非规则】判断联赛类别(0:其他,1:联赛,2:杯赛)
        );
  }

  // 检查赛事分析盘面
  bool checkMarketView() {
    StatisticsTabSwitchMarketView? marketView =
        detailState.statisticsTabSwitchEntity?.marketView;
    return marketView != null &&
        (marketView.expectedAnalysis == "1" ||
            marketView.matchArticles == "1" ||
            marketView.trend == "1");
  }

  // 检查统计开关
  bool checkStatistics() {
    StatisticsTabSwitchStatistics? statistics =
        detailState.statisticsTabSwitchEntity?.statistics;
    return statistics != null &&
        (statistics.currentSeasonStats == "1" ||
            statistics.headToHead == "1" ||
            statistics.historicalPerformance == "1" ||
            statistics.lineup == "1" ||
            statistics.technicalStats == "1");
  }

  // 检查数据开关 早盘关闭
  bool checkStatsData() {
    StatisticsTabSwitchStatsData? statsData =
        detailState.statisticsTabSwitchEntity?.statsData;
    return statsData != null &&
        (statsData.data == "1" ||
            statsData.event == "1" ||
            statsData.playBack == "1") &&
        TyHomeController.to.homeState.menu.mi != 3;
  }
}
