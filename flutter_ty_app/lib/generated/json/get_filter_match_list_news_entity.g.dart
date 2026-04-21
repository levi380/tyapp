import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_list_news_entity.dart';

GetFilterMatchListNewsEntity $GetFilterMatchListNewsEntityFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewsEntity getFilterMatchListNewsEntity = GetFilterMatchListNewsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFilterMatchListNewsEntity.code = code;
  }
  final List<GetFilterMatchListNewsData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListNewsData>(
          e) as GetFilterMatchListNewsData).toList();
  if (data != null) {
    getFilterMatchListNewsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFilterMatchListNewsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFilterMatchListNewsEntity.ts = ts;
  }
  return getFilterMatchListNewsEntity;
}

Map<String, dynamic> $GetFilterMatchListNewsEntityToJson(
    GetFilterMatchListNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFilterMatchListNewsEntityExtension on GetFilterMatchListNewsEntity {
  GetFilterMatchListNewsEntity copyWith({
    String? code,
    List<GetFilterMatchListNewsData>? data,
    String? msg,
    int? ts,
  }) {
    return GetFilterMatchListNewsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFilterMatchListNewsData $GetFilterMatchListNewsDataFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewsData getFilterMatchListNewsData = GetFilterMatchListNewsData();
  final String? en = jsonConvert.convert<String>(json['en']);
  if (en != null) {
    getFilterMatchListNewsData.en = en;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListNewsData.id = id;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    getFilterMatchListNewsData.introduction = introduction;
  }
  final String? nameCode = jsonConvert.convert<String>(json['nameCode']);
  if (nameCode != null) {
    getFilterMatchListNewsData.nameCode = nameCode;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListNewsData.spell = spell;
  }
  final List<
      GetFilterMatchListNewsDataTournaments>? tournaments = (json['tournaments'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFilterMatchListNewsDataTournaments>(
          e) as GetFilterMatchListNewsDataTournaments).toList();
  if (tournaments != null) {
    getFilterMatchListNewsData.tournaments = tournaments;
  }
  final String? zh = jsonConvert.convert<String>(json['zh']);
  if (zh != null) {
    getFilterMatchListNewsData.zh = zh;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListNewsData.isSelect = isSelect;
  }
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getFilterMatchListNewsData.isExpand = isExpand;
  }
  return getFilterMatchListNewsData;
}

Map<String, dynamic> $GetFilterMatchListNewsDataToJson(
    GetFilterMatchListNewsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['en'] = entity.en;
  data['id'] = entity.id;
  data['introduction'] = entity.introduction;
  data['nameCode'] = entity.nameCode;
  data['spell'] = entity.spell;
  data['tournaments'] = entity.tournaments.map((v) => v.toJson()).toList();
  data['zh'] = entity.zh;
  data['isSelect'] = entity.isSelect;
  data['isExpand'] = entity.isExpand;
  return data;
}

extension GetFilterMatchListNewsDataExtension on GetFilterMatchListNewsData {
  GetFilterMatchListNewsData copyWith({
    String? en,
    String? id,
    String? introduction,
    String? nameCode,
    String? spell,
    List<GetFilterMatchListNewsDataTournaments>? tournaments,
    String? zh,
    bool? isSelect,
    bool? isExpand,
  }) {
    return GetFilterMatchListNewsData()
      ..en = en ?? this.en
      ..id = id ?? this.id
      ..introduction = introduction ?? this.introduction
      ..nameCode = nameCode ?? this.nameCode
      ..spell = spell ?? this.spell
      ..tournaments = tournaments ?? this.tournaments
      ..zh = zh ?? this.zh
      ..isSelect = isSelect ?? this.isSelect
      ..isExpand = isExpand ?? this.isExpand;
  }
}

GetFilterMatchListNewsDataTournaments $GetFilterMatchListNewsDataTournamentsFromJson(
    Map<String, dynamic> json) {
  final GetFilterMatchListNewsDataTournaments getFilterMatchListNewsDataTournaments = GetFilterMatchListNewsDataTournaments();
  final int? hotStatus = jsonConvert.convert<int>(json['hotStatus']);
  if (hotStatus != null) {
    getFilterMatchListNewsDataTournaments.hotStatus = hotStatus;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFilterMatchListNewsDataTournaments.id = id;
  }
  final dynamic nameCode = json['nameCode'];
  if (nameCode != null) {
    getFilterMatchListNewsDataTournaments.nameCode = nameCode;
  }
  final String? nameText = jsonConvert.convert<String>(json['nameText']);
  if (nameText != null) {
    getFilterMatchListNewsDataTournaments.nameText = nameText;
  }
  final int? num = jsonConvert.convert<int>(json['num']);
  if (num != null) {
    getFilterMatchListNewsDataTournaments.num = num;
  }
  final String? picUrlthumb = jsonConvert.convert<String>(json['picUrlthumb']);
  if (picUrlthumb != null) {
    getFilterMatchListNewsDataTournaments.picUrlthumb = picUrlthumb;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    getFilterMatchListNewsDataTournaments.regionId = regionId;
  }
  final String? spell = jsonConvert.convert<String>(json['spell']);
  if (spell != null) {
    getFilterMatchListNewsDataTournaments.spell = spell;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    getFilterMatchListNewsDataTournaments.sportId = sportId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFilterMatchListNewsDataTournaments.tournamentId = tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFilterMatchListNewsDataTournaments.tournamentLevel = tournamentLevel;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    getFilterMatchListNewsDataTournaments.tournamentName = tournamentName;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    getFilterMatchListNewsDataTournaments.isSelect = isSelect;
  }
  return getFilterMatchListNewsDataTournaments;
}

Map<String, dynamic> $GetFilterMatchListNewsDataTournamentsToJson(
    GetFilterMatchListNewsDataTournaments entity) {
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

extension GetFilterMatchListNewsDataTournamentsExtension on GetFilterMatchListNewsDataTournaments {
  GetFilterMatchListNewsDataTournaments copyWith({
    int? hotStatus,
    String? id,
    dynamic nameCode,
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
    return GetFilterMatchListNewsDataTournaments()
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