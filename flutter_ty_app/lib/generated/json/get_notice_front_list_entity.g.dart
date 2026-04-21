import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_notice_front_list_entity.dart';

GetNoticeFrontListEntity $GetNoticeFrontListEntityFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListEntity getNoticeFrontListEntity = GetNoticeFrontListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getNoticeFrontListEntity.code = code;
  }
  final GetNoticeFrontListData? data = jsonConvert.convert<
      GetNoticeFrontListData>(json['data']);
  if (data != null) {
    getNoticeFrontListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getNoticeFrontListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getNoticeFrontListEntity.ts = ts;
  }
  return getNoticeFrontListEntity;
}

Map<String, dynamic> $GetNoticeFrontListEntityToJson(
    GetNoticeFrontListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetNoticeFrontListEntityExtension on GetNoticeFrontListEntity {
  GetNoticeFrontListEntity copyWith({
    String? code,
    GetNoticeFrontListData? data,
    String? msg,
    int? ts,
  }) {
    return GetNoticeFrontListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetNoticeFrontListData $GetNoticeFrontListDataFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListData getNoticeFrontListData = GetNoticeFrontListData();
  final List<GetNoticeFrontListDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListDataNb>(
          e) as GetNoticeFrontListDataNb)
      .toList();
  if (nb != null) {
    getNoticeFrontListData.nb = nb;
  }
  final List<GetNoticeFrontListDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListDataNt>(
          e) as GetNoticeFrontListDataNt)
      .toList();
  if (nt != null) {
    getNoticeFrontListData.nt = nt;
  }
  final List<GetNoticeFrontListDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListDataNl>(
          e) as GetNoticeFrontListDataNl)
      .toList();
  if (nl != null) {
    getNoticeFrontListData.nl = nl;
  }
  return getNoticeFrontListData;
}

Map<String, dynamic> $GetNoticeFrontListDataToJson(
    GetNoticeFrontListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension GetNoticeFrontListDataExtension on GetNoticeFrontListData {
  GetNoticeFrontListData copyWith({
    List<GetNoticeFrontListDataNb>? nb,
    List<GetNoticeFrontListDataNt>? nt,
    List<GetNoticeFrontListDataNl>? nl,
  }) {
    return GetNoticeFrontListData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

GetNoticeFrontListDataNb $GetNoticeFrontListDataNbFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListDataNb getNoticeFrontListDataNb = GetNoticeFrontListDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    getNoticeFrontListDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getNoticeFrontListDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    getNoticeFrontListDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    getNoticeFrontListDataNb.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    getNoticeFrontListDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    getNoticeFrontListDataNb.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    getNoticeFrontListDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    getNoticeFrontListDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getNoticeFrontListDataNb.title = title;
  }
  final bool? displayDate = jsonConvert.convert<bool>(json['displayDate']);
  if (displayDate != null) {
    getNoticeFrontListDataNb.displayDate = displayDate;
  }
  return getNoticeFrontListDataNb;
}

Map<String, dynamic> $GetNoticeFrontListDataNbToJson(
    GetNoticeFrontListDataNb entity) {
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
  data['displayDate'] = entity.displayDate;
  return data;
}

extension GetNoticeFrontListDataNbExtension on GetNoticeFrontListDataNb {
  GetNoticeFrontListDataNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    int? noticeType,
    String? noticeTypeName,
    String? sendTime,
    String? sendTimeOther,
    String? title,
    bool? displayDate,
  }) {
    return GetNoticeFrontListDataNb()
      ..context = context ?? this.context
      ..id = id ?? this.id
      ..isShuf = isShuf ?? this.isShuf
      ..isTop = isTop ?? this.isTop
      ..noticeType = noticeType ?? this.noticeType
      ..noticeTypeName = noticeTypeName ?? this.noticeTypeName
      ..sendTime = sendTime ?? this.sendTime
      ..sendTimeOther = sendTimeOther ?? this.sendTimeOther
      ..title = title ?? this.title
      ..displayDate = displayDate ?? this.displayDate;
  }
}

GetNoticeFrontListDataNt $GetNoticeFrontListDataNtFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListDataNt getNoticeFrontListDataNt = GetNoticeFrontListDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    getNoticeFrontListDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getNoticeFrontListDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    getNoticeFrontListDataNt.type = type;
  }
  return getNoticeFrontListDataNt;
}

Map<String, dynamic> $GetNoticeFrontListDataNtToJson(
    GetNoticeFrontListDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension GetNoticeFrontListDataNtExtension on GetNoticeFrontListDataNt {
  GetNoticeFrontListDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return GetNoticeFrontListDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

GetNoticeFrontListDataNl $GetNoticeFrontListDataNlFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListDataNl getNoticeFrontListDataNl = GetNoticeFrontListDataNl();
  final List<GetNoticeFrontListDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListDataNlMtl>(
          e) as GetNoticeFrontListDataNlMtl)
      .toList();
  if (mtl != null) {
    getNoticeFrontListDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    getNoticeFrontListDataNl.nen = nen;
  }
  final String? net = jsonConvert.convert<String>(json['net']);
  if (net != null) {
    getNoticeFrontListDataNl.net = net;
  }
  return getNoticeFrontListDataNl;
}

Map<String, dynamic> $GetNoticeFrontListDataNlToJson(
    GetNoticeFrontListDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension GetNoticeFrontListDataNlExtension on GetNoticeFrontListDataNl {
  GetNoticeFrontListDataNl copyWith({
    List<GetNoticeFrontListDataNlMtl>? mtl,
    String? nen,
    String? net,
  }) {
    return GetNoticeFrontListDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

GetNoticeFrontListDataNlMtl $GetNoticeFrontListDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListDataNlMtl getNoticeFrontListDataNlMtl = GetNoticeFrontListDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    getNoticeFrontListDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getNoticeFrontListDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    getNoticeFrontListDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    getNoticeFrontListDataNlMtl.isTop = isTop;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    getNoticeFrontListDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    getNoticeFrontListDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    getNoticeFrontListDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    getNoticeFrontListDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getNoticeFrontListDataNlMtl.title = title;
  }
  return getNoticeFrontListDataNlMtl;
}

Map<String, dynamic> $GetNoticeFrontListDataNlMtlToJson(
    GetNoticeFrontListDataNlMtl entity) {
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

extension GetNoticeFrontListDataNlMtlExtension on GetNoticeFrontListDataNlMtl {
  GetNoticeFrontListDataNlMtl copyWith({
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
    return GetNoticeFrontListDataNlMtl()
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