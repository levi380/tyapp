import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/user_personalise_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/user_personalise_entity.g.dart';

@JsonSerializable()
class UserPersonaliseEntity {
	late String addHandicap = '';
	late String handicapType = ''; // 盘口类型,欧盘/亚盘(EU-欧盘,AS-亚盘,默认欧盘) 新增 马来、印尼、美国、英国
	late String isHk = '';
	late String playAdName = '';
	late String playAdNameCg = '';
	late String popUps = '';
	late String skinMode = '';
	late String toAccept = '';
	late String userId = '';
	late String userLanguage = '';
	late String userVersion = '';

	UserPersonaliseEntity();

	factory UserPersonaliseEntity.fromJson(Map<String, dynamic> json) => $UserPersonaliseEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserPersonaliseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}