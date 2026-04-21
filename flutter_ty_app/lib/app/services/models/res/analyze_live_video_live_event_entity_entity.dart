import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_live_video_live_event_entity_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/analyze_live_video_live_event_entity_entity.g.dart';

@JsonSerializable()
class AnalyzeLiveVideoLiveEventEntityEntity {
	String? code = '';
	AnalyzeLiveVideoLiveEventEntityData? data;
	String? msg = '';
	int? ts = 0;

	AnalyzeLiveVideoLiveEventEntityEntity();

	factory AnalyzeLiveVideoLiveEventEntityEntity.fromJson(Map<String, dynamic> json) => $AnalyzeLiveVideoLiveEventEntityEntityFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeLiveVideoLiveEventEntityEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeLiveVideoLiveEventEntityData {
	List<AnalyzeLiveVideoLiveEventEntityDataEvents>? events = [];

	AnalyzeLiveVideoLiveEventEntityData();

	factory AnalyzeLiveVideoLiveEventEntityData.fromJson(Map<String, dynamic> json) => $AnalyzeLiveVideoLiveEventEntityDataFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeLiveVideoLiveEventEntityDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeLiveVideoLiveEventEntityDataEvents {
	int? canceled = 0;
	String? createTime = '';
	String? dataSourceCode = '';
	String? eventCode = '';
	String? eventTime = '';
	String? extraInfo = '';
	String? homeAway = '';
	String? id = '';
	String? imgUrl = '';
	String? matchPeriodId = '';
	String? modifyTime = '';
	String? player1Id = '';
	String? centerName ;
	String? centerTopName ;
	String? player1Name = '';
	String? fragmentPic = '';
	String? fragmentVideo;
	dynamic player2Id;
	String? player2Name = '';
	String? remark = '';
	String? secondsFromTart = '';
	int? sportId = 0;
	String? standardMatchId = '';
	String? standardTeamId = '';
	String? t1 = '';
	String? t2 = '';
	String? thirdEventId = '';
	String? thirdMatchId = '';
	String? thirdMatchSourceId = '';
	String? thirdTeamId = '';
	String? title = '';
	String? addition1 = '';
	String? addition2 = '';
	String? addition3 = '';
	String? addition4 = '';
	String? addition5 = '';
	String? addition6 = '';

	String? firstT1 = '';
	String? firstT2 = '';



	dynamic updateTime;
	String? videoUrl = '';
	// 0 全部事件  1  回放事件
	int  type=0;

	AnalyzeLiveVideoLiveEventEntityDataEvents();

	factory AnalyzeLiveVideoLiveEventEntityDataEvents.fromJson(Map<String, dynamic> json) => $AnalyzeLiveVideoLiveEventEntityDataEventsFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeLiveVideoLiveEventEntityDataEventsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}