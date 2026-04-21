import '../../login/login_head_import.dart';

// 详情通用tab
typedef MatchDetailChildBuilder = Widget Function(String tag);

class MatchDetailTab {
  final String title;
  final DetailTabType type; // tab类型
  final MatchDetailChildBuilder childBuilder; // 工厂函数延迟创建
  final VoidCallback? fetchData; // 点击tab回调

  const MatchDetailTab(this.title, this.type, this.childBuilder,
      {this.fetchData});
}

enum DetailTabType {
  bet,
  data,
  cupIntegral,
  leagueIntegral,
  statistics,
  article,
  disk,

  // 数据
  statsDataData, // 数据
  statsDataEvent, // 事件

  //  统计的tab
  statisticsCurrentSeasonStats, //本赛季数据
  statisticsHeadToHead, //正面交手
  statisticsHistoricalPerformance, //历史表现
  statisticsLineup, //阵容
  statisticsTechnicalStats, //技术统计

  // 盘面
  overviewTrend, // 走势
  overviewExpectedAnalysis, // 预期分析
  overviewMatchArticles, // 赛事文章

  // 杯赛积分
  cupPointLeaguePoints, // 小组赛
  cupPointKnockoutStage, // 淘汰赛
}
