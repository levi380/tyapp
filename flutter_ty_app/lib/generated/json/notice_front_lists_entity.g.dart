import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_front_lists_entity.dart';

NoticeFrontListsEntity $NoticeFrontListsEntityFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListsEntity noticeFrontListsEntity = NoticeFrontListsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    noticeFrontListsEntity.code = code;
  }
  final NoticeFrontListsData? data = jsonConvert.convert<NoticeFrontListsData>(
      json['data']);
  if (data != null) {
    noticeFrontListsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    noticeFrontListsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    noticeFrontListsEntity.ts = ts;
  }
  return noticeFrontListsEntity;
}

Map<String, dynamic> $NoticeFrontListsEntityToJson(
    NoticeFrontListsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension NoticeFrontListsEntityExtension on NoticeFrontListsEntity {
  NoticeFrontListsEntity copyWith({
    String? code,
    NoticeFrontListsData? data,
    String? msg,
    int? ts,
  }) {
    return NoticeFrontListsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

NoticeFrontListsData $NoticeFrontListsDataFromJson(Map<String, dynamic> json) {
  final NoticeFrontListsData noticeFrontListsData = NoticeFrontListsData();
  final List<NoticeFrontListsDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListsDataNb>(e) as NoticeFrontListsDataNb)
      .toList();
  if (nb != null) {
    noticeFrontListsData.nb = nb;
  }
  final List<NoticeFrontListsDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListsDataNt>(e) as NoticeFrontListsDataNt)
      .toList();
  if (nt != null) {
    noticeFrontListsData.nt = nt;
  }
  final List<NoticeFrontListsDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListsDataNl>(e) as NoticeFrontListsDataNl)
      .toList();
  if (nl != null) {
    noticeFrontListsData.nl = nl;
  }
  return noticeFrontListsData;
}

Map<String, dynamic> $NoticeFrontListsDataToJson(NoticeFrontListsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension NoticeFrontListsDataExtension on NoticeFrontListsData {
  NoticeFrontListsData copyWith({
    List<NoticeFrontListsDataNb>? nb,
    List<NoticeFrontListsDataNt>? nt,
    List<NoticeFrontListsDataNl>? nl,
  }) {
    return NoticeFrontListsData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

NoticeFrontListsDataNb $NoticeFrontListsDataNbFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListsDataNb noticeFrontListsDataNb = NoticeFrontListsDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListsDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListsDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListsDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListsDataNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListsDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListsDataNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListsDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListsDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListsDataNb.title = title;
  }
  return noticeFrontListsDataNb;
}

Map<String, dynamic> $NoticeFrontListsDataNbToJson(
    NoticeFrontListsDataNb entity) {
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

extension NoticeFrontListsDataNbExtension on NoticeFrontListsDataNb {
  NoticeFrontListsDataNb copyWith({
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
    return NoticeFrontListsDataNb()
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

NoticeFrontListsDataNt $NoticeFrontListsDataNtFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListsDataNt noticeFrontListsDataNt = NoticeFrontListsDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    noticeFrontListsDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    noticeFrontListsDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    noticeFrontListsDataNt.type = type;
  }
  return noticeFrontListsDataNt;
}

Map<String, dynamic> $NoticeFrontListsDataNtToJson(
    NoticeFrontListsDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension NoticeFrontListsDataNtExtension on NoticeFrontListsDataNt {
  NoticeFrontListsDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return NoticeFrontListsDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

NoticeFrontListsDataNl $NoticeFrontListsDataNlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListsDataNl noticeFrontListsDataNl = NoticeFrontListsDataNl();
  final List<NoticeFrontListsDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListsDataNlMtl>(
          e) as NoticeFrontListsDataNlMtl)
      .toList();
  if (mtl != null) {
    noticeFrontListsDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    noticeFrontListsDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    noticeFrontListsDataNl.net = net;
  }
  return noticeFrontListsDataNl;
}

Map<String, dynamic> $NoticeFrontListsDataNlToJson(
    NoticeFrontListsDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension NoticeFrontListsDataNlExtension on NoticeFrontListsDataNl {
  NoticeFrontListsDataNl copyWith({
    List<NoticeFrontListsDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return NoticeFrontListsDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

NoticeFrontListsDataNlMtl $NoticeFrontListsDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListsDataNlMtl noticeFrontListsDataNlMtl = NoticeFrontListsDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListsDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListsDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListsDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListsDataNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListsDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListsDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListsDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListsDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListsDataNlMtl.title = title;
  }
  return noticeFrontListsDataNlMtl;
}

Map<String, dynamic> $NoticeFrontListsDataNlMtlToJson(
    NoticeFrontListsDataNlMtl entity) {
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

extension NoticeFrontListsDataNlMtlExtension on NoticeFrontListsDataNlMtl {
  NoticeFrontListsDataNlMtl copyWith({
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
    return NoticeFrontListsDataNlMtl()
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