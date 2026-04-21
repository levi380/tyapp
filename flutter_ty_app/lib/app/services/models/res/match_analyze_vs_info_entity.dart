import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_analyze_vs_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/match_analyze_vs_info_entity.g.dart';

@JsonSerializable()
class MatchAnalyzeVsInfoEntity {
	late int drawTotal = 0;
	late int goalDiffTotal = 0;
	late int goalsAgainstTotal = 0;
	late int goalsForTotal = 0;
	late int lossTotal = 0;
	late int matchCount = 0;
	late int matchGroup = 0;
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

	MatchAnalyzeVsInfoEntity();

	factory MatchAnalyzeVsInfoEntity.fromJson(Map<String, dynamic> json) => $MatchAnalyzeVsInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchAnalyzeVsInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}