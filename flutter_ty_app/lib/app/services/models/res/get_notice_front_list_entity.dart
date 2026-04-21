import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_notice_front_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_notice_front_list_entity.g.dart';

@JsonSerializable()
class GetNoticeFrontListEntity {
	late String code;
	late GetNoticeFrontListData data;
	late String msg;
	late int ts;

	GetNoticeFrontListEntity();

	factory GetNoticeFrontListEntity.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListData {
	late List<GetNoticeFrontListDataNb> nb;
	late List<GetNoticeFrontListDataNt> nt;
	late List<GetNoticeFrontListDataNl> nl;

	GetNoticeFrontListData();

	factory GetNoticeFrontListData.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;
	late bool displayDate = false;

	GetNoticeFrontListDataNb();

	factory GetNoticeFrontListDataNb.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListDataNbFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListDataNt {
	late String enType;
	late int id;
	late String type;

	GetNoticeFrontListDataNt();

	factory GetNoticeFrontListDataNt.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListDataNtFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListDataNl {
	late List<GetNoticeFrontListDataNlMtl> mtl;
	late String nen;
	late String net;

	GetNoticeFrontListDataNl();

	factory GetNoticeFrontListDataNl.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListDataNlFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	GetNoticeFrontListDataNlMtl();

	factory GetNoticeFrontListDataNlMtl.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}