import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';

AnalyzeVsInfoNewInfoEntity $AnalyzeVsInfoNewInfoEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeVsInfoNewInfoEntity analyzeVsInfoNewInfoEntity = AnalyzeVsInfoNewInfoEntity();
  final String? rankingId = jsonConvert.convert<String>(json['rankingId']);
  if (rankingId != null) {
    analyzeVsInfoNewInfoEntity.rankingId = rankingId;
  }
  final String? rankingName = jsonConvert.convert<String>(json['rankingName']);
  if (rankingName != null) {
    analyzeVsInfoNewInfoEntity.rankingName = rankingName;
  }
  final String? teamPO = jsonConvert.convert<String>(json['teamPO']);
  if (teamPO != null) {
    analyzeVsInfoNewInfoEntity.teamPO = teamPO;
  }
  final List<
      AnalyzeVsInfoNewInfoTeamRankings>? teamRankings = (json['teamRankings'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<AnalyzeVsInfoNewInfoTeamRankings>(
          e) as AnalyzeVsInfoNewInfoTeamRankings).toList();
  if (teamRankings != null) {
    analyzeVsInfoNewInfoEntity.teamRankings = teamRankings;
  }
  return analyzeVsInfoNewInfoEntity;
}

Map<String, dynamic> $AnalyzeVsInfoNewInfoEntityToJson(
    AnalyzeVsInfoNewInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['rankingId'] = entity.rankingId;
  data['rankingName'] = entity.rankingName;
  data['teamPO'] = entity.teamPO;
  data['teamRankings'] = entity.teamRankings.map((v) => v.toJson()).toList();
  return data;
}

extension AnalyzeVsInfoNewInfoEntityExtension on AnalyzeVsInfoNewInfoEntity {
  AnalyzeVsInfoNewInfoEntity copyWith({
    String? rankingId,
    String? rankingName,
    String? teamPO,
    List<AnalyzeVsInfoNewInfoTeamRankings>? teamRankings,
  }) {
    return AnalyzeVsInfoNewInfoEntity()
      ..rankingId = rankingId ?? this.rankingId
      ..rankingName = rankingName ?? this.rankingName
      ..teamPO = teamPO ?? this.teamPO
      ..teamRankings = teamRankings ?? this.teamRankings;
  }
}

AnalyzeVsInfoNewInfoTeamRankings $AnalyzeVsInfoNewInfoTeamRankingsFromJson(
    Map<String, dynamic> json) {
  final AnalyzeVsInfoNewInfoTeamRankings analyzeVsInfoNewInfoTeamRankings = AnalyzeVsInfoNewInfoTeamRankings();
  final int? drawTotal = jsonConvert.convert<int>(json['drawTotal']);
  if (drawTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.drawTotal = drawTotal;
  }
  final int? goalDiffTotal = jsonConvert.convert<int>(json['goalDiffTotal']);
  if (goalDiffTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.goalDiffTotal = goalDiffTotal;
  }
  final int? goalsAgainstTotal = jsonConvert.convert<int>(
      json['goalsAgainstTotal']);
  if (goalsAgainstTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.goalsAgainstTotal = goalsAgainstTotal;
  }
  final int? goalsForTotal = jsonConvert.convert<int>(json['goalsForTotal']);
  if (goalsForTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.goalsForTotal = goalsForTotal;
  }
  final int? lossTotal = jsonConvert.convert<int>(json['lossTotal']);
  if (lossTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.lossTotal = lossTotal;
  }
  final int? matchCount = jsonConvert.convert<int>(json['matchCount']);
  if (matchCount != null) {
    analyzeVsInfoNewInfoTeamRankings.matchCount = matchCount;
  }
  final dynamic matchGroup = json['matchGroup'];
  if (matchGroup != null) {
    analyzeVsInfoNewInfoTeamRankings.matchGroup = matchGroup;
  }
  final dynamic matchesCompleted = json['matchesCompleted'];
  if (matchesCompleted != null) {
    analyzeVsInfoNewInfoTeamRankings.matchesCompleted = matchesCompleted;
  }
  final int? pointsTotal = jsonConvert.convert<int>(json['pointsTotal']);
  if (pointsTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.pointsTotal = pointsTotal;
  }
  final int? positionTotal = jsonConvert.convert<int>(json['positionTotal']);
  if (positionTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.positionTotal = positionTotal;
  }
  final String? promotionCnName = jsonConvert.convert<String>(
      json['promotionCnName']);
  if (promotionCnName != null) {
    analyzeVsInfoNewInfoTeamRankings.promotionCnName = promotionCnName;
  }
  final String? promotionEnName = jsonConvert.convert<String>(
      json['promotionEnName']);
  if (promotionEnName != null) {
    analyzeVsInfoNewInfoTeamRankings.promotionEnName = promotionEnName;
  }
  final String? promotionId = jsonConvert.convert<String>(json['promotionId']);
  if (promotionId != null) {
    analyzeVsInfoNewInfoTeamRankings.promotionId = promotionId;
  }
  final String? rankingCnName = jsonConvert.convert<String>(
      json['rankingCnName']);
  if (rankingCnName != null) {
    analyzeVsInfoNewInfoTeamRankings.rankingCnName = rankingCnName;
  }
  final String? rankingEnName = jsonConvert.convert<String>(
      json['rankingEnName']);
  if (rankingEnName != null) {
    analyzeVsInfoNewInfoTeamRankings.rankingEnName = rankingEnName;
  }
  final String? rankingId = jsonConvert.convert<String>(json['rankingId']);
  if (rankingId != null) {
    analyzeVsInfoNewInfoTeamRankings.rankingId = rankingId;
  }
  final String? teamBadge = jsonConvert.convert<String>(json['teamBadge']);
  if (teamBadge != null) {
    analyzeVsInfoNewInfoTeamRankings.teamBadge = teamBadge;
  }
  final String? teamCnName = jsonConvert.convert<String>(json['teamCnName']);
  if (teamCnName != null) {
    analyzeVsInfoNewInfoTeamRankings.teamCnName = teamCnName;
  }
  final String? teamEnName = jsonConvert.convert<String>(json['teamEnName']);
  if (teamEnName != null) {
    analyzeVsInfoNewInfoTeamRankings.teamEnName = teamEnName;
  }
  final String? teamFlag = jsonConvert.convert<String>(json['teamFlag']);
  if (teamFlag != null) {
    analyzeVsInfoNewInfoTeamRankings.teamFlag = teamFlag;
  }
  final String? teamLogo = jsonConvert.convert<String>(json['teamLogo']);
  if (teamLogo != null) {
    analyzeVsInfoNewInfoTeamRankings.teamLogo = teamLogo;
  }
  final String? teamName = jsonConvert.convert<String>(json['teamName']);
  if (teamName != null) {
    analyzeVsInfoNewInfoTeamRankings.teamName = teamName;
  }
  final String? thirdTeamSourceId = jsonConvert.convert<String>(
      json['thirdTeamSourceId']);
  if (thirdTeamSourceId != null) {
    analyzeVsInfoNewInfoTeamRankings.thirdTeamSourceId = thirdTeamSourceId;
  }
  final dynamic totalMatches = json['totalMatches'];
  if (totalMatches != null) {
    analyzeVsInfoNewInfoTeamRankings.totalMatches = totalMatches;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    analyzeVsInfoNewInfoTeamRankings.tournamentName = tournamentName;
  }
  final int? tournamentType = jsonConvert.convert<int>(json['tournamentType']);
  if (tournamentType != null) {
    analyzeVsInfoNewInfoTeamRankings.tournamentType = tournamentType;
  }
  final int? winTotal = jsonConvert.convert<int>(json['winTotal']);
  if (winTotal != null) {
    analyzeVsInfoNewInfoTeamRankings.winTotal = winTotal;
  }
  return analyzeVsInfoNewInfoTeamRankings;
}

Map<String, dynamic> $AnalyzeVsInfoNewInfoTeamRankingsToJson(
    AnalyzeVsInfoNewInfoTeamRankings entity) {
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

extension AnalyzeVsInfoNewInfoTeamRankingsExtension on AnalyzeVsInfoNewInfoTeamRankings {
  AnalyzeVsInfoNewInfoTeamRankings copyWith({
    int? drawTotal,
    int? goalDiffTotal,
    int? goalsAgainstTotal,
    int? goalsForTotal,
    int? lossTotal,
    int? matchCount,
    dynamic matchGroup,
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
    int? index,
  }) {
    return AnalyzeVsInfoNewInfoTeamRankings()
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
      ..winTotal = winTotal ?? this.winTotal
      ..index = index ?? this.index;
  }
}