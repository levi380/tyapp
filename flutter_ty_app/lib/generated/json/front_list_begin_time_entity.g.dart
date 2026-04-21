import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/front_list_begin_time_entity.dart';

FrontListBeginTimeEntity $FrontListBeginTimeEntityFromJson(
    Map<String, dynamic> json) {
  final FrontListBeginTimeEntity frontListBeginTimeEntity = FrontListBeginTimeEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    frontListBeginTimeEntity.code = code;
  }
  final FrontListBeginTimeData? data = jsonConvert.convert<
      FrontListBeginTimeData>(json['data']);
  if (data != null) {
    frontListBeginTimeEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    frontListBeginTimeEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    frontListBeginTimeEntity.ts = ts;
  }
  return frontListBeginTimeEntity;
}

Map<String, dynamic> $FrontListBeginTimeEntityToJson(
    FrontListBeginTimeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension FrontListBeginTimeEntityExtension on FrontListBeginTimeEntity {
  FrontListBeginTimeEntity copyWith({
    String? code,
    FrontListBeginTimeData? data,
    String? msg,
    int? ts,
  }) {
    return FrontListBeginTimeEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

FrontListBeginTimeData $FrontListBeginTimeDataFromJson(
    Map<String, dynamic> json) {
  final FrontListBeginTimeData frontListBeginTimeData = FrontListBeginTimeData();
  final List<FrontListBeginTimeDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListBeginTimeDataNb>(
          e) as FrontListBeginTimeDataNb)
      .toList();
  if (nb != null) {
    frontListBeginTimeData.nb = nb;
  }
  final List<FrontListBeginTimeDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListBeginTimeDataNt>(
          e) as FrontListBeginTimeDataNt)
      .toList();
  if (nt != null) {
    frontListBeginTimeData.nt = nt;
  }
  final List<FrontListBeginTimeDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListBeginTimeDataNl>(
          e) as FrontListBeginTimeDataNl)
      .toList();
  if (nl != null) {
    frontListBeginTimeData.nl = nl;
  }
  return frontListBeginTimeData;
}

Map<String, dynamic> $FrontListBeginTimeDataToJson(
    FrontListBeginTimeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension FrontListBeginTimeDataExtension on FrontListBeginTimeData {
  FrontListBeginTimeData copyWith({
    List<FrontListBeginTimeDataNb>? nb,
    List<FrontListBeginTimeDataNt>? nt,
    List<FrontListBeginTimeDataNl>? nl,
  }) {
    return FrontListBeginTimeData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

FrontListBeginTimeDataNb $FrontListBeginTimeDataNbFromJson(
    Map<String, dynamic> json) {
  final FrontListBeginTimeDataNb frontListBeginTimeDataNb = FrontListBeginTimeDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListBeginTimeDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListBeginTimeDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListBeginTimeDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListBeginTimeDataNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListBeginTimeDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListBeginTimeDataNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListBeginTimeDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListBeginTimeDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListBeginTimeDataNb.title = title;
  }
  return frontListBeginTimeDataNb;
}

Map<String, dynamic> $FrontListBeginTimeDataNbToJson(
    FrontListBeginTimeDataNb entity) {
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

extension FrontListBeginTimeDataNbExtension on FrontListBeginTimeDataNb {
  FrontListBeginTimeDataNb copyWith({
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
    return FrontListBeginTimeDataNb()
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

FrontListBeginTimeDataNt $FrontListBeginTimeDataNtFromJson(
    Map<String, dynamic> json) {
  final FrontListBeginTimeDataNt frontListBeginTimeDataNt = FrontListBeginTimeDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    frontListBeginTimeDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    frontListBeginTimeDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    frontListBeginTimeDataNt.type = type;
  }
  return frontListBeginTimeDataNt;
}

Map<String, dynamic> $FrontListBeginTimeDataNtToJson(
    FrontListBeginTimeDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension FrontListBeginTimeDataNtExtension on FrontListBeginTimeDataNt {
  FrontListBeginTimeDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return FrontListBeginTimeDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

FrontListBeginTimeDataNl $FrontListBeginTimeDataNlFromJson(
    Map<String, dynamic> json) {
  final FrontListBeginTimeDataNl frontListBeginTimeDataNl = FrontListBeginTimeDataNl();
  final List<FrontListBeginTimeDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListBeginTimeDataNlMtl>(
          e) as FrontListBeginTimeDataNlMtl)
      .toList();
  if (mtl != null) {
    frontListBeginTimeDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    frontListBeginTimeDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    frontListBeginTimeDataNl.net = net;
  }
  return frontListBeginTimeDataNl;
}

Map<String, dynamic> $FrontListBeginTimeDataNlToJson(
    FrontListBeginTimeDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension FrontListBeginTimeDataNlExtension on FrontListBeginTimeDataNl {
  FrontListBeginTimeDataNl copyWith({
    List<FrontListBeginTimeDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return FrontListBeginTimeDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

FrontListBeginTimeDataNlMtl $FrontListBeginTimeDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final FrontListBeginTimeDataNlMtl frontListBeginTimeDataNlMtl = FrontListBeginTimeDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListBeginTimeDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListBeginTimeDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListBeginTimeDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListBeginTimeDataNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListBeginTimeDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListBeginTimeDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListBeginTimeDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListBeginTimeDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListBeginTimeDataNlMtl.title = title;
  }
  return frontListBeginTimeDataNlMtl;
}

Map<String, dynamic> $FrontListBeginTimeDataNlMtlToJson(
    FrontListBeginTimeDataNlMtl entity) {
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

extension FrontListBeginTimeDataNlMtlExtension on FrontListBeginTimeDataNlMtl {
  FrontListBeginTimeDataNlMtl copyWith({
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
    return FrontListBeginTimeDataNlMtl()
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