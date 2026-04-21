import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/md_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/md_entity.g.dart';

@JsonSerializable()
class MdEntity {
	late String code;
	dynamic data;
	late String msg;
	late int ts;

	MdEntity();

	factory MdEntity.fromJson(Map<String, dynamic> json) => $MdEntityFromJson(json);

	Map<String, dynamic> toJson() => $MdEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}