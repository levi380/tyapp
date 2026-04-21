
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/match_detail_tab.dart';
import '../../../../generated/locales.g.dart';
import '../widgets/container/match_market_overview/expected_analysis/expected_analysis.dart';
import '../widgets/container/match_market_overview/football_trend/football_trend.dart';
import '../widgets/container/match_market_overview/match_market_news/match_market_new_page.dart';
import 'match_detail_controller.dart';
import 'match_market_overview_api_service.dart';
import 'match_market_overview_selector_service.dart';
import 'match_market_overview_chart_service.dart' as chart_service;
import 'match_market_overview_utils.dart';
import '../../../services/models/res/statistics_tab_switch_entity.dart';
import '../../../services/api/analyze_detail_api.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../global/ws/ws_type.dart';

/**
 * 盘面初始化服务
 * 
 * 负责处理盘面相关的初始化逻辑，包括：
 * - Tab初始化
 * - 数据初始化
 * - WebSocket推送初始化
 */

/**
 * 初始化Tab
 * 
 * 根据配置信息初始化盘面的Tab列表，包括走势、预期分析、赛事文章等
 * 
 * @param state 盘面状态对象
 * @param tag 控制器标签
 */
void initTab(MatchMarketOverviewState state, String tag) {
  StatisticsTabSwitchEntity? statisticsTabSwitchEntity =
      Get.find<MatchDetailController>(tag: tag)
          .detailState
          .statisticsTabSwitchEntity;
  state.tabs.clear();

  // 走势
  if (statisticsTabSwitchEntity?.marketView?.trend == "1") {
    state.tabs.add(MatchDetailTab(
      LocaleKeys.analysis_trends.tr,
      DetailTabType.overviewTrend,
      (tag) => FootballTrend(tag: tag),
      fetchData: () => fetchTrendChart(state, tag),
    ));
  }

  // 是否显示预期分析 足球
  if (statisticsTabSwitchEntity?.marketView?.expectedAnalysis == "1") {
    state.tabs.add(MatchDetailTab(
      LocaleKeys.analysis_expected_analysis.tr,
      DetailTabType.overviewExpectedAnalysis,
      (tag) => ExpectedAnalysis(tag: tag),
      fetchData: () => requestMatchData(state, "4", "2", tag),
    ));
  }

  // 是否显示赛事文章
  if (statisticsTabSwitchEntity?.marketView?.matchArticles == "1") {
    state.tabs.add(MatchDetailTab(
      LocaleKeys.analysis_race_article.tr,
      DetailTabType.overviewMatchArticles,
      (tag) => MatchMarketNewsPage(
        tag: tag,
      ),
    ));
  }
  // TabController需要在controller中创建，因为需要vsync参数
  // state.tabController = TabController(length: state.tabs.length, vsync: null);
  // 初始化第一个tab的数据
  if (state.tabs.isNotEmpty && state.tabs.safeFirst?.fetchData != null) {
    state.tabs.safeFirst!.fetchData!();
  }
}

/**
 * 初始化数据
 * 
 * 初始化盘面的基础数据，包括分析数据和选项数据
 * 
 * @param state 盘面状态对象
 * @param tag 控制器标签
 */
Future<void> initData(MatchMarketOverviewState state, String tag) async {
  await requestMatchAnalysiseData(state, tag, "5", "${state.curMainTab.value + 1}");
  getAllOptions(state, tag);
  //   初始化走势图盘口
}

/**
 * 初始化WebSocket推送
 * 
 * 注册WebSocket推送监听，处理盘面数据推送
 * 
 * @param state 盘面状态对象
 * @param onPushMessage 推送消息处理回调
 */
void initBus(
  MatchMarketOverviewState state,
  Function(Map<String, dynamic>) onPushMessage,
) {
  Bus.getInstance().on(EventType.RCMD_C1041, (data) {
    Map<String, dynamic> allMap =
        (data as List).first as Map<String, dynamic>;
    String cmd = allMap['cmd'];
    switch (cmd) {
      case WsType.C102:
        onPushMessage(allMap);
        break;
    }
  });
}

/**
 * 获取走势图数据
 * 
 * 请求走势图所需的数据
 * 
 * @param state 盘面状态对象
 * @param tag 控制器标签
 */
Future<void> fetchTrendChart(MatchMarketOverviewState state, String tag) async {
  MatchDetailController controller =
      Get.find<MatchDetailController>(tag: tag);

  MatchEntity? match = controller.detailState.match;
  
  // 检查选择器索引是否有效
  if (state.selectOptionIndex1 < state.selectBeans.length &&
      state.selectOptionIndex1 >= 0) {
    if (state.selectOptionIndex2 <
            (state.selectBeans[state.selectOptionIndex1].datas?.length ??
                0) &&
        state.selectOptionIndex2 >= 0) {
      if (state.selectOptionIndex3 <
              (state.selectBeans[state.selectOptionIndex1]
                      .datas?[state.selectOptionIndex2].datas?.length ??
                  0) &&
          state.selectOptionIndex3 >= 0) {
        // 索引有效，继续处理
      }
    }
  }
  
  // 走势图接口请求
  AnalyzeDetailApi.instance()
      .getMultipleOddsReportList(
    playId: "${state.playId}",
    matchId: tag,
    sportId: match?.csid,
    matchType: "${getMatchStatus(match?.ms ?? 0) == 1 ? 2 : 1}",
    period: (int.tryParse(match?.mmp ?? "0") ?? 0) > 0
        ? "${((int.tryParse(match?.mmp ?? "0") ?? 0))}"
        : null,
    playType: "1",
    marketValue: (!state.showSelect_Option3) ? null : state.select_Option2,
    oddsType: state.oddsType,
  )
      .then((value) {
    chart_service.convertChartFromOddReportAnalyzeDataData(state, value.data);
  });
}

