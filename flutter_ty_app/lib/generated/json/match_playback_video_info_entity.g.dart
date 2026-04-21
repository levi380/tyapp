import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_playback_video_info_entity.dart';

MatchPlaybackVideoInfoEntity $MatchPlaybackVideoInfoEntityFromJson(
    Map<String, dynamic> json) {
  final MatchPlaybackVideoInfoEntity matchPlaybackVideoInfoEntity = MatchPlaybackVideoInfoEntity();
  final List<
      MatchPlaybackVideoInfoEntityEventList>? eventList = (json['eventList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchPlaybackVideoInfoEntityEventList>(
          e) as MatchPlaybackVideoInfoEntityEventList).toList();
  if (eventList != null) {
    matchPlaybackVideoInfoEntity.eventList = eventList;
  }
  final String? playBackPicUrl = jsonConvert.convert<String>(
      json['playBackPicUrl']);
  if (playBackPicUrl != null) {
    matchPlaybackVideoInfoEntity.playBackPicUrl = playBackPicUrl;
  }
  final String? playBackUrl = jsonConvert.convert<String>(json['playBackUrl']);
  if (playBackUrl != null) {
    matchPlaybackVideoInfoEntity.playBackUrl = playBackUrl;
  }
  final String? referUrl = jsonConvert.convert<String>(json['referUrl']);
  if (referUrl != null) {
    matchPlaybackVideoInfoEntity.referUrl = referUrl;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    matchPlaybackVideoInfoEntity.serverTime = serverTime;
  }
  return matchPlaybackVideoInfoEntity;
}

Map<String, dynamic> $MatchPlaybackVideoInfoEntityToJson(
    MatchPlaybackVideoInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['eventList'] = entity.eventList.map((v) => v.toJson()).toList();
  data['playBackPicUrl'] = entity.playBackPicUrl;
  data['playBackUrl'] = entity.playBackUrl;
  data['referUrl'] = entity.referUrl;
  data['serverTime'] = entity.serverTime;
  return data;
}

extension MatchPlaybackVideoInfoEntityExtension on MatchPlaybackVideoInfoEntity {
  MatchPlaybackVideoInfoEntity copyWith({
    List<MatchPlaybackVideoInfoEntityEventList>? eventList,
    String? playBackPicUrl,
    String? playBackUrl,
    String? referUrl,
    String? serverTime,
  }) {
    return MatchPlaybackVideoInfoEntity()
      ..eventList = eventList ?? this.eventList
      ..playBackPicUrl = playBackPicUrl ?? this.playBackPicUrl
      ..playBackUrl = playBackUrl ?? this.playBackUrl
      ..referUrl = referUrl ?? this.referUrl
      ..serverTime = serverTime ?? this.serverTime;
  }
}

