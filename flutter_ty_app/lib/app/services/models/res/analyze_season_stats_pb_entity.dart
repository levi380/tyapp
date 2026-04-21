import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_season_stats_pb_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/analyze_season_stats_pb_entity.g.dart';

@JsonSerializable()
class AnalyzeSeasonStatsPbEntity {
	late double averageCard;
	late double averageCorner;
	late double averageGoal;
	late String createTime;
	late String dataSourceCode;
	late String id;
	late String modifyTime;
	late double percentThanOne;
	late double percentThanThree;
	late double percentThanTwo;
	late String sportId;
	late String standardTournamentId;
	late String standardTournamentNameCode;
	late String thirdSourceSeasonId;
	late String thirdSourceSeasonName;
	late String thirdTournamentSourceId;
	late int tournamentType;

	AnalyzeSeasonStatsPbEntity();

	factory AnalyzeSeasonStatsPbEntity.fromJson(Map<String, dynamic> json) => $AnalyzeSeasonStatsPbEntityFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeSeasonStatsPbEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}