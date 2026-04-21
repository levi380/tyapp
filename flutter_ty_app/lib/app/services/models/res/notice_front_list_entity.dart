import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_front_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_front_list_entity.g.dart';

@JsonSerializable()
class NoticeFrontListEntity {
	late String code;
	late NoticeFrontListData data;
	late String msg;
	late int ts;

	NoticeFrontListEntity();

	factory NoticeFrontListEntity.fromJson(Map<String, dynamic> json) => $NoticeFrontListEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListData {
	late List<NoticeFrontListDataNb> nb = [];
	late List<NoticeFrontListDataNt> nt = [];
	late List<NoticeFrontListDataNl> nl = [];

	NoticeFrontListData();

	factory NoticeFrontListData.fromJson(Map<String, dynamic> json) => $NoticeFrontListDataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListDataNb();

	factory NoticeFrontListDataNb.fromJson(Map<String, dynamic> json) => $NoticeFrontListDataNbFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListDataNt {
	late String enType;
	late int id;
	late String type;

	NoticeFrontListDataNt();

	factory NoticeFrontListDataNt.fromJson(Map<String, dynamic> json) => $NoticeFrontListDataNtFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListDataNl {
	late List<NoticeFrontListDataNlMtl> mtl = [];
	late String nen;
	late int net;

	NoticeFrontListDataNl();

	factory NoticeFrontListDataNl.fromJson(Map<String, dynamic> json) => $NoticeFrontListDataNlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListDataNlMtl();

	factory NoticeFrontListDataNlMtl.fromJson(Map<String, dynamic> json) => $NoticeFrontListDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}