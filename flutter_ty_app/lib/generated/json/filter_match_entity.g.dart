import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/filter_match_entity.dart';

FilterMatchEntity $FilterMatchEntityFromJson(Map<String, dynamic> json) {
  final FilterMatchEntity filterMatchEntity = FilterMatchEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    filterMatchEntity.code = code;
  }
  final List<FilterMatchData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<FilterMatchData>(e) as FilterMatchData)
      .toList();
  if (data != null) {
    filterMatchEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    filterMatchEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    filterMatchEntity.ts = ts;
  }
  return filterMatchEntity;
}

Map<String, dynamic> $FilterMatchEntityToJson(FilterMatchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension FilterMatchEntityExtension on FilterMatchEntity {
  FilterMatchEntity copyWith({
    String? code,
    List<FilterMatchData>? data,
    String? msg,
    int? ts,
  }) {
    return FilterMatchEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

FilterMatchData $FilterMatchDataFromJson(Map<String, dynamic> json) {
  final FilterMatchData filterMatchData = FilterMatchData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    filterMatchData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    filterMatchData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    filterMatchData.introduction = introduction;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    filterMatchData.spell = spell;
  }
  final List<FilterMatchDataSportVOs>? sportVOs = (json['sportVOs'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FilterMatchDataSportVOs>(
          e) as FilterMatchDataSportVOs).toList();
  if (sportVOs != null) {
    filterMatchData.sportVOs = sportVOs;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    filterMatchData.zh = zh;
  }
  return filterMatchData;
}

Map<String, dynamic> $FilterMatchDataToJson(FilterMatchData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['en'] = entity.en;
  data['id'] = entity.id;
  data['introduction'] = entity.introduction;
  data['spell'] = entity.spell;
  data['sportVOs'] = entity.sportVOs.map((v) => v.toJson()).toList();
  data['zh'] = entity.zh;
  return data;
}

extension FilterMatchDataExtension on FilterMatchData {
  FilterMatchData copyWith({
    String? en,
    String? id,
    String? introduction,
    String? spell,
    List<FilterMatchDataSportVOs>? sportVOs,
    String? zh,
  }) {
    return FilterMatchData()
      ..en = en ?? this.en
      ..id = id ?? this.id
      ..introduction = introduction ?? this.introduction
      ..spell = spell ?? this.spell
      ..sportVOs = sportVOs ?? this.sportVOs
      ..zh = zh ?? this.zh;
  }
}

FilterMatchDataSportVOs $FilterMatchDataSportVOsFromJson(
    Map<String, dynamic> json) {
  final FilterMatchDataSportVOs filterMatchDataSportVOs = FilterMatchDataSportVOs();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    filterMatchDataSportVOs.id = id;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    filterMatchDataSportVOs.nameText = nameText;
  }
  final int? orderNum = jsonConvert.convert<int>(json['orderNum']);
  if (orderNum != null) {
    filterMatchDataSportVOs.orderNum = orderNum;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    filterMatchDataSportVOs.spell = spell;
  }
  final List<
      FilterMatchDataSportVOsTournamentList>? tournamentList = (json['tournamentList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FilterMatchDataSportVOsTournamentList>(
          e) as FilterMatchDataSportVOsTournamentList).toList();
  if (tournamentList != null) {
    filterMatchDataSportVOs.tournamentList = tournamentList;
  }
  return filterMatchDataSportVOs;
}

Map<String, dynamic> $FilterMatchDataSportVOsToJson(
    FilterMatchDataSportVOs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['nameText'] = entity.nameText;
  data['orderNum'] = entity.orderNum;
  data['spell'] = entity.spell;
  data['tournamentList'] =
      entity.tournamentList.map((v) => v.toJson()).toList();
  return data;
}

extension FilterMatchDataSportVOsExtension on FilterMatchDataSportVOs {
  FilterMatchDataSportVOs copyWith({
    String? id,
    String? nameText,
    int? orderNum,
    String? spell,
    List<FilterMatchDataSportVOsTournamentList>? tournamentList,
  }) {
    return FilterMatchDataSportVOs()
      ..id = id ?? this.id
      ..nameText = nameText ?? this.nameText
      ..orderNum = orderNum ?? this.orderNum
      ..spell = spell ?? this.spell
      ..tournamentList = tournamentList ?? this.tournamentList;
  }
}

FilterMatchDataSportVOsTournamentList $FilterMatchDataSportVOsTournamentListFromJson(
    Map<String, dynamic> json) {
  final FilterMatchDataSportVOsTournamentList filterMatchDataSportVOsTournamentList = FilterMatchDataSportVOsTournamentList();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    filterMatchDataSportVOsTournamentList.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    filterMatchDataSportVOsTournamentList.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    filterMatchDataSportVOsTournamentList.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    filterMatchDataSportVOsTournamentList.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    filterMatchDataSportVOsTournamentList.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    filterMatchDataSportVOsTournamentList.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    filterMatchDataSportVOsTournamentList.regionId = regionId;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    filterMatchDataSportVOsTournamentList.sportId = sportId;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    filterMatchDataSportVOsTournamentList.tnjc = tnjc;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    filterMatchDataSportVOsTournamentList.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    filterMatchDataSportVOsTournamentList.tournamentLevel = tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    filterMatchDataSportVOsTournamentList.tournamentName = tournamentName;
  }
  return filterMatchDataSportVOsTournamentList;
}

Map<String, dynamic> $FilterMatchDataSportVOsTournamentListToJson(
    FilterMatchDataSportVOsTournamentList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hotStatus'] = entity.hotStatus;
  data['id'] = entity.id;
  data['nameCode'] = entity.nameCode;
  data['nameText'] = entity.nameText;
  data['num'] = entity.num;
  data['picUrlthumb'] = entity.picUrlthumb;
  data['regionId'] = entity.regionId;
  data['sportId'] = entity.sportId;
  data['tnjc'] = entity.tnjc;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentName'] = entity.tournamentName;
  return data;
}

extension FilterMatchDataSportVOsTournamentListExtension on FilterMatchDataSportVOsTournamentList {
  FilterMatchDataSportVOsTournamentList copyWith({
    int? hotStatus,
    String? id,
    dynamic nameCode,
    String? nameText,
    int? num,
    String? picUrlthumb,
    String? regionId,
    String? sportId,
    String? tnjc,
    String? tournamentId,
    int? tournamentLevel,
    String? tournamentName,
  }) {
    return FilterMatchDataSportVOsTournamentList()
      ..hotStatus = hotStatus ?? this.hotStatus
      ..id = id ?? this.id
      ..nameCode = nameCode ?? this.nameCode
      ..nameText = nameText ?? this.nameText
      ..num = num ?? this.num
      ..picUrlthumb = picUrlthumb ?? this.picUrlthumb
      ..regionId = regionId ?? this.regionId
      ..sportId = sportId ?? this.sportId
      ..tnjc = tnjc ?? this.tnjc
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentName = tournamentName ?? this.tournamentName;
  }
}