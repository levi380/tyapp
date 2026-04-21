import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vr_menus_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/vr_menus_entity.g.dart';

@JsonSerializable()
class VrMenusEntity {
	late String code;
	late List<VrMenusData> data;
	late String msg;
	late int ts;

	VrMenusEntity();

	factory VrMenusEntity.fromJson(Map<String, dynamic> json) => $VrMenusEntityFromJson(json);

	Map<String, dynamic> toJson() => $VrMenusEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VrMenusData {
	dynamic count;
	late String field1;
	late String field2;
	late String field3;
	late String field4;
	late String menuId;
	dynamic menuType;
	late String name;
	late List<VrMenusDataSubList> subList;

	VrMenusData();

	factory VrMenusData.fromJson(Map<String, dynamic> json) => $VrMenusDataFromJson(json);

	Map<String, dynamic> toJson() => $VrMenusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VrMenusDataSubList {
	late int count;
	late String field1;
	late String field2;
	late String field3;
	late String field4;
	late String menuId;
	dynamic menuType;
	late String name;
	dynamic subList;

	VrMenusDataSubList();

	factory VrMenusDataSubList.fromJson(Map<String, dynamic> json) => $VrMenusDataSubListFromJson(json);

	Map<String, dynamic> toJson() => $VrMenusDataSubListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}