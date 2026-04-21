import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_front_fight_entity.dart';

StatisticsFrontFightEntity $StatisticsFrontFightEntityFromJson(
    Map<String, dynamic> json) {
  final StatisticsFrontFightEntity statisticsFrontFightEntity = StatisticsFrontFightEntity();
  final int? allScores = jsonConvert.convert<int>(json['allScores']);
  if (allScores != null) {
    statisticsFrontFightEntity.allScores = allScores;
  }
  final dynamic awayNameCode = json['awayNameCode'];
  if (awayNameCode != null) {
    statisticsFrontFightEntity.awayNameCode = awayNameCode;
  }
  final int? awayNotLost = jsonConvert.convert<int>(json['awayNotLost']);
  if (awayNotLost != null) {
    statisticsFrontFightEntity.awayNotLost = awayNotLost;
  }
  final String? awayTeamId = jsonConvert.convert<String>(json['awayTeamId']);
  if (awayTeamId != null) {
    statisticsFrontFightEntity.awayTeamId = awayTeamId;
  }
  final String? awayTeamName = jsonConvert.convert<String>(
      json['awayTeamName']);
  if (awayTeamName != null) {
    statisticsFrontFightEntity.awayTeamName = awayTeamName;
  }
  final int? awayWin = jsonConvert.convert<int>(json['awayWin']);
  if (awayWin != null) {
    statisticsFrontFightEntity.awayWin = awayWin;
  }
  final int? countTotal = jsonConvert.convert<int>(json['countTotal']);
  if (countTotal != null) {
    statisticsFrontFightEntity.countTotal = countTotal;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    statisticsFrontFightEntity.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    statisticsFrontFightEntity.dataSourceCode = dataSourceCode;
  }
  final int? dogfallTotal = jsonConvert.convert<int>(json['dogfallTotal']);
  if (dogfallTotal != null) {
    statisticsFrontFightEntity.dogfallTotal = dogfallTotal;
  }
  final dynamic homeNameCode = json['homeNameCode'];
  if (homeNameCode != null) {
    statisticsFrontFightEntity.homeNameCode = homeNameCode;
  }
  final int? homeNotLost = jsonConvert.convert<int>(json['homeNotLost']);
  if (homeNotLost != null) {
    statisticsFrontFightEntity.homeNotLost = homeNotLost;
  }
  final String? homeTeamId = jsonConvert.convert<String>(json['homeTeamId']);
  if (homeTeamId != null) {
    statisticsFrontFightEntity.homeTeamId = homeTeamId;
  }
  final String? homeTeamName = jsonConvert.convert<String>(
      json['homeTeamName']);
  if (homeTeamName != null) {
    statisticsFrontFightEntity.homeTeamName = homeTeamName;
  }
  final int? homeWin = jsonConvert.convert<int>(json['homeWin']);
  if (homeWin != null) {
    statisticsFrontFightEntity.homeWin = homeWin;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    statisticsFrontFightEntity.id = id;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    statisticsFrontFightEntity.modifyTime = modifyTime;
  }
  final int? moreThanOne = jsonConvert.convert<int>(json['moreThanOne']);
  if (moreThanOne != null) {
    statisticsFrontFightEntity.moreThanOne = moreThanOne;
  }
  final int? moreThanThree = jsonConvert.convert<int>(json['moreThanThree']);
  if (moreThanThree != null) {
    statisticsFrontFightEntity.moreThanThree = moreThanThree;
  }
  final int? moreThanTwo = jsonConvert.convert<int>(json['moreThanTwo']);
  if (moreThanTwo != null) {
    statisticsFrontFightEntity.moreThanTwo = moreThanTwo;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    statisticsFrontFightEntity.sportId = sportId;
  }
  final String? standardAwayTeamId = jsonConvert.convert<String>(
      json['standardAwayTeamId']);
  if (standardAwayTeamId != null) {
    statisticsFrontFightEntity.standardAwayTeamId = standardAwayTeamId;
  }
  final String? standardHomeTeamId = jsonConvert.convert<String>(
      json['standardHomeTeamId']);
  if (standardHomeTeamId != null) {
    statisticsFrontFightEntity.standardHomeTeamId = standardHomeTeamId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    statisticsFrontFightEntity.standardMatchId = standardMatchId;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    statisticsFrontFightEntity.thirdMatchId = thirdMatchId;
  }
  final String? thirdMatchSourceId = jsonConvert.convert<String>(
      json['thirdMatchSourceId']);
  if (thirdMatchSourceId != null) {
    statisticsFrontFightEntity.thirdMatchSourceId = thirdMatchSourceId;
  }
  return statisticsFrontFightEntity;
}

