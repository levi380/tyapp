import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/front_list_time_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/front_list_time_entity.g.dart';

@JsonSerializable()
class FrontListTimeEntity {
	late String code;
	late FrontListTimeData data;
	late String msg;
	late int ts;

	FrontListTimeEntity();

	factory FrontListTimeEntity.fromJson(Map<String, dynamic> json) => $FrontListTimeEntityFromJson(json);

	Map<String, dynamic> toJson() => $FrontListTimeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListTimeData {
	late List<FrontListTimeDataNb> nb;
	late List<FrontListTimeDataNt> nt;
	late List<FrontListTimeDataNl> nl;

	FrontListTimeData();

	factory FrontListTimeData.fromJson(Map<String, dynamic> json) => $FrontListTimeDataFromJson(json);

	Map<String, dynamic> toJson() => $FrontListTimeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListTimeDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListTimeDataNb();

	factory FrontListTimeDataNb.fromJson(Map<String, dynamic> json) => $FrontListTimeDataNbFromJson(json);

	Map<String, dynamic> toJson() => $FrontListTimeDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListTimeDataNt {
	late String enType;
	late int id;
	late String type;

	FrontListTimeDataNt();

	factory FrontListTimeDataNt.fromJson(Map<String, dynamic> json) => $FrontListTimeDataNtFromJson(json);

	Map<String, dynamic> toJson() => $FrontListTimeDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListTimeDataNl {
	late List<FrontListTimeDataNlMtl> mtl;
	late String nen;
	late int net;

	FrontListTimeDataNl();

	factory FrontListTimeDataNl.fromJson(Map<String, dynamic> json) => $FrontListTimeDataNlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListTimeDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListTimeDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListTimeDataNlMtl();

	factory FrontListTimeDataNlMtl.fromJson(Map<String, dynamic> json) => $FrontListTimeDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListTimeDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}