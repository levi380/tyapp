import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/front_list_begin_time_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/front_list_begin_time_entity.g.dart';

@JsonSerializable()
class FrontListBeginTimeEntity {
	late String code;
	late FrontListBeginTimeData data;
	late String msg;
	late int ts;

	FrontListBeginTimeEntity();

	factory FrontListBeginTimeEntity.fromJson(Map<String, dynamic> json) => $FrontListBeginTimeEntityFromJson(json);

	Map<String, dynamic> toJson() => $FrontListBeginTimeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListBeginTimeData {
	late List<FrontListBeginTimeDataNb> nb;
	late List<FrontListBeginTimeDataNt> nt;
	late List<FrontListBeginTimeDataNl> nl;

	FrontListBeginTimeData();

	factory FrontListBeginTimeData.fromJson(Map<String, dynamic> json) => $FrontListBeginTimeDataFromJson(json);

	Map<String, dynamic> toJson() => $FrontListBeginTimeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListBeginTimeDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListBeginTimeDataNb();

	factory FrontListBeginTimeDataNb.fromJson(Map<String, dynamic> json) => $FrontListBeginTimeDataNbFromJson(json);

	Map<String, dynamic> toJson() => $FrontListBeginTimeDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListBeginTimeDataNt {
	late String enType;
	late int id;
	late String type;

	FrontListBeginTimeDataNt();

	factory FrontListBeginTimeDataNt.fromJson(Map<String, dynamic> json) => $FrontListBeginTimeDataNtFromJson(json);

	Map<String, dynamic> toJson() => $FrontListBeginTimeDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListBeginTimeDataNl {
	late List<FrontListBeginTimeDataNlMtl> mtl;
	late String nen;
	late int net;

	FrontListBeginTimeDataNl();

	factory FrontListBeginTimeDataNl.fromJson(Map<String, dynamic> json) => $FrontListBeginTimeDataNlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListBeginTimeDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListBeginTimeDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListBeginTimeDataNlMtl();

	factory FrontListBeginTimeDataNlMtl.fromJson(Map<String, dynamic> json) => $FrontListBeginTimeDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListBeginTimeDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}