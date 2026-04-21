import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_front_list_begin_time_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_front_list_begin_time_entity.g.dart';

@JsonSerializable()
class NoticeFrontListBeginTimeEntity {
	late String code;
	late NoticeFrontListBeginTimeData data;
	late String msg;
	late int ts;

	NoticeFrontListBeginTimeEntity();

	factory NoticeFrontListBeginTimeEntity.fromJson(Map<String, dynamic> json) => $NoticeFrontListBeginTimeEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListBeginTimeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListBeginTimeData {
	late List<NoticeFrontListBeginTimeDataNb> nb = [];
	late List<NoticeFrontListBeginTimeDataNt> nt = [];
	late List<NoticeFrontListBeginTimeDataNl> nl = [];

	NoticeFrontListBeginTimeData();

	factory NoticeFrontListBeginTimeData.fromJson(Map<String, dynamic> json) => $NoticeFrontListBeginTimeDataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListBeginTimeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListBeginTimeDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListBeginTimeDataNb();

	factory NoticeFrontListBeginTimeDataNb.fromJson(Map<String, dynamic> json) => $NoticeFrontListBeginTimeDataNbFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListBeginTimeDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListBeginTimeDataNt {
	late String enType;
	late int id;
	late String type;

	NoticeFrontListBeginTimeDataNt();

	factory NoticeFrontListBeginTimeDataNt.fromJson(Map<String, dynamic> json) => $NoticeFrontListBeginTimeDataNtFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListBeginTimeDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListBeginTimeDataNl {
	late List<NoticeFrontListBeginTimeDataNlMtl> mtl = [];
	late String nen;
	late int net;

	NoticeFrontListBeginTimeDataNl();

	factory NoticeFrontListBeginTimeDataNl.fromJson(Map<String, dynamic> json) => $NoticeFrontListBeginTimeDataNlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListBeginTimeDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListBeginTimeDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListBeginTimeDataNlMtl();

	factory NoticeFrontListBeginTimeDataNlMtl.fromJson(Map<String, dynamic> json) => $NoticeFrontListBeginTimeDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListBeginTimeDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}