MatchPlaybackVideoInfoEntityEventList $MatchPlaybackVideoInfoEntityEventListFromJson(
    Map<String, dynamic> json) {
  final MatchPlaybackVideoInfoEntityEventList matchPlaybackVideoInfoEntityEventList = MatchPlaybackVideoInfoEntityEventList();
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    matchPlaybackVideoInfoEntityEventList.createTime = createTime;
  }
  final String? eventCode = jsonConvert.convert<String>(json['eventCode']);
  if (eventCode != null) {
    matchPlaybackVideoInfoEntityEventList.eventCode = eventCode;
  }
  final String? eventId = jsonConvert.convert<String>(json['eventId']);
  if (eventId != null) {
    matchPlaybackVideoInfoEntityEventList.eventId = eventId;
  }
  final String? eventTime = jsonConvert.convert<String>(json['eventTime']);
  if (eventTime != null) {
    matchPlaybackVideoInfoEntityEventList.eventTime = eventTime;
  }
  final String? extraInfo = jsonConvert.convert<String>(json['extraInfo']);
  if (extraInfo != null) {
    matchPlaybackVideoInfoEntityEventList.extraInfo = extraInfo;
  }
  final int? firstNum = jsonConvert.convert<int>(json['firstNum']);
  if (firstNum != null) {
    matchPlaybackVideoInfoEntityEventList.firstNum = firstNum;
  }
  final String? fragmentCode = jsonConvert.convert<String>(
      json['fragmentCode']);
  if (fragmentCode != null) {
    matchPlaybackVideoInfoEntityEventList.fragmentCode = fragmentCode;
  }
  final String? fragmentId = jsonConvert.convert<String>(json['fragmentId']);
  if (fragmentId != null) {
    matchPlaybackVideoInfoEntityEventList.fragmentId = fragmentId;
  }
  final String? fragmentPic = jsonConvert.convert<String>(json['fragmentPic']);
  if (fragmentPic != null) {
    matchPlaybackVideoInfoEntityEventList.fragmentPic = fragmentPic;
  }
  final String? fragmentVideo = jsonConvert.convert<String>(
      json['fragmentVideo']);
  if (fragmentVideo != null) {
    matchPlaybackVideoInfoEntityEventList.fragmentVideo = fragmentVideo;
  }
  final String? homeAway = jsonConvert.convert<String>(json['homeAway']);
  if (homeAway != null) {
    matchPlaybackVideoInfoEntityEventList.homeAway = homeAway;
  }
  final String? isHomeOrAway = jsonConvert.convert<String>(
      json['isHomeOrAway']);
  if (isHomeOrAway != null) {
    matchPlaybackVideoInfoEntityEventList.isHomeOrAway = isHomeOrAway;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    matchPlaybackVideoInfoEntityEventList.matchPeriodId = matchPeriodId;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchPlaybackVideoInfoEntityEventList.mid = mid;
  }
  final int? secondsFromStart = jsonConvert.convert<int>(
      json['secondsFromStart']);
  if (secondsFromStart != null) {
    matchPlaybackVideoInfoEntityEventList.secondsFromStart = secondsFromStart;
  }
  final int? t1 = jsonConvert.convert<int>(json['t1']);
  if (t1 != null) {
    matchPlaybackVideoInfoEntityEventList.t1 = t1;
  }
  final int? t2 = jsonConvert.convert<int>(json['t2']);
  if (t2 != null) {
    matchPlaybackVideoInfoEntityEventList.t2 = t2;
  }
  return matchPlaybackVideoInfoEntityEventList;
}

Map<String, dynamic> $MatchPlaybackVideoInfoEntityEventListToJson(
    MatchPlaybackVideoInfoEntityEventList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createTime'] = entity.createTime;
  data['eventCode'] = entity.eventCode;
  data['eventId'] = entity.eventId;
  data['eventTime'] = entity.eventTime;
  data['extraInfo'] = entity.extraInfo;
  data['firstNum'] = entity.firstNum;
  data['fragmentCode'] = entity.fragmentCode;
  data['fragmentId'] = entity.fragmentId;
  data['fragmentPic'] = entity.fragmentPic;
  data['fragmentVideo'] = entity.fragmentVideo;
  data['homeAway'] = entity.homeAway;
  data['isHomeOrAway'] = entity.isHomeOrAway;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['mid'] = entity.mid;
  data['secondsFromStart'] = entity.secondsFromStart;
  data['t1'] = entity.t1;
  data['t2'] = entity.t2;
  return data;
}

extension MatchPlaybackVideoInfoEntityEventListExtension on MatchPlaybackVideoInfoEntityEventList {
  MatchPlaybackVideoInfoEntityEventList copyWith({
    dynamic createTime,
    String? eventCode,
    String? eventId,
    String? eventTime,
    String? extraInfo,
    int? firstNum,
    String? fragmentCode,
    String? fragmentId,
    String? fragmentPic,
    String? fragmentVideo,
    String? homeAway,
    String? isHomeOrAway,
    String? matchPeriodId,
    String? mid,
    int? secondsFromStart,
    int? t1,
    int? t2,
  }) {
    return MatchPlaybackVideoInfoEntityEventList()
      ..createTime = createTime ?? this.createTime
      ..eventCode = eventCode ?? this.eventCode
      ..eventId = eventId ?? this.eventId
      ..eventTime = eventTime ?? this.eventTime
      ..extraInfo = extraInfo ?? this.extraInfo
      ..firstNum = firstNum ?? this.firstNum
      ..fragmentCode = fragmentCode ?? this.fragmentCode
      ..fragmentId = fragmentId ?? this.fragmentId
      ..fragmentPic = fragmentPic ?? this.fragmentPic
      ..fragmentVideo = fragmentVideo ?? this.fragmentVideo
      ..homeAway = homeAway ?? this.homeAway
      ..isHomeOrAway = isHomeOrAway ?? this.isHomeOrAway
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..mid = mid ?? this.mid
      ..secondsFromStart = secondsFromStart ?? this.secondsFromStart
      ..t1 = t1 ?? this.t1
      ..t2 = t2 ?? this.t2;
  }
}