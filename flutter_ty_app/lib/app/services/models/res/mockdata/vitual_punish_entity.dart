import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vitual_punish_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/vitual_punish_entity.g.dart';

@JsonSerializable()
class VitualPunishEntity {
	late String code;
	late List<VitualPunishData> data;
	late String msg;
	late int ts;

	VitualPunishEntity();

	factory VitualPunishEntity.fromJson(Map<String, dynamic> json) => $VitualPunishEntityFromJson(json);

	Map<String, dynamic> toJson() => $VitualPunishEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VitualPunishData {
	late String marketName;
	late int orderNo;
	late List<int> plays;
	late String id;
	late String label;

	VitualPunishData();

	factory VitualPunishData.fromJson(Map<String, dynamic> json) => $VitualPunishDataFromJson(json);

	Map<String, dynamic> toJson() => $VitualPunishDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}