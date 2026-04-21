import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/knockout_info_bean_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/knockout_info_bean_entity.g.dart';

@JsonSerializable()
class KnockoutInfoBeanEntity {
	String? add1 = '';
	String? add2 = '';
	String? add3 = '';
	String? homeName = '';
	String? awayName = '';
	String? awayLogoUrl = '';
	String? awayNameCode = '';
	String? awayTeamId = '';
	String? createTime = '';
	String? homeLogoUrl = '';
	String? homeNameCode = '';
	String? homeTeamId = '';
	String? id = '';
	String? modifyTime = '';
	String? roundGroup = '';
	String? scores = '';
	String? sportId = '';
	String? tournamentId = '';


	String? homeScores = '';
	String? awayScores = '';


	KnockoutInfoBeanEntity();

	factory KnockoutInfoBeanEntity.fromJson(Map<String, dynamic> json) => $KnockoutInfoBeanEntityFromJson(json);

	Map<String, dynamic> toJson() => $KnockoutInfoBeanEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}