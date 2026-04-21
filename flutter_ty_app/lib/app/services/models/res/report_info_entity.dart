import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/report_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/report_info_entity.g.dart';

@JsonSerializable()
class ReportInfoEntity {
	late String msg;
	late int code;
	late ReportInfoData data;

	ReportInfoEntity();

	factory ReportInfoEntity.fromJson(Map<String, dynamic> json) => $ReportInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $ReportInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ReportInfoData {
	late String url;

	ReportInfoData();

	factory ReportInfoData.fromJson(Map<String, dynamic> json) => $ReportInfoDataFromJson(json);

	Map<String, dynamic> toJson() => $ReportInfoDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}