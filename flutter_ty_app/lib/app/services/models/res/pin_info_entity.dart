import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/pin_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/pin_info_entity.g.dart';

@JsonSerializable()
class PinInfoEntity {
	late List<String> tIds = [];
	late List<String> mIds = [];
	late List<String> cMids = [];

	PinInfoEntity();

	factory PinInfoEntity.fromJson(Map<String, dynamic> json) => $PinInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $PinInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}