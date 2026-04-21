import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/knockout_info_bean_entity.dart';

KnockoutInfoBeanEntity $KnockoutInfoBeanEntityFromJson(
    Map<String, dynamic> json) {
  final KnockoutInfoBeanEntity knockoutInfoBeanEntity = KnockoutInfoBeanEntity();
  final String? add1 = jsonConvert.convert<String>(json['add1']);
  if (add1 != null) {
    knockoutInfoBeanEntity.add1 = add1;
  }
  final String? add2 = jsonConvert.convert<String>(json['add2']);
  if (add2 != null) {
    knockoutInfoBeanEntity.add2 = add2;
  }
  final String? add3 = jsonConvert.convert<String>(json['add3']);
  if (add3 != null) {
    knockoutInfoBeanEntity.add3 = add3;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    knockoutInfoBeanEntity.homeName = homeName;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    knockoutInfoBeanEntity.awayName = awayName;
  }
  final String? awayLogoUrl = jsonConvert.convert<String>(json['awayLogoUrl']);
  if (awayLogoUrl != null) {
    knockoutInfoBeanEntity.awayLogoUrl = awayLogoUrl;
  }
  final String? awayNameCode = jsonConvert.convert<String>(
      json['awayNameCode']);
  if (awayNameCode != null) {
    knockoutInfoBeanEntity.awayNameCode = awayNameCode;
  }
  final String? awayTeamId = jsonConvert.convert<String>(json['awayTeamId']);
  if (awayTeamId != null) {
    knockoutInfoBeanEntity.awayTeamId = awayTeamId;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    knockoutInfoBeanEntity.createTime = createTime;
  }
  final String? homeLogoUrl = jsonConvert.convert<String>(json['homeLogoUrl']);
  if (homeLogoUrl != null) {
    knockoutInfoBeanEntity.homeLogoUrl = homeLogoUrl;
  }
  final String? homeNameCode = jsonConvert.convert<String>(
      json['homeNameCode']);
  if (homeNameCode != null) {
    knockoutInfoBeanEntity.homeNameCode = homeNameCode;
  }
  final String? homeTeamId = jsonConvert.convert<String>(json['homeTeamId']);
  if (homeTeamId != null) {
    knockoutInfoBeanEntity.homeTeamId = homeTeamId;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    knockoutInfoBeanEntity.id = id;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    knockoutInfoBeanEntity.modifyTime = modifyTime;
  }
  final String? roundGroup = jsonConvert.convert<String>(json['roundGroup']);
  if (roundGroup != null) {
    knockoutInfoBeanEntity.roundGroup = roundGroup;
  }
  final String? scores = jsonConvert.convert<String>(json['scores']);
  if (scores != null) {
    knockoutInfoBeanEntity.scores = scores;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    knockoutInfoBeanEntity.sportId = sportId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    knockoutInfoBeanEntity.tournamentId = tournamentId;
  }
  final String? homeScores = jsonConvert.convert<String>(json['homeScores']);
  if (homeScores != null) {
    knockoutInfoBeanEntity.homeScores = homeScores;
  }
  final String? awayScores = jsonConvert.convert<String>(json['awayScores']);
  if (awayScores != null) {
    knockoutInfoBeanEntity.awayScores = awayScores;
  }
  return knockoutInfoBeanEntity;
}

Map<String, dynamic> $KnockoutInfoBeanEntityToJson(
    KnockoutInfoBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['add1'] = entity.add1;
  data['add2'] = entity.add2;
  data['add3'] = entity.add3;
  data['homeName'] = entity.homeName;
  data['awayName'] = entity.awayName;
  data['awayLogoUrl'] = entity.awayLogoUrl;
  data['awayNameCode'] = entity.awayNameCode;
  data['awayTeamId'] = entity.awayTeamId;
  data['createTime'] = entity.createTime;
  data['homeLogoUrl'] = entity.homeLogoUrl;
  data['homeNameCode'] = entity.homeNameCode;
  data['homeTeamId'] = entity.homeTeamId;
  data['id'] = entity.id;
  data['modifyTime'] = entity.modifyTime;
  data['roundGroup'] = entity.roundGroup;
  data['scores'] = entity.scores;
  data['sportId'] = entity.sportId;
  data['tournamentId'] = entity.tournamentId;
  data['homeScores'] = entity.homeScores;
  data['awayScores'] = entity.awayScores;
  return data;
}

extension KnockoutInfoBeanEntityExtension on KnockoutInfoBeanEntity {
  KnockoutInfoBeanEntity copyWith({
    String? add1,
    String? add2,
    String? add3,
    String? homeName,
    String? awayName,
    String? awayLogoUrl,
    String? awayNameCode,
    String? awayTeamId,
    String? createTime,
    String? homeLogoUrl,
    String? homeNameCode,
    String? homeTeamId,
    String? id,
    String? modifyTime,
    String? roundGroup,
    String? scores,
    String? sportId,
    String? tournamentId,
    String? homeScores,
    String? awayScores,
  }) {
    return KnockoutInfoBeanEntity()
      ..add1 = add1 ?? this.add1
      ..add2 = add2 ?? this.add2
      ..add3 = add3 ?? this.add3
      ..homeName = homeName ?? this.homeName
      ..awayName = awayName ?? this.awayName
      ..awayLogoUrl = awayLogoUrl ?? this.awayLogoUrl
      ..awayNameCode = awayNameCode ?? this.awayNameCode
      ..awayTeamId = awayTeamId ?? this.awayTeamId
      ..createTime = createTime ?? this.createTime
      ..homeLogoUrl = homeLogoUrl ?? this.homeLogoUrl
      ..homeNameCode = homeNameCode ?? this.homeNameCode
      ..homeTeamId = homeTeamId ?? this.homeTeamId
      ..id = id ?? this.id
      ..modifyTime = modifyTime ?? this.modifyTime
      ..roundGroup = roundGroup ?? this.roundGroup
      ..scores = scores ?? this.scores
      ..sportId = sportId ?? this.sportId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..homeScores = homeScores ?? this.homeScores
      ..awayScores = awayScores ?? this.awayScores;
  }
}