import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/cp_login_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/cp_login_entity.g.dart';

@JsonSerializable()
class CpLoginEntity {
	late bool status;
	late String message;
	late String code;
	late CpLoginData data;
	late int serverTime;
	late String msg;

	CpLoginEntity();

	factory CpLoginEntity.fromJson(Map<String, dynamic> json) => $CpLoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $CpLoginEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CpLoginData {
	late String pc;
	late String h5;
	late String token;

	CpLoginData();

	factory CpLoginData.fromJson(Map<String, dynamic> json) => $CpLoginDataFromJson(json);

	Map<String, dynamic> toJson() => $CpLoginDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}