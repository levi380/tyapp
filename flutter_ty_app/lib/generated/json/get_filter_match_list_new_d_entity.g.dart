import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_list_new_d_entity.dart';

GetFilterMatchListNewDEntity $GetFilterMatchListNewDEntityFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewDEntity getFilterMatchListNewDEntity = GetFilterMatchListNewDEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFilterMatchListNewDEntity.code = code;
  }
  final List<GetFilterMatchListNewDData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListNewDData>(
          e) as GetFilterMatchListNewDData).toList();
  if (data != null) {
    getFilterMatchListNewDEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFilterMatchListNewDEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFilterMatchListNewDEntity.ts = ts;
  }
  return getFilterMatchListNewDEntity;
}

Map<String, dynamic> $GetFilterMatchListNewDEntityToJson(
    GetFilterMatchListNewDEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFilterMatchListNewDEntityExtension on GetFilterMatchListNewDEntity {
  GetFilterMatchListNewDEntity copyWith({
    String? code,
    List<GetFilterMatchListNewDData>? data,
    String? msg,
    int? ts,
  }) {
    return GetFilterMatchListNewDEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFilterMatchListNewDData $GetFilterMatchListNewDDataFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewDData getFilterMatchListNewDData = GetFilterMatchListNewDData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    getFilterMatchListNewDData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListNewDData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    getFilterMatchListNewDData.introduction = introduction;
  }
  final String? nameCode = jsonConvert.convert<String>(json['nameCode']);
  if (nameCode != null) {
    getFilterMatchListNewDData.nameCode = nameCode;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListNewDData.spell = spell;
  }
  final String? spellOrder = jsonConvert.convert<String>(json['spellOrder']);
  if (spellOrder != null) {
    getFilterMatchListNewDData.spellOrder = spellOrder;
  }
  final List<
      GetFilterMatchListNewDDataTournaments>? tournaments = (json['tournaments'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListNewDDataTournaments>(
          e) as GetFilterMatchListNewDDataTournaments).toList();
  if (tournaments != null) {
    getFilterMatchListNewDData.tournaments = tournaments;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    getFilterMatchListNewDData.zh = zh;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListNewDData.isSelect = isSelect;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getFilterMatchListNewDData.isExpand = isExpand;
  }
  return getFilterMatchListNewDData;
}

Map<String, dynamic> $GetFilterMatchListNewDDataToJson(
    GetFilterMatchListNewDData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['en'] = entity.en;
  data['id'] = entity.id;
  data['introduction'] = entity.introduction;
  data['nameCode'] = entity.nameCode;
  data['spell'] = entity.spell;
  data['spellOrder'] = entity.spellOrder;
  data['tournaments'] = entity.tournaments.map((v) => v.toJson()).toList();
  data['zh'] = entity.zh;
  data['isSelect'] = entity.isSelect;
  data['isExpand'] = entity.isExpand;
  return data;
}

extension GetFilterMatchListNewDDataExtension on GetFilterMatchListNewDData {
  GetFilterMatchListNewDData copyWith({
    String? en,
    String? id,
    String? introduction,
    String? nameCode,
    String? spell,
    String? spellOrder,
    List<GetFilterMatchListNewDDataTournaments>? tournaments,
    String? zh,
    bool? isSelect,
    bool? isExpand,
  }) {
    return GetFilterMatchListNewDData()
      ..en = en ?? this.en
      ..id = id ?? this.id
      ..introduction = introduction ?? this.introduction
      ..nameCode = nameCode ?? this.nameCode
      ..spell = spell ?? this.spell
      ..spellOrder = spellOrder ?? this.spellOrder
      ..tournaments = tournaments ?? this.tournaments
      ..zh = zh ?? this.zh
      ..isSelect = isSelect ?? this.isSelect
      ..isExpand = isExpand ?? this.isExpand;
  }
}

GetFilterMatchListNewDDataTournaments $GetFilterMatchListNewDDataTournamentsFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewDDataTournaments getFilterMatchListNewDDataTournaments = GetFilterMatchListNewDDataTournaments();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    getFilterMatchListNewDDataTournaments.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListNewDDataTournaments.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    getFilterMatchListNewDDataTournaments.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListNewDDataTournaments.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    getFilterMatchListNewDDataTournaments.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    getFilterMatchListNewDDataTournaments.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    getFilterMatchListNewDDataTournaments.regionId = regionId;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListNewDDataTournaments.spell = spell;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    getFilterMatchListNewDDataTournaments.sportId = sportId;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    getFilterMatchListNewDDataTournaments.tnjc = tnjc;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFilterMatchListNewDDataTournaments.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFilterMatchListNewDDataTournaments.tournamentLevel = tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    getFilterMatchListNewDDataTournaments.tournamentName = tournamentName;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListNewDDataTournaments.isSelect = isSelect;
  }
  return getFilterMatchListNewDDataTournaments;
}

Map<String, dynamic> $GetFilterMatchListNewDDataTournamentsToJson(
    GetFilterMatchListNewDDataTournaments entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hotStatus'] = entity.hotStatus;
  data['id'] = entity.id;
  data['nameCode'] = entity.nameCode;
  data['nameText'] = entity.nameText;
  data['num'] = entity.num;
  data['picUrlthumb'] = entity.picUrlthumb;
  data['regionId'] = entity.regionId;
  data['spell'] = entity.spell;
  data['sportId'] = entity.sportId;
  data['tnjc'] = entity.tnjc;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentName'] = entity.tournamentName;
  data['isSelect'] = entity.isSelect;
  return data;
}

extension GetFilterMatchListNewDDataTournamentsExtension on GetFilterMatchListNewDDataTournaments {
  GetFilterMatchListNewDDataTournaments copyWith({
    int? hotStatus,
    String? id,
    dynamic nameCode,
    String? nameText,
    int? num,
    String? picUrlthumb,
    String? regionId,
    String? spell,
    String? sportId,
    String? tnjc,
    String? tournamentId,
    int? tournamentLevel,
    String? tournamentName,
    bool? isSelect,
  }) {
    return GetFilterMatchListNewDDataTournaments()
      ..hotStatus = hotStatus ?? this.hotStatus
      ..id = id ?? this.id
      ..nameCode = nameCode ?? this.nameCode
      ..nameText = nameText ?? this.nameText
      ..num = num ?? this.num
      ..picUrlthumb = picUrlthumb ?? this.picUrlthumb
      ..regionId = regionId ?? this.regionId
      ..spell = spell ?? this.spell
      ..sportId = sportId ?? this.sportId
      ..tnjc = tnjc ?? this.tnjc
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentName = tournamentName ?? this.tournamentName
      ..isSelect = isSelect ?? this.isSelect;
  }
}