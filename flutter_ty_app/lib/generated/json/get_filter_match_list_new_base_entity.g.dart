import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_list_new_base_entity.dart';

GetFilterMatchListNewBaseEntity $GetFilterMatchListNewBaseEntityFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewBaseEntity getFilterMatchListNewBaseEntity = GetFilterMatchListNewBaseEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFilterMatchListNewBaseEntity.code = code;
  }
  final List<GetFilterMatchListNewBaseData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListNewBaseData>(
          e) as GetFilterMatchListNewBaseData).toList();
  if (data != null) {
    getFilterMatchListNewBaseEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFilterMatchListNewBaseEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFilterMatchListNewBaseEntity.ts = ts;
  }
  return getFilterMatchListNewBaseEntity;
}

Map<String, dynamic> $GetFilterMatchListNewBaseEntityToJson(
    GetFilterMatchListNewBaseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFilterMatchListNewBaseEntityExtension on GetFilterMatchListNewBaseEntity {
  GetFilterMatchListNewBaseEntity copyWith({
    String? code,
    List<GetFilterMatchListNewBaseData>? data,
    String? msg,
    int? ts,
  }) {
    return GetFilterMatchListNewBaseEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFilterMatchListNewBaseData $GetFilterMatchListNewBaseDataFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewBaseData getFilterMatchListNewBaseData = GetFilterMatchListNewBaseData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    getFilterMatchListNewBaseData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListNewBaseData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    getFilterMatchListNewBaseData.introduction = introduction;
  }
  final String? nameCode = jsonConvert.convert<String>(json['nameCode']);
  if (nameCode != null) {
    getFilterMatchListNewBaseData.nameCode = nameCode;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListNewBaseData.spell = spell;
  }
  final String? spellOrder = jsonConvert.convert<String>(json['spellOrder']);
  if (spellOrder != null) {
    getFilterMatchListNewBaseData.spellOrder = spellOrder;
  }
  final List<
      GetFilterMatchListNewBaseDataTournaments>? tournaments = (json['tournaments'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListNewBaseDataTournaments>(
          e) as GetFilterMatchListNewBaseDataTournaments).toList();
  if (tournaments != null) {
    getFilterMatchListNewBaseData.tournaments = tournaments;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    getFilterMatchListNewBaseData.zh = zh;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListNewBaseData.isSelect = isSelect;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getFilterMatchListNewBaseData.isExpand = isExpand;
  }
  return getFilterMatchListNewBaseData;
}

Map<String, dynamic> $GetFilterMatchListNewBaseDataToJson(
    GetFilterMatchListNewBaseData entity) {
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

extension GetFilterMatchListNewBaseDataExtension on GetFilterMatchListNewBaseData {
  GetFilterMatchListNewBaseData copyWith({
    String? en,
    String? id,
    String? introduction,
    String? nameCode,
    String? spell,
    String? spellOrder,
    List<GetFilterMatchListNewBaseDataTournaments>? tournaments,
    String? zh,
    bool? isSelect,
    bool? isExpand,
  }) {
    return GetFilterMatchListNewBaseData()
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

GetFilterMatchListNewBaseDataTournaments $GetFilterMatchListNewBaseDataTournamentsFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewBaseDataTournaments getFilterMatchListNewBaseDataTournaments = GetFilterMatchListNewBaseDataTournaments();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    getFilterMatchListNewBaseDataTournaments.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListNewBaseDataTournaments.id = id;
  }
  final String? nameCode = jsonConvert.convert<String>(json['nameCode']);
  if (nameCode != null) {
    getFilterMatchListNewBaseDataTournaments.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListNewBaseDataTournaments.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    getFilterMatchListNewBaseDataTournaments.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    getFilterMatchListNewBaseDataTournaments.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    getFilterMatchListNewBaseDataTournaments.regionId = regionId;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListNewBaseDataTournaments.spell = spell;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    getFilterMatchListNewBaseDataTournaments.sportId = sportId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFilterMatchListNewBaseDataTournaments.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFilterMatchListNewBaseDataTournaments.tournamentLevel = tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    getFilterMatchListNewBaseDataTournaments.tournamentName = tournamentName;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListNewBaseDataTournaments.isSelect = isSelect;
  }
  return getFilterMatchListNewBaseDataTournaments;
}

Map<String, dynamic> $GetFilterMatchListNewBaseDataTournamentsToJson(
    GetFilterMatchListNewBaseDataTournaments entity) {
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
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentName'] = entity.tournamentName;
  data['isSelect'] = entity.isSelect;
  return data;
}

extension GetFilterMatchListNewBaseDataTournamentsExtension on GetFilterMatchListNewBaseDataTournaments {
  GetFilterMatchListNewBaseDataTournaments copyWith({
    int? hotStatus,
    String? id,
    String? nameCode,
    String? nameText,
    int? num,
    String? picUrlthumb,
    String? regionId,
    String? spell,
    String? sportId,
    String? tournamentId,
    int? tournamentLevel,
    String? tournamentName,
    bool? isSelect,
  }) {
    return GetFilterMatchListNewBaseDataTournaments()
      ..hotStatus = hotStatus ?? this.hotStatus
      ..id = id ?? this.id
      ..nameCode = nameCode ?? this.nameCode
      ..nameText = nameText ?? this.nameText
      ..num = num ?? this.num
      ..picUrlthumb = picUrlthumb ?? this.picUrlthumb
      ..regionId = regionId ?? this.regionId
      ..spell = spell ?? this.spell
      ..sportId = sportId ?? this.sportId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentName = tournamentName ?? this.tournamentName
      ..isSelect = isSelect ?? this.isSelect;
  }
}