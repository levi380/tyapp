import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/save_user_info_zr_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/save_user_info_zr_entity.g.dart';

@JsonSerializable()
class SaveUserInfoZrEntity {
	late bool status;
	late String message;
	late String code;
	late SaveUserInfoZrData data;
	late int serverTime;
	late String msg;

	SaveUserInfoZrEntity();

	factory SaveUserInfoZrEntity.fromJson(Map<String, dynamic> json) => $SaveUserInfoZrEntityFromJson(json);

	Map<String, dynamic> toJson() => $SaveUserInfoZrEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SaveUserInfoZrData {
	late String timestamp;
	late String loginName;
	late List<SaveUserInfoZrDataPlayerSettingList> playerSettingList;

	SaveUserInfoZrData();

	factory SaveUserInfoZrData.fromJson(Map<String, dynamic> json) => $SaveUserInfoZrDataFromJson(json);

	Map<String, dynamic> toJson() => $SaveUserInfoZrDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SaveUserInfoZrDataPlayerSettingList {
	dynamic timestamp;
	dynamic loginName;
	dynamic playerSettingList;
	late String settingType;
	late String settingObject;
	late int deviceType;
	late String value;
	dynamic playerId;
	dynamic defaultValue;
	late bool userDefault;

	SaveUserInfoZrDataPlayerSettingList();

	factory SaveUserInfoZrDataPlayerSettingList.fromJson(Map<String, dynamic> json) => $SaveUserInfoZrDataPlayerSettingListFromJson(json);

	Map<String, dynamic> toJson() => $SaveUserInfoZrDataPlayerSettingListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}