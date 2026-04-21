import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_technical_entity.dart';

StatisticsTechnicalEntity $StatisticsTechnicalEntityFromJson(
    Map<String, dynamic> json) {
  final StatisticsTechnicalEntity statisticsTechnicalEntity = StatisticsTechnicalEntity();
  final dynamic assist = json['assist'];
  if (assist != null) {
    statisticsTechnicalEntity.assist = assist;
  }
  final dynamic blockedShots = json['blockedShots'];
  if (blockedShots != null) {
    statisticsTechnicalEntity.blockedShots = blockedShots;
  }
  final dynamic defensiveRebound = json['defensiveRebound'];
  if (defensiveRebound != null) {
    statisticsTechnicalEntity.defensiveRebound = defensiveRebound;
  }
  final int? fouls = jsonConvert.convert<int>(json['fouls']);
  if (fouls != null) {
    statisticsTechnicalEntity.fouls = fouls;
  }
  final String? homeAway = jsonConvert.convert<String>(json['homeAway']);
  if (homeAway != null) {
    statisticsTechnicalEntity.homeAway = homeAway;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    statisticsTechnicalEntity.id = id;
  }
  final dynamic offensiveRebound = json['offensiveRebound'];
  if (offensiveRebound != null) {
    statisticsTechnicalEntity.offensiveRebound = offensiveRebound;
  }
  final int? rebound = jsonConvert.convert<int>(json['rebound']);
  if (rebound != null) {
    statisticsTechnicalEntity.rebound = rebound;
  }
  final int? score = jsonConvert.convert<int>(json['score']);
  if (score != null) {
    statisticsTechnicalEntity.score = score;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    statisticsTechnicalEntity.standardMatchId = standardMatchId;
  }
  final String? standardTeamId = jsonConvert.convert<String>(
      json['standardTeamId']);
  if (standardTeamId != null) {
    statisticsTechnicalEntity.standardTeamId = standardTeamId;
  }
  final dynamic steal = json['steal'];
  if (steal != null) {
    statisticsTechnicalEntity.steal = steal;
  }
  final String? teamLogo = jsonConvert.convert<String>(json['teamLogo']);
  if (teamLogo != null) {
    statisticsTechnicalEntity.teamLogo = teamLogo;
  }
  final String? teamLogoUrlThumb = jsonConvert.convert<String>(
      json['teamLogoUrlThumb']);
  if (teamLogoUrlThumb != null) {
    statisticsTechnicalEntity.teamLogoUrlThumb = teamLogoUrlThumb;
  }
  final dynamic turnover = json['turnover'];
  if (turnover != null) {
    statisticsTechnicalEntity.turnover = turnover;
  }
  return statisticsTechnicalEntity;
}

Map<String, dynamic> $StatisticsTechnicalEntityToJson(
    StatisticsTechnicalEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['assist'] = entity.assist;
  data['blockedShots'] = entity.blockedShots;
  data['defensiveRebound'] = entity.defensiveRebound;
  data['fouls'] = entity.fouls;
  data['homeAway'] = entity.homeAway;
  data['id'] = entity.id;
  data['offensiveRebound'] = entity.offensiveRebound;
  data['rebound'] = entity.rebound;
  data['score'] = entity.score;
  data['standardMatchId'] = entity.standardMatchId;
  data['standardTeamId'] = entity.standardTeamId;
  data['steal'] = entity.steal;
  data['teamLogo'] = entity.teamLogo;
  data['teamLogoUrlThumb'] = entity.teamLogoUrlThumb;
  data['turnover'] = entity.turnover;
  return data;
}

extension StatisticsTechnicalEntityExtension on StatisticsTechnicalEntity {
  StatisticsTechnicalEntity copyWith({
    dynamic assist,
    dynamic blockedShots,
    dynamic defensiveRebound,
    int? fouls,
    String? homeAway,
    String? id,
    dynamic offensiveRebound,
    int? rebound,
    int? score,
    String? standardMatchId,
    String? standardTeamId,
    dynamic steal,
    String? teamLogo,
    String? teamLogoUrlThumb,
    dynamic turnover,
  }) {
    return StatisticsTechnicalEntity()
      ..assist = assist ?? this.assist
      ..blockedShots = blockedShots ?? this.blockedShots
      ..defensiveRebound = defensiveRebound ?? this.defensiveRebound
      ..fouls = fouls ?? this.fouls
      ..homeAway = homeAway ?? this.homeAway
      ..id = id ?? this.id
      ..offensiveRebound = offensiveRebound ?? this.offensiveRebound
      ..rebound = rebound ?? this.rebound
      ..score = score ?? this.score
      ..standardMatchId = standardMatchId ?? this.standardMatchId
      ..standardTeamId = standardTeamId ?? this.standardTeamId
      ..steal = steal ?? this.steal
      ..teamLogo = teamLogo ?? this.teamLogo
      ..teamLogoUrlThumb = teamLogoUrlThumb ?? this.teamLogoUrlThumb
      ..turnover = turnover ?? this.turnover;
  }
}