Map<String, dynamic> $StatisticsFrontFightEntityToJson(
    StatisticsFrontFightEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['allScores'] = entity.allScores;
  data['awayNameCode'] = entity.awayNameCode;
  data['awayNotLost'] = entity.awayNotLost;
  data['awayTeamId'] = entity.awayTeamId;
  data['awayTeamName'] = entity.awayTeamName;
  data['awayWin'] = entity.awayWin;
  data['countTotal'] = entity.countTotal;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['dogfallTotal'] = entity.dogfallTotal;
  data['homeNameCode'] = entity.homeNameCode;
  data['homeNotLost'] = entity.homeNotLost;
  data['homeTeamId'] = entity.homeTeamId;
  data['homeTeamName'] = entity.homeTeamName;
  data['homeWin'] = entity.homeWin;
  data['id'] = entity.id;
  data['modifyTime'] = entity.modifyTime;
  data['moreThanOne'] = entity.moreThanOne;
  data['moreThanThree'] = entity.moreThanThree;
  data['moreThanTwo'] = entity.moreThanTwo;
  data['sportId'] = entity.sportId;
  data['standardAwayTeamId'] = entity.standardAwayTeamId;
  data['standardHomeTeamId'] = entity.standardHomeTeamId;
  data['standardMatchId'] = entity.standardMatchId;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['thirdMatchSourceId'] = entity.thirdMatchSourceId;
  return data;
}

extension StatisticsFrontFightEntityExtension on StatisticsFrontFightEntity {
  StatisticsFrontFightEntity copyWith({
    int? allScores,
    dynamic awayNameCode,
    int? awayNotLost,
    String? awayTeamId,
    String? awayTeamName,
    int? awayWin,
    int? countTotal,
    String? createTime,
    String? dataSourceCode,
    int? dogfallTotal,
    dynamic homeNameCode,
    int? homeNotLost,
    String? homeTeamId,
    String? homeTeamName,
    int? homeWin,
    String? id,
    String? modifyTime,
    int? moreThanOne,
    int? moreThanThree,
    int? moreThanTwo,
    String? sportId,
    String? standardAwayTeamId,
    String? standardHomeTeamId,
    String? standardMatchId,
    String? thirdMatchId,
    String? thirdMatchSourceId,
  }) {
    return StatisticsFrontFightEntity()
      ..allScores = allScores ?? this.allScores
      ..awayNameCode = awayNameCode ?? this.awayNameCode
      ..awayNotLost = awayNotLost ?? this.awayNotLost
      ..awayTeamId = awayTeamId ?? this.awayTeamId
      ..awayTeamName = awayTeamName ?? this.awayTeamName
      ..awayWin = awayWin ?? this.awayWin
      ..countTotal = countTotal ?? this.countTotal
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..dogfallTotal = dogfallTotal ?? this.dogfallTotal
      ..homeNameCode = homeNameCode ?? this.homeNameCode
      ..homeNotLost = homeNotLost ?? this.homeNotLost
      ..homeTeamId = homeTeamId ?? this.homeTeamId
      ..homeTeamName = homeTeamName ?? this.homeTeamName
      ..homeWin = homeWin ?? this.homeWin
      ..id = id ?? this.id
      ..modifyTime = modifyTime ?? this.modifyTime
      ..moreThanOne = moreThanOne ?? this.moreThanOne
      ..moreThanThree = moreThanThree ?? this.moreThanThree
      ..moreThanTwo = moreThanTwo ?? this.moreThanTwo
      ..sportId = sportId ?? this.sportId
      ..standardAwayTeamId = standardAwayTeamId ?? this.standardAwayTeamId
      ..standardHomeTeamId = standardHomeTeamId ?? this.standardHomeTeamId
      ..standardMatchId = standardMatchId ?? this.standardMatchId
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..thirdMatchSourceId = thirdMatchSourceId ?? this.thirdMatchSourceId;
  }
}