import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_front_list_notice_type_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_front_list_notice_type_entity.g.dart';

@JsonSerializable()
class NoticeFrontListNoticeTypeEntity {
	late String code;
	late NoticeFrontListNoticeTypeData data;
	late String msg;
	late int ts;

	NoticeFrontListNoticeTypeEntity();

	factory NoticeFrontListNoticeTypeEntity.fromJson(Map<String, dynamic> json) => $NoticeFrontListNoticeTypeEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListNoticeTypeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListNoticeTypeData {
	late List<NoticeFrontListNoticeTypeDataNb> nb = [];
	late List<NoticeFrontListNoticeTypeDataNt> nt = [];
	late List<NoticeFrontListNoticeTypeDataNl> nl = [];

	NoticeFrontListNoticeTypeData();

	factory NoticeFrontListNoticeTypeData.fromJson(Map<String, dynamic> json) => $NoticeFrontListNoticeTypeDataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListNoticeTypeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListNoticeTypeDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListNoticeTypeDataNb();

	factory NoticeFrontListNoticeTypeDataNb.fromJson(Map<String, dynamic> json) => $NoticeFrontListNoticeTypeDataNbFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListNoticeTypeDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListNoticeTypeDataNt {
	late String enType;
	late int id;
	late String type;

	NoticeFrontListNoticeTypeDataNt();

	factory NoticeFrontListNoticeTypeDataNt.fromJson(Map<String, dynamic> json) => $NoticeFrontListNoticeTypeDataNtFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListNoticeTypeDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListNoticeTypeDataNl {
	late List<NoticeFrontListNoticeTypeDataNlMtl> mtl = [];
	late String nen;
	late int net;

	NoticeFrontListNoticeTypeDataNl();

	factory NoticeFrontListNoticeTypeDataNl.fromJson(Map<String, dynamic> json) => $NoticeFrontListNoticeTypeDataNlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListNoticeTypeDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListNoticeTypeDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListNoticeTypeDataNlMtl();

	factory NoticeFrontListNoticeTypeDataNlMtl.fromJson(Map<String, dynamic> json) => $NoticeFrontListNoticeTypeDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListNoticeTypeDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}