import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/playback_video_urls_entity.dart';

PlaybackVideoUrlsEntity $PlaybackVideoUrlsEntityFromJson(
    Map<String, dynamic> json) {
  final PlaybackVideoUrlsEntity playbackVideoUrlsEntity = PlaybackVideoUrlsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    playbackVideoUrlsEntity.code = code;
  }
  final PlaybackVideoUrlsData? data = jsonConvert.convert<
      PlaybackVideoUrlsData>(json['data']);
  if (data != null) {
    playbackVideoUrlsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    playbackVideoUrlsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    playbackVideoUrlsEntity.ts = ts;
  }
  return playbackVideoUrlsEntity;
}

Map<String, dynamic> $PlaybackVideoUrlsEntityToJson(
    PlaybackVideoUrlsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension PlaybackVideoUrlsEntityExtension on PlaybackVideoUrlsEntity {
  PlaybackVideoUrlsEntity copyWith({
    String? code,
    PlaybackVideoUrlsData? data,
    String? msg,
    int? ts,
  }) {
    return PlaybackVideoUrlsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

PlaybackVideoUrlsData $PlaybackVideoUrlsDataFromJson(
    Map<String, dynamic> json) {
  final PlaybackVideoUrlsData playbackVideoUrlsData = PlaybackVideoUrlsData();
  final List<
      PlaybackVideoUrlsDataEventList>? eventList = (json['eventList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<PlaybackVideoUrlsDataEventList>(
          e) as PlaybackVideoUrlsDataEventList).toList();
  if (eventList != null) {
    playbackVideoUrlsData.eventList = eventList;
  }
  final String? playBackPicUrl = jsonConvert.convert<String>(
      json['playBackPicUrl']);
  if (playBackPicUrl != null) {
    playbackVideoUrlsData.playBackPicUrl = playBackPicUrl;
  }
  final String? playBackUrl = jsonConvert.convert<String>(json['playBackUrl']);
  if (playBackUrl != null) {
    playbackVideoUrlsData.playBackUrl = playBackUrl;
  }
  final String? referUrl = jsonConvert.convert<String>(json['referUrl']);
  if (referUrl != null) {
    playbackVideoUrlsData.referUrl = referUrl;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    playbackVideoUrlsData.serverTime = serverTime;
  }
  return playbackVideoUrlsData;
}

Map<String, dynamic> $PlaybackVideoUrlsDataToJson(
    PlaybackVideoUrlsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['eventList'] = entity.eventList.map((v) => v.toJson()).toList();
  data['playBackPicUrl'] = entity.playBackPicUrl;
  data['playBackUrl'] = entity.playBackUrl;
  data['referUrl'] = entity.referUrl;
  data['serverTime'] = entity.serverTime;
  return data;
}

extension PlaybackVideoUrlsDataExtension on PlaybackVideoUrlsData {
  PlaybackVideoUrlsData copyWith({
    List<PlaybackVideoUrlsDataEventList>? eventList,
    String? playBackPicUrl,
    String? playBackUrl,
    String? referUrl,
    String? serverTime,
  }) {
    return PlaybackVideoUrlsData()
      ..eventList = eventList ?? this.eventList
      ..playBackPicUrl = playBackPicUrl ?? this.playBackPicUrl
      ..playBackUrl = playBackUrl ?? this.playBackUrl
      ..referUrl = referUrl ?? this.referUrl
      ..serverTime = serverTime ?? this.serverTime;
  }
}

PlaybackVideoUrlsDataEventList $PlaybackVideoUrlsDataEventListFromJson(
    Map<String, dynamic> json) {
  final PlaybackVideoUrlsDataEventList playbackVideoUrlsDataEventList = PlaybackVideoUrlsDataEventList();
  final String? ad4Sort = jsonConvert.convert<String>(json['ad4Sort']);
  if (ad4Sort != null) {
    playbackVideoUrlsDataEventList.ad4Sort = ad4Sort;
  }
  final String? addition3 = jsonConvert.convert<String>(json['addition3']);
  if (addition3 != null) {
    playbackVideoUrlsDataEventList.addition3 = addition3;
  }
  final String? addition4 = jsonConvert.convert<String>(json['addition4']);
  if (addition4 != null) {
    playbackVideoUrlsDataEventList.addition4 = addition4;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    playbackVideoUrlsDataEventList.awayName = awayName;
  }
  final String? cid = jsonConvert.convert<String>(json['cid']);
  if (cid != null) {
    playbackVideoUrlsDataEventList.cid = cid;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    playbackVideoUrlsDataEventList.createTime = createTime;
  }
  final String? eventCode = jsonConvert.convert<String>(json['eventCode']);
  if (eventCode != null) {
    playbackVideoUrlsDataEventList.eventCode = eventCode;
  }
  final String? eventId = jsonConvert.convert<String>(json['eventId']);
  if (eventId != null) {
    playbackVideoUrlsDataEventList.eventId = eventId;
  }
  final String? eventTime = jsonConvert.convert<String>(json['eventTime']);
  if (eventTime != null) {
    playbackVideoUrlsDataEventList.eventTime = eventTime;
  }
  final String? extraInfo = jsonConvert.convert<String>(json['extraInfo']);
  if (extraInfo != null) {
    playbackVideoUrlsDataEventList.extraInfo = extraInfo;
  }
  final int? firstNum = jsonConvert.convert<int>(json['firstNum']);
  if (firstNum != null) {
    playbackVideoUrlsDataEventList.firstNum = firstNum;
  }
  final String? fragmentCode = jsonConvert.convert<String>(
      json['fragmentCode']);
  if (fragmentCode != null) {
    playbackVideoUrlsDataEventList.fragmentCode = fragmentCode;
  }
  final String? fragmentId = jsonConvert.convert<String>(json['fragmentId']);
  if (fragmentId != null) {
    playbackVideoUrlsDataEventList.fragmentId = fragmentId;
  }
  final String? fragmentPic = jsonConvert.convert<String>(json['fragmentPic']);
  if (fragmentPic != null) {
    playbackVideoUrlsDataEventList.fragmentPic = fragmentPic;
  }
  final String? fragmentVideo = jsonConvert.convert<String>(
      json['fragmentVideo']);
  if (fragmentVideo != null) {
    playbackVideoUrlsDataEventList.fragmentVideo = fragmentVideo;
  }
  final String? homeAway = jsonConvert.convert<String>(json['homeAway']);
  if (homeAway != null) {
    playbackVideoUrlsDataEventList.homeAway = homeAway;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    playbackVideoUrlsDataEventList.homeName = homeName;
  }
  final String? isHomeOrAway = jsonConvert.convert<String>(
      json['isHomeOrAway']);
  if (isHomeOrAway != null) {
    playbackVideoUrlsDataEventList.isHomeOrAway = isHomeOrAway;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    playbackVideoUrlsDataEventList.matchPeriodId = matchPeriodId;
  }
  final int? matchStatus = jsonConvert.convert<int>(json['matchStatus']);
  if (matchStatus != null) {
    playbackVideoUrlsDataEventList.matchStatus = matchStatus;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    playbackVideoUrlsDataEventList.mid = mid;
  }
  final String? roundName = jsonConvert.convert<String>(json['roundName']);
  if (roundName != null) {
    playbackVideoUrlsDataEventList.roundName = roundName;
  }
  final int? secondsFromStart = jsonConvert.convert<int>(
      json['secondsFromStart']);
  if (secondsFromStart != null) {
    playbackVideoUrlsDataEventList.secondsFromStart = secondsFromStart;
  }
  final int? t1 = jsonConvert.convert<int>(json['t1']);
  if (t1 != null) {
    playbackVideoUrlsDataEventList.t1 = t1;
  }
  final int? t2 = jsonConvert.convert<int>(json['t2']);
  if (t2 != null) {
    playbackVideoUrlsDataEventList.t2 = t2;
  }
  return playbackVideoUrlsDataEventList;
}

Map<String, dynamic> $PlaybackVideoUrlsDataEventListToJson(
    PlaybackVideoUrlsDataEventList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ad4Sort'] = entity.ad4Sort;
  data['addition3'] = entity.addition3;
  data['addition4'] = entity.addition4;
  data['awayName'] = entity.awayName;
  data['cid'] = entity.cid;
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
  data['homeName'] = entity.homeName;
  data['isHomeOrAway'] = entity.isHomeOrAway;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchStatus'] = entity.matchStatus;
  data['mid'] = entity.mid;
  data['roundName'] = entity.roundName;
  data['secondsFromStart'] = entity.secondsFromStart;
  data['t1'] = entity.t1;
  data['t2'] = entity.t2;
  return data;
}

extension PlaybackVideoUrlsDataEventListExtension on PlaybackVideoUrlsDataEventList {
  PlaybackVideoUrlsDataEventList copyWith({
    String? ad4Sort,
    String? addition3,
    String? addition4,
    String? awayName,
    String? cid,
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
    String? homeName,
    String? isHomeOrAway,
    String? matchPeriodId,
    int? matchStatus,
    String? mid,
    String? roundName,
    int? secondsFromStart,
    int? t1,
    int? t2,
  }) {
    return PlaybackVideoUrlsDataEventList()
      ..ad4Sort = ad4Sort ?? this.ad4Sort
      ..addition3 = addition3 ?? this.addition3
      ..addition4 = addition4 ?? this.addition4
      ..awayName = awayName ?? this.awayName
      ..cid = cid ?? this.cid
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
      ..homeName = homeName ?? this.homeName
      ..isHomeOrAway = isHomeOrAway ?? this.isHomeOrAway
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchStatus = matchStatus ?? this.matchStatus
      ..mid = mid ?? this.mid
      ..roundName = roundName ?? this.roundName
      ..secondsFromStart = secondsFromStart ?? this.secondsFromStart
      ..t1 = t1 ?? this.t1
      ..t2 = t2 ?? this.t2;
  }
}