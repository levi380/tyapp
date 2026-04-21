import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_front_list_notice_type_entity.dart';

NoticeFrontListNoticeTypeEntity $NoticeFrontListNoticeTypeEntityFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListNoticeTypeEntity noticeFrontListNoticeTypeEntity = NoticeFrontListNoticeTypeEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    noticeFrontListNoticeTypeEntity.code = code;
  }
  final NoticeFrontListNoticeTypeData? data = jsonConvert.convert<
      NoticeFrontListNoticeTypeData>(json['data']);
  if (data != null) {
    noticeFrontListNoticeTypeEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    noticeFrontListNoticeTypeEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    noticeFrontListNoticeTypeEntity.ts = ts;
  }
  return noticeFrontListNoticeTypeEntity;
}

Map<String, dynamic> $NoticeFrontListNoticeTypeEntityToJson(
    NoticeFrontListNoticeTypeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension NoticeFrontListNoticeTypeEntityExtension on NoticeFrontListNoticeTypeEntity {
  NoticeFrontListNoticeTypeEntity copyWith({
    String? code,
    NoticeFrontListNoticeTypeData? data,
    String? msg,
    int? ts,
  }) {
    return NoticeFrontListNoticeTypeEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

NoticeFrontListNoticeTypeData $NoticeFrontListNoticeTypeDataFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListNoticeTypeData noticeFrontListNoticeTypeData = NoticeFrontListNoticeTypeData();
  final List<NoticeFrontListNoticeTypeDataNb>? nb = (json['nb'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListNoticeTypeDataNb>(
          e) as NoticeFrontListNoticeTypeDataNb).toList();
  if (nb != null) {
    noticeFrontListNoticeTypeData.nb = nb;
  }
  final List<NoticeFrontListNoticeTypeDataNt>? nt = (json['nt'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListNoticeTypeDataNt>(
          e) as NoticeFrontListNoticeTypeDataNt).toList();
  if (nt != null) {
    noticeFrontListNoticeTypeData.nt = nt;
  }
  final List<NoticeFrontListNoticeTypeDataNl>? nl = (json['nl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListNoticeTypeDataNl>(
          e) as NoticeFrontListNoticeTypeDataNl).toList();
  if (nl != null) {
    noticeFrontListNoticeTypeData.nl = nl;
  }
  return noticeFrontListNoticeTypeData;
}

Map<String, dynamic> $NoticeFrontListNoticeTypeDataToJson(
    NoticeFrontListNoticeTypeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension NoticeFrontListNoticeTypeDataExtension on NoticeFrontListNoticeTypeData {
  NoticeFrontListNoticeTypeData copyWith({
    List<NoticeFrontListNoticeTypeDataNb>? nb,
    List<NoticeFrontListNoticeTypeDataNt>? nt,
    List<NoticeFrontListNoticeTypeDataNl>? nl,
  }) {
    return NoticeFrontListNoticeTypeData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

NoticeFrontListNoticeTypeDataNb $NoticeFrontListNoticeTypeDataNbFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListNoticeTypeDataNb noticeFrontListNoticeTypeDataNb = NoticeFrontListNoticeTypeDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListNoticeTypeDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListNoticeTypeDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListNoticeTypeDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListNoticeTypeDataNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListNoticeTypeDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListNoticeTypeDataNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListNoticeTypeDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListNoticeTypeDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListNoticeTypeDataNb.title = title;
  }
  return noticeFrontListNoticeTypeDataNb;
}

Map<String, dynamic> $NoticeFrontListNoticeTypeDataNbToJson(
    NoticeFrontListNoticeTypeDataNb entity) {
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

extension NoticeFrontListNoticeTypeDataNbExtension on NoticeFrontListNoticeTypeDataNb {
  NoticeFrontListNoticeTypeDataNb copyWith({
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
    return NoticeFrontListNoticeTypeDataNb()
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

NoticeFrontListNoticeTypeDataNt $NoticeFrontListNoticeTypeDataNtFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListNoticeTypeDataNt noticeFrontListNoticeTypeDataNt = NoticeFrontListNoticeTypeDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    noticeFrontListNoticeTypeDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    noticeFrontListNoticeTypeDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    noticeFrontListNoticeTypeDataNt.type = type;
  }
  return noticeFrontListNoticeTypeDataNt;
}

Map<String, dynamic> $NoticeFrontListNoticeTypeDataNtToJson(
    NoticeFrontListNoticeTypeDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension NoticeFrontListNoticeTypeDataNtExtension on NoticeFrontListNoticeTypeDataNt {
  NoticeFrontListNoticeTypeDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return NoticeFrontListNoticeTypeDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

NoticeFrontListNoticeTypeDataNl $NoticeFrontListNoticeTypeDataNlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListNoticeTypeDataNl noticeFrontListNoticeTypeDataNl = NoticeFrontListNoticeTypeDataNl();
  final List<NoticeFrontListNoticeTypeDataNlMtl>? mtl = (json['mtl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListNoticeTypeDataNlMtl>(
          e) as NoticeFrontListNoticeTypeDataNlMtl).toList();
  if (mtl != null) {
    noticeFrontListNoticeTypeDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    noticeFrontListNoticeTypeDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    noticeFrontListNoticeTypeDataNl.net = net;
  }
  return noticeFrontListNoticeTypeDataNl;
}

Map<String, dynamic> $NoticeFrontListNoticeTypeDataNlToJson(
    NoticeFrontListNoticeTypeDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension NoticeFrontListNoticeTypeDataNlExtension on NoticeFrontListNoticeTypeDataNl {
  NoticeFrontListNoticeTypeDataNl copyWith({
    List<NoticeFrontListNoticeTypeDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return NoticeFrontListNoticeTypeDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

NoticeFrontListNoticeTypeDataNlMtl $NoticeFrontListNoticeTypeDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListNoticeTypeDataNlMtl noticeFrontListNoticeTypeDataNlMtl = NoticeFrontListNoticeTypeDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListNoticeTypeDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListNoticeTypeDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListNoticeTypeDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListNoticeTypeDataNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListNoticeTypeDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListNoticeTypeDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListNoticeTypeDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListNoticeTypeDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListNoticeTypeDataNlMtl.title = title;
  }
  return noticeFrontListNoticeTypeDataNlMtl;
}

Map<String, dynamic> $NoticeFrontListNoticeTypeDataNlMtlToJson(
    NoticeFrontListNoticeTypeDataNlMtl entity) {
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

extension NoticeFrontListNoticeTypeDataNlMtlExtension on NoticeFrontListNoticeTypeDataNlMtl {
  NoticeFrontListNoticeTypeDataNlMtl copyWith({
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
    return NoticeFrontListNoticeTypeDataNlMtl()
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