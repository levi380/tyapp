import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_tab_switch_entity.dart';

StatisticsTabSwitchEntity $StatisticsTabSwitchEntityFromJson(
    Map<String, dynamic> json) {
  final StatisticsTabSwitchEntity statisticsTabSwitchEntity = StatisticsTabSwitchEntity();
  final StatisticsTabSwitchMarketView? marketView = jsonConvert.convert<
      StatisticsTabSwitchMarketView>(json['marketView']);
  if (marketView != null) {
    statisticsTabSwitchEntity.marketView = marketView;
  }
  final StatisticsTabSwitchPoints? points = jsonConvert.convert<
      StatisticsTabSwitchPoints>(json['points']);
  if (points != null) {
    statisticsTabSwitchEntity.points = points;
  }
  final StatisticsTabSwitchStatistics? statistics = jsonConvert.convert<
      StatisticsTabSwitchStatistics>(json['statistics']);
  if (statistics != null) {
    statisticsTabSwitchEntity.statistics = statistics;
  }
  final StatisticsTabSwitchStatsData? statsData = jsonConvert.convert<
      StatisticsTabSwitchStatsData>(json['statsData']);
  if (statsData != null) {
    statisticsTabSwitchEntity.statsData = statsData;
  }
  return statisticsTabSwitchEntity;
}

Map<String, dynamic> $StatisticsTabSwitchEntityToJson(
    StatisticsTabSwitchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['marketView'] = entity.marketView?.toJson();
  data['points'] = entity.points?.toJson();
  data['statistics'] = entity.statistics?.toJson();
  data['statsData'] = entity.statsData?.toJson();
  return data;
}

extension StatisticsTabSwitchEntityExtension on StatisticsTabSwitchEntity {
  StatisticsTabSwitchEntity copyWith({
    StatisticsTabSwitchMarketView? marketView,
    StatisticsTabSwitchPoints? points,
    StatisticsTabSwitchStatistics? statistics,
    StatisticsTabSwitchStatsData? statsData,
  }) {
    return StatisticsTabSwitchEntity()
      ..marketView = marketView ?? this.marketView
      ..points = points ?? this.points
      ..statistics = statistics ?? this.statistics
      ..statsData = statsData ?? this.statsData;
  }
}

StatisticsTabSwitchMarketView $StatisticsTabSwitchMarketViewFromJson(
    Map<String, dynamic> json) {
  final StatisticsTabSwitchMarketView statisticsTabSwitchMarketView = StatisticsTabSwitchMarketView();
  final String? expectedAnalysis = jsonConvert.convert<String>(
      json['expectedAnalysis']);
  if (expectedAnalysis != null) {
    statisticsTabSwitchMarketView.expectedAnalysis = expectedAnalysis;
  }
  final String? matchArticles = jsonConvert.convert<String>(
      json['matchArticles']);
  if (matchArticles != null) {
    statisticsTabSwitchMarketView.matchArticles = matchArticles;
  }
  final String? trend = jsonConvert.convert<String>(json['trend']);
  if (trend != null) {
    statisticsTabSwitchMarketView.trend = trend;
  }
  return statisticsTabSwitchMarketView;
}

Map<String, dynamic> $StatisticsTabSwitchMarketViewToJson(
    StatisticsTabSwitchMarketView entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['expectedAnalysis'] = entity.expectedAnalysis;
  data['matchArticles'] = entity.matchArticles;
  data['trend'] = entity.trend;
  return data;
}

extension StatisticsTabSwitchMarketViewExtension on StatisticsTabSwitchMarketView {
  StatisticsTabSwitchMarketView copyWith({
    String? expectedAnalysis,
    String? matchArticles,
    String? trend,
  }) {
    return StatisticsTabSwitchMarketView()
      ..expectedAnalysis = expectedAnalysis ?? this.expectedAnalysis
      ..matchArticles = matchArticles ?? this.matchArticles
      ..trend = trend ?? this.trend;
  }
}

StatisticsTabSwitchPoints $StatisticsTabSwitchPointsFromJson(
    Map<String, dynamic> json) {
  final StatisticsTabSwitchPoints statisticsTabSwitchPoints = StatisticsTabSwitchPoints();
  final String? knockoutStage = jsonConvert.convert<String>(
      json['knockoutStage']);
  if (knockoutStage != null) {
    statisticsTabSwitchPoints.knockoutStage = knockoutStage;
  }
  final String? leaguePoints = jsonConvert.convert<String>(
      json['leaguePoints']);
  if (leaguePoints != null) {
    statisticsTabSwitchPoints.leaguePoints = leaguePoints;
  }
  final String? pointType = jsonConvert.convert<String>(json['pointType']);
  if (pointType != null) {
    statisticsTabSwitchPoints.pointType = pointType;
  }
  return statisticsTabSwitchPoints;
}

