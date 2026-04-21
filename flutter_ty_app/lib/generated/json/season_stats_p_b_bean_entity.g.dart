import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/season_stats_p_b_bean_entity.dart';

SeasonStatsPBBeanEntity $SeasonStatsPBBeanEntityFromJson(
    Map<String, dynamic> json) {
  final SeasonStatsPBBeanEntity seasonStatsPBBeanEntity = SeasonStatsPBBeanEntity();
  final double? averageCard = jsonConvert.convert<double>(json['averageCard']);
  if (averageCard != null) {
    seasonStatsPBBeanEntity.averageCard = averageCard;
  }
  final double? averageCorner = jsonConvert.convert<double>(
      json['averageCorner']);
  if (averageCorner != null) {
    seasonStatsPBBeanEntity.averageCorner = averageCorner;
  }
  final double? averageGoal = jsonConvert.convert<double>(json['averageGoal']);
  if (averageGoal != null) {
    seasonStatsPBBeanEntity.averageGoal = averageGoal;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    seasonStatsPBBeanEntity.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    seasonStatsPBBeanEntity.dataSourceCode = dataSourceCode;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    seasonStatsPBBeanEntity.id = id;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    seasonStatsPBBeanEntity.modifyTime = modifyTime;
  }
  final double? percentThanOne = jsonConvert.convert<double>(
      json['percentThanOne']);
  if (percentThanOne != null) {
    seasonStatsPBBeanEntity.percentThanOne = percentThanOne;
  }
  final double? percentThanThree = jsonConvert.convert<double>(
      json['percentThanThree']);
  if (percentThanThree != null) {
    seasonStatsPBBeanEntity.percentThanThree = percentThanThree;
  }
  final double? percentThanTwo = jsonConvert.convert<double>(
      json['percentThanTwo']);
  if (percentThanTwo != null) {
    seasonStatsPBBeanEntity.percentThanTwo = percentThanTwo;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    seasonStatsPBBeanEntity.sportId = sportId;
  }
  final String? standardTournamentId = jsonConvert.convert<String>(
      json['standardTournamentId']);
  if (standardTournamentId != null) {
    seasonStatsPBBeanEntity.standardTournamentId = standardTournamentId;
  }
  final String? standardTournamentNameCode = jsonConvert.convert<String>(
      json['standardTournamentNameCode']);
  if (standardTournamentNameCode != null) {
    seasonStatsPBBeanEntity.standardTournamentNameCode =
        standardTournamentNameCode;
  }
  final String? thirdSourceSeasonId = jsonConvert.convert<String>(
      json['thirdSourceSeasonId']);
  if (thirdSourceSeasonId != null) {
    seasonStatsPBBeanEntity.thirdSourceSeasonId = thirdSourceSeasonId;
  }
  final String? thirdSourceSeasonName = jsonConvert.convert<String>(
      json['thirdSourceSeasonName']);
  if (thirdSourceSeasonName != null) {
    seasonStatsPBBeanEntity.thirdSourceSeasonName = thirdSourceSeasonName;
  }
  final String? thirdTournamentSourceId = jsonConvert.convert<String>(
      json['thirdTournamentSourceId']);
  if (thirdTournamentSourceId != null) {
    seasonStatsPBBeanEntity.thirdTournamentSourceId = thirdTournamentSourceId;
  }
  final int? tournamentType = jsonConvert.convert<int>(json['tournamentType']);
  if (tournamentType != null) {
    seasonStatsPBBeanEntity.tournamentType = tournamentType;
  }
  return seasonStatsPBBeanEntity;
}

Map<String, dynamic> $SeasonStatsPBBeanEntityToJson(
    SeasonStatsPBBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['averageCard'] = entity.averageCard;
  data['averageCorner'] = entity.averageCorner;
  data['averageGoal'] = entity.averageGoal;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['id'] = entity.id;
  data['modifyTime'] = entity.modifyTime;
  data['percentThanOne'] = entity.percentThanOne;
  data['percentThanThree'] = entity.percentThanThree;
  data['percentThanTwo'] = entity.percentThanTwo;
  data['sportId'] = entity.sportId;
  data['standardTournamentId'] = entity.standardTournamentId;
  data['standardTournamentNameCode'] = entity.standardTournamentNameCode;
  data['thirdSourceSeasonId'] = entity.thirdSourceSeasonId;
  data['thirdSourceSeasonName'] = entity.thirdSourceSeasonName;
  data['thirdTournamentSourceId'] = entity.thirdTournamentSourceId;
  data['tournamentType'] = entity.tournamentType;
  return data;
}

extension SeasonStatsPBBeanEntityExtension on SeasonStatsPBBeanEntity {
  SeasonStatsPBBeanEntity copyWith({
    double? averageCard,
    double? averageCorner,
    double? averageGoal,
    String? createTime,
    String? dataSourceCode,
    String? id,
    String? modifyTime,
    double? percentThanOne,
    double? percentThanThree,
    double? percentThanTwo,
    String? sportId,
    String? standardTournamentId,
    String? standardTournamentNameCode,
    String? thirdSourceSeasonId,
    String? thirdSourceSeasonName,
    String? thirdTournamentSourceId,
    int? tournamentType,
  }) {
    return SeasonStatsPBBeanEntity()
      ..averageCard = averageCard ?? this.averageCard
      ..averageCorner = averageCorner ?? this.averageCorner
      ..averageGoal = averageGoal ?? this.averageGoal
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..id = id ?? this.id
      ..modifyTime = modifyTime ?? this.modifyTime
      ..percentThanOne = percentThanOne ?? this.percentThanOne
      ..percentThanThree = percentThanThree ?? this.percentThanThree
      ..percentThanTwo = percentThanTwo ?? this.percentThanTwo
      ..sportId = sportId ?? this.sportId
      ..standardTournamentId = standardTournamentId ?? this.standardTournamentId
      ..standardTournamentNameCode = standardTournamentNameCode ??
          this.standardTournamentNameCode
      ..thirdSourceSeasonId = thirdSourceSeasonId ?? this.thirdSourceSeasonId
      ..thirdSourceSeasonName = thirdSourceSeasonName ??
          this.thirdSourceSeasonName
      ..thirdTournamentSourceId = thirdTournamentSourceId ??
          this.thirdTournamentSourceId
      ..tournamentType = tournamentType ?? this.tournamentType;
  }
}