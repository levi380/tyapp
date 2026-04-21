import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/statistics_team_vs_other_team_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/statistics_team_vs_other_team_entity.g.dart';

@JsonSerializable()
class StatisticsTeamVsOtherTeamEntity {
	List<StatisticsTeamVsOtherTeam> away = [];
	List<StatisticsTeamVsOtherTeam> home = [];

	StatisticsTeamVsOtherTeamEntity();

	factory StatisticsTeamVsOtherTeamEntity.fromJson(Map<String, dynamic> json) => $StatisticsTeamVsOtherTeamEntityFromJson(json);

	Map<String, dynamic> toJson() => $StatisticsTeamVsOtherTeamEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}


@JsonSerializable()
class StatisticsTeamVsOtherTeam {
	String awayTeamId = '';
	String awayTeamName = '';
	String awayTeamScore = '';
	String beginTime = '';
	String boldTagName = '';
	String handicapOdds = '';
	int handicapResult = 0;
	String handicapVal = '';
	String homeTeamId = '';
	String homeTeamName = '';
	String homeTeamScore = '';
	int matchGroup = 0;
	String overunderOdds = '';
	int overunderResult = 0;
	String overunderVal = '';
	int result = 0;
	String sportId = '';
	String teamGroup = '';
	String thirdMatchId = '';
	String tournamentName = '';
	String winnerOdds = '';

	StatisticsTeamVsOtherTeam();

	factory StatisticsTeamVsOtherTeam.fromJson(Map<String, dynamic> json) => $StatisticsTeamVsOtherTeamFromJson(json);

	Map<String, dynamic> toJson() => $StatisticsTeamVsOtherTeamToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}