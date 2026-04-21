import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/query_league_template_list_entity.dart';

QueryLeagueTemplateListEntity $QueryLeagueTemplateListEntityFromJson(
    Map<String, dynamic> json) {
  final QueryLeagueTemplateListEntity queryLeagueTemplateListEntity = QueryLeagueTemplateListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    queryLeagueTemplateListEntity.code = code;
  }
  final List<QueryLeagueTemplateListData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QueryLeagueTemplateListData>(
          e) as QueryLeagueTemplateListData).toList();
  if (data != null) {
    queryLeagueTemplateListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    queryLeagueTemplateListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    queryLeagueTemplateListEntity.ts = ts;
  }
  return queryLeagueTemplateListEntity;
}

Map<String, dynamic> $QueryLeagueTemplateListEntityToJson(
    QueryLeagueTemplateListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension QueryLeagueTemplateListEntityExtension on QueryLeagueTemplateListEntity {
  QueryLeagueTemplateListEntity copyWith({
    String? code,
    List<QueryLeagueTemplateListData>? data,
    String? msg,
    int? ts,
  }) {
    return QueryLeagueTemplateListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

QueryLeagueTemplateListData $QueryLeagueTemplateListDataFromJson(
    Map<String, dynamic> json) {
  final QueryLeagueTemplateListData queryLeagueTemplateListData = QueryLeagueTemplateListData();
  final String? activityTemplateImageH5Sdk = jsonConvert.convert<String>(
      json['activityTemplateImageH5Sdk']);
  if (activityTemplateImageH5Sdk != null) {
    queryLeagueTemplateListData.activityTemplateImageH5Sdk =
        activityTemplateImageH5Sdk;
  }
  final String? activityTemplateImagePc = jsonConvert.convert<String>(
      json['activityTemplateImagePc']);
  if (activityTemplateImagePc != null) {
    queryLeagueTemplateListData.activityTemplateImagePc =
        activityTemplateImagePc;
  }
  final List<
      dynamic>? championBettingIdList = (json['championBettingIdList'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (championBettingIdList != null) {
    queryLeagueTemplateListData.championBettingIdList = championBettingIdList;
  }
  final List<String>? leagueIdList = (json['leagueIdList'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (leagueIdList != null) {
    queryLeagueTemplateListData.leagueIdList = leagueIdList;
  }
  final int? leagueTemplateId = jsonConvert.convert<int>(
      json['leagueTemplateId']);
  if (leagueTemplateId != null) {
    queryLeagueTemplateListData.leagueTemplateId = leagueTemplateId;
  }
  final String? pcSpecialPageBanner = jsonConvert.convert<String>(
      json['pcSpecialPageBanner']);
  if (pcSpecialPageBanner != null) {
    queryLeagueTemplateListData.pcSpecialPageBanner = pcSpecialPageBanner;
  }
  final int? scoreboard = jsonConvert.convert<int>(json['scoreboard']);
  if (scoreboard != null) {
    queryLeagueTemplateListData.scoreboard = scoreboard;
  }
  final List<String>? selectModules = (json['selectModules'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (selectModules != null) {
    queryLeagueTemplateListData.selectModules = selectModules;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    queryLeagueTemplateListData.sort = sort;
  }
  final int? templateStatus = jsonConvert.convert<int>(json['templateStatus']);
  if (templateStatus != null) {
    queryLeagueTemplateListData.templateStatus = templateStatus;
  }
  final String? themeColor = jsonConvert.convert<String>(json['themeColor']);
  if (themeColor != null) {
    queryLeagueTemplateListData.themeColor = themeColor;
  }
  final String? themeColorBottom = jsonConvert.convert<String>(
      json['themeColorBottom']);
  if (themeColorBottom != null) {
    queryLeagueTemplateListData.themeColorBottom = themeColorBottom;
  }
  final String? themeColorGradientEnd = jsonConvert.convert<String>(
      json['themeColorGradientEnd']);
  if (themeColorGradientEnd != null) {
    queryLeagueTemplateListData.themeColorGradientEnd = themeColorGradientEnd;
  }
  final String? themeColorGradientStart = jsonConvert.convert<String>(
      json['themeColorGradientStart']);
  if (themeColorGradientStart != null) {
    queryLeagueTemplateListData.themeColorGradientStart =
        themeColorGradientStart;
  }
  final String? themeColorTop = jsonConvert.convert<String>(
      json['themeColorTop']);
  if (themeColorTop != null) {
    queryLeagueTemplateListData.themeColorTop = themeColorTop;
  }
  final int? themeType = jsonConvert.convert<int>(json['themeType']);
  if (themeType != null) {
    queryLeagueTemplateListData.themeType = themeType;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    queryLeagueTemplateListData.tid = tid;
  }
  return queryLeagueTemplateListData;
}

Map<String, dynamic> $QueryLeagueTemplateListDataToJson(
    QueryLeagueTemplateListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['activityTemplateImageH5Sdk'] = entity.activityTemplateImageH5Sdk;
  data['activityTemplateImagePc'] = entity.activityTemplateImagePc;
  data['championBettingIdList'] = entity.championBettingIdList;
  data['leagueIdList'] = entity.leagueIdList;
  data['leagueTemplateId'] = entity.leagueTemplateId;
  data['pcSpecialPageBanner'] = entity.pcSpecialPageBanner;
  data['scoreboard'] = entity.scoreboard;
  data['selectModules'] = entity.selectModules;
  data['sort'] = entity.sort;
  data['templateStatus'] = entity.templateStatus;
  data['themeColor'] = entity.themeColor;
  data['themeColorBottom'] = entity.themeColorBottom;
  data['themeColorGradientEnd'] = entity.themeColorGradientEnd;
  data['themeColorGradientStart'] = entity.themeColorGradientStart;
  data['themeColorTop'] = entity.themeColorTop;
  data['themeType'] = entity.themeType;
  data['tid'] = entity.tid;
  return data;
}

extension QueryLeagueTemplateListDataExtension on QueryLeagueTemplateListData {
  QueryLeagueTemplateListData copyWith({
    String? activityTemplateImageH5Sdk,
    String? activityTemplateImagePc,
    List<dynamic>? championBettingIdList,
    List<String>? leagueIdList,
    int? leagueTemplateId,
    String? pcSpecialPageBanner,
    int? scoreboard,
    List<String>? selectModules,
    int? sort,
    int? templateStatus,
    String? themeColor,
    String? themeColorBottom,
    String? themeColorGradientEnd,
    String? themeColorGradientStart,
    String? themeColorTop,
    int? themeType,
    String? tid,
  }) {
    return QueryLeagueTemplateListData()
      ..activityTemplateImageH5Sdk = activityTemplateImageH5Sdk ??
          this.activityTemplateImageH5Sdk
      ..activityTemplateImagePc = activityTemplateImagePc ??
          this.activityTemplateImagePc
      ..championBettingIdList = championBettingIdList ??
          this.championBettingIdList
      ..leagueIdList = leagueIdList ?? this.leagueIdList
      ..leagueTemplateId = leagueTemplateId ?? this.leagueTemplateId
      ..pcSpecialPageBanner = pcSpecialPageBanner ?? this.pcSpecialPageBanner
      ..scoreboard = scoreboard ?? this.scoreboard
      ..selectModules = selectModules ?? this.selectModules
      ..sort = sort ?? this.sort
      ..templateStatus = templateStatus ?? this.templateStatus
      ..themeColor = themeColor ?? this.themeColor
      ..themeColorBottom = themeColorBottom ?? this.themeColorBottom
      ..themeColorGradientEnd = themeColorGradientEnd ??
          this.themeColorGradientEnd
      ..themeColorGradientStart = themeColorGradientStart ??
          this.themeColorGradientStart
      ..themeColorTop = themeColorTop ?? this.themeColorTop
      ..themeType = themeType ?? this.themeType
      ..tid = tid ?? this.tid;
  }
}