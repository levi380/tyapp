import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/front_fight_p_b_bean_entity_electronic_football_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/front_fight_p_b_bean_entity_electronic_football_entity.g.dart';

@JsonSerializable()
class FrontFightPBBeanEntityElectronicFootballEntity {
	String? away = '';
	String? awayName = '';
	String? home = '';
	String? homeName = '';
	String? mid = '';
	int? t1 = 0;
	int? t2 = 0;
	String? time = '';
	String? thirdId = '';
	FrontFightPBBeanEntityElectronicFootballEntity();

	factory FrontFightPBBeanEntityElectronicFootballEntity.fromJson(Map<String, dynamic> json) => $FrontFightPBBeanEntityElectronicFootballEntityFromJson(json);

	Map<String, dynamic> toJson() => $FrontFightPBBeanEntityElectronicFootballEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}