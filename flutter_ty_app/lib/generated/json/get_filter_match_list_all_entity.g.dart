import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_list_all_entity.dart';

GetFilterMatchListAllEntity $GetFilterMatchListAllEntityFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListAllEntity getFilterMatchListAllEntity = GetFilterMatchListAllEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFilterMatchListAllEntity.code = code;
  }
  final List<GetFilterMatchListAllData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListAllData>(
          e) as GetFilterMatchListAllData)
      .toList();
  if (data != null) {
    getFilterMatchListAllEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFilterMatchListAllEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFilterMatchListAllEntity.ts = ts;
  }
  return getFilterMatchListAllEntity;
}

Map<String, dynamic> $GetFilterMatchListAllEntityToJson(
    GetFilterMatchListAllEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFilterMatchListAllEntityExtension on GetFilterMatchListAllEntity {
  GetFilterMatchListAllEntity copyWith({
    String? code,
    List<GetFilterMatchListAllData>? data,
    String? msg,
    int? ts,
  }) {
    return GetFilterMatchListAllEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFilterMatchListAllData $GetFilterMatchListAllDataFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListAllData getFilterMatchListAllData = GetFilterMatchListAllData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    getFilterMatchListAllData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListAllData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    getFilterMatchListAllData.introduction = introduction;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    getFilterMatchListAllData.nameCode = nameCode;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListAllData.spell = spell;
  }
  final List<
      GetFilterMatchListAllDataSportVOs>? sportVOs = (json['sportVOs'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListAllDataSportVOs>(
          e) as GetFilterMatchListAllDataSportVOs).toList();
  if (sportVOs != null) {
    getFilterMatchListAllData.sportVOs = sportVOs;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    getFilterMatchListAllData.zh = zh;
  }
  return getFilterMatchListAllData;
}

Map<String, dynamic> $GetFilterMatchListAllDataToJson(
    GetFilterMatchListAllData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['en'] = entity.en;
  data['id'] = entity.id;
  data['introduction'] = entity.introduction;
  data['nameCode'] = entity.nameCode;
  data['spell'] = entity.spell;
  data['sportVOs'] = entity.sportVOs.map((v) => v.toJson()).toList();
  data['zh'] = entity.zh;
  return data;
}

extension GetFilterMatchListAllDataExtension on GetFilterMatchListAllData {
  GetFilterMatchListAllData copyWith({
    String? en,
    String? id,
    String? introduction,
    dynamic nameCode,
    String? spell,
    List<GetFilterMatchListAllDataSportVOs>? sportVOs,
    String? zh,
  }) {
    return GetFilterMatchListAllData()
      ..en = en ?? this.en
      ..id = id ?? this.id
      ..introduction = introduction ?? this.introduction
      ..nameCode = nameCode ?? this.nameCode
      ..spell = spell ?? this.spell
      ..sportVOs = sportVOs ?? this.sportVOs
      ..zh = zh ?? this.zh;
  }
}

GetFilterMatchListAllDataSportVOs $GetFilterMatchListAllDataSportVOsFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListAllDataSportVOs getFilterMatchListAllDataSportVOs = GetFilterMatchListAllDataSportVOs();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListAllDataSportVOs.id = id;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListAllDataSportVOs.nameText = nameText;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListAllDataSportVOs.spell = spell;
  }
  final List<
      GetFilterMatchListAllDataSportVOsTournamentList>? tournamentList = (json['tournamentList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetFilterMatchListAllDataSportVOsTournamentList>(
          e) as GetFilterMatchListAllDataSportVOsTournamentList).toList();
  if (tournamentList != null) {
    getFilterMatchListAllDataSportVOs.tournamentList = tournamentList;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListAllDataSportVOs.isSelect = isSelect;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getFilterMatchListAllDataSportVOs.isExpand = isExpand;
  }
  return getFilterMatchListAllDataSportVOs;
}

Map<String, dynamic> $GetFilterMatchListAllDataSportVOsToJson(
    GetFilterMatchListAllDataSportVOs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['nameText'] = entity.nameText;
  data['spell'] = entity.spell;
  data['tournamentList'] =
      entity.tournamentList.map((v) => v.toJson()).toList();
  data['isSelect'] = entity.isSelect;
  data['isExpand'] = entity.isExpand;
  return data;
}

extension GetFilterMatchListAllDataSportVOsExtension on GetFilterMatchListAllDataSportVOs {
  GetFilterMatchListAllDataSportVOs copyWith({
    String? id,
    String? nameText,
    String? spell,
    List<GetFilterMatchListAllDataSportVOsTournamentList>? tournamentList,
    bool? isSelect,
    bool? isExpand,
  }) {
    return GetFilterMatchListAllDataSportVOs()
      ..id = id ?? this.id
      ..nameText = nameText ?? this.nameText
      ..spell = spell ?? this.spell
      ..tournamentList = tournamentList ?? this.tournamentList
      ..isSelect = isSelect ?? this.isSelect
      ..isExpand = isExpand ?? this.isExpand;
  }
}

GetFilterMatchListAllDataSportVOsTournamentList $GetFilterMatchListAllDataSportVOsTournamentListFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListAllDataSportVOsTournamentList getFilterMatchListAllDataSportVOsTournamentList = GetFilterMatchListAllDataSportVOsTournamentList();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    getFilterMatchListAllDataSportVOsTournamentList.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListAllDataSportVOsTournamentList.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    getFilterMatchListAllDataSportVOsTournamentList.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListAllDataSportVOsTournamentList.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    getFilterMatchListAllDataSportVOsTournamentList.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    getFilterMatchListAllDataSportVOsTournamentList.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    getFilterMatchListAllDataSportVOsTournamentList.regionId = regionId;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    getFilterMatchListAllDataSportVOsTournamentList.sportId = sportId;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    getFilterMatchListAllDataSportVOsTournamentList.tnjc = tnjc;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFilterMatchListAllDataSportVOsTournamentList.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFilterMatchListAllDataSportVOsTournamentList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    getFilterMatchListAllDataSportVOsTournamentList.tournamentName =
        tournamentName;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListAllDataSportVOsTournamentList.isSelect = isSelect;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getFilterMatchListAllDataSportVOsTournamentList.isExpand = isExpand;
  }
  return getFilterMatchListAllDataSportVOsTournamentList;
}

Map<String, dynamic> $GetFilterMatchListAllDataSportVOsTournamentListToJson(
    GetFilterMatchListAllDataSportVOsTournamentList entity) {
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
  data['isSelect'] = entity.isSelect;
  data['isExpand'] = entity.isExpand;
  return data;
}

extension GetFilterMatchListAllDataSportVOsTournamentListExtension on GetFilterMatchListAllDataSportVOsTournamentList {
  GetFilterMatchListAllDataSportVOsTournamentList copyWith({
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
    bool? isSelect,
    bool? isExpand,
  }) {
    return GetFilterMatchListAllDataSportVOsTournamentList()
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
      ..tournamentName = tournamentName ?? this.tournamentName
      ..isSelect = isSelect ?? this.isSelect
      ..isExpand = isExpand ?? this.isExpand;
  }
}