import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_live_video_event_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/analyze_live_video_event_entity.g.dart';

@JsonSerializable()
class AnalyzeLiveVideoEventEntity {
	late String code;
	late AnalyzeLiveVideoEventData data;
	late String msg;
	late int ts;

	AnalyzeLiveVideoEventEntity();

	factory AnalyzeLiveVideoEventEntity.fromJson(Map<String, dynamic> json) => $AnalyzeLiveVideoEventEntityFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeLiveVideoEventEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeLiveVideoEventData {
	late AnalyzeLiveVideoEventDataVideo video;
	late List<AnalyzeLiveVideoEventDataEvents> events;

	AnalyzeLiveVideoEventData();

	factory AnalyzeLiveVideoEventData.fromJson(Map<String, dynamic> json) => $AnalyzeLiveVideoEventDataFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeLiveVideoEventDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeLiveVideoEventDataVideo {
	dynamic eventList;
	late String playBackPicUrl;
	late String playBackUrl;
	late String referUrl;
	late String serverTime;

	AnalyzeLiveVideoEventDataVideo();

	factory AnalyzeLiveVideoEventDataVideo.fromJson(Map<String, dynamic> json) => $AnalyzeLiveVideoEventDataVideoFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeLiveVideoEventDataVideoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeLiveVideoEventDataEvents {
	late int canceled;
	late String createTime;
	late String dataSourceCode;
	late String eventCode;
	late String eventTime;
	late String extraInfo;
	late String homeAway;
	late String id;
	late String matchPeriodId;
	late String modifyTime;
	late String player1Id;
	late String player1Name;
	late String player2Id;
	late String player2Name;
	late String remark;
	late String secondsFromTart;
	late int sportId;
	late String standardMatchId;
	late String standardTeamId;
	late String t1;
	late String t2;
	late String thirdEventId;
	late String thirdMatchId;
	late String thirdMatchSourceId;
	late String thirdTeamId;
	dynamic updateTime;

	 String? fragmentPic;
	 String? fragmentVideo;

	AnalyzeLiveVideoEventDataEvents();

	factory AnalyzeLiveVideoEventDataEvents.fromJson(Map<String, dynamic> json) => $AnalyzeLiveVideoEventDataEventsFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeLiveVideoEventDataEventsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}