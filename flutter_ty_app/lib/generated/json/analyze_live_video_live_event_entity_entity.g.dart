import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';

AnalyzeLiveVideoLiveEventEntityEntity $AnalyzeLiveVideoLiveEventEntityEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeLiveVideoLiveEventEntityEntity analyzeLiveVideoLiveEventEntityEntity = AnalyzeLiveVideoLiveEventEntityEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    analyzeLiveVideoLiveEventEntityEntity.code = code;
  }
  final AnalyzeLiveVideoLiveEventEntityData? data = jsonConvert.convert<
      AnalyzeLiveVideoLiveEventEntityData>(json['data']);
  if (data != null) {
    analyzeLiveVideoLiveEventEntityEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    analyzeLiveVideoLiveEventEntityEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    analyzeLiveVideoLiveEventEntityEntity.ts = ts;
  }
  return analyzeLiveVideoLiveEventEntityEntity;
}

Map<String, dynamic> $AnalyzeLiveVideoLiveEventEntityEntityToJson(
    AnalyzeLiveVideoLiveEventEntityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension AnalyzeLiveVideoLiveEventEntityEntityExtension on AnalyzeLiveVideoLiveEventEntityEntity {
  AnalyzeLiveVideoLiveEventEntityEntity copyWith({
    String? code,
    AnalyzeLiveVideoLiveEventEntityData? data,
    String? msg,
    int? ts,
  }) {
    return AnalyzeLiveVideoLiveEventEntityEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

AnalyzeLiveVideoLiveEventEntityData $AnalyzeLiveVideoLiveEventEntityDataFromJson(
    Map<String, dynamic> json) {
  final AnalyzeLiveVideoLiveEventEntityData analyzeLiveVideoLiveEventEntityData = AnalyzeLiveVideoLiveEventEntityData();
  final List<
      AnalyzeLiveVideoLiveEventEntityDataEvents>? events = (json['events'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<AnalyzeLiveVideoLiveEventEntityDataEvents>(
          e) as AnalyzeLiveVideoLiveEventEntityDataEvents).toList();
  if (events != null) {
    analyzeLiveVideoLiveEventEntityData.events = events;
  }
  return analyzeLiveVideoLiveEventEntityData;
}

Map<String, dynamic> $AnalyzeLiveVideoLiveEventEntityDataToJson(
    AnalyzeLiveVideoLiveEventEntityData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['events'] = entity.events?.map((v) => v.toJson()).toList();
  return data;
}

extension AnalyzeLiveVideoLiveEventEntityDataExtension on AnalyzeLiveVideoLiveEventEntityData {
  AnalyzeLiveVideoLiveEventEntityData copyWith({
    List<AnalyzeLiveVideoLiveEventEntityDataEvents>? events,
  }) {
    return AnalyzeLiveVideoLiveEventEntityData()
      ..events = events ?? this.events;
  }
}

AnalyzeLiveVideoLiveEventEntityDataEvents $AnalyzeLiveVideoLiveEventEntityDataEventsFromJson(
    Map<String, dynamic> json) {
  final AnalyzeLiveVideoLiveEventEntityDataEvents analyzeLiveVideoLiveEventEntityDataEvents = AnalyzeLiveVideoLiveEventEntityDataEvents();
  final int? canceled = jsonConvert.convert<int>(json['canceled']);
  if (canceled != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.canceled = canceled;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.dataSourceCode = dataSourceCode;
  }
  final String? eventCode = jsonConvert.convert<String>(json['eventCode']);
  if (eventCode != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.eventCode = eventCode;
  }
  final String? eventTime = jsonConvert.convert<String>(json['eventTime']);
  if (eventTime != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.eventTime = eventTime;
  }
  final String? extraInfo = jsonConvert.convert<String>(json['extraInfo']);
  if (extraInfo != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.extraInfo = extraInfo;
  }
  final String? homeAway = jsonConvert.convert<String>(json['homeAway']);
  if (homeAway != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.homeAway = homeAway;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.id = id;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.imgUrl = imgUrl;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.matchPeriodId = matchPeriodId;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.modifyTime = modifyTime;
  }
  final String? player1Id = jsonConvert.convert<String>(json['player1Id']);
  if (player1Id != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.player1Id = player1Id;
  }
  final String? centerName = jsonConvert.convert<String>(json['centerName']);
  if (centerName != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.centerName = centerName;
  }
  final String? centerTopName = jsonConvert.convert<String>(
      json['centerTopName']);
  if (centerTopName != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.centerTopName = centerTopName;
  }
  final String? player1Name = jsonConvert.convert<String>(json['player1Name']);
  if (player1Name != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.player1Name = player1Name;
  }
  final String? fragmentPic = jsonConvert.convert<String>(json['fragmentPic']);
  if (fragmentPic != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.fragmentPic = fragmentPic;
  }
  final String? fragmentVideo = jsonConvert.convert<String>(
      json['fragmentVideo']);
  if (fragmentVideo != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.fragmentVideo = fragmentVideo;
  }
  final dynamic player2Id = json['player2Id'];
  if (player2Id != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.player2Id = player2Id;
  }
  final String? player2Name = jsonConvert.convert<String>(json['player2Name']);
  if (player2Name != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.player2Name = player2Name;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.remark = remark;
  }
  final String? secondsFromTart = jsonConvert.convert<String>(
      json['secondsFromTart']);
  if (secondsFromTart != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.secondsFromTart = secondsFromTart;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.sportId = sportId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.standardMatchId = standardMatchId;
  }
  final String? standardTeamId = jsonConvert.convert<String>(
      json['standardTeamId']);
  if (standardTeamId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.standardTeamId = standardTeamId;
  }
  final String? t1 = jsonConvert.convert<String>(json['t1']);
  if (t1 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.t1 = t1;
  }
  final String? t2 = jsonConvert.convert<String>(json['t2']);
  if (t2 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.t2 = t2;
  }
  final String? thirdEventId = jsonConvert.convert<String>(
      json['thirdEventId']);
  if (thirdEventId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.thirdEventId = thirdEventId;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.thirdMatchId = thirdMatchId;
  }
  final String? thirdMatchSourceId = jsonConvert.convert<String>(
      json['thirdMatchSourceId']);
  if (thirdMatchSourceId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.thirdMatchSourceId =
        thirdMatchSourceId;
  }
  final String? thirdTeamId = jsonConvert.convert<String>(json['thirdTeamId']);
  if (thirdTeamId != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.thirdTeamId = thirdTeamId;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.title = title;
  }
  final String? addition1 = jsonConvert.convert<String>(json['addition1']);
  if (addition1 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.addition1 = addition1;
  }
  final String? addition2 = jsonConvert.convert<String>(json['addition2']);
  if (addition2 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.addition2 = addition2;
  }
  final String? addition3 = jsonConvert.convert<String>(json['addition3']);
  if (addition3 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.addition3 = addition3;
  }
  final String? addition4 = jsonConvert.convert<String>(json['addition4']);
  if (addition4 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.addition4 = addition4;
  }
  final String? addition5 = jsonConvert.convert<String>(json['addition5']);
  if (addition5 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.addition5 = addition5;
  }
  final String? addition6 = jsonConvert.convert<String>(json['addition6']);
  if (addition6 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.addition6 = addition6;
  }
  final String? firstT1 = jsonConvert.convert<String>(json['firstT1']);
  if (firstT1 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.firstT1 = firstT1;
  }
  final String? firstT2 = jsonConvert.convert<String>(json['firstT2']);
  if (firstT2 != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.firstT2 = firstT2;
  }
  final dynamic updateTime = json['updateTime'];
  if (updateTime != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.updateTime = updateTime;
  }
  final String? videoUrl = jsonConvert.convert<String>(json['videoUrl']);
  if (videoUrl != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.videoUrl = videoUrl;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    analyzeLiveVideoLiveEventEntityDataEvents.type = type;
  }
  return analyzeLiveVideoLiveEventEntityDataEvents;
}

Map<String, dynamic> $AnalyzeLiveVideoLiveEventEntityDataEventsToJson(
    AnalyzeLiveVideoLiveEventEntityDataEvents entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['canceled'] = entity.canceled;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eventCode'] = entity.eventCode;
  data['eventTime'] = entity.eventTime;
  data['extraInfo'] = entity.extraInfo;
  data['homeAway'] = entity.homeAway;
  data['id'] = entity.id;
  data['imgUrl'] = entity.imgUrl;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['modifyTime'] = entity.modifyTime;
  data['player1Id'] = entity.player1Id;
  data['centerName'] = entity.centerName;
  data['centerTopName'] = entity.centerTopName;
  data['player1Name'] = entity.player1Name;
  data['fragmentPic'] = entity.fragmentPic;
  data['fragmentVideo'] = entity.fragmentVideo;
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
  data['title'] = entity.title;
  data['addition1'] = entity.addition1;
  data['addition2'] = entity.addition2;
  data['addition3'] = entity.addition3;
  data['addition4'] = entity.addition4;
  data['addition5'] = entity.addition5;
  data['addition6'] = entity.addition6;
  data['firstT1'] = entity.firstT1;
  data['firstT2'] = entity.firstT2;
  data['updateTime'] = entity.updateTime;
  data['videoUrl'] = entity.videoUrl;
  data['type'] = entity.type;
  return data;
}

extension AnalyzeLiveVideoLiveEventEntityDataEventsExtension on AnalyzeLiveVideoLiveEventEntityDataEvents {
  AnalyzeLiveVideoLiveEventEntityDataEvents copyWith({
    int? canceled,
    String? createTime,
    String? dataSourceCode,
    String? eventCode,
    String? eventTime,
    String? extraInfo,
    String? homeAway,
    String? id,
    String? imgUrl,
    String? matchPeriodId,
    String? modifyTime,
    String? player1Id,
    String? centerName,
    String? centerTopName,
    String? player1Name,
    String? fragmentPic,
    String? fragmentVideo,
    dynamic player2Id,
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
    String? title,
    String? addition1,
    String? addition2,
    String? addition3,
    String? addition4,
    String? addition5,
    String? addition6,
    String? firstT1,
    String? firstT2,
    dynamic updateTime,
    String? videoUrl,
    int? type,
  }) {
    return AnalyzeLiveVideoLiveEventEntityDataEvents()
      ..canceled = canceled ?? this.canceled
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eventCode = eventCode ?? this.eventCode
      ..eventTime = eventTime ?? this.eventTime
      ..extraInfo = extraInfo ?? this.extraInfo
      ..homeAway = homeAway ?? this.homeAway
      ..id = id ?? this.id
      ..imgUrl = imgUrl ?? this.imgUrl
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..modifyTime = modifyTime ?? this.modifyTime
      ..player1Id = player1Id ?? this.player1Id
      ..centerName = centerName ?? this.centerName
      ..centerTopName = centerTopName ?? this.centerTopName
      ..player1Name = player1Name ?? this.player1Name
      ..fragmentPic = fragmentPic ?? this.fragmentPic
      ..fragmentVideo = fragmentVideo ?? this.fragmentVideo
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
      ..title = title ?? this.title
      ..addition1 = addition1 ?? this.addition1
      ..addition2 = addition2 ?? this.addition2
      ..addition3 = addition3 ?? this.addition3
      ..addition4 = addition4 ?? this.addition4
      ..addition5 = addition5 ?? this.addition5
      ..addition6 = addition6 ?? this.addition6
      ..firstT1 = firstT1 ?? this.firstT1
      ..firstT2 = firstT2 ?? this.firstT2
      ..updateTime = updateTime ?? this.updateTime
      ..videoUrl = videoUrl ?? this.videoUrl
      ..type = type ?? this.type;
  }
}