Map<String, dynamic> $StatisticsTabSwitchPointsToJson(
    StatisticsTabSwitchPoints entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['knockoutStage'] = entity.knockoutStage;
  data['leaguePoints'] = entity.leaguePoints;
  data['pointType'] = entity.pointType;
  return data;
}

extension StatisticsTabSwitchPointsExtension on StatisticsTabSwitchPoints {
  StatisticsTabSwitchPoints copyWith({
    String? knockoutStage,
    String? leaguePoints,
    String? pointType,
  }) {
    return StatisticsTabSwitchPoints()
      ..knockoutStage = knockoutStage ?? this.knockoutStage
      ..leaguePoints = leaguePoints ?? this.leaguePoints
      ..pointType = pointType ?? this.pointType;
  }
}

StatisticsTabSwitchStatistics $StatisticsTabSwitchStatisticsFromJson(
    Map<String, dynamic> json) {
  final StatisticsTabSwitchStatistics statisticsTabSwitchStatistics = StatisticsTabSwitchStatistics();
  final String? currentSeasonStats = jsonConvert.convert<String>(
      json['currentSeasonStats']);
  if (currentSeasonStats != null) {
    statisticsTabSwitchStatistics.currentSeasonStats = currentSeasonStats;
  }
  final String? headToHead = jsonConvert.convert<String>(json['headToHead']);
  if (headToHead != null) {
    statisticsTabSwitchStatistics.headToHead = headToHead;
  }
  final String? historicalPerformance = jsonConvert.convert<String>(
      json['historicalPerformance']);
  if (historicalPerformance != null) {
    statisticsTabSwitchStatistics.historicalPerformance = historicalPerformance;
  }
  final String? lineup = jsonConvert.convert<String>(json['lineup']);
  if (lineup != null) {
    statisticsTabSwitchStatistics.lineup = lineup;
  }
  final String? technicalStats = jsonConvert.convert<String>(
      json['technicalStats']);
  if (technicalStats != null) {
    statisticsTabSwitchStatistics.technicalStats = technicalStats;
  }
  return statisticsTabSwitchStatistics;
}

Map<String, dynamic> $StatisticsTabSwitchStatisticsToJson(
    StatisticsTabSwitchStatistics entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['currentSeasonStats'] = entity.currentSeasonStats;
  data['headToHead'] = entity.headToHead;
  data['historicalPerformance'] = entity.historicalPerformance;
  data['lineup'] = entity.lineup;
  data['technicalStats'] = entity.technicalStats;
  return data;
}

extension StatisticsTabSwitchStatisticsExtension on StatisticsTabSwitchStatistics {
  StatisticsTabSwitchStatistics copyWith({
    String? currentSeasonStats,
    String? headToHead,
    String? historicalPerformance,
    String? lineup,
    String? technicalStats,
  }) {
    return StatisticsTabSwitchStatistics()
      ..currentSeasonStats = currentSeasonStats ?? this.currentSeasonStats
      ..headToHead = headToHead ?? this.headToHead
      ..historicalPerformance = historicalPerformance ??
          this.historicalPerformance
      ..lineup = lineup ?? this.lineup
      ..technicalStats = technicalStats ?? this.technicalStats;
  }
}

StatisticsTabSwitchStatsData $StatisticsTabSwitchStatsDataFromJson(
    Map<String, dynamic> json) {
  final StatisticsTabSwitchStatsData statisticsTabSwitchStatsData = StatisticsTabSwitchStatsData();
  final String? data = jsonConvert.convert<String>(json['data']);
  if (data != null) {
    statisticsTabSwitchStatsData.data = data;
  }
  final String? event = jsonConvert.convert<String>(json['event']);
  if (event != null) {
    statisticsTabSwitchStatsData.event = event;
  }
  final String? playBack = jsonConvert.convert<String>(json['playBack']);
  if (playBack != null) {
    statisticsTabSwitchStatsData.playBack = playBack;
  }
  return statisticsTabSwitchStatsData;
}

Map<String, dynamic> $StatisticsTabSwitchStatsDataToJson(
    StatisticsTabSwitchStatsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data;
  data['event'] = entity.event;
  data['playBack'] = entity.playBack;
  return data;
}

extension StatisticsTabSwitchStatsDataExtension on StatisticsTabSwitchStatsData {
  StatisticsTabSwitchStatsData copyWith({
    String? data,
    String? event,
    String? playBack,
  }) {
    return StatisticsTabSwitchStatsData()
      ..data = data ?? this.data
      ..event = event ?? this.event
      ..playBack = playBack ?? this.playBack;
  }
}