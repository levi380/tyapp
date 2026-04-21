import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_vs_info_new_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/analyze_vs_info_new_info_entity.g.dart';

@JsonSerializable()
class AnalyzeVsInfoNewInfoEntity {
  late String rankingId = '';
  late String rankingName = '';
  late String teamPO = '';
  late List<AnalyzeVsInfoNewInfoTeamRankings> teamRankings = [];

  AnalyzeVsInfoNewInfoEntity();

  factory AnalyzeVsInfoNewInfoEntity.fromJson(Map<String, dynamic> json) =>
      $AnalyzeVsInfoNewInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeVsInfoNewInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeVsInfoNewInfoTeamRankings {
  late int drawTotal = 0;
  late int goalDiffTotal = 0;
  late int goalsAgainstTotal = 0;
  late int goalsForTotal = 0;
  late int lossTotal = 0;
  late int matchCount = 0;
  dynamic matchGroup;
  dynamic matchesCompleted;
  late int pointsTotal = 0;
  late int positionTotal = 0;
  late String promotionCnName = '';
  late String promotionEnName = '';
  late String promotionId = '';
  late String rankingCnName = '';
  late String rankingEnName = '';
  late String rankingId = '';
  late String teamBadge = '';
  late String teamCnName = '';
  late String teamEnName = '';
  late String teamFlag = '';
  late String teamLogo = '';
  late String teamName = '';
  late String thirdTeamSourceId = '';
  dynamic totalMatches;
  late String tournamentName = '';
  late int tournamentType = 0;
  late int winTotal = 0;

  @JSONField(serialize: false, deserialize: false)
  int index = 0;

  AnalyzeVsInfoNewInfoTeamRankings();

  factory AnalyzeVsInfoNewInfoTeamRankings.fromJson(
          Map<String, dynamic> json) =>
      $AnalyzeVsInfoNewInfoTeamRankingsFromJson(json);

  Map<String, dynamic> toJson() =>
      $AnalyzeVsInfoNewInfoTeamRankingsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
