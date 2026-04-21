import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_notice_list_by_id_entity.dart';

GetNoticeListByIdEntity $GetNoticeListByIdEntityFromJson(
    Map<String, dynamic> json) {
  final GetNoticeListByIdEntity getNoticeListByIdEntity = GetNoticeListByIdEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getNoticeListByIdEntity.code = code;
  }
  final List<GetNoticeListByIdData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeListByIdData>(e) as GetNoticeListByIdData)
      .toList();
  if (data != null) {
    getNoticeListByIdEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getNoticeListByIdEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getNoticeListByIdEntity.ts = ts;
  }
  return getNoticeListByIdEntity;
}

Map<String, dynamic> $GetNoticeListByIdEntityToJson(
    GetNoticeListByIdEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetNoticeListByIdEntityExtension on GetNoticeListByIdEntity {
  GetNoticeListByIdEntity copyWith({
    String? code,
    List<GetNoticeListByIdData>? data,
    String? msg,
    int? ts,
  }) {
    return GetNoticeListByIdEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetNoticeListByIdData $GetNoticeListByIdDataFromJson(
    Map<String, dynamic> json) {
  final GetNoticeListByIdData getNoticeListByIdData = GetNoticeListByIdData();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    getNoticeListByIdData.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getNoticeListByIdData.id = id;
  }
  final dynamic isShuf = json['isShuf'];
  if (isShuf != null) {
    getNoticeListByIdData.isShuf = isShuf;
  }
  final dynamic isTop = json['isTop'];
  if (isTop != null) {
    getNoticeListByIdData.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    getNoticeListByIdData.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    getNoticeListByIdData.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    getNoticeListByIdData.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    getNoticeListByIdData.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getNoticeListByIdData.title = title;
  }
  return getNoticeListByIdData;
}

Map<String, dynamic> $GetNoticeListByIdDataToJson(
    GetNoticeListByIdData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['context'] = entity.context;
  data['id'] = entity.id;
  data['isShuf'] = entity.isShuf;
  data['isTop'] = entity.isTop;
  data['noticeType'] = entity.noticeType;
  data['noticeTypeName'] = entity.noticeTypeName;
  data['sendTime'] = entity.sendTime;
  data['sendTimeOther'] = entity.sendTimeOther;
  data['title'] = entity.title;
  return data;
}

extension GetNoticeListByIdDataExtension on GetNoticeListByIdData {
  GetNoticeListByIdData copyWith({
    String? context,
    String? id,
    dynamic isShuf,
    dynamic isTop,
    int? noticeType,
    String? noticeTypeName,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return GetNoticeListByIdData()
      ..context = context ?? this.context
      ..id = id ?? this.id
      ..isShuf = isShuf ?? this.isShuf
      ..isTop = isTop ?? this.isTop
      ..noticeType = noticeType ?? this.noticeType
      ..noticeTypeName = noticeTypeName ?? this.noticeTypeName
      ..sendTime = sendTime ?? this.sendTime
      ..sendTimeOther = sendTimeOther ?? this.sendTimeOther
      ..title = title ?? this.title;
  }
}