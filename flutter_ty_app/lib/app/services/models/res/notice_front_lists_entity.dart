import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_front_lists_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_front_lists_entity.g.dart';

@JsonSerializable()
class NoticeFrontListsEntity {
	late String code;
	late NoticeFrontListsData data;
	late String msg;
	late int ts;

	NoticeFrontListsEntity();

	factory NoticeFrontListsEntity.fromJson(Map<String, dynamic> json) => $NoticeFrontListsEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListsData {
	late List<NoticeFrontListsDataNb> nb = [];
	late List<NoticeFrontListsDataNt> nt = [];
	late List<NoticeFrontListsDataNl> nl = [];

	NoticeFrontListsData();

	factory NoticeFrontListsData.fromJson(Map<String, dynamic> json) => $NoticeFrontListsDataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListsDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListsDataNb();

	factory NoticeFrontListsDataNb.fromJson(Map<String, dynamic> json) => $NoticeFrontListsDataNbFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListsDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListsDataNt {
	late String enType;
	late int id;
	late String type;

	NoticeFrontListsDataNt();

	factory NoticeFrontListsDataNt.fromJson(Map<String, dynamic> json) => $NoticeFrontListsDataNtFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListsDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListsDataNl {
	late List<NoticeFrontListsDataNlMtl> mtl = [];
	late String nen;
	late int net;

	NoticeFrontListsDataNl();

	factory NoticeFrontListsDataNl.fromJson(Map<String, dynamic> json) => $NoticeFrontListsDataNlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListsDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeFrontListsDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeFrontListsDataNlMtl();

	factory NoticeFrontListsDataNlMtl.fromJson(Map<String, dynamic> json) => $NoticeFrontListsDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeFrontListsDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}