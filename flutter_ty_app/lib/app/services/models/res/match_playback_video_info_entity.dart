import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_playback_video_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchPlaybackVideoInfoEntity {
  List<MatchPlaybackVideoInfoEntityEventList> eventList = [];
  String playBackPicUrl = "";
  String playBackUrl = "";
  String referUrl = "";
  String serverTime = "";

  MatchPlaybackVideoInfoEntity();

  factory MatchPlaybackVideoInfoEntity.fromJson(Map<String, dynamic> json) => $MatchPlaybackVideoInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $MatchPlaybackVideoInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MatchPlaybackVideoInfoEntityEventList {

	dynamic createTime;
	String? eventCode;
	String? eventId;
	String? eventTime;
	String? extraInfo;
	int? firstNum;
	String? fragmentCode;
	String? fragmentId;
	String? fragmentPic;
	String? fragmentVideo;
	String? homeAway;
	String? isHomeOrAway;
	String? matchPeriodId;
	String? mid;
	int? secondsFromStart;
	int? t1;
	int? t2;

  MatchPlaybackVideoInfoEntityEventList();

  factory MatchPlaybackVideoInfoEntityEventList.fromJson(Map<String, dynamic> json) => $MatchPlaybackVideoInfoEntityEventListFromJson(json);

  Map<String, dynamic> toJson() => $MatchPlaybackVideoInfoEntityEventListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}