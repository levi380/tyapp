import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/filter_match_lists_entity.dart';

FilterMatchListsEntity $FilterMatchListsEntityFromJson(
    Map<String, dynamic> json) {
  final FilterMatchListsEntity filterMatchListsEntity = FilterMatchListsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    filterMatchListsEntity.code = code;
  }
  final List<FilterMatchListsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FilterMatchListsData>(e) as FilterMatchListsData)
      .toList();
  if (data != null) {
    filterMatchListsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    filterMatchListsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    filterMatchListsEntity.ts = ts;
  }
  return filterMatchListsEntity;
}

Map<String, dynamic> $FilterMatchListsEntityToJson(
    FilterMatchListsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension FilterMatchListsEntityExtension on FilterMatchListsEntity {
  FilterMatchListsEntity copyWith({
    String? code,
    List<FilterMatchListsData>? data,
    String? msg,
    int? ts,
  }) {
    return FilterMatchListsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

FilterMatchListsData $FilterMatchListsDataFromJson(Map<String, dynamic> json) {
  final FilterMatchListsData filterMatchListsData = FilterMatchListsData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    filterMatchListsData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    filterMatchListsData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    filterMatchListsData.introduction = introduction;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    filterMatchListsData.spell = spell;
  }
  final List<
      FilterMatchListsDataSportVOs>? sportVOs = (json['sportVOs'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FilterMatchListsDataSportVOs>(
          e) as FilterMatchListsDataSportVOs).toList();
  if (sportVOs != null) {
    filterMatchListsData.sportVOs = sportVOs;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    filterMatchListsData.zh = zh;
  }
  return filterMatchListsData;
}

Map<String, dynamic> $FilterMatchListsDataToJson(FilterMatchListsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['en'] = entity.en;
  data['id'] = entity.id;
  data['introduction'] = entity.introduction;
  data['spell'] = entity.spell;
  data['sportVOs'] = entity.sportVOs.map((v) => v.toJson()).toList();
  data['zh'] = entity.zh;
  return data;
}

extension FilterMatchListsDataExtension on FilterMatchListsData {
  FilterMatchListsData copyWith({
    String? en,
    String? id,
    String? introduction,
    String? spell,
    List<FilterMatchListsDataSportVOs>? sportVOs,
    String? zh,
  }) {
    return FilterMatchListsData()
      ..en = en ?? this.en
      ..id = id ?? this.id
      ..introduction = introduction ?? this.introduction
      ..spell = spell ?? this.spell
      ..sportVOs = sportVOs ?? this.sportVOs
      ..zh = zh ?? this.zh;
  }
}

FilterMatchListsDataSportVOs $FilterMatchListsDataSportVOsFromJson(
    Map<String, dynamic> json) {
  final FilterMatchListsDataSportVOs filterMatchListsDataSportVOs = FilterMatchListsDataSportVOs();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    filterMatchListsDataSportVOs.id = id;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    filterMatchListsDataSportVOs.nameText = nameText;
  }
  final int? orderNum = jsonConvert.convert<int>(json['orderNum']);
  if (orderNum != null) {
    filterMatchListsDataSportVOs.orderNum = orderNum;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    filterMatchListsDataSportVOs.spell = spell;
  }
  final List<
      FilterMatchListsDataSportVOsTournamentList>? tournamentList = (json['tournamentList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FilterMatchListsDataSportVOsTournamentList>(
          e) as FilterMatchListsDataSportVOsTournamentList).toList();
  if (tournamentList != null) {
    filterMatchListsDataSportVOs.tournamentList = tournamentList;
  }
  return filterMatchListsDataSportVOs;
}

Map<String, dynamic> $FilterMatchListsDataSportVOsToJson(
    FilterMatchListsDataSportVOs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['nameText'] = entity.nameText;
  data['orderNum'] = entity.orderNum;
  data['spell'] = entity.spell;
  data['tournamentList'] =
      entity.tournamentList.map((v) => v.toJson()).toList();
  return data;
}

extension FilterMatchListsDataSportVOsExtension on FilterMatchListsDataSportVOs {
  FilterMatchListsDataSportVOs copyWith({
    String? id,
    String? nameText,
    int? orderNum,
    String? spell,
    List<FilterMatchListsDataSportVOsTournamentList>? tournamentList,
  }) {
    return FilterMatchListsDataSportVOs()
      ..id = id ?? this.id
      ..nameText = nameText ?? this.nameText
      ..orderNum = orderNum ?? this.orderNum
      ..spell = spell ?? this.spell
      ..tournamentList = tournamentList ?? this.tournamentList;
  }
}

FilterMatchListsDataSportVOsTournamentList $FilterMatchListsDataSportVOsTournamentListFromJson(
    Map<String, dynamic> json) {
  final FilterMatchListsDataSportVOsTournamentList filterMatchListsDataSportVOsTournamentList = FilterMatchListsDataSportVOsTournamentList();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    filterMatchListsDataSportVOsTournamentList.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    filterMatchListsDataSportVOsTournamentList.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    filterMatchListsDataSportVOsTournamentList.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    filterMatchListsDataSportVOsTournamentList.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    filterMatchListsDataSportVOsTournamentList.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    filterMatchListsDataSportVOsTournamentList.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    filterMatchListsDataSportVOsTournamentList.regionId = regionId;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    filterMatchListsDataSportVOsTournamentList.sportId = sportId;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    filterMatchListsDataSportVOsTournamentList.tnjc = tnjc;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    filterMatchListsDataSportVOsTournamentList.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    filterMatchListsDataSportVOsTournamentList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    filterMatchListsDataSportVOsTournamentList.tournamentName = tournamentName;
  }
  return filterMatchListsDataSportVOsTournamentList;
}

Map<String, dynamic> $FilterMatchListsDataSportVOsTournamentListToJson(
    FilterMatchListsDataSportVOsTournamentList entity) {
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

extension FilterMatchListsDataSportVOsTournamentListExtension on FilterMatchListsDataSportVOsTournamentList {
  FilterMatchListsDataSportVOsTournamentList copyWith({
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
    return FilterMatchListsDataSportVOsTournamentList()
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