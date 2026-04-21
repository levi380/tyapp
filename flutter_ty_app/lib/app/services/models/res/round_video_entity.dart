import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/round_video_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/round_video_entity.g.dart';

@JsonSerializable()
class RoundVideoEntity {
	late bool status;
	late String message;
	late String code;
	late int serverTime;
	late String msg;
	late List<RoundVideoData> data;

	RoundVideoEntity();

	factory RoundVideoEntity.fromJson(Map<String, dynamic> json) => $RoundVideoEntityFromJson(json);

	Map<String, dynamic> toJson() => $RoundVideoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class RoundVideoData {
	late String roundNo;
	late String videoPath;

	RoundVideoData();

	factory RoundVideoData.fromJson(Map<String, dynamic> json) => $RoundVideoDataFromJson(json);

	Map<String, dynamic> toJson() => $RoundVideoDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}