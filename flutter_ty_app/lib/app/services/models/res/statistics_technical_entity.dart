import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/statistics_technical_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/statistics_technical_entity.g.dart';

@JsonSerializable()
class StatisticsTechnicalEntity {
	dynamic assist;
	dynamic blockedShots;
	dynamic defensiveRebound;
	late int fouls = 0;
	late String homeAway = '';
	late String id = '';
	dynamic offensiveRebound;
	late int rebound = 0;
	late int score = 0;
	late String standardMatchId = '';
	late String standardTeamId = '';
	dynamic steal;
	late String teamLogo = '';
	late String teamLogoUrlThumb = '';
	dynamic turnover;

	StatisticsTechnicalEntity();

	factory StatisticsTechnicalEntity.fromJson(Map<String, dynamic> json) => $StatisticsTechnicalEntityFromJson(json);

	Map<String, dynamic> toJson() => $StatisticsTechnicalEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}