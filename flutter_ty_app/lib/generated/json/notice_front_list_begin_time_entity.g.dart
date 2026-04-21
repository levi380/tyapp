import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_front_list_begin_time_entity.dart';

NoticeFrontListBeginTimeEntity $NoticeFrontListBeginTimeEntityFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListBeginTimeEntity noticeFrontListBeginTimeEntity = NoticeFrontListBeginTimeEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    noticeFrontListBeginTimeEntity.code = code;
  }
  final NoticeFrontListBeginTimeData? data = jsonConvert.convert<
      NoticeFrontListBeginTimeData>(json['data']);
  if (data != null) {
    noticeFrontListBeginTimeEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    noticeFrontListBeginTimeEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    noticeFrontListBeginTimeEntity.ts = ts;
  }
  return noticeFrontListBeginTimeEntity;
}

Map<String, dynamic> $NoticeFrontListBeginTimeEntityToJson(
    NoticeFrontListBeginTimeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension NoticeFrontListBeginTimeEntityExtension on NoticeFrontListBeginTimeEntity {
  NoticeFrontListBeginTimeEntity copyWith({
    String? code,
    NoticeFrontListBeginTimeData? data,
    String? msg,
    int? ts,
  }) {
    return NoticeFrontListBeginTimeEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

NoticeFrontListBeginTimeData $NoticeFrontListBeginTimeDataFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListBeginTimeData noticeFrontListBeginTimeData = NoticeFrontListBeginTimeData();
  final List<NoticeFrontListBeginTimeDataNb>? nb = (json['nb'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListBeginTimeDataNb>(
          e) as NoticeFrontListBeginTimeDataNb).toList();
  if (nb != null) {
    noticeFrontListBeginTimeData.nb = nb;
  }
  final List<NoticeFrontListBeginTimeDataNt>? nt = (json['nt'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListBeginTimeDataNt>(
          e) as NoticeFrontListBeginTimeDataNt).toList();
  if (nt != null) {
    noticeFrontListBeginTimeData.nt = nt;
  }
  final List<NoticeFrontListBeginTimeDataNl>? nl = (json['nl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListBeginTimeDataNl>(
          e) as NoticeFrontListBeginTimeDataNl).toList();
  if (nl != null) {
    noticeFrontListBeginTimeData.nl = nl;
  }
  return noticeFrontListBeginTimeData;
}

Map<String, dynamic> $NoticeFrontListBeginTimeDataToJson(
    NoticeFrontListBeginTimeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension NoticeFrontListBeginTimeDataExtension on NoticeFrontListBeginTimeData {
  NoticeFrontListBeginTimeData copyWith({
    List<NoticeFrontListBeginTimeDataNb>? nb,
    List<NoticeFrontListBeginTimeDataNt>? nt,
    List<NoticeFrontListBeginTimeDataNl>? nl,
  }) {
    return NoticeFrontListBeginTimeData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

NoticeFrontListBeginTimeDataNb $NoticeFrontListBeginTimeDataNbFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListBeginTimeDataNb noticeFrontListBeginTimeDataNb = NoticeFrontListBeginTimeDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListBeginTimeDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListBeginTimeDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListBeginTimeDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListBeginTimeDataNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListBeginTimeDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListBeginTimeDataNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListBeginTimeDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListBeginTimeDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListBeginTimeDataNb.title = title;
  }
  return noticeFrontListBeginTimeDataNb;
}

Map<String, dynamic> $NoticeFrontListBeginTimeDataNbToJson(
    NoticeFrontListBeginTimeDataNb entity) {
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

extension NoticeFrontListBeginTimeDataNbExtension on NoticeFrontListBeginTimeDataNb {
  NoticeFrontListBeginTimeDataNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    int? noticeType,
    String? noticeTypeName,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return NoticeFrontListBeginTimeDataNb()
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

NoticeFrontListBeginTimeDataNt $NoticeFrontListBeginTimeDataNtFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListBeginTimeDataNt noticeFrontListBeginTimeDataNt = NoticeFrontListBeginTimeDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    noticeFrontListBeginTimeDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    noticeFrontListBeginTimeDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    noticeFrontListBeginTimeDataNt.type = type;
  }
  return noticeFrontListBeginTimeDataNt;
}

Map<String, dynamic> $NoticeFrontListBeginTimeDataNtToJson(
    NoticeFrontListBeginTimeDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension NoticeFrontListBeginTimeDataNtExtension on NoticeFrontListBeginTimeDataNt {
  NoticeFrontListBeginTimeDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return NoticeFrontListBeginTimeDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

NoticeFrontListBeginTimeDataNl $NoticeFrontListBeginTimeDataNlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListBeginTimeDataNl noticeFrontListBeginTimeDataNl = NoticeFrontListBeginTimeDataNl();
  final List<NoticeFrontListBeginTimeDataNlMtl>? mtl = (json['mtl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListBeginTimeDataNlMtl>(
          e) as NoticeFrontListBeginTimeDataNlMtl).toList();
  if (mtl != null) {
    noticeFrontListBeginTimeDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    noticeFrontListBeginTimeDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    noticeFrontListBeginTimeDataNl.net = net;
  }
  return noticeFrontListBeginTimeDataNl;
}

Map<String, dynamic> $NoticeFrontListBeginTimeDataNlToJson(
    NoticeFrontListBeginTimeDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension NoticeFrontListBeginTimeDataNlExtension on NoticeFrontListBeginTimeDataNl {
  NoticeFrontListBeginTimeDataNl copyWith({
    List<NoticeFrontListBeginTimeDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return NoticeFrontListBeginTimeDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

NoticeFrontListBeginTimeDataNlMtl $NoticeFrontListBeginTimeDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListBeginTimeDataNlMtl noticeFrontListBeginTimeDataNlMtl = NoticeFrontListBeginTimeDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListBeginTimeDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListBeginTimeDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListBeginTimeDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListBeginTimeDataNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListBeginTimeDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListBeginTimeDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListBeginTimeDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListBeginTimeDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListBeginTimeDataNlMtl.title = title;
  }
  return noticeFrontListBeginTimeDataNlMtl;
}

Map<String, dynamic> $NoticeFrontListBeginTimeDataNlMtlToJson(
    NoticeFrontListBeginTimeDataNlMtl entity) {
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

extension NoticeFrontListBeginTimeDataNlMtlExtension on NoticeFrontListBeginTimeDataNlMtl {
  NoticeFrontListBeginTimeDataNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    int? noticeType,
    String? noticeTypeName,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return NoticeFrontListBeginTimeDataNlMtl()
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