import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/playback_video_urls_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/playback_video_urls_entity.g.dart';

@JsonSerializable()
class PlaybackVideoUrlsEntity {
	late String code;
	late PlaybackVideoUrlsData data;
	late String msg;
	late int ts;

	PlaybackVideoUrlsEntity();

	factory PlaybackVideoUrlsEntity.fromJson(Map<String, dynamic> json) => $PlaybackVideoUrlsEntityFromJson(json);

	Map<String, dynamic> toJson() => $PlaybackVideoUrlsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PlaybackVideoUrlsData {
	late List<PlaybackVideoUrlsDataEventList> eventList;
	late String playBackPicUrl;
	late String playBackUrl;
	late String referUrl;
	late String serverTime;

	PlaybackVideoUrlsData();

	factory PlaybackVideoUrlsData.fromJson(Map<String, dynamic> json) => $PlaybackVideoUrlsDataFromJson(json);

	Map<String, dynamic> toJson() => $PlaybackVideoUrlsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PlaybackVideoUrlsDataEventList {
	late String ad4Sort;
	late String addition3;
	late String addition4;
	late String awayName;
	late String cid;
	dynamic createTime;
	late String eventCode;
	late String eventId;
	late String eventTime;
	late String extraInfo;
	late int firstNum;
	late String fragmentCode;
	late String fragmentId;
	late String fragmentPic;
	late String fragmentVideo;
	late String homeAway;
	late String homeName;
	late String isHomeOrAway;
	late String matchPeriodId;
	late int matchStatus;
	late String mid;
	late String roundName;
	late int secondsFromStart;
	late int t1;
	late int t2;

	PlaybackVideoUrlsDataEventList();

	factory PlaybackVideoUrlsDataEventList.fromJson(Map<String, dynamic> json) => $PlaybackVideoUrlsDataEventListFromJson(json);

	Map<String, dynamic> toJson() => $PlaybackVideoUrlsDataEventListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}