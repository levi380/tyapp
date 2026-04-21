import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_user_personalise_new_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_user_personalise_new_entity.g.dart';

@JsonSerializable()
class GetUserPersonaliseNewEntity {
	int? uid = 0;
		List<GetUserPersonaliseNewUserPersonaliseNewList>? userPersonaliseNewList = [];

	GetUserPersonaliseNewEntity();

	factory GetUserPersonaliseNewEntity.fromJson(Map<String, dynamic> json) => $GetUserPersonaliseNewEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserPersonaliseNewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserPersonaliseNewUserPersonaliseNewList {
	int? uid = 0;
	String? paramKey = '';
	String? paramValue = '';
	String? cp = '';

	GetUserPersonaliseNewUserPersonaliseNewList();

	factory GetUserPersonaliseNewUserPersonaliseNewList.fromJson(Map<String, dynamic> json) => $GetUserPersonaliseNewUserPersonaliseNewListFromJson(json);

	Map<String, dynamic> toJson() => $GetUserPersonaliseNewUserPersonaliseNewListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}