import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_user_info_zr_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_user_info_zr_entity.g.dart';

@JsonSerializable()
class GetUserInfoZrEntity {
	late bool status = false;
	late String message = "";
	late String code = "";
	late GetUserInfoZrData data;
	late int serverTime;
	late String msg = "";

	GetUserInfoZrEntity();

	factory GetUserInfoZrEntity.fromJson(Map<String, dynamic> json) => $GetUserInfoZrEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoZrEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserInfoZrData {
	late String timestamp;
	late String loginName;
	late List<GetUserInfoZrDataPlayerSettingList> playerSettingList = [];

	GetUserInfoZrData();

	factory GetUserInfoZrData.fromJson(Map<String, dynamic> json) => $GetUserInfoZrDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoZrDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserInfoZrDataPlayerSettingList {
	dynamic timestamp;
	dynamic loginName;
	dynamic playerSettingList;
	late int settingType;
	late int settingObject;
	late int deviceType;
	late String value;
	late int playerId;
	late String defaultValue;
	late bool userDefault;

	GetUserInfoZrDataPlayerSettingList();

	factory GetUserInfoZrDataPlayerSettingList.fromJson(Map<String, dynamic> json) => $GetUserInfoZrDataPlayerSettingListFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoZrDataPlayerSettingListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}