import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_lists_entity.dart';

GetFilterMatchListsEntity $GetFilterMatchListsEntityFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListsEntity getFilterMatchListsEntity = GetFilterMatchListsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFilterMatchListsEntity.code = code;
  }
  final List<GetFilterMatchListsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListsData>(
          e) as GetFilterMatchListsData)
      .toList();
  if (data != null) {
    getFilterMatchListsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFilterMatchListsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFilterMatchListsEntity.ts = ts;
  }
  return getFilterMatchListsEntity;
}

Map<String, dynamic> $GetFilterMatchListsEntityToJson(
    GetFilterMatchListsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFilterMatchListsEntityExtension on GetFilterMatchListsEntity {
  GetFilterMatchListsEntity copyWith({
    String? code,
    List<GetFilterMatchListsData>? data,
    String? msg,
    int? ts,
  }) {
    return GetFilterMatchListsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFilterMatchListsData $GetFilterMatchListsDataFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListsData getFilterMatchListsData = GetFilterMatchListsData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    getFilterMatchListsData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListsData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    getFilterMatchListsData.introduction = introduction;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListsData.spell = spell;
  }
  final List<
      GetFilterMatchListsDataSportVOs>? sportVOs = (json['sportVOs'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListsDataSportVOs>(
          e) as GetFilterMatchListsDataSportVOs).toList();
  if (sportVOs != null) {
    getFilterMatchListsData.sportVOs = sportVOs;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    getFilterMatchListsData.zh = zh;
  }
  return getFilterMatchListsData;
}

Map<String, dynamic> $GetFilterMatchListsDataToJson(
    GetFilterMatchListsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['en'] = entity.en;
  data['id'] = entity.id;
  data['introduction'] = entity.introduction;
  data['spell'] = entity.spell;
  data['sportVOs'] = entity.sportVOs.map((v) => v.toJson()).toList();
  data['zh'] = entity.zh;
  return data;
}

extension GetFilterMatchListsDataExtension on GetFilterMatchListsData {
  GetFilterMatchListsData copyWith({
    String? en,
    String? id,
    String? introduction,
    String? spell,
    List<GetFilterMatchListsDataSportVOs>? sportVOs,
    String? zh,
  }) {
    return GetFilterMatchListsData()
      ..en = en ?? this.en
      ..id = id ?? this.id
      ..introduction = introduction ?? this.introduction
      ..spell = spell ?? this.spell
      ..sportVOs = sportVOs ?? this.sportVOs
      ..zh = zh ?? this.zh;
  }
}

GetFilterMatchListsDataSportVOs $GetFilterMatchListsDataSportVOsFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListsDataSportVOs getFilterMatchListsDataSportVOs = GetFilterMatchListsDataSportVOs();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListsDataSportVOs.id = id;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListsDataSportVOs.nameText = nameText;
  }
  final int? orderNum = jsonConvert.convert<int>(json['orderNum']);
  if (orderNum != null) {
    getFilterMatchListsDataSportVOs.orderNum = orderNum;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListsDataSportVOs.spell = spell;
  }
  final List<
      GetFilterMatchListsDataSportVOsTournamentList>? tournamentList = (json['tournamentList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetFilterMatchListsDataSportVOsTournamentList>(
          e) as GetFilterMatchListsDataSportVOsTournamentList).toList();
  if (tournamentList != null) {
    getFilterMatchListsDataSportVOs.tournamentList = tournamentList;
  }
  return getFilterMatchListsDataSportVOs;
}

Map<String, dynamic> $GetFilterMatchListsDataSportVOsToJson(
    GetFilterMatchListsDataSportVOs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['nameText'] = entity.nameText;
  data['orderNum'] = entity.orderNum;
  data['spell'] = entity.spell;
  data['tournamentList'] =
      entity.tournamentList.map((v) => v.toJson()).toList();
  return data;
}

extension GetFilterMatchListsDataSportVOsExtension on GetFilterMatchListsDataSportVOs {
  GetFilterMatchListsDataSportVOs copyWith({
    String? id,
    String? nameText,
    int? orderNum,
    String? spell,
    List<GetFilterMatchListsDataSportVOsTournamentList>? tournamentList,
  }) {
    return GetFilterMatchListsDataSportVOs()
      ..id = id ?? this.id
      ..nameText = nameText ?? this.nameText
      ..orderNum = orderNum ?? this.orderNum
      ..spell = spell ?? this.spell
      ..tournamentList = tournamentList ?? this.tournamentList;
  }
}

GetFilterMatchListsDataSportVOsTournamentList $GetFilterMatchListsDataSportVOsTournamentListFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListsDataSportVOsTournamentList getFilterMatchListsDataSportVOsTournamentList = GetFilterMatchListsDataSportVOsTournamentList();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    getFilterMatchListsDataSportVOsTournamentList.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListsDataSportVOsTournamentList.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    getFilterMatchListsDataSportVOsTournamentList.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListsDataSportVOsTournamentList.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    getFilterMatchListsDataSportVOsTournamentList.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    getFilterMatchListsDataSportVOsTournamentList.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    getFilterMatchListsDataSportVOsTournamentList.regionId = regionId;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    getFilterMatchListsDataSportVOsTournamentList.sportId = sportId;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    getFilterMatchListsDataSportVOsTournamentList.tnjc = tnjc;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFilterMatchListsDataSportVOsTournamentList.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFilterMatchListsDataSportVOsTournamentList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    getFilterMatchListsDataSportVOsTournamentList.tournamentName =
        tournamentName;
  }
  return getFilterMatchListsDataSportVOsTournamentList;
}

Map<String, dynamic> $GetFilterMatchListsDataSportVOsTournamentListToJson(
    GetFilterMatchListsDataSportVOsTournamentList entity) {
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

extension GetFilterMatchListsDataSportVOsTournamentListExtension on GetFilterMatchListsDataSportVOsTournamentList {
  GetFilterMatchListsDataSportVOsTournamentList copyWith({
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
    return GetFilterMatchListsDataSportVOsTournamentList()
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