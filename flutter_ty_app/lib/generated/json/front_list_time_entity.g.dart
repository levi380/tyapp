import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/front_list_time_entity.dart';

FrontListTimeEntity $FrontListTimeEntityFromJson(Map<String, dynamic> json) {
  final FrontListTimeEntity frontListTimeEntity = FrontListTimeEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    frontListTimeEntity.code = code;
  }
  final FrontListTimeData? data = jsonConvert.convert<FrontListTimeData>(
      json['data']);
  if (data != null) {
    frontListTimeEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    frontListTimeEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    frontListTimeEntity.ts = ts;
  }
  return frontListTimeEntity;
}

Map<String, dynamic> $FrontListTimeEntityToJson(FrontListTimeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension FrontListTimeEntityExtension on FrontListTimeEntity {
  FrontListTimeEntity copyWith({
    String? code,
    FrontListTimeData? data,
    String? msg,
    int? ts,
  }) {
    return FrontListTimeEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

FrontListTimeData $FrontListTimeDataFromJson(Map<String, dynamic> json) {
  final FrontListTimeData frontListTimeData = FrontListTimeData();
  final List<FrontListTimeDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListTimeDataNb>(e) as FrontListTimeDataNb)
      .toList();
  if (nb != null) {
    frontListTimeData.nb = nb;
  }
  final List<FrontListTimeDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListTimeDataNt>(e) as FrontListTimeDataNt)
      .toList();
  if (nt != null) {
    frontListTimeData.nt = nt;
  }
  final List<FrontListTimeDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListTimeDataNl>(e) as FrontListTimeDataNl)
      .toList();
  if (nl != null) {
    frontListTimeData.nl = nl;
  }
  return frontListTimeData;
}

Map<String, dynamic> $FrontListTimeDataToJson(FrontListTimeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension FrontListTimeDataExtension on FrontListTimeData {
  FrontListTimeData copyWith({
    List<FrontListTimeDataNb>? nb,
    List<FrontListTimeDataNt>? nt,
    List<FrontListTimeDataNl>? nl,
  }) {
    return FrontListTimeData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

FrontListTimeDataNb $FrontListTimeDataNbFromJson(Map<String, dynamic> json) {
  final FrontListTimeDataNb frontListTimeDataNb = FrontListTimeDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListTimeDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListTimeDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListTimeDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListTimeDataNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListTimeDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListTimeDataNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListTimeDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListTimeDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListTimeDataNb.title = title;
  }
  return frontListTimeDataNb;
}

Map<String, dynamic> $FrontListTimeDataNbToJson(FrontListTimeDataNb entity) {
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

extension FrontListTimeDataNbExtension on FrontListTimeDataNb {
  FrontListTimeDataNb copyWith({
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
    return FrontListTimeDataNb()
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

FrontListTimeDataNt $FrontListTimeDataNtFromJson(Map<String, dynamic> json) {
  final FrontListTimeDataNt frontListTimeDataNt = FrontListTimeDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    frontListTimeDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    frontListTimeDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    frontListTimeDataNt.type = type;
  }
  return frontListTimeDataNt;
}

Map<String, dynamic> $FrontListTimeDataNtToJson(FrontListTimeDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension FrontListTimeDataNtExtension on FrontListTimeDataNt {
  FrontListTimeDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return FrontListTimeDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

FrontListTimeDataNl $FrontListTimeDataNlFromJson(Map<String, dynamic> json) {
  final FrontListTimeDataNl frontListTimeDataNl = FrontListTimeDataNl();
  final List<FrontListTimeDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListTimeDataNlMtl>(e) as FrontListTimeDataNlMtl)
      .toList();
  if (mtl != null) {
    frontListTimeDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    frontListTimeDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    frontListTimeDataNl.net = net;
  }
  return frontListTimeDataNl;
}

Map<String, dynamic> $FrontListTimeDataNlToJson(FrontListTimeDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension FrontListTimeDataNlExtension on FrontListTimeDataNl {
  FrontListTimeDataNl copyWith({
    List<FrontListTimeDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return FrontListTimeDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

FrontListTimeDataNlMtl $FrontListTimeDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final FrontListTimeDataNlMtl frontListTimeDataNlMtl = FrontListTimeDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListTimeDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListTimeDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListTimeDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListTimeDataNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListTimeDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListTimeDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListTimeDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListTimeDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListTimeDataNlMtl.title = title;
  }
  return frontListTimeDataNlMtl;
}

Map<String, dynamic> $FrontListTimeDataNlMtlToJson(
    FrontListTimeDataNlMtl entity) {
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

extension FrontListTimeDataNlMtlExtension on FrontListTimeDataNlMtl {
  FrontListTimeDataNlMtl copyWith({
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
    return FrontListTimeDataNlMtl()
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