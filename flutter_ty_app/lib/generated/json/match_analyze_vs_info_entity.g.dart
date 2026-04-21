import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analyze_vs_info_entity.dart';

MatchAnalyzeVsInfoEntity $MatchAnalyzeVsInfoEntityFromJson(
    Map<String, dynamic> json) {
  final MatchAnalyzeVsInfoEntity matchAnalyzeVsInfoEntity = MatchAnalyzeVsInfoEntity();
  final int? drawTotal = jsonConvert.convert<int>(json['drawTotal']);
  if (drawTotal != null) {
    matchAnalyzeVsInfoEntity.drawTotal = drawTotal;
  }
  final int? goalDiffTotal = jsonConvert.convert<int>(json['goalDiffTotal']);
  if (goalDiffTotal != null) {
    matchAnalyzeVsInfoEntity.goalDiffTotal = goalDiffTotal;
  }
  final int? goalsAgainstTotal = jsonConvert.convert<int>(
      json['goalsAgainstTotal']);
  if (goalsAgainstTotal != null) {
    matchAnalyzeVsInfoEntity.goalsAgainstTotal = goalsAgainstTotal;
  }
  final int? goalsForTotal = jsonConvert.convert<int>(json['goalsForTotal']);
  if (goalsForTotal != null) {
    matchAnalyzeVsInfoEntity.goalsForTotal = goalsForTotal;
  }
  final int? lossTotal = jsonConvert.convert<int>(json['lossTotal']);
  if (lossTotal != null) {
    matchAnalyzeVsInfoEntity.lossTotal = lossTotal;
  }
  final int? matchCount = jsonConvert.convert<int>(json['matchCount']);
  if (matchCount != null) {
    matchAnalyzeVsInfoEntity.matchCount = matchCount;
  }
  final int? matchGroup = jsonConvert.convert<int>(json['matchGroup']);
  if (matchGroup != null) {
    matchAnalyzeVsInfoEntity.matchGroup = matchGroup;
  }
  final dynamic matchesCompleted = json['matchesCompleted'];
  if (matchesCompleted != null) {
    matchAnalyzeVsInfoEntity.matchesCompleted = matchesCompleted;
  }
  final int? pointsTotal = jsonConvert.convert<int>(json['pointsTotal']);
  if (pointsTotal != null) {
    matchAnalyzeVsInfoEntity.pointsTotal = pointsTotal;
  }
  final int? positionTotal = jsonConvert.convert<int>(json['positionTotal']);
  if (positionTotal != null) {
    matchAnalyzeVsInfoEntity.positionTotal = positionTotal;
  }
  final String? promotionCnName = jsonConvert.convert<String>(
      json['promotionCnName']);
  if (promotionCnName != null) {
    matchAnalyzeVsInfoEntity.promotionCnName = promotionCnName;
  }
  final String? promotionEnName = jsonConvert.convert<String>(
      json['promotionEnName']);
  if (promotionEnName != null) {
    matchAnalyzeVsInfoEntity.promotionEnName = promotionEnName;
  }
  final String? promotionId = jsonConvert.convert<String>(json['promotionId']);
  if (promotionId != null) {
    matchAnalyzeVsInfoEntity.promotionId = promotionId;
  }
  final String? rankingCnName = jsonConvert.convert<String>(
      json['rankingCnName']);
  if (rankingCnName != null) {
    matchAnalyzeVsInfoEntity.rankingCnName = rankingCnName;
  }
  final String? rankingEnName = jsonConvert.convert<String>(
      json['rankingEnName']);
  if (rankingEnName != null) {
    matchAnalyzeVsInfoEntity.rankingEnName = rankingEnName;
  }
  final String? rankingId = jsonConvert.convert<String>(json['rankingId']);
  if (rankingId != null) {
    matchAnalyzeVsInfoEntity.rankingId = rankingId;
  }
  final String? teamBadge = jsonConvert.convert<String>(json['teamBadge']);
  if (teamBadge != null) {
    matchAnalyzeVsInfoEntity.teamBadge = teamBadge;
  }
  final String? teamCnName = jsonConvert.convert<String>(json['teamCnName']);
  if (teamCnName != null) {
    matchAnalyzeVsInfoEntity.teamCnName = teamCnName;
  }
  final String? teamEnName = jsonConvert.convert<String>(json['teamEnName']);
  if (teamEnName != null) {
    matchAnalyzeVsInfoEntity.teamEnName = teamEnName;
  }
  final String? teamFlag = jsonConvert.convert<String>(json['teamFlag']);
  if (teamFlag != null) {
    matchAnalyzeVsInfoEntity.teamFlag = teamFlag;
  }
  final String? teamLogo = jsonConvert.convert<String>(json['teamLogo']);
  if (teamLogo != null) {
    matchAnalyzeVsInfoEntity.teamLogo = teamLogo;
  }
  final String? teamName = jsonConvert.convert<String>(json['teamName']);
  if (teamName != null) {
    matchAnalyzeVsInfoEntity.teamName = teamName;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    matchAnalyzeVsInfoEntity.thirdTeamSourceId = thirdTeamSourceId;
  }
  final dynamic totalMatches = json['totalMatches'];
  if (totalMatches != null) {
    matchAnalyzeVsInfoEntity.totalMatches = totalMatches;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    matchAnalyzeVsInfoEntity.tournamentName = tournamentName;
  }
  final int? tournamentType = jsonConvert.convert<int>(json['tournamentType']);
  if (tournamentType != null) {
    matchAnalyzeVsInfoEntity.tournamentType = tournamentType;
  }
  final int? winTotal = jsonConvert.convert<int>(json['winTotal']);
  if (winTotal != null) {
    matchAnalyzeVsInfoEntity.winTotal = winTotal;
  }
  return matchAnalyzeVsInfoEntity;
}

Map<String, dynamic> $MatchAnalyzeVsInfoEntityToJson(
    MatchAnalyzeVsInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['drawTotal'] = entity.drawTotal;
  data['goalDiffTotal'] = entity.goalDiffTotal;
  data['goalsAgainstTotal'] = entity.goalsAgainstTotal;
  data['goalsForTotal'] = entity.goalsForTotal;
  data['lossTotal'] = entity.lossTotal;
  data['matchCount'] = entity.matchCount;
  data['matchGroup'] = entity.matchGroup;
  data['matchesCompleted'] = entity.matchesCompleted;
  data['pointsTotal'] = entity.pointsTotal;
  data['positionTotal'] = entity.positionTotal;
  data['promotionCnName'] = entity.promotionCnName;
  data['promotionEnName'] = entity.promotionEnName;
  data['promotionId'] = entity.promotionId;
  data['rankingCnName'] = entity.rankingCnName;
  data['rankingEnName'] = entity.rankingEnName;
  data['rankingId'] = entity.rankingId;
  data['teamBadge'] = entity.teamBadge;
  data['teamCnName'] = entity.teamCnName;
  data['teamEnName'] = entity.teamEnName;
  data['teamFlag'] = entity.teamFlag;
  data['teamLogo'] = entity.teamLogo;
  data['teamName'] = entity.teamName;
  data['thirdTeamSourceId'] = entity.thirdTeamSourceId;
  data['totalMatches'] = entity.totalMatches;
  data['tournamentName'] = entity.tournamentName;
  data['tournamentType'] = entity.tournamentType;
  data['winTotal'] = entity.winTotal;
  return data;
}

extension MatchAnalyzeVsInfoEntityExtension on MatchAnalyzeVsInfoEntity {
  MatchAnalyzeVsInfoEntity copyWith({
    int? drawTotal,
    int? goalDiffTotal,
    int? goalsAgainstTotal,
    int? goalsForTotal,
    int? lossTotal,
    int? matchCount,
    int? matchGroup,
    dynamic matchesCompleted,
    int? pointsTotal,
    int? positionTotal,
    String? promotionCnName,
    String? promotionEnName,
    String? promotionId,
    String? rankingCnName,
    String? rankingEnName,
    String? rankingId,
    String? teamBadge,
    String? teamCnName,
    String? teamEnName,
    String? teamFlag,
    String? teamLogo,
    String? teamName,
    String? thirdTeamSourceId,
    dynamic totalMatches,
    String? tournamentName,
    int? tournamentType,
    int? winTotal,
  }) {
    return MatchAnalyzeVsInfoEntity()
      ..drawTotal = drawTotal ?? this.drawTotal
      ..goalDiffTotal = goalDiffTotal ?? this.goalDiffTotal
      ..goalsAgainstTotal = goalsAgainstTotal ?? this.goalsAgainstTotal
      ..goalsForTotal = goalsForTotal ?? this.goalsForTotal
      ..lossTotal = lossTotal ?? this.lossTotal
      ..matchCount = matchCount ?? this.matchCount
      ..matchGroup = matchGroup ?? this.matchGroup
      ..matchesCompleted = matchesCompleted ?? this.matchesCompleted
      ..pointsTotal = pointsTotal ?? this.pointsTotal
      ..positionTotal = positionTotal ?? this.positionTotal
      ..promotionCnName = promotionCnName ?? this.promotionCnName
      ..promotionEnName = promotionEnName ?? this.promotionEnName
      ..promotionId = promotionId ?? this.promotionId
      ..rankingCnName = rankingCnName ?? this.rankingCnName
      ..rankingEnName = rankingEnName ?? this.rankingEnName
      ..rankingId = rankingId ?? this.rankingId
      ..teamBadge = teamBadge ?? this.teamBadge
      ..teamCnName = teamCnName ?? this.teamCnName
      ..teamEnName = teamEnName ?? this.teamEnName
      ..teamFlag = teamFlag ?? this.teamFlag
      ..teamLogo = teamLogo ?? this.teamLogo
      ..teamName = teamName ?? this.teamName
      ..thirdTeamSourceId = thirdTeamSourceId ?? this.thirdTeamSourceId
      ..totalMatches = totalMatches ?? this.totalMatches
      ..tournamentName = tournamentName ?? this.tournamentName
      ..tournamentType = tournamentType ?? this.tournamentType
      ..winTotal = winTotal ?? this.winTotal;
  }
}