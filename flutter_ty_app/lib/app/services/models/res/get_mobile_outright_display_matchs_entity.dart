import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_mobile_outright_display_matchs_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_mobile_outright_display_matchs_entity.g.dart';

@JsonSerializable()
class GetMobileOutrightDisplayMatchsEntity {
	late String code;
	dynamic data;
	late String msg;
	late int ts;

	GetMobileOutrightDisplayMatchsEntity();

	factory GetMobileOutrightDisplayMatchsEntity.fromJson(Map<String, dynamic> json) => $GetMobileOutrightDisplayMatchsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetMobileOutrightDisplayMatchsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}