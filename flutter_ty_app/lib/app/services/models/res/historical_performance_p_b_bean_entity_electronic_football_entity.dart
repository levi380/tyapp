import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/historical_performance_p_b_bean_entity_electronic_football_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/historical_performance_p_b_bean_entity_electronic_football_entity.g.dart';

@JsonSerializable()
class HistoricalPerformancePBBeanEntityElectronicFootballEntity {
	List<int>? summary = [];
	String? awayName = '';
	List<int>? away = [];
	double? homeAvg;
	String? flag = '';
	String? mhlu = '';
	double? awayAvg;
	String? homeName = '';
	String? team = '';
	double? summaryAvg;
	String? malu = '';

	List<int>? home = [];

	HistoricalPerformancePBBeanEntityElectronicFootballEntity();

	factory HistoricalPerformancePBBeanEntityElectronicFootballEntity.fromJson(Map<String, dynamic> json) => $HistoricalPerformancePBBeanEntityElectronicFootballEntityFromJson(json);

	Map<String, dynamic> toJson() => $HistoricalPerformancePBBeanEntityElectronicFootballEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}