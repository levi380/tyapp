import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_team_vs_other_team_entity.dart';

StatisticsTeamVsOtherTeamEntity $StatisticsTeamVsOtherTeamEntityFromJson(
    Map<String, dynamic> json) {
  final StatisticsTeamVsOtherTeamEntity statisticsTeamVsOtherTeamEntity = StatisticsTeamVsOtherTeamEntity();
  final List<StatisticsTeamVsOtherTeam>? away = (json['away'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<StatisticsTeamVsOtherTeam>(
          e) as StatisticsTeamVsOtherTeam)
      .toList();
  if (away != null) {
    statisticsTeamVsOtherTeamEntity.away = away;
  }
  final List<StatisticsTeamVsOtherTeam>? home = (json['home'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<StatisticsTeamVsOtherTeam>(
          e) as StatisticsTeamVsOtherTeam)
      .toList();
  if (home != null) {
    statisticsTeamVsOtherTeamEntity.home = home;
  }
  return statisticsTeamVsOtherTeamEntity;
}

Map<String, dynamic> $StatisticsTeamVsOtherTeamEntityToJson(
    StatisticsTeamVsOtherTeamEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['away'] = entity.away.map((v) => v.toJson()).toList();
  data['home'] = entity.home.map((v) => v.toJson()).toList();
  return data;
}

extension StatisticsTeamVsOtherTeamEntityExtension on StatisticsTeamVsOtherTeamEntity {
  StatisticsTeamVsOtherTeamEntity copyWith({
    List<StatisticsTeamVsOtherTeam>? away,
    List<StatisticsTeamVsOtherTeam>? home,
  }) {
    return StatisticsTeamVsOtherTeamEntity()
      ..away = away ?? this.away
      ..home = home ?? this.home;
  }
}

StatisticsTeamVsOtherTeam $StatisticsTeamVsOtherTeamFromJson(
    Map<String, dynamic> json) {
  final StatisticsTeamVsOtherTeam statisticsTeamVsOtherTeam = StatisticsTeamVsOtherTeam();
  final String? awayTeamId = jsonConvert.convert<String>(json['awayTeamId']);
  if (awayTeamId != null) {
    statisticsTeamVsOtherTeam.awayTeamId = awayTeamId;
  }
  final String? awayTeamName = jsonConvert.convert<String>(
      json['awayTeamName']);
  if (awayTeamName != null) {
    statisticsTeamVsOtherTeam.awayTeamName = awayTeamName;
  }
  final String? awayTeamScore = jsonConvert.convert<String>(
      json['awayTeamScore']);
  if (awayTeamScore != null) {
    statisticsTeamVsOtherTeam.awayTeamScore = awayTeamScore;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    statisticsTeamVsOtherTeam.beginTime = beginTime;
  }
  final String? boldTagName = jsonConvert.convert<String>(json['boldTagName']);
  if (boldTagName != null) {
    statisticsTeamVsOtherTeam.boldTagName = boldTagName;
  }
  final String? handicapOdds = jsonConvert.convert<String>(
      json['handicapOdds']);
  if (handicapOdds != null) {
    statisticsTeamVsOtherTeam.handicapOdds = handicapOdds;
  }
  final int? handicapResult = jsonConvert.convert<int>(json['handicapResult']);
  if (handicapResult != null) {
    statisticsTeamVsOtherTeam.handicapResult = handicapResult;
  }
  final String? handicapVal = jsonConvert.convert<String>(json['handicapVal']);
  if (handicapVal != null) {
    statisticsTeamVsOtherTeam.handicapVal = handicapVal;
  }
  final String? homeTeamId = jsonConvert.convert<String>(json['homeTeamId']);
  if (homeTeamId != null) {
    statisticsTeamVsOtherTeam.homeTeamId = homeTeamId;
  }
  final String? homeTeamName = jsonConvert.convert<String>(
      json['homeTeamName']);
  if (homeTeamName != null) {
    statisticsTeamVsOtherTeam.homeTeamName = homeTeamName;
  }
  final String? homeTeamScore = jsonConvert.convert<String>(
      json['homeTeamScore']);
  if (homeTeamScore != null) {
    statisticsTeamVsOtherTeam.homeTeamScore = homeTeamScore;
  }
  final int? matchGroup = jsonConvert.convert<int>(json['matchGroup']);
  if (matchGroup != null) {
    statisticsTeamVsOtherTeam.matchGroup = matchGroup;
  }
  final String? overunderOdds = jsonConvert.convert<String>(
      json['overunderOdds']);
  if (overunderOdds != null) {
    statisticsTeamVsOtherTeam.overunderOdds = overunderOdds;
  }
  final int? overunderResult = jsonConvert.convert<int>(
      json['overunderResult']);
  if (overunderResult != null) {
    statisticsTeamVsOtherTeam.overunderResult = overunderResult;
  }
  final String? overunderVal = jsonConvert.convert<String>(
      json['overunderVal']);
  if (overunderVal != null) {
    statisticsTeamVsOtherTeam.overunderVal = overunderVal;
  }
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    statisticsTeamVsOtherTeam.result = result;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    statisticsTeamVsOtherTeam.sportId = sportId;
  }
  final String? teamGroup = jsonConvert.convert<String>(json['teamGroup']);
  if (teamGroup != null) {
    statisticsTeamVsOtherTeam.teamGroup = teamGroup;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    statisticsTeamVsOtherTeam.thirdMatchId = thirdMatchId;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    statisticsTeamVsOtherTeam.tournamentName = tournamentName;
  }
  final String? winnerOdds = jsonConvert.convert<String>(json['winnerOdds']);
  if (winnerOdds != null) {
    statisticsTeamVsOtherTeam.winnerOdds = winnerOdds;
  }
  return statisticsTeamVsOtherTeam;
}

Map<String, dynamic> $StatisticsTeamVsOtherTeamToJson(
    StatisticsTeamVsOtherTeam entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayTeamId'] = entity.awayTeamId;
  data['awayTeamName'] = entity.awayTeamName;
  data['awayTeamScore'] = entity.awayTeamScore;
  data['beginTime'] = entity.beginTime;
  data['boldTagName'] = entity.boldTagName;
  data['handicapOdds'] = entity.handicapOdds;
  data['handicapResult'] = entity.handicapResult;
  data['handicapVal'] = entity.handicapVal;
  data['homeTeamId'] = entity.homeTeamId;
  data['homeTeamName'] = entity.homeTeamName;
  data['homeTeamScore'] = entity.homeTeamScore;
  data['matchGroup'] = entity.matchGroup;
  data['overunderOdds'] = entity.overunderOdds;
  data['overunderResult'] = entity.overunderResult;
  data['overunderVal'] = entity.overunderVal;
  data['result'] = entity.result;
  data['sportId'] = entity.sportId;
  data['teamGroup'] = entity.teamGroup;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentName'] = entity.tournamentName;
  data['winnerOdds'] = entity.winnerOdds;
  return data;
}

extension StatisticsTeamVsOtherTeamExtension on StatisticsTeamVsOtherTeam {
  StatisticsTeamVsOtherTeam copyWith({
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamScore,
    String? beginTime,
    String? boldTagName,
    String? handicapOdds,
    int? handicapResult,
    String? handicapVal,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamScore,
    int? matchGroup,
    String? overunderOdds,
    int? overunderResult,
    String? overunderVal,
    int? result,
    String? sportId,
    String? teamGroup,
    String? thirdMatchId,
    String? tournamentName,
    String? winnerOdds,
  }) {
    return StatisticsTeamVsOtherTeam()
      ..awayTeamId = awayTeamId ?? this.awayTeamId
      ..awayTeamName = awayTeamName ?? this.awayTeamName
      ..awayTeamScore = awayTeamScore ?? this.awayTeamScore
      ..beginTime = beginTime ?? this.beginTime
      ..boldTagName = boldTagName ?? this.boldTagName
      ..handicapOdds = handicapOdds ?? this.handicapOdds
      ..handicapResult = handicapResult ?? this.handicapResult
      ..handicapVal = handicapVal ?? this.handicapVal
      ..homeTeamId = homeTeamId ?? this.homeTeamId
      ..homeTeamName = homeTeamName ?? this.homeTeamName
      ..homeTeamScore = homeTeamScore ?? this.homeTeamScore
      ..matchGroup = matchGroup ?? this.matchGroup
      ..overunderOdds = overunderOdds ?? this.overunderOdds
      ..overunderResult = overunderResult ?? this.overunderResult
      ..overunderVal = overunderVal ?? this.overunderVal
      ..result = result ?? this.result
      ..sportId = sportId ?? this.sportId
      ..teamGroup = teamGroup ?? this.teamGroup
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentName = tournamentName ?? this.tournamentName
      ..winnerOdds = winnerOdds ?? this.winnerOdds;
  }
}