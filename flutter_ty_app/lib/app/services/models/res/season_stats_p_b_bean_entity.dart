import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/season_stats_p_b_bean_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/season_stats_p_b_bean_entity.g.dart';

@JsonSerializable()
class SeasonStatsPBBeanEntity {
	double? averageCard;
	double? averageCorner;
	double? averageGoal;
	String? createTime = '';
	String? dataSourceCode = '';
	String? id = '';
	String? modifyTime = '';
	double? percentThanOne;
	double? percentThanThree;
	double? percentThanTwo;
	String? sportId = '';
	String? standardTournamentId = '';
	String? standardTournamentNameCode = '';
	String? thirdSourceSeasonId = '';
	String? thirdSourceSeasonName = '';
	String? thirdTournamentSourceId = '';
	int? tournamentType = 0;

	SeasonStatsPBBeanEntity();

	factory SeasonStatsPBBeanEntity.fromJson(Map<String, dynamic> json) => $SeasonStatsPBBeanEntityFromJson(json);

	Map<String, dynamic> toJson() => $SeasonStatsPBBeanEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}