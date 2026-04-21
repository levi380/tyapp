import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/query_market_max_min_pre_bet_money_entity.dart';

QueryMarketMaxMinPreBetMoneyEntity $QueryMarketMaxMinPreBetMoneyEntityFromJson(
    Map<String, dynamic> json) {
  final QueryMarketMaxMinPreBetMoneyEntity queryMarketMaxMinPreBetMoneyEntity = QueryMarketMaxMinPreBetMoneyEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    queryMarketMaxMinPreBetMoneyEntity.code = code;
  }
  final List<QueryMarketMaxMinPreBetMoneyData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QueryMarketMaxMinPreBetMoneyData>(
          e) as QueryMarketMaxMinPreBetMoneyData).toList();
  if (data != null) {
    queryMarketMaxMinPreBetMoneyEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    queryMarketMaxMinPreBetMoneyEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    queryMarketMaxMinPreBetMoneyEntity.ts = ts;
  }
  return queryMarketMaxMinPreBetMoneyEntity;
}

Map<String, dynamic> $QueryMarketMaxMinPreBetMoneyEntityToJson(
    QueryMarketMaxMinPreBetMoneyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension QueryMarketMaxMinPreBetMoneyEntityExtension on QueryMarketMaxMinPreBetMoneyEntity {
  QueryMarketMaxMinPreBetMoneyEntity copyWith({
    String? code,
    List<QueryMarketMaxMinPreBetMoneyData>? data,
    String? msg,
    int? ts,
  }) {
    return QueryMarketMaxMinPreBetMoneyEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

QueryMarketMaxMinPreBetMoneyData $QueryMarketMaxMinPreBetMoneyDataFromJson(
    Map<String, dynamic> json) {
  final QueryMarketMaxMinPreBetMoneyData queryMarketMaxMinPreBetMoneyData = QueryMarketMaxMinPreBetMoneyData();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    queryMarketMaxMinPreBetMoneyData.code = code;
  }
  final String? globalId = jsonConvert.convert<String>(json['globalId']);
  if (globalId != null) {
    queryMarketMaxMinPreBetMoneyData.globalId = globalId;
  }
  final String? minBet = jsonConvert.convert<String>(json['minBet']);
  if (minBet != null) {
    queryMarketMaxMinPreBetMoneyData.minBet = minBet;
  }
  final String? orderMaxPay = jsonConvert.convert<String>(json['orderMaxPay']);
  if (orderMaxPay != null) {
    queryMarketMaxMinPreBetMoneyData.orderMaxPay = orderMaxPay;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    queryMarketMaxMinPreBetMoneyData.playId = playId;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    queryMarketMaxMinPreBetMoneyData.playOptionsId = playOptionsId;
  }
  final String? seriesOdds = jsonConvert.convert<String>(json['seriesOdds']);
  if (seriesOdds != null) {
    queryMarketMaxMinPreBetMoneyData.seriesOdds = seriesOdds;
  }
  final dynamic strayMaxOdds = json['strayMaxOdds'];
  if (strayMaxOdds != null) {
    queryMarketMaxMinPreBetMoneyData.strayMaxOdds = strayMaxOdds;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    queryMarketMaxMinPreBetMoneyData.type = type;
  }
  return queryMarketMaxMinPreBetMoneyData;
}

Map<String, dynamic> $QueryMarketMaxMinPreBetMoneyDataToJson(
    QueryMarketMaxMinPreBetMoneyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['globalId'] = entity.globalId;
  data['minBet'] = entity.minBet;
  data['orderMaxPay'] = entity.orderMaxPay;
  data['playId'] = entity.playId;
  data['playOptionsId'] = entity.playOptionsId;
  data['seriesOdds'] = entity.seriesOdds;
  data['strayMaxOdds'] = entity.strayMaxOdds;
  data['type'] = entity.type;
  return data;
}

extension QueryMarketMaxMinPreBetMoneyDataExtension on QueryMarketMaxMinPreBetMoneyData {
  QueryMarketMaxMinPreBetMoneyData copyWith({
    int? code,
    String? globalId,
    String? minBet,
    String? orderMaxPay,
    String? playId,
    String? playOptionsId,
    String? seriesOdds,
    dynamic strayMaxOdds,
    String? type,
  }) {
    return QueryMarketMaxMinPreBetMoneyData()
      ..code = code ?? this.code
      ..globalId = globalId ?? this.globalId
      ..minBet = minBet ?? this.minBet
      ..orderMaxPay = orderMaxPay ?? this.orderMaxPay
      ..playId = playId ?? this.playId
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..seriesOdds = seriesOdds ?? this.seriesOdds
      ..strayMaxOdds = strayMaxOdds ?? this.strayMaxOdds
      ..type = type ?? this.type;
  }
}