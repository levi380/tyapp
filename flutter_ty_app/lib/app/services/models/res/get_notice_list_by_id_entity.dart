import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_notice_list_by_id_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_notice_list_by_id_entity.g.dart';

@JsonSerializable()
class GetNoticeListByIdEntity {
	late String code;
	late List<GetNoticeListByIdData> data;
	late String msg;
	late int ts;

	GetNoticeListByIdEntity();

	factory GetNoticeListByIdEntity.fromJson(Map<String, dynamic> json) => $GetNoticeListByIdEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeListByIdEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeListByIdData {
	late String context;
	late String id;
	dynamic isShuf;
	dynamic isTop;
	late int noticeType;
	late String noticeTypeName;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	GetNoticeListByIdData();

	factory GetNoticeListByIdData.fromJson(Map<String, dynamic> json) => $GetNoticeListByIdDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeListByIdDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}