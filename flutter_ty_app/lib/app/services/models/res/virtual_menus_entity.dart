import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/virtual_menus_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/virtual_menus_entity.g.dart';

@JsonSerializable()
class VirtualMenusEntity {
	late String code;
	late List<VirtualMenusData> data = [];
	late String msg;
	late int ts;

	VirtualMenusEntity();

	factory VirtualMenusEntity.fromJson(Map<String, dynamic> json) => $VirtualMenusEntityFromJson(json);

	Map<String, dynamic> toJson() => $VirtualMenusEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VirtualMenusData {
	dynamic count;
	late String field1;
	late String field2;
	late String field3;
	late String field4;
	late String menuId;
	dynamic menuType;
	late String name;
	late List<VirtualMenusDataSubList> subList;

	VirtualMenusData();

	factory VirtualMenusData.fromJson(Map<String, dynamic> json) => $VirtualMenusDataFromJson(json);

	Map<String, dynamic> toJson() => $VirtualMenusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VirtualMenusDataSubList {
	late int count;
	late String field1;
	late String field2;
	late String field3;
	late String field4;
	late String menuId;
	dynamic menuType;
	late String name;
	dynamic subList;

	VirtualMenusDataSubList();

	factory VirtualMenusDataSubList.fromJson(Map<String, dynamic> json) => $VirtualMenusDataSubListFromJson(json);

	Map<String, dynamic> toJson() => $VirtualMenusDataSubListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}