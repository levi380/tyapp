import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/player_setting_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/player_setting_list_entity.g.dart';

@JsonSerializable()
class PlayerSettingListEntity {
	late List<PlayerSettingListPlayerSettingList> playerSettingList;
	late int timestamp;

	PlayerSettingListEntity();

	factory PlayerSettingListEntity.fromJson(Map<String, dynamic> json) => $PlayerSettingListEntityFromJson(json);

	Map<String, dynamic> toJson() => $PlayerSettingListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PlayerSettingListPlayerSettingList {
	late int settingType;
	late int settingObject;
	late int deviceType;
	late int value;

	PlayerSettingListPlayerSettingList();

	factory PlayerSettingListPlayerSettingList.fromJson(Map<String, dynamic> json) => $PlayerSettingListPlayerSettingListFromJson(json);

	Map<String, dynamic> toJson() => $PlayerSettingListPlayerSettingListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}