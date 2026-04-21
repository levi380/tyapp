import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/statistics_front_fight_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/statistics_front_fight_entity.g.dart';

@JsonSerializable()
class StatisticsFrontFightEntity {
	int allScores = 0;
	dynamic awayNameCode;
	int awayNotLost = 0;
	String awayTeamId = '';
	String awayTeamName = '';
	int awayWin = 0;
	int countTotal = 0;
	String createTime = '';
	String dataSourceCode = '';
	int dogfallTotal = 0;
	dynamic homeNameCode;
	int homeNotLost = 0;
	String homeTeamId = '';
	String homeTeamName = '';
	int homeWin = 0;
	String id = '';
	String modifyTime = '';
	int moreThanOne = 0;
	int moreThanThree = 0;
	int moreThanTwo = 0;
	String sportId = '';
	String standardAwayTeamId = '';
	String standardHomeTeamId = '';
	String standardMatchId = '';
	String thirdMatchId = '';
	String thirdMatchSourceId = '';

	StatisticsFrontFightEntity();

	factory StatisticsFrontFightEntity.fromJson(Map<String, dynamic> json) => $StatisticsFrontFightEntityFromJson(json);

	Map<String, dynamic> toJson() => $StatisticsFrontFightEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}