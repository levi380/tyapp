import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_base_info_entity.g.dart';
import 'dart:convert';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
export 'package:flutter_ty_app/generated/json/match_base_info_entity.g.dart';

@JsonSerializable()
class MatchBaseInfoEntity {
	late MatchBaseInfoKySwitch kySwitch = MatchBaseInfoKySwitch();
	late List<MatchEntity> list = [];

	MatchBaseInfoEntity();

	factory MatchBaseInfoEntity.fromJson(Map<String, dynamic> json) => $MatchBaseInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoKySwitch {
	late int playType = 0;
	late int isKy = 0;

	MatchBaseInfoKySwitch();

	factory MatchBaseInfoKySwitch.fromJson(Map<String, dynamic> json) => $MatchBaseInfoKySwitchFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoKySwitchToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}