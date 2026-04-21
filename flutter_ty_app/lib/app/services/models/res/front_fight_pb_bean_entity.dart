import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/front_fight_pb_bean_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/front_fight_pb_bean_entity.g.dart';

@JsonSerializable()
class FrontFightPbBeanEntity {
	double? averageGoal;
	double? averageGoalPercent;
	double? bothGoalPercent;
	String? createTime = '';
	String? dataSourceCode = '';
	int? expressingType = 0;
	String? expressionRanking = '';
	int? fifthStatus = 0;
	double? firstGoalPercent;
	int? firstStatus = 0;
	int? fourthStatus = 0;
	double? goalPercent;
	double? goalXg;
	double? goalXga;
	int? goalsForTotal = 0;
	String? id = '';
	double? lostGoalPercent;
	String? modifyTime = '';
	double? notLostPercent;
	int? secondStatus = 0;
	String? sportId = '';
	String? standardTeamId = '';
	String? teamCnName = '';
	String? teamEnName = '';
	int? thirdStatus = 0;
	String? thirdTeamSourceId = '';
	String? thirdTournamentSourceId = '';
	double? winPercent;

	FrontFightPbBeanEntity();

	factory FrontFightPbBeanEntity.fromJson(Map<String, dynamic> json) => $FrontFightPbBeanEntityFromJson(json);

	Map<String, dynamic> toJson() => $FrontFightPbBeanEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}