import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/query_market_info_by_match_id_and_play_id_entity.dart';

QueryMarketInfoByMatchIdAndPlayIdEntity $QueryMarketInfoByMatchIdAndPlayIdEntityFromJson(
    Map<String, dynamic> json) {
  final QueryMarketInfoByMatchIdAndPlayIdEntity queryMarketInfoByMatchIdAndPlayIdEntity = QueryMarketInfoByMatchIdAndPlayIdEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    queryMarketInfoByMatchIdAndPlayIdEntity.code = code;
  }
  final QueryMarketInfoByMatchIdAndPlayIdData? data = jsonConvert.convert<
      QueryMarketInfoByMatchIdAndPlayIdData>(json['data']);
  if (data != null) {
    queryMarketInfoByMatchIdAndPlayIdEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    queryMarketInfoByMatchIdAndPlayIdEntity.msg = msg;
  }
  final String? tips = jsonConvert.convert<String>(json['tips']);
  if (tips != null) {
    queryMarketInfoByMatchIdAndPlayIdEntity.tips = tips;
  }
  final String? traceId = jsonConvert.convert<String>(json['traceId']);
  if (traceId != null) {
    queryMarketInfoByMatchIdAndPlayIdEntity.traceId = traceId;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    queryMarketInfoByMatchIdAndPlayIdEntity.ts = ts;
  }
  return queryMarketInfoByMatchIdAndPlayIdEntity;
}

Map<String, dynamic> $QueryMarketInfoByMatchIdAndPlayIdEntityToJson(
    QueryMarketInfoByMatchIdAndPlayIdEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['tips'] = entity.tips;
  data['traceId'] = entity.traceId;
  data['ts'] = entity.ts;
  return data;
}

extension QueryMarketInfoByMatchIdAndPlayIdEntityExtension on QueryMarketInfoByMatchIdAndPlayIdEntity {
  QueryMarketInfoByMatchIdAndPlayIdEntity copyWith({
    String? code,
    QueryMarketInfoByMatchIdAndPlayIdData? data,
    String? msg,
    String? tips,
    String? traceId,
    int? ts,
  }) {
    return QueryMarketInfoByMatchIdAndPlayIdEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..tips = tips ?? this.tips
      ..traceId = traceId ?? this.traceId
      ..ts = ts ?? this.ts;
  }
}

QueryMarketInfoByMatchIdAndPlayIdData $QueryMarketInfoByMatchIdAndPlayIdDataFromJson(
    Map<String, dynamic> json) {
  final QueryMarketInfoByMatchIdAndPlayIdData queryMarketInfoByMatchIdAndPlayIdData = QueryMarketInfoByMatchIdAndPlayIdData();
  final String? away = jsonConvert.convert<String>(json['away']);
  if (away != null) {
    queryMarketInfoByMatchIdAndPlayIdData.away = away;
  }
  final String? home = jsonConvert.convert<String>(json['home']);
  if (home != null) {
    queryMarketInfoByMatchIdAndPlayIdData.home = home;
  }
  final String? matchInfoId = jsonConvert.convert<String>(json['matchInfoId']);
  if (matchInfoId != null) {
    queryMarketInfoByMatchIdAndPlayIdData.matchInfoId = matchInfoId;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    queryMarketInfoByMatchIdAndPlayIdData.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    queryMarketInfoByMatchIdAndPlayIdData.playName = playName;
  }
  final List<
      QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO>? queryMarketDetailVO = (json['queryMarketDetailVO'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO>(
          e) as QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO)
      .toList();
  if (queryMarketDetailVO != null) {
    queryMarketInfoByMatchIdAndPlayIdData.queryMarketDetailVO =
        queryMarketDetailVO;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    queryMarketInfoByMatchIdAndPlayIdData.sportId = sportId;
  }
  return queryMarketInfoByMatchIdAndPlayIdData;
}

Map<String, dynamic> $QueryMarketInfoByMatchIdAndPlayIdDataToJson(
    QueryMarketInfoByMatchIdAndPlayIdData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['away'] = entity.away;
  data['home'] = entity.home;
  data['matchInfoId'] = entity.matchInfoId;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  data['queryMarketDetailVO'] =
      entity.queryMarketDetailVO.map((v) => v.toJson()).toList();
  data['sportId'] = entity.sportId;
  return data;
}

extension QueryMarketInfoByMatchIdAndPlayIdDataExtension on QueryMarketInfoByMatchIdAndPlayIdData {
  QueryMarketInfoByMatchIdAndPlayIdData copyWith({
    String? away,
    String? home,
    String? matchInfoId,
    String? playId,
    String? playName,
    List<
        QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO>? queryMarketDetailVO,
    int? sportId,
  }) {
    return QueryMarketInfoByMatchIdAndPlayIdData()
      ..away = away ?? this.away
      ..home = home ?? this.home
      ..matchInfoId = matchInfoId ?? this.matchInfoId
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName
      ..queryMarketDetailVO = queryMarketDetailVO ?? this.queryMarketDetailVO
      ..sportId = sportId ?? this.sportId;
  }
}

QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOFromJson(
    Map<String, dynamic> json) {
  final QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO = QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO.id = id;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO.marketValue =
        marketValue;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO.playId = playId;
  }
  final List<
      QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList>? queryMarketOddsVOList = (json['queryMarketOddsVOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList>(
          e) as QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList)
      .toList();
  if (queryMarketOddsVOList != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO
        .queryMarketOddsVOList = queryMarketOddsVOList;
  }
  return queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO;
}

Map<String,
    dynamic> $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOToJson(
    QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['marketValue'] = entity.marketValue;
  data['playId'] = entity.playId;
  data['queryMarketOddsVOList'] =
      entity.queryMarketOddsVOList.map((v) => v.toJson()).toList();
  return data;
}

extension QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOExtension on QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO {
  QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO copyWith({
    String? id,
    String? marketValue,
    String? playId,
    List<
        QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList>? queryMarketOddsVOList,
  }) {
    return QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO()
      ..id = id ?? this.id
      ..marketValue = marketValue ?? this.marketValue
      ..playId = playId ?? this.playId
      ..queryMarketOddsVOList = queryMarketOddsVOList ??
          this.queryMarketOddsVOList;
  }
}

QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOListFromJson(
    Map<String, dynamic> json) {
  final QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList = QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList
        .id = id;
  }
  final String? oddsType = jsonConvert.convert<String>(json['oddsType']);
  if (oddsType != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList
        .oddsType = oddsType;
  }
  final int? oddsValue = jsonConvert.convert<int>(json['oddsValue']);
  if (oddsValue != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList
        .oddsValue = oddsValue;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList
        .playOptions = playOptions;
  }
  return queryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList;
}

Map<String,
    dynamic> $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOListToJson(
    QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['oddsType'] = entity.oddsType;
  data['oddsValue'] = entity.oddsValue;
  data['playOptions'] = entity.playOptions;
  return data;
}

extension QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOListExtension on QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList {
  QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList copyWith(
      {
        String? id,
        String? oddsType,
        int? oddsValue,
        String? playOptions,
      }) {
    return QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList()
      ..id = id ?? this.id
      ..oddsType = oddsType ?? this.oddsType
      ..oddsValue = oddsValue ?? this.oddsValue
      ..playOptions = playOptions ?? this.playOptions;
  }
}