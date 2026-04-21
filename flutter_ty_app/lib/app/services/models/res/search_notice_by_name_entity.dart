import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/search_notice_by_name_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/search_notice_by_name_entity.g.dart';

@JsonSerializable()
class SearchNoticeByNameEntity {
	late String code;
	late SearchNoticeByNameData data;
	late String msg;
	late int ts;

	SearchNoticeByNameEntity();

	factory SearchNoticeByNameEntity.fromJson(Map<String, dynamic> json) => $SearchNoticeByNameEntityFromJson(json);

	Map<String, dynamic> toJson() => $SearchNoticeByNameEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SearchNoticeByNameData {
	late List<dynamic> nb;
	late List<SearchNoticeByNameDataNt> nt;
	late List<SearchNoticeByNameDataNl> nl;

	SearchNoticeByNameData();

	factory SearchNoticeByNameData.fromJson(Map<String, dynamic> json) => $SearchNoticeByNameDataFromJson(json);

	Map<String, dynamic> toJson() => $SearchNoticeByNameDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SearchNoticeByNameDataNt {
	late String enType;
	late int id;
	late String type;

	SearchNoticeByNameDataNt();

	factory SearchNoticeByNameDataNt.fromJson(Map<String, dynamic> json) => $SearchNoticeByNameDataNtFromJson(json);

	Map<String, dynamic> toJson() => $SearchNoticeByNameDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SearchNoticeByNameDataNl {
	late List<dynamic> mtl;
	late String nen;
	late String net;

	SearchNoticeByNameDataNl();

	factory SearchNoticeByNameDataNl.fromJson(Map<String, dynamic> json) => $SearchNoticeByNameDataNlFromJson(json);

	Map<String, dynamic> toJson() => $SearchNoticeByNameDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}