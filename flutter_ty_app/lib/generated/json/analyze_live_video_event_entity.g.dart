import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_event_entity.dart';

AnalyzeLiveVideoEventEntity $AnalyzeLiveVideoEventEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeLiveVideoEventEntity analyzeLiveVideoEventEntity = AnalyzeLiveVideoEventEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    analyzeLiveVideoEventEntity.code = code;
  }
  final AnalyzeLiveVideoEventData? data = jsonConvert.convert<
      AnalyzeLiveVideoEventData>(json['data']);
  if (data != null) {
    analyzeLiveVideoEventEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    analyzeLiveVideoEventEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    analyzeLiveVideoEventEntity.ts = ts;
  }
  return analyzeLiveVideoEventEntity;
}

Map<String, dynamic> $AnalyzeLiveVideoEventEntityToJson(
    AnalyzeLiveVideoEventEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension AnalyzeLiveVideoEventEntityExtension on AnalyzeLiveVideoEventEntity {
  AnalyzeLiveVideoEventEntity copyWith({
    String? code,
    AnalyzeLiveVideoEventData? data,
    String? msg,
    int? ts,
  }) {
    return AnalyzeLiveVideoEventEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

AnalyzeLiveVideoEventData $AnalyzeLiveVideoEventDataFromJson(
    Map<String, dynamic> json) {
  final AnalyzeLiveVideoEventData analyzeLiveVideoEventData = AnalyzeLiveVideoEventData();
  final AnalyzeLiveVideoEventDataVideo? video = jsonConvert.convert<
      AnalyzeLiveVideoEventDataVideo>(json['video']);
  if (video != null) {
    analyzeLiveVideoEventData.video = video;
  }
  final List<AnalyzeLiveVideoEventDataEvents>? events = (json['events'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<AnalyzeLiveVideoEventDataEvents>(
          e) as AnalyzeLiveVideoEventDataEvents).toList();
  if (events != null) {
    analyzeLiveVideoEventData.events = events;
  }
  return analyzeLiveVideoEventData;
}

Map<String, dynamic> $AnalyzeLiveVideoEventDataToJson(
    AnalyzeLiveVideoEventData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['video'] = entity.video.toJson();
  data['events'] = entity.events.map((v) => v.toJson()).toList();
  return data;
}

extension AnalyzeLiveVideoEventDataExtension on AnalyzeLiveVideoEventData {
  AnalyzeLiveVideoEventData copyWith({
    AnalyzeLiveVideoEventDataVideo? video,
    List<AnalyzeLiveVideoEventDataEvents>? events,
  }) {
    return AnalyzeLiveVideoEventData()
      ..video = video ?? this.video
      ..events = events ?? this.events;
  }
}

AnalyzeLiveVideoEventDataVideo $AnalyzeLiveVideoEventDataVideoFromJson(
    Map<String, dynamic> json) {
  final AnalyzeLiveVideoEventDataVideo analyzeLiveVideoEventDataVideo = AnalyzeLiveVideoEventDataVideo();
  final dynamic eventList = json['eventList'];
  if (eventList != null) {
    analyzeLiveVideoEventDataVideo.eventList = eventList;
  }
  final String? playBackPicUrl = jsonConvert.convert<String>(
      json['playBackPicUrl']);
  if (playBackPicUrl != null) {
    analyzeLiveVideoEventDataVideo.playBackPicUrl = playBackPicUrl;
  }
  final String? playBackUrl = jsonConvert.convert<String>(json['playBackUrl']);
  if (playBackUrl != null) {
    analyzeLiveVideoEventDataVideo.playBackUrl = playBackUrl;
  }
  final String? referUrl = jsonConvert.convert<String>(json['referUrl']);
  if (referUrl != null) {
    analyzeLiveVideoEventDataVideo.referUrl = referUrl;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    analyzeLiveVideoEventDataVideo.serverTime = serverTime;
  }
  return analyzeLiveVideoEventDataVideo;
}

Map<String, dynamic> $AnalyzeLiveVideoEventDataVideoToJson(
    AnalyzeLiveVideoEventDataVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['eventList'] = entity.eventList;
  data['playBackPicUrl'] = entity.playBackPicUrl;
  data['playBackUrl'] = entity.playBackUrl;
  data['referUrl'] = entity.referUrl;
  data['serverTime'] = entity.serverTime;
  return data;
}

extension AnalyzeLiveVideoEventDataVideoExtension on AnalyzeLiveVideoEventDataVideo {
  AnalyzeLiveVideoEventDataVideo copyWith({
    dynamic eventList,
    String? playBackPicUrl,
    String? playBackUrl,
    String? referUrl,
    String? serverTime,
  }) {
    return AnalyzeLiveVideoEventDataVideo()
      ..eventList = eventList ?? this.eventList
      ..playBackPicUrl = playBackPicUrl ?? this.playBackPicUrl
      ..playBackUrl = playBackUrl ?? this.playBackUrl
      ..referUrl = referUrl ?? this.referUrl
      ..serverTime = serverTime ?? this.serverTime;
  }
}

AnalyzeLiveVideoEventDataEvents $AnalyzeLiveVideoEventDataEventsFromJson(
    Map<String, dynamic> json) {
  final AnalyzeLiveVideoEventDataEvents analyzeLiveVideoEventDataEvents = AnalyzeLiveVideoEventDataEvents();
  final int? canceled = jsonConvert.convert<int>(json['canceled']);
  if (canceled != null) {
    analyzeLiveVideoEventDataEvents.canceled = canceled;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    analyzeLiveVideoEventDataEvents.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    analyzeLiveVideoEventDataEvents.dataSourceCode = dataSourceCode;
  }
  final String? eventCode = jsonConvert.convert<String>(json['eventCode']);
  if (eventCode != null) {
    analyzeLiveVideoEventDataEvents.eventCode = eventCode;
  }
  final String? eventTime = jsonConvert.convert<String>(json['eventTime']);
  if (eventTime != null) {
    analyzeLiveVideoEventDataEvents.eventTime = eventTime;
  }
  final String? extraInfo = jsonConvert.convert<String>(json['extraInfo']);
  if (extraInfo != null) {
    analyzeLiveVideoEventDataEvents.extraInfo = extraInfo;
  }
  final String? homeAway = jsonConvert.convert<String>(json['homeAway']);
  if (homeAway != null) {
    analyzeLiveVideoEventDataEvents.homeAway = homeAway;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    analyzeLiveVideoEventDataEvents.id = id;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    analyzeLiveVideoEventDataEvents.matchPeriodId = matchPeriodId;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    analyzeLiveVideoEventDataEvents.modifyTime = modifyTime;
  }
  final String? player1Id = jsonConvert.convert<String>(json['player1Id']);
  if (player1Id != null) {
    analyzeLiveVideoEventDataEvents.player1Id = player1Id;
  }
  final String? player1Name = jsonConvert.convert<String>(json['player1Name']);
  if (player1Name != null) {
    analyzeLiveVideoEventDataEvents.player1Name = player1Name;
  }
  final String? player2Id = jsonConvert.convert<String>(json['player2Id']);
  if (player2Id != null) {
    analyzeLiveVideoEventDataEvents.player2Id = player2Id;
  }
  final String? player2Name = jsonConvert.convert<String>(json['player2Name']);
  if (player2Name != null) {
    analyzeLiveVideoEventDataEvents.player2Name = player2Name;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    analyzeLiveVideoEventDataEvents.remark = remark;
  }
  final String? secondsFromTart = jsonConvert.convert<String>(
      json['secondsFromTart']);
  if (secondsFromTart != null) {
    analyzeLiveVideoEventDataEvents.secondsFromTart = secondsFromTart;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    analyzeLiveVideoEventDataEvents.sportId = sportId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    analyzeLiveVideoEventDataEvents.standardMatchId = standardMatchId;
  }
  final String? standardTeamId = jsonConvert.convert<String>(
      json['standardTeamId']);
  if (standardTeamId != null) {
    analyzeLiveVideoEventDataEvents.standardTeamId = standardTeamId;
  }
  final String? t1 = jsonConvert.convert<String>(json['t1']);
  if (t1 != null) {
    analyzeLiveVideoEventDataEvents.t1 = t1;
  }
  final String? t2 = jsonConvert.convert<String>(json['t2']);
  if (t2 != null) {
    analyzeLiveVideoEventDataEvents.t2 = t2;
  }
  final String? thirdEventId = jsonConvert.convert<String>(
      json['thirdEventId']);
  if (thirdEventId != null) {
    analyzeLiveVideoEventDataEvents.thirdEventId = thirdEventId;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    analyzeLiveVideoEventDataEvents.thirdMatchId = thirdMatchId;
  }
  final String? thirdMatchSourceId = jsonConvert.convert<String>(
      json['thirdMatchSourceId']);
  if (thirdMatchSourceId != null) {
    analyzeLiveVideoEventDataEvents.thirdMatchSourceId = thirdMatchSourceId;
  }
  final String? thirdTeamId = jsonConvert.convert<String>(json['thirdTeamId']);
  if (thirdTeamId != null) {
    analyzeLiveVideoEventDataEvents.thirdTeamId = thirdTeamId;
  }
  final dynamic updateTime = json['updateTime'];
  if (updateTime != null) {
    analyzeLiveVideoEventDataEvents.updateTime = updateTime;
  }
  final String? fragmentPic = jsonConvert.convert<String>(json['fragmentPic']);
  if (fragmentPic != null) {
    analyzeLiveVideoEventDataEvents.fragmentPic = fragmentPic;
  }
  final String? fragmentVideo = jsonConvert.convert<String>(
      json['fragmentVideo']);
  if (fragmentVideo != null) {
    analyzeLiveVideoEventDataEvents.fragmentVideo = fragmentVideo;
  }
  return analyzeLiveVideoEventDataEvents;
}

Map<String, dynamic> $AnalyzeLiveVideoEventDataEventsToJson(
    AnalyzeLiveVideoEventDataEvents entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['canceled'] = entity.canceled;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eventCode'] = entity.eventCode;
  data['eventTime'] = entity.eventTime;
  data['extraInfo'] = entity.extraInfo;
  data['homeAway'] = entity.homeAway;
  data['id'] = entity.id;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['modifyTime'] = entity.modifyTime;
  data['player1Id'] = entity.player1Id;
  data['player1Name'] = entity.player1Name;
  data['player2Id'] = entity.player2Id;
  data['player2Name'] = entity.player2Name;
  data['remark'] = entity.remark;
  data['secondsFromTart'] = entity.secondsFromTart;
  data['sportId'] = entity.sportId;
  data['standardMatchId'] = entity.standardMatchId;
  data['standardTeamId'] = entity.standardTeamId;
  data['t1'] = entity.t1;
  data['t2'] = entity.t2;
  data['thirdEventId'] = entity.thirdEventId;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['thirdMatchSourceId'] = entity.thirdMatchSourceId;
  data['thirdTeamId'] = entity.thirdTeamId;
  data['updateTime'] = entity.updateTime;
  data['fragmentPic'] = entity.fragmentPic;
  data['fragmentVideo'] = entity.fragmentVideo;
  return data;
}

extension AnalyzeLiveVideoEventDataEventsExtension on AnalyzeLiveVideoEventDataEvents {
  AnalyzeLiveVideoEventDataEvents copyWith({
    int? canceled,
    String? createTime,
    String? dataSourceCode,
    String? eventCode,
    String? eventTime,
    String? extraInfo,
    String? homeAway,
    String? id,
    String? matchPeriodId,
    String? modifyTime,
    String? player1Id,
    String? player1Name,
    String? player2Id,
    String? player2Name,
    String? remark,
    String? secondsFromTart,
    int? sportId,
    String? standardMatchId,
    String? standardTeamId,
    String? t1,
    String? t2,
    String? thirdEventId,
    String? thirdMatchId,
    String? thirdMatchSourceId,
    String? thirdTeamId,
    dynamic updateTime,
    String? fragmentPic,
    String? fragmentVideo,
  }) {
    return AnalyzeLiveVideoEventDataEvents()
      ..canceled = canceled ?? this.canceled
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eventCode = eventCode ?? this.eventCode
      ..eventTime = eventTime ?? this.eventTime
      ..extraInfo = extraInfo ?? this.extraInfo
      ..homeAway = homeAway ?? this.homeAway
      ..id = id ?? this.id
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..modifyTime = modifyTime ?? this.modifyTime
      ..player1Id = player1Id ?? this.player1Id
      ..player1Name = player1Name ?? this.player1Name
      ..player2Id = player2Id ?? this.player2Id
      ..player2Name = player2Name ?? this.player2Name
      ..remark = remark ?? this.remark
      ..secondsFromTart = secondsFromTart ?? this.secondsFromTart
      ..sportId = sportId ?? this.sportId
      ..standardMatchId = standardMatchId ?? this.standardMatchId
      ..standardTeamId = standardTeamId ?? this.standardTeamId
      ..t1 = t1 ?? this.t1
      ..t2 = t2 ?? this.t2
      ..thirdEventId = thirdEventId ?? this.thirdEventId
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..thirdMatchSourceId = thirdMatchSourceId ?? this.thirdMatchSourceId
      ..thirdTeamId = thirdTeamId ?? this.thirdTeamId
      ..updateTime = updateTime ?? this.updateTime
      ..fragmentPic = fragmentPic ?? this.fragmentPic
      ..fragmentVideo = fragmentVideo ?? this.fragmentVideo;
  }
}