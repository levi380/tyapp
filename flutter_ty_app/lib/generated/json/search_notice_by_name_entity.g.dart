import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/search_notice_by_name_entity.dart';

SearchNoticeByNameEntity $SearchNoticeByNameEntityFromJson(
    Map<String, dynamic> json) {
  final SearchNoticeByNameEntity searchNoticeByNameEntity = SearchNoticeByNameEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    searchNoticeByNameEntity.code = code;
  }
  final SearchNoticeByNameData? data = jsonConvert.convert<
      SearchNoticeByNameData>(json['data']);
  if (data != null) {
    searchNoticeByNameEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    searchNoticeByNameEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    searchNoticeByNameEntity.ts = ts;
  }
  return searchNoticeByNameEntity;
}

Map<String, dynamic> $SearchNoticeByNameEntityToJson(
    SearchNoticeByNameEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension SearchNoticeByNameEntityExtension on SearchNoticeByNameEntity {
  SearchNoticeByNameEntity copyWith({
    String? code,
    SearchNoticeByNameData? data,
    String? msg,
    int? ts,
  }) {
    return SearchNoticeByNameEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

SearchNoticeByNameData $SearchNoticeByNameDataFromJson(
    Map<String, dynamic> json) {
  final SearchNoticeByNameData searchNoticeByNameData = SearchNoticeByNameData();
  final List<dynamic>? nb = (json['nb'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (nb != null) {
    searchNoticeByNameData.nb = nb;
  }
  final List<SearchNoticeByNameDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<SearchNoticeByNameDataNt>(
          e) as SearchNoticeByNameDataNt)
      .toList();
  if (nt != null) {
    searchNoticeByNameData.nt = nt;
  }
  final List<SearchNoticeByNameDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<SearchNoticeByNameDataNl>(
          e) as SearchNoticeByNameDataNl)
      .toList();
  if (nl != null) {
    searchNoticeByNameData.nl = nl;
  }
  return searchNoticeByNameData;
}

Map<String, dynamic> $SearchNoticeByNameDataToJson(
    SearchNoticeByNameData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb;
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension SearchNoticeByNameDataExtension on SearchNoticeByNameData {
  SearchNoticeByNameData copyWith({
    List<dynamic>? nb,
    List<SearchNoticeByNameDataNt>? nt,
    List<SearchNoticeByNameDataNl>? nl,
  }) {
    return SearchNoticeByNameData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

SearchNoticeByNameDataNt $SearchNoticeByNameDataNtFromJson(
    Map<String, dynamic> json) {
  final SearchNoticeByNameDataNt searchNoticeByNameDataNt = SearchNoticeByNameDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    searchNoticeByNameDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    searchNoticeByNameDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    searchNoticeByNameDataNt.type = type;
  }
  return searchNoticeByNameDataNt;
}

Map<String, dynamic> $SearchNoticeByNameDataNtToJson(
    SearchNoticeByNameDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension SearchNoticeByNameDataNtExtension on SearchNoticeByNameDataNt {
  SearchNoticeByNameDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return SearchNoticeByNameDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

SearchNoticeByNameDataNl $SearchNoticeByNameDataNlFromJson(
    Map<String, dynamic> json) {
  final SearchNoticeByNameDataNl searchNoticeByNameDataNl = SearchNoticeByNameDataNl();
  final List<dynamic>? mtl = (json['mtl'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (mtl != null) {
    searchNoticeByNameDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    searchNoticeByNameDataNl.nen = nen;
  }
  final String? net = jsonConvert.convert<String>(json['net']);
  if (net != null) {
    searchNoticeByNameDataNl.net = net;
  }
  return searchNoticeByNameDataNl;
}

Map<String, dynamic> $SearchNoticeByNameDataNlToJson(
    SearchNoticeByNameDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl;
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension SearchNoticeByNameDataNlExtension on SearchNoticeByNameDataNl {
  SearchNoticeByNameDataNl copyWith({
    List<dynamic>? mtl,
    String? nen,
    String? net,
  }) {
    return SearchNoticeByNameDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}