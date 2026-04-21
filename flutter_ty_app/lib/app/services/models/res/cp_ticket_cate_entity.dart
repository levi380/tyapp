import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/cp_ticket_cate_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/cp_ticket_cate_entity.g.dart';

@JsonSerializable()
class CpTicketCateEntity {
	late String id = '';
	late List<CpTicketCateList> list = [];
	late String name = '';
	late int seriesKind = 0;

	CpTicketCateEntity();

	factory CpTicketCateEntity.fromJson(Map<String, dynamic> json) => $CpTicketCateEntityFromJson(json);

	Map<String, dynamic> toJson() => $CpTicketCateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CpTicketCateList {
	late String code = '';
	late bool isCollect = false;
	late String ticketId = '';
	late String ticketName = '';

	CpTicketCateList();

	factory CpTicketCateList.fromJson(Map<String, dynamic> json) => $CpTicketCateListFromJson(json);

	Map<String, dynamic> toJson() => $CpTicketCateListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}