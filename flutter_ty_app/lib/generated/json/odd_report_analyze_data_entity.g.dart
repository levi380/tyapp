import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/odd_report_analyze_data_entity.dart';

OddReportAnalyzeDataEntity $OddReportAnalyzeDataEntityFromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataEntity oddReportAnalyzeDataEntity = OddReportAnalyzeDataEntity();
  final OddReportAnalyzeDataMarket? market = jsonConvert.convert<
      OddReportAnalyzeDataMarket>(json['market']);
  if (market != null) {
    oddReportAnalyzeDataEntity.market = market;
  }
  final OddReportAnalyzeDataOdds? odds = jsonConvert.convert<
      OddReportAnalyzeDataOdds>(json['odds']);
  if (odds != null) {
    oddReportAnalyzeDataEntity.odds = odds;
  }
  return oddReportAnalyzeDataEntity;
}

Map<String, dynamic> $OddReportAnalyzeDataEntityToJson(
    OddReportAnalyzeDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['market'] = entity.market?.toJson();
  data['odds'] = entity.odds?.toJson();
  return data;
}

extension OddReportAnalyzeDataEntityExtension on OddReportAnalyzeDataEntity {
  OddReportAnalyzeDataEntity copyWith({
    OddReportAnalyzeDataMarket? market,
    OddReportAnalyzeDataOdds? odds,
  }) {
    return OddReportAnalyzeDataEntity()
      ..market = market ?? this.market
      ..odds = odds ?? this.odds;
  }
}

OddReportAnalyzeDataMarket $OddReportAnalyzeDataMarketFromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataMarket oddReportAnalyzeDataMarket = OddReportAnalyzeDataMarket();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    oddReportAnalyzeDataMarket.code = code;
  }
  final List<String>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (data != null) {
    oddReportAnalyzeDataMarket.data = data;
  }
  final String? linkId = jsonConvert.convert<String>(json['linkId']);
  if (linkId != null) {
    oddReportAnalyzeDataMarket.linkId = linkId;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    oddReportAnalyzeDataMarket.msg = msg;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    oddReportAnalyzeDataMarket.success = success;
  }
  return oddReportAnalyzeDataMarket;
}

Map<String, dynamic> $OddReportAnalyzeDataMarketToJson(
    OddReportAnalyzeDataMarket entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['linkId'] = entity.linkId;
  data['msg'] = entity.msg;
  data['success'] = entity.success;
  return data;
}

extension OddReportAnalyzeDataMarketExtension on OddReportAnalyzeDataMarket {
  OddReportAnalyzeDataMarket copyWith({
    String? code,
    List<String>? data,
    String? linkId,
    String? msg,
    bool? success,
  }) {
    return OddReportAnalyzeDataMarket()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..linkId = linkId ?? this.linkId
      ..msg = msg ?? this.msg
      ..success = success ?? this.success;
  }
}

OddReportAnalyzeDataOdds $OddReportAnalyzeDataOddsFromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataOdds oddReportAnalyzeDataOdds = OddReportAnalyzeDataOdds();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    oddReportAnalyzeDataOdds.code = code;
  }
  final OddReportAnalyzeDataOddsData? data = jsonConvert.convert<
      OddReportAnalyzeDataOddsData>(json['data']);
  if (data != null) {
    oddReportAnalyzeDataOdds.data = data;
  }
  final String? linkId = jsonConvert.convert<String>(json['linkId']);
  if (linkId != null) {
    oddReportAnalyzeDataOdds.linkId = linkId;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    oddReportAnalyzeDataOdds.msg = msg;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    oddReportAnalyzeDataOdds.success = success;
  }
  return oddReportAnalyzeDataOdds;
}

Map<String, dynamic> $OddReportAnalyzeDataOddsToJson(
    OddReportAnalyzeDataOdds entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['linkId'] = entity.linkId;
  data['msg'] = entity.msg;
  data['success'] = entity.success;
  return data;
}

extension OddReportAnalyzeDataOddsExtension on OddReportAnalyzeDataOdds {
  OddReportAnalyzeDataOdds copyWith({
    String? code,
    OddReportAnalyzeDataOddsData? data,
    String? linkId,
    String? msg,
    bool? success,
  }) {
    return OddReportAnalyzeDataOdds()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..linkId = linkId ?? this.linkId
      ..msg = msg ?? this.msg
      ..success = success ?? this.success;
  }
}

OddReportAnalyzeDataOddsData $OddReportAnalyzeDataOddsDataFromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataOddsData oddReportAnalyzeDataOddsData = OddReportAnalyzeDataOddsData();
  final List<
      OddReportAnalyzeDataOddsDataAverageList>? averageList = (json['averageList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<OddReportAnalyzeDataOddsDataAverageList>(
          e) as OddReportAnalyzeDataOddsDataAverageList).toList();
  if (averageList != null) {
    oddReportAnalyzeDataOddsData.averageList = averageList;
  }
  final Map<String, dynamic>? fieldOddsValueList =
  (json['fieldOddsValueList'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e));
  if (fieldOddsValueList != null) {
    oddReportAnalyzeDataOddsData.fieldOddsValueList = fieldOddsValueList;
  }
  final List<
      OddReportAnalyzeDataOddsDataOnSaleOddsList>? onSaleOddsList = (json['onSaleOddsList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<OddReportAnalyzeDataOddsDataOnSaleOddsList>(
          e) as OddReportAnalyzeDataOddsDataOnSaleOddsList).toList();
  if (onSaleOddsList != null) {
    oddReportAnalyzeDataOddsData.onSaleOddsList = onSaleOddsList;
  }
  final String? period = jsonConvert.convert<String>(json['period']);
  if (period != null) {
    oddReportAnalyzeDataOddsData.period = period;
  }
  return oddReportAnalyzeDataOddsData;
}

Map<String, dynamic> $OddReportAnalyzeDataOddsDataToJson(
    OddReportAnalyzeDataOddsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['averageList'] = entity.averageList?.map((v) => v.toJson()).toList();
  data['fieldOddsValueList'] = entity.fieldOddsValueList;
  data['onSaleOddsList'] =
      entity.onSaleOddsList?.map((v) => v.toJson()).toList();
  data['period'] = entity.period;
  return data;
}

extension OddReportAnalyzeDataOddsDataExtension on OddReportAnalyzeDataOddsData {
  OddReportAnalyzeDataOddsData copyWith({
    List<OddReportAnalyzeDataOddsDataAverageList>? averageList,
    Map<String, dynamic>? fieldOddsValueList,
    List<OddReportAnalyzeDataOddsDataOnSaleOddsList>? onSaleOddsList,
    String? period,
  }) {
    return OddReportAnalyzeDataOddsData()
      ..averageList = averageList ?? this.averageList
      ..fieldOddsValueList = fieldOddsValueList ?? this.fieldOddsValueList
      ..onSaleOddsList = onSaleOddsList ?? this.onSaleOddsList
      ..period = period ?? this.period;
  }
}

OddReportAnalyzeDataOddsDataAverageList $OddReportAnalyzeDataOddsDataAverageListFromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataOddsDataAverageList oddReportAnalyzeDataOddsDataAverageList = OddReportAnalyzeDataOddsDataAverageList();
  final dynamic average = json['average'];
  if (average != null) {
    oddReportAnalyzeDataOddsDataAverageList.average = average;
  }
  final String? formatTime = jsonConvert.convert<String>(json['formatTime']);
  if (formatTime != null) {
    oddReportAnalyzeDataOddsDataAverageList.formatTime = formatTime;
  }
  final String? oddsValue = jsonConvert.convert<String>(json['oddsValue']);
  if (oddsValue != null) {
    oddReportAnalyzeDataOddsDataAverageList.oddsValue = oddsValue;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    oddReportAnalyzeDataOddsDataAverageList.time = time;
  }
  final String? timeMillis = jsonConvert.convert<String>(json['timeMillis']);
  if (timeMillis != null) {
    oddReportAnalyzeDataOddsDataAverageList.timeMillis = timeMillis;
  }
  final String? dataSourceTime = jsonConvert.convert<String>(
      json['dataSourceTime']);
  if (dataSourceTime != null) {
    oddReportAnalyzeDataOddsDataAverageList.dataSourceTime = dataSourceTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    oddReportAnalyzeDataOddsDataAverageList.dataSourceCode = dataSourceCode;
  }
  return oddReportAnalyzeDataOddsDataAverageList;
}

Map<String, dynamic> $OddReportAnalyzeDataOddsDataAverageListToJson(
    OddReportAnalyzeDataOddsDataAverageList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['average'] = entity.average;
  data['formatTime'] = entity.formatTime;
  data['oddsValue'] = entity.oddsValue;
  data['time'] = entity.time;
  data['timeMillis'] = entity.timeMillis;
  data['dataSourceTime'] = entity.dataSourceTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  return data;
}

extension OddReportAnalyzeDataOddsDataAverageListExtension on OddReportAnalyzeDataOddsDataAverageList {
  OddReportAnalyzeDataOddsDataAverageList copyWith({
    dynamic average,
    String? formatTime,
    String? oddsValue,
    String? time,
    String? timeMillis,
    String? dataSourceTime,
    String? dataSourceCode,
  }) {
    return OddReportAnalyzeDataOddsDataAverageList()
      ..average = average ?? this.average
      ..formatTime = formatTime ?? this.formatTime
      ..oddsValue = oddsValue ?? this.oddsValue
      ..time = time ?? this.time
      ..timeMillis = timeMillis ?? this.timeMillis
      ..dataSourceTime = dataSourceTime ?? this.dataSourceTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode;
  }
}

OddReportAnalyzeDataOddsDataFieldOddsValueList $OddReportAnalyzeDataOddsDataFieldOddsValueListFromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataOddsDataFieldOddsValueList oddReportAnalyzeDataOddsDataFieldOddsValueList = OddReportAnalyzeDataOddsDataFieldOddsValueList();
  final dynamic l01Fonbet = json['L01_FonBet'];
  if (l01Fonbet != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.l01Fonbet = l01Fonbet;
  }
  final dynamic n02 = json['N02'];
  if (n02 != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.n02 = n02;
  }
  final dynamic a01 = json['A01'];
  if (a01 != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.a01 = a01;
  }
  final dynamic l01Bet365 = json['L01_Bet365'];
  if (l01Bet365 != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.l01Bet365 = l01Bet365;
  }
  final List<
      OddReportAnalyzeDataOddsDataFieldOddsValueListG01>? g01 = (json['G01'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          OddReportAnalyzeDataOddsDataFieldOddsValueListG01>(
          e) as OddReportAnalyzeDataOddsDataFieldOddsValueListG01).toList();
  if (g01 != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.g01 = g01;
  }
  final dynamic l011xbet = json['L01_1XBet'];
  if (l011xbet != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.l011xbet = l011xbet;
  }
  final dynamic l01188bet = json['L01_188Bet'];
  if (l01188bet != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.l01188bet = l01188bet;
  }
  final dynamic t01Ibcbet = json['T01_IBCBet'];
  if (t01Ibcbet != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.t01Ibcbet = t01Ibcbet;
  }
  final dynamic t01188bet = json['T01_188Bet'];
  if (t01188bet != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.t01188bet = t01188bet;
  }
  final dynamic n01 = json['N01'];
  if (n01 != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueList.n01 = n01;
  }
  return oddReportAnalyzeDataOddsDataFieldOddsValueList;
}

Map<String, dynamic> $OddReportAnalyzeDataOddsDataFieldOddsValueListToJson(
    OddReportAnalyzeDataOddsDataFieldOddsValueList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['L01_FonBet'] = entity.l01Fonbet;
  data['N02'] = entity.n02;
  data['A01'] = entity.a01;
  data['L01_Bet365'] = entity.l01Bet365;
  data['G01'] = entity.g01?.map((v) => v.toJson()).toList();
  data['L01_1XBet'] = entity.l011xbet;
  data['L01_188Bet'] = entity.l01188bet;
  data['T01_IBCBet'] = entity.t01Ibcbet;
  data['T01_188Bet'] = entity.t01188bet;
  data['N01'] = entity.n01;
  return data;
}

extension OddReportAnalyzeDataOddsDataFieldOddsValueListExtension on OddReportAnalyzeDataOddsDataFieldOddsValueList {
  OddReportAnalyzeDataOddsDataFieldOddsValueList copyWith({
    dynamic l01Fonbet,
    dynamic n02,
    dynamic a01,
    dynamic l01Bet365,
    List<OddReportAnalyzeDataOddsDataFieldOddsValueListG01>? g01,
    dynamic l011xbet,
    dynamic l01188bet,
    dynamic t01Ibcbet,
    dynamic t01188bet,
    dynamic n01,
  }) {
    return OddReportAnalyzeDataOddsDataFieldOddsValueList()
      ..l01Fonbet = l01Fonbet ?? this.l01Fonbet
      ..n02 = n02 ?? this.n02
      ..a01 = a01 ?? this.a01
      ..l01Bet365 = l01Bet365 ?? this.l01Bet365
      ..g01 = g01 ?? this.g01
      ..l011xbet = l011xbet ?? this.l011xbet
      ..l01188bet = l01188bet ?? this.l01188bet
      ..t01Ibcbet = t01Ibcbet ?? this.t01Ibcbet
      ..t01188bet = t01188bet ?? this.t01188bet
      ..n01 = n01 ?? this.n01;
  }
}

OddReportAnalyzeDataOddsDataFieldOddsValueListG01 $OddReportAnalyzeDataOddsDataFieldOddsValueListG01FromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataOddsDataFieldOddsValueListG01 oddReportAnalyzeDataOddsDataFieldOddsValueListG01 = OddReportAnalyzeDataOddsDataFieldOddsValueListG01();
  final String? average = jsonConvert.convert<String>(json['average']);
  if (average != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueListG01.average = average;
  }
  final String? formatTime = jsonConvert.convert<String>(json['formatTime']);
  if (formatTime != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueListG01.formatTime = formatTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueListG01.dataSourceCode =
        dataSourceCode;
  }
  final String? oddsValue = jsonConvert.convert<String>(json['oddsValue']);
  if (oddsValue != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueListG01.oddsValue = oddsValue;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueListG01.time = time;
  }
  final String? timeMillis = jsonConvert.convert<String>(json['timeMillis']);
  if (timeMillis != null) {
    oddReportAnalyzeDataOddsDataFieldOddsValueListG01.timeMillis = timeMillis;
  }
  return oddReportAnalyzeDataOddsDataFieldOddsValueListG01;
}

Map<String, dynamic> $OddReportAnalyzeDataOddsDataFieldOddsValueListG01ToJson(
    OddReportAnalyzeDataOddsDataFieldOddsValueListG01 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['average'] = entity.average;
  data['formatTime'] = entity.formatTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['oddsValue'] = entity.oddsValue;
  data['time'] = entity.time;
  data['timeMillis'] = entity.timeMillis;
  return data;
}

extension OddReportAnalyzeDataOddsDataFieldOddsValueListG01Extension on OddReportAnalyzeDataOddsDataFieldOddsValueListG01 {
  OddReportAnalyzeDataOddsDataFieldOddsValueListG01 copyWith({
    String? average,
    String? formatTime,
    String? dataSourceCode,
    String? oddsValue,
    String? time,
    String? timeMillis,
  }) {
    return OddReportAnalyzeDataOddsDataFieldOddsValueListG01()
      ..average = average ?? this.average
      ..formatTime = formatTime ?? this.formatTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..oddsValue = oddsValue ?? this.oddsValue
      ..time = time ?? this.time
      ..timeMillis = timeMillis ?? this.timeMillis;
  }
}

OddReportAnalyzeDataOddsDataOnSaleOddsList $OddReportAnalyzeDataOddsDataOnSaleOddsListFromJson(
    Map<String, dynamic> json) {
  final OddReportAnalyzeDataOddsDataOnSaleOddsList oddReportAnalyzeDataOddsDataOnSaleOddsList = OddReportAnalyzeDataOddsDataOnSaleOddsList();
  final String? average = jsonConvert.convert<String>(json['average']);
  if (average != null) {
    oddReportAnalyzeDataOddsDataOnSaleOddsList.average = average;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    oddReportAnalyzeDataOddsDataOnSaleOddsList.dataSourceCode = dataSourceCode;
  }
  final String? formatTime = jsonConvert.convert<String>(json['formatTime']);
  if (formatTime != null) {
    oddReportAnalyzeDataOddsDataOnSaleOddsList.formatTime = formatTime;
  }
  final String? oddsValue = jsonConvert.convert<String>(json['oddsValue']);
  if (oddsValue != null) {
    oddReportAnalyzeDataOddsDataOnSaleOddsList.oddsValue = oddsValue;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    oddReportAnalyzeDataOddsDataOnSaleOddsList.time = time;
  }
  final String? timeMillis = jsonConvert.convert<String>(json['timeMillis']);
  if (timeMillis != null) {
    oddReportAnalyzeDataOddsDataOnSaleOddsList.timeMillis = timeMillis;
  }
  return oddReportAnalyzeDataOddsDataOnSaleOddsList;
}

Map<String, dynamic> $OddReportAnalyzeDataOddsDataOnSaleOddsListToJson(
    OddReportAnalyzeDataOddsDataOnSaleOddsList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['average'] = entity.average;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['formatTime'] = entity.formatTime;
  data['oddsValue'] = entity.oddsValue;
  data['time'] = entity.time;
  data['timeMillis'] = entity.timeMillis;
  return data;
}

extension OddReportAnalyzeDataOddsDataOnSaleOddsListExtension on OddReportAnalyzeDataOddsDataOnSaleOddsList {
  OddReportAnalyzeDataOddsDataOnSaleOddsList copyWith({
    String? average,
    String? dataSourceCode,
    String? formatTime,
    String? oddsValue,
    String? time,
    String? timeMillis,
  }) {
    return OddReportAnalyzeDataOddsDataOnSaleOddsList()
      ..average = average ?? this.average
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..formatTime = formatTime ?? this.formatTime
      ..oddsValue = oddsValue ?? this.oddsValue
      ..time = time ?? this.time
      ..timeMillis = timeMillis ?? this.timeMillis;
  }
}