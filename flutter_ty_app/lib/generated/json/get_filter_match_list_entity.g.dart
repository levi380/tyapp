import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_list_entity.dart';

GetFilterMatchListEntity $GetFilterMatchListEntityFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListEntity getFilterMatchListEntity = GetFilterMatchListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFilterMatchListEntity.code = code;
  }
  final List<GetFilterMatchListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListData>(e) as GetFilterMatchListData)
      .toList();
  if (data != null) {
    getFilterMatchListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFilterMatchListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFilterMatchListEntity.ts = ts;
  }
  return getFilterMatchListEntity;
}

Map<String, dynamic> $GetFilterMatchListEntityToJson(
    GetFilterMatchListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFilterMatchListEntityExtension on GetFilterMatchListEntity {
  GetFilterMatchListEntity copyWith({
    String? code,
    List<GetFilterMatchListData>? data,
    String? msg,
    int? ts,
  }) {
    return GetFilterMatchListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFilterMatchListData $GetFilterMatchListDataFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListData getFilterMatchListData = GetFilterMatchListData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    getFilterMatchListData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    getFilterMatchListData.introduction = introduction;
  }
  final String? nameCode = jsonConvert.convert<String>(json['nameCode']);
  if (nameCode != null) {
    getFilterMatchListData.nameCode = nameCode;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListData.spell = spell;
  }
  final List<
      GetFilterMatchListDataSportVOs>? sportVOs = (json['sportVOs'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListDataSportVOs>(
          e) as GetFilterMatchListDataSportVOs).toList();
  if (sportVOs != null) {
    getFilterMatchListData.sportVOs = sportVOs;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    getFilterMatchListData.zh = zh;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListData.isSelect = isSelect;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getFilterMatchListData.isExpand = isExpand;
  }
  return getFilterMatchListData;
}

Map<String, dynamic> $GetFilterMatchListDataToJson(
    GetFilterMatchListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['en'] = entity.en;
  data['id'] = entity.id;
  data['introduction'] = entity.introduction;
  data['nameCode'] = entity.nameCode;
  data['spell'] = entity.spell;
  data['sportVOs'] = entity.sportVOs.map((v) => v.toJson()).toList();
  data['zh'] = entity.zh;
  data['isSelect'] = entity.isSelect;
  data['isExpand'] = entity.isExpand;
  return data;
}

extension GetFilterMatchListDataExtension on GetFilterMatchListData {
  GetFilterMatchListData copyWith({
    String? en,
    String? id,
    String? introduction,
    String? nameCode,
    String? spell,
    List<GetFilterMatchListDataSportVOs>? sportVOs,
    String? zh,
    bool? isSelect,
    bool? isExpand,
  }) {
    return GetFilterMatchListData()
      ..en = en ?? this.en
      ..id = id ?? this.id
      ..introduction = introduction ?? this.introduction
      ..nameCode = nameCode ?? this.nameCode
      ..spell = spell ?? this.spell
      ..sportVOs = sportVOs ?? this.sportVOs
      ..zh = zh ?? this.zh
      ..isSelect = isSelect ?? this.isSelect
      ..isExpand = isExpand ?? this.isExpand;
  }
}

GetFilterMatchListDataSportVOs $GetFilterMatchListDataSportVOsFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListDataSportVOs getFilterMatchListDataSportVOs = GetFilterMatchListDataSportVOs();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListDataSportVOs.id = id;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListDataSportVOs.nameText = nameText;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListDataSportVOs.spell = spell;
  }
  final List<
      GetFilterMatchListDataSportVOsTournamentList>? tournamentList = (json['tournamentList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetFilterMatchListDataSportVOsTournamentList>(
          e) as GetFilterMatchListDataSportVOsTournamentList).toList();
  if (tournamentList != null) {
    getFilterMatchListDataSportVOs.tournamentList = tournamentList;
  }
  return getFilterMatchListDataSportVOs;
}

Map<String, dynamic> $GetFilterMatchListDataSportVOsToJson(
    GetFilterMatchListDataSportVOs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['nameText'] = entity.nameText;
  data['spell'] = entity.spell;
  data['tournamentList'] =
      entity.tournamentList.map((v) => v.toJson()).toList();
  return data;
}

extension GetFilterMatchListDataSportVOsExtension on GetFilterMatchListDataSportVOs {
  GetFilterMatchListDataSportVOs copyWith({
    String? id,
    String? nameText,
    String? spell,
    List<GetFilterMatchListDataSportVOsTournamentList>? tournamentList,
  }) {
    return GetFilterMatchListDataSportVOs()
      ..id = id ?? this.id
      ..nameText = nameText ?? this.nameText
      ..spell = spell ?? this.spell
      ..tournamentList = tournamentList ?? this.tournamentList;
  }
}

GetFilterMatchListDataSportVOsTournamentList $GetFilterMatchListDataSportVOsTournamentListFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListDataSportVOsTournamentList getFilterMatchListDataSportVOsTournamentList = GetFilterMatchListDataSportVOsTournamentList();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    getFilterMatchListDataSportVOsTournamentList.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListDataSportVOsTournamentList.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    getFilterMatchListDataSportVOsTournamentList.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListDataSportVOsTournamentList.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    getFilterMatchListDataSportVOsTournamentList.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    getFilterMatchListDataSportVOsTournamentList.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    getFilterMatchListDataSportVOsTournamentList.regionId = regionId;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    getFilterMatchListDataSportVOsTournamentList.sportId = sportId;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    getFilterMatchListDataSportVOsTournamentList.tnjc = tnjc;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFilterMatchListDataSportVOsTournamentList.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFilterMatchListDataSportVOsTournamentList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    getFilterMatchListDataSportVOsTournamentList.tournamentName =
        tournamentName;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListDataSportVOsTournamentList.isSelect = isSelect;
  }
  return getFilterMatchListDataSportVOsTournamentList;
}

Map<String, dynamic> $GetFilterMatchListDataSportVOsTournamentListToJson(
    GetFilterMatchListDataSportVOsTournamentList entity) {
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
  return data;
}

extension GetFilterMatchListDataSportVOsTournamentListExtension on GetFilterMatchListDataSportVOsTournamentList {
  GetFilterMatchListDataSportVOsTournamentList copyWith({
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
  }) {
    return GetFilterMatchListDataSportVOsTournamentList()
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
      ..isSelect = isSelect ?? this.isSelect;
  }
}