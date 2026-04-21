import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/virtualmenus_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/virtualmenus_entity.g.dart';

@JsonSerializable()
class VirtualmenusEntity {
	late String code;
	late List<VirtualmenusData> data;
	late String msg;
	late int ts;

	VirtualmenusEntity();

	factory VirtualmenusEntity.fromJson(Map<String, dynamic> json) => $VirtualmenusEntityFromJson(json);

	Map<String, dynamic> toJson() => $VirtualmenusEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VirtualmenusData {
	dynamic count;
	late String field1;
	late String field2;
	late String field3;
	late String field4;
	late String menuId;
	dynamic menuType;
	late String name;
	late List<VirtualmenusDataSubList> subList;

	VirtualmenusData();

	factory VirtualmenusData.fromJson(Map<String, dynamic> json) => $VirtualmenusDataFromJson(json);

	Map<String, dynamic> toJson() => $VirtualmenusDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VirtualmenusDataSubList {
	late int count;
	late String field1;
	late String field2;
	late String field3;
	late String field4;
	late String menuId;
	dynamic menuType;
	late String name;
	dynamic subList;

	VirtualmenusDataSubList();

	factory VirtualmenusDataSubList.fromJson(Map<String, dynamic> json) => $VirtualmenusDataSubListFromJson(json);

	Map<String, dynamic> toJson() => $VirtualmenusDataSubListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}