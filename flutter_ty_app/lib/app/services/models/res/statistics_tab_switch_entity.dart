import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/statistics_tab_switch_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/statistics_tab_switch_entity.g.dart';

@JsonSerializable()
class StatisticsTabSwitchEntity {
  // 盘面
  StatisticsTabSwitchMarketView? marketView;

  // 积分
  StatisticsTabSwitchPoints? points;

  // 统计
  StatisticsTabSwitchStatistics? statistics;

  // 数据
  StatisticsTabSwitchStatsData? statsData;

  StatisticsTabSwitchEntity();

  factory StatisticsTabSwitchEntity.fromJson(Map<String, dynamic> json) =>
      $StatisticsTabSwitchEntityFromJson(json);

  Map<String, dynamic> toJson() => $StatisticsTabSwitchEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StatisticsTabSwitchMarketView {
  late String expectedAnalysis = '';
  late String matchArticles = '';
  late String trend = '';

  StatisticsTabSwitchMarketView();

  factory StatisticsTabSwitchMarketView.fromJson(Map<String, dynamic> json) =>
      $StatisticsTabSwitchMarketViewFromJson(json);

  Map<String, dynamic> toJson() => $StatisticsTabSwitchMarketViewToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StatisticsTabSwitchPoints {
  late String knockoutStage = '';
  late String leaguePoints = '';

  // 2 杯赛  1 联赛
  late String pointType = '';

  StatisticsTabSwitchPoints();

  factory StatisticsTabSwitchPoints.fromJson(Map<String, dynamic> json) =>
      $StatisticsTabSwitchPointsFromJson(json);

  Map<String, dynamic> toJson() => $StatisticsTabSwitchPointsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StatisticsTabSwitchStatistics {
  late String currentSeasonStats = '';
  late String headToHead = '';
  late String historicalPerformance = '';
  late String lineup = '';
  late String technicalStats = '';

  StatisticsTabSwitchStatistics();

  factory StatisticsTabSwitchStatistics.fromJson(Map<String, dynamic> json) =>
      $StatisticsTabSwitchStatisticsFromJson(json);

  Map<String, dynamic> toJson() => $StatisticsTabSwitchStatisticsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class StatisticsTabSwitchStatsData {
  // 数据
  late String data = '';

  // 实时事件
  late String event = '';

  // 精彩回放
  late String playBack = '';

  StatisticsTabSwitchStatsData();

  factory StatisticsTabSwitchStatsData.fromJson(Map<String, dynamic> json) =>
      $StatisticsTabSwitchStatsDataFromJson(json);

  Map<String, dynamic> toJson() => $StatisticsTabSwitchStatsDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
