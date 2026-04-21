import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_front_list_entity.dart';

NoticeFrontListEntity $NoticeFrontListEntityFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListEntity noticeFrontListEntity = NoticeFrontListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    noticeFrontListEntity.code = code;
  }
  final NoticeFrontListData? data = jsonConvert.convert<NoticeFrontListData>(
      json['data']);
  if (data != null) {
    noticeFrontListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    noticeFrontListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    noticeFrontListEntity.ts = ts;
  }
  return noticeFrontListEntity;
}

Map<String, dynamic> $NoticeFrontListEntityToJson(
    NoticeFrontListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension NoticeFrontListEntityExtension on NoticeFrontListEntity {
  NoticeFrontListEntity copyWith({
    String? code,
    NoticeFrontListData? data,
    String? msg,
    int? ts,
  }) {
    return NoticeFrontListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

NoticeFrontListData $NoticeFrontListDataFromJson(Map<String, dynamic> json) {
  final NoticeFrontListData noticeFrontListData = NoticeFrontListData();
  final List<NoticeFrontListDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListDataNb>(e) as NoticeFrontListDataNb)
      .toList();
  if (nb != null) {
    noticeFrontListData.nb = nb;
  }
  final List<NoticeFrontListDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListDataNt>(e) as NoticeFrontListDataNt)
      .toList();
  if (nt != null) {
    noticeFrontListData.nt = nt;
  }
  final List<NoticeFrontListDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListDataNl>(e) as NoticeFrontListDataNl)
      .toList();
  if (nl != null) {
    noticeFrontListData.nl = nl;
  }
  return noticeFrontListData;
}

Map<String, dynamic> $NoticeFrontListDataToJson(NoticeFrontListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension NoticeFrontListDataExtension on NoticeFrontListData {
  NoticeFrontListData copyWith({
    List<NoticeFrontListDataNb>? nb,
    List<NoticeFrontListDataNt>? nt,
    List<NoticeFrontListDataNl>? nl,
  }) {
    return NoticeFrontListData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

NoticeFrontListDataNb $NoticeFrontListDataNbFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListDataNb noticeFrontListDataNb = NoticeFrontListDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListDataNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListDataNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListDataNb.title = title;
  }
  return noticeFrontListDataNb;
}

Map<String, dynamic> $NoticeFrontListDataNbToJson(
    NoticeFrontListDataNb entity) {
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

extension NoticeFrontListDataNbExtension on NoticeFrontListDataNb {
  NoticeFrontListDataNb copyWith({
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
    return NoticeFrontListDataNb()
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

NoticeFrontListDataNt $NoticeFrontListDataNtFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListDataNt noticeFrontListDataNt = NoticeFrontListDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    noticeFrontListDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    noticeFrontListDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    noticeFrontListDataNt.type = type;
  }
  return noticeFrontListDataNt;
}

Map<String, dynamic> $NoticeFrontListDataNtToJson(
    NoticeFrontListDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension NoticeFrontListDataNtExtension on NoticeFrontListDataNt {
  NoticeFrontListDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return NoticeFrontListDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

NoticeFrontListDataNl $NoticeFrontListDataNlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListDataNl noticeFrontListDataNl = NoticeFrontListDataNl();
  final List<NoticeFrontListDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeFrontListDataNlMtl>(
          e) as NoticeFrontListDataNlMtl)
      .toList();
  if (mtl != null) {
    noticeFrontListDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    noticeFrontListDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    noticeFrontListDataNl.net = net;
  }
  return noticeFrontListDataNl;
}

Map<String, dynamic> $NoticeFrontListDataNlToJson(
    NoticeFrontListDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension NoticeFrontListDataNlExtension on NoticeFrontListDataNl {
  NoticeFrontListDataNl copyWith({
    List<NoticeFrontListDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return NoticeFrontListDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

NoticeFrontListDataNlMtl $NoticeFrontListDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final NoticeFrontListDataNlMtl noticeFrontListDataNlMtl = NoticeFrontListDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeFrontListDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeFrontListDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeFrontListDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeFrontListDataNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeFrontListDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeFrontListDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeFrontListDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeFrontListDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeFrontListDataNlMtl.title = title;
  }
  return noticeFrontListDataNlMtl;
}

Map<String, dynamic> $NoticeFrontListDataNlMtlToJson(
    NoticeFrontListDataNlMtl entity) {
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

extension NoticeFrontListDataNlMtlExtension on NoticeFrontListDataNlMtl {
  NoticeFrontListDataNlMtl copyWith({
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
    return NoticeFrontListDataNlMtl()
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