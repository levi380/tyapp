import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/exist_match_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/exist_match_result_entity.g.dart';

@JsonSerializable()
class ExistMatchResultEntity {
	late String code;
	late ExistMatchResultData data;
	late String msg;
	late String tips;
	late String traceId;
	late int ts;

	ExistMatchResultEntity();

	factory ExistMatchResultEntity.fromJson(Map<String, dynamic> json) => $ExistMatchResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $ExistMatchResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ExistMatchResultData {
	late int matchHandicapStatus;
	late bool matchEnd;
	late bool marketResult;

	ExistMatchResultData();

	factory ExistMatchResultData.fromJson(Map<String, dynamic> json) => $ExistMatchResultDataFromJson(json);

	Map<String, dynamic> toJson() => $ExistMatchResultDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}