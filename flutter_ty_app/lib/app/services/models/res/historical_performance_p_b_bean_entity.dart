import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/historical_performance_p_b_bean_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/historical_performance_p_b_bean_entity.g.dart';

@JsonSerializable()
class HistoricalPerformancePBBeanEntity {
	double? averageGoal;
	double? averageGoalPercent;
	double? bothGoalPercent;
	String? createTime = '';
	String? teamLogo='';
	List<int>? name2=[];
	String? name4='';
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

	HistoricalPerformancePBBeanEntity();

	factory HistoricalPerformancePBBeanEntity.fromJson(Map<String, dynamic> json) => $HistoricalPerformancePBBeanEntityFromJson(json);

	Map<String, dynamic> toJson() => $HistoricalPerformancePBBeanEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}