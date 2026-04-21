import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_rhgy_match_test_score_entity.dart';

GetRhgyMatchTestScoreEntity $GetRhgyMatchTestScoreEntityFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreEntity getRhgyMatchTestScoreEntity = GetRhgyMatchTestScoreEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getRhgyMatchTestScoreEntity.code = code;
  }
  final GetRhgyMatchTestScoreData? data = jsonConvert.convert<
      GetRhgyMatchTestScoreData>(json['data']);
  if (data != null) {
    getRhgyMatchTestScoreEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getRhgyMatchTestScoreEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getRhgyMatchTestScoreEntity.ts = ts;
  }
  return getRhgyMatchTestScoreEntity;
}

Map<String, dynamic> $GetRhgyMatchTestScoreEntityToJson(
    GetRhgyMatchTestScoreEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetRhgyMatchTestScoreEntityExtension on GetRhgyMatchTestScoreEntity {
  GetRhgyMatchTestScoreEntity copyWith({
    String? code,
    GetRhgyMatchTestScoreData? data,
    String? msg,
    int? ts,
  }) {
    return GetRhgyMatchTestScoreEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetRhgyMatchTestScoreData $GetRhgyMatchTestScoreDataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreData getRhgyMatchTestScoreData = GetRhgyMatchTestScoreData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getRhgyMatchTestScoreData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getRhgyMatchTestScoreData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getRhgyMatchTestScoreData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getRhgyMatchTestScoreData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getRhgyMatchTestScoreData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getRhgyMatchTestScoreData.hasPrevious = hasPrevious;
  }
  final String? maxWinTotalAmount = jsonConvert.convert<String>(
      json['maxWinTotalAmount']);
  if (maxWinTotalAmount != null) {
    getRhgyMatchTestScoreData.maxWinTotalAmount = maxWinTotalAmount;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getRhgyMatchTestScoreData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getRhgyMatchTestScoreData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getRhgyMatchTestScoreData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getRhgyMatchTestScoreData.profit = profit;
  }
  final GetRhgyMatchTestScoreDataRecord? record = jsonConvert.convert<
      GetRhgyMatchTestScoreDataRecord>(json['record']);
  if (record != null) {
    getRhgyMatchTestScoreData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getRhgyMatchTestScoreData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getRhgyMatchTestScoreData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getRhgyMatchTestScoreData.size = size;
  }
  final String? subOrderTotal = jsonConvert.convert<String>(
      json['subOrderTotal']);
  if (subOrderTotal != null) {
    getRhgyMatchTestScoreData.subOrderTotal = subOrderTotal;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getRhgyMatchTestScoreData.total = total;
  }
  return getRhgyMatchTestScoreData;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataToJson(
    GetRhgyMatchTestScoreData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ascs'] = entity.ascs;
  data['betTotalAmount'] = entity.betTotalAmount;
  data['current'] = entity.current;
  data['descs'] = entity.descs;
  data['hasNext'] = entity.hasNext;
  data['hasPrevious'] = entity.hasPrevious;
  data['maxWinTotalAmount'] = entity.maxWinTotalAmount;
  data['optimizeCountSql'] = entity.optimizeCountSql;
  data['pages'] = entity.pages;
  data['preBetTotalAmount'] = entity.preBetTotalAmount;
  data['profit'] = entity.profit;
  data['record'] = entity.record.toJson();
  data['records'] = entity.records;
  data['searchCount'] = entity.searchCount;
  data['size'] = entity.size;
  data['subOrderTotal'] = entity.subOrderTotal;
  data['total'] = entity.total;
  return data;
}

extension GetRhgyMatchTestScoreDataExtension on GetRhgyMatchTestScoreData {
  GetRhgyMatchTestScoreData copyWith({
    dynamic ascs,
    String? betTotalAmount,
    String? current,
    dynamic descs,
    bool? hasNext,
    bool? hasPrevious,
    String? maxWinTotalAmount,
    bool? optimizeCountSql,
    String? pages,
    String? preBetTotalAmount,
    String? profit,
    GetRhgyMatchTestScoreDataRecord? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? subOrderTotal,
    String? total,
  }) {
    return GetRhgyMatchTestScoreData()
      ..ascs = ascs ?? this.ascs
      ..betTotalAmount = betTotalAmount ?? this.betTotalAmount
      ..current = current ?? this.current
      ..descs = descs ?? this.descs
      ..hasNext = hasNext ?? this.hasNext
      ..hasPrevious = hasPrevious ?? this.hasPrevious
      ..maxWinTotalAmount = maxWinTotalAmount ?? this.maxWinTotalAmount
      ..optimizeCountSql = optimizeCountSql ?? this.optimizeCountSql
      ..pages = pages ?? this.pages
      ..preBetTotalAmount = preBetTotalAmount ?? this.preBetTotalAmount
      ..profit = profit ?? this.profit
      ..record = record ?? this.record
      ..records = records ?? this.records
      ..searchCount = searchCount ?? this.searchCount
      ..size = size ?? this.size
      ..subOrderTotal = subOrderTotal ?? this.subOrderTotal
      ..total = total ?? this.total;
  }
}

GetRhgyMatchTestScoreDataRecord $GetRhgyMatchTestScoreDataRecordFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecord getRhgyMatchTestScoreDataRecord = GetRhgyMatchTestScoreDataRecord();
  final GetRhgyMatchTestScoreDataRecordx20251212? x20251212 = jsonConvert
      .convert<GetRhgyMatchTestScoreDataRecordx20251212>(json['2025-12-12']);
  if (x20251212 != null) {
    getRhgyMatchTestScoreDataRecord.x20251212 = x20251212;
  }
  final GetRhgyMatchTestScoreDataRecordx20251202? x20251202 = jsonConvert
      .convert<GetRhgyMatchTestScoreDataRecordx20251202>(json['2025-12-02']);
  if (x20251202 != null) {
    getRhgyMatchTestScoreDataRecord.x20251202 = x20251202;
  }
  final GetRhgyMatchTestScoreDataRecordx20251130? x20251130 = jsonConvert
      .convert<GetRhgyMatchTestScoreDataRecordx20251130>(json['2025-11-30']);
  if (x20251130 != null) {
    getRhgyMatchTestScoreDataRecord.x20251130 = x20251130;
  }
  final GetRhgyMatchTestScoreDataRecordx20251026? x20251026 = jsonConvert
      .convert<GetRhgyMatchTestScoreDataRecordx20251026>(json['2025-10-26']);
  if (x20251026 != null) {
    getRhgyMatchTestScoreDataRecord.x20251026 = x20251026;
  }
  return getRhgyMatchTestScoreDataRecord;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordToJson(
    GetRhgyMatchTestScoreDataRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['2025-12-12'] = entity.x20251212.toJson();
  data['2025-12-02'] = entity.x20251202.toJson();
  data['2025-11-30'] = entity.x20251130.toJson();
  data['2025-10-26'] = entity.x20251026.toJson();
  return data;
}

extension GetRhgyMatchTestScoreDataRecordExtension on GetRhgyMatchTestScoreDataRecord {
  GetRhgyMatchTestScoreDataRecord copyWith({
    GetRhgyMatchTestScoreDataRecordx20251212? x20251212,
    GetRhgyMatchTestScoreDataRecordx20251202? x20251202,
    GetRhgyMatchTestScoreDataRecordx20251130? x20251130,
    GetRhgyMatchTestScoreDataRecordx20251026? x20251026,
  }) {
    return GetRhgyMatchTestScoreDataRecord()
      ..x20251212 = x20251212 ?? this.x20251212
      ..x20251202 = x20251202 ?? this.x20251202
      ..x20251130 = x20251130 ?? this.x20251130
      ..x20251026 = x20251026 ?? this.x20251026;
  }
}

GetRhgyMatchTestScoreDataRecordx20251212 $GetRhgyMatchTestScoreDataRecordx20251212FromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251212 getRhgyMatchTestScoreDataRecordx20251212 = GetRhgyMatchTestScoreDataRecordx20251212();
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212.preBetAmount = preBetAmount;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212.maxWinAmount = maxWinAmount;
  }
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212.betAmount = betAmount;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251212Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251212Data>(
          e) as GetRhgyMatchTestScoreDataRecordx20251212Data).toList();
  if (data != null) {
    getRhgyMatchTestScoreDataRecordx20251212.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyMatchTestScoreDataRecordx20251212.totalOrders = totalOrders;
  }
  return getRhgyMatchTestScoreDataRecordx20251212;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251212ToJson(
    GetRhgyMatchTestScoreDataRecordx20251212 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['preBetAmount'] = entity.preBetAmount;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251212Extension on GetRhgyMatchTestScoreDataRecordx20251212 {
  GetRhgyMatchTestScoreDataRecordx20251212 copyWith({
    double? preBetAmount,
    double? maxWinAmount,
    double? betAmount,
    List<GetRhgyMatchTestScoreDataRecordx20251212Data>? data,
    int? totalOrders,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251212()
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders;
  }
}

GetRhgyMatchTestScoreDataRecordx20251212Data $GetRhgyMatchTestScoreDataRecordx20251212DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251212Data getRhgyMatchTestScoreDataRecordx20251212Data = GetRhgyMatchTestScoreDataRecordx20251212Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251212DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251212DataDetailList>(
          e) as GetRhgyMatchTestScoreDataRecordx20251212DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.detailList = detailList;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.id = id;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.languageName = languageName;
  }
  final dynamic managerCode = json['managerCode'];
  if (managerCode != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.matchType = matchType;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.orderType = orderType;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.outcome = outcome;
  }
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.preOrder = preOrder;
  }
  final int? preOrderStatus = jsonConvert.convert<int>(json['preOrderStatus']);
  if (preOrderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.preSettle = preSettle;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212Data.settledAmount = settledAmount;
  }
  return getRhgyMatchTestScoreDataRecordx20251212Data;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251212DataToJson(
    GetRhgyMatchTestScoreDataRecordx20251212Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acCode'] = entity.acCode;
  data['addition'] = entity.addition;
  data['backAmount'] = entity.backAmount;
  data['beginTime'] = entity.beginTime;
  data['beginTimeStr'] = entity.beginTimeStr;
  data['betTime'] = entity.betTime;
  data['betTimeStr'] = entity.betTimeStr;
  data['cashOutTimes'] = entity.cashOutTimes;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['id'] = entity.id;
  data['langCode'] = entity.langCode;
  data['languageName'] = entity.languageName;
  data['managerCode'] = entity.managerCode;
  data['marketType'] = entity.marketType;
  data['matchType'] = entity.matchType;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['modifyTime'] = entity.modifyTime;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['odds'] = entity.odds;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['orderType'] = entity.orderType;
  data['outcome'] = entity.outcome;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrder'] = entity.preOrder;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['preOrderVoList'] = entity.preOrderVoList;
  data['preSettle'] = entity.preSettle;
  data['profitAmount'] = entity.profitAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValue'] = entity.seriesValue;
  data['settleTime'] = entity.settleTime;
  data['settleType'] = entity.settleType;
  data['settledAmount'] = entity.settledAmount;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251212DataExtension on GetRhgyMatchTestScoreDataRecordx20251212Data {
  GetRhgyMatchTestScoreDataRecordx20251212Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetRhgyMatchTestScoreDataRecordx20251212DataDetailList>? detailList,
    String? id,
    String? langCode,
    String? languageName,
    dynamic managerCode,
    String? marketType,
    dynamic matchType,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic outcome,
    double? preBetAmount,
    dynamic preOrder,
    int? preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    int? settleType,
    dynamic settledAmount,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251212Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
      ..detailList = detailList ?? this.detailList
      ..id = id ?? this.id
      ..langCode = langCode ?? this.langCode
      ..languageName = languageName ?? this.languageName
      ..managerCode = managerCode ?? this.managerCode
      ..marketType = marketType ?? this.marketType
      ..matchType = matchType ?? this.matchType
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..odds = odds ?? this.odds
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderType = orderType ?? this.orderType
      ..outcome = outcome ?? this.outcome
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrder = preOrder ?? this.preOrder
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..preOrderVoList = preOrderVoList ?? this.preOrderVoList
      ..preSettle = preSettle ?? this.preSettle
      ..profitAmount = profitAmount ?? this.profitAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleTime = settleTime ?? this.settleTime
      ..settleType = settleType ?? this.settleType
      ..settledAmount = settledAmount ?? this.settledAmount;
  }
}

GetRhgyMatchTestScoreDataRecordx20251212DataDetailList $GetRhgyMatchTestScoreDataRecordx20251212DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251212DataDetailList getRhgyMatchTestScoreDataRecordx20251212DataDetailList = GetRhgyMatchTestScoreDataRecordx20251212DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.cancelType =
        cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.childPlayId =
        childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchInfo =
        matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchName =
        matchName;
  }
  final dynamic matchOver = json['matchOver'];
  if (matchOver != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchOver =
        matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.secondNum =
        secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.startTime =
        startTime;
  }
  final dynamic thirdMatchId = json['thirdMatchId'];
  if (thirdMatchId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.tournamentId =
        tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyMatchTestScoreDataRecordx20251212DataDetailList.userId = userId;
  }
  return getRhgyMatchTestScoreDataRecordx20251212DataDetailList;
}

Map<String,
    dynamic> $GetRhgyMatchTestScoreDataRecordx20251212DataDetailListToJson(
    GetRhgyMatchTestScoreDataRecordx20251212DataDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acceptBetOdds'] = entity.acceptBetOdds;
  data['awayName'] = entity.awayName;
  data['backAmount'] = entity.backAmount;
  data['batchNo'] = entity.batchNo;
  data['beginTime'] = entity.beginTime;
  data['betAmount'] = entity.betAmount;
  data['betNo'] = entity.betNo;
  data['betResult'] = entity.betResult;
  data['betStatus'] = entity.betStatus;
  data['betTime'] = entity.betTime;
  data['cancelType'] = entity.cancelType;
  data['childPlayId'] = entity.childPlayId;
  data['closingTime'] = entity.closingTime;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eov'] = entity.eov;
  data['extJson'] = entity.extJson;
  data['firstNum'] = entity.firstNum;
  data['homeName'] = entity.homeName;
  data['isValid'] = entity.isValid;
  data['marketId'] = entity.marketId;
  data['marketName'] = entity.marketName;
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchDay'] = entity.matchDay;
  data['matchId'] = entity.matchId;
  data['matchInfo'] = entity.matchInfo;
  data['matchManageType'] = entity.matchManageType;
  data['matchName'] = entity.matchName;
  data['matchOver'] = entity.matchOver;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchProcessId'] = entity.matchProcessId;
  data['matchStatusId'] = entity.matchStatusId;
  data['matchTestScore'] = entity.matchTestScore;
  data['matchType'] = entity.matchType;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['oddFinally'] = entity.oddFinally;
  data['oddsValue'] = entity.oddsValue;
  data['optionValue'] = entity.optionValue;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderSettleRemark'] = entity.orderSettleRemark;
  data['originalMarketValue'] = entity.originalMarketValue;
  data['outrightYear'] = entity.outrightYear;
  data['phase'] = entity.phase;
  data['placeNum'] = entity.placeNum;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  data['playOptionName'] = entity.playOptionName;
  data['playOptions'] = entity.playOptions;
  data['playOptionsId'] = entity.playOptionsId;
  data['playOptionsRange'] = entity.playOptionsRange;
  data['remark'] = entity.remark;
  data['riskEvent'] = entity.riskEvent;
  data['score'] = entity.score;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['secondNum'] = entity.secondNum;
  data['secondsMatchStart'] = entity.secondsMatchStart;
  data['settleScore'] = entity.settleScore;
  data['sportId'] = entity.sportId;
  data['sportName'] = entity.sportName;
  data['startTime'] = entity.startTime;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentPic'] = entity.tournamentPic;
  data['uid'] = entity.uid;
  data['userId'] = entity.userId;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251212DataDetailListExtension on GetRhgyMatchTestScoreDataRecordx20251212DataDetailList {
  GetRhgyMatchTestScoreDataRecordx20251212DataDetailList copyWith({
    dynamic acceptBetOdds,
    String? awayName,
    String? backAmount,
    String? batchNo,
    String? beginTime,
    String? betAmount,
    String? betNo,
    int? betResult,
    int? betStatus,
    dynamic betTime,
    int? cancelType,
    dynamic childPlayId,
    dynamic closingTime,
    dynamic createTime,
    String? dataSourceCode,
    String? eov,
    String? extJson,
    dynamic firstNum,
    String? homeName,
    dynamic isValid,
    String? marketId,
    String? marketName,
    String? marketType,
    String? marketValue,
    String? matchDay,
    String? matchId,
    String? matchInfo,
    dynamic matchManageType,
    String? matchName,
    dynamic matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    double? oddsValue,
    String? optionValue,
    String? orderAmountTotal,
    String? orderNo,
    String? orderSettleRemark,
    String? originalMarketValue,
    String? outrightYear,
    String? phase,
    dynamic placeNum,
    int? playId,
    String? playName,
    String? playOptionName,
    String? playOptions,
    String? playOptionsId,
    String? playOptionsRange,
    String? remark,
    String? riskEvent,
    String? score,
    String? scoreBenchmark,
    dynamic secondNum,
    dynamic secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    dynamic thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251212DataDetailList()
      ..acceptBetOdds = acceptBetOdds ?? this.acceptBetOdds
      ..awayName = awayName ?? this.awayName
      ..backAmount = backAmount ?? this.backAmount
      ..batchNo = batchNo ?? this.batchNo
      ..beginTime = beginTime ?? this.beginTime
      ..betAmount = betAmount ?? this.betAmount
      ..betNo = betNo ?? this.betNo
      ..betResult = betResult ?? this.betResult
      ..betStatus = betStatus ?? this.betStatus
      ..betTime = betTime ?? this.betTime
      ..cancelType = cancelType ?? this.cancelType
      ..childPlayId = childPlayId ?? this.childPlayId
      ..closingTime = closingTime ?? this.closingTime
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eov = eov ?? this.eov
      ..extJson = extJson ?? this.extJson
      ..firstNum = firstNum ?? this.firstNum
      ..homeName = homeName ?? this.homeName
      ..isValid = isValid ?? this.isValid
      ..marketId = marketId ?? this.marketId
      ..marketName = marketName ?? this.marketName
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchDay = matchDay ?? this.matchDay
      ..matchId = matchId ?? this.matchId
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchManageType = matchManageType ?? this.matchManageType
      ..matchName = matchName ?? this.matchName
      ..matchOver = matchOver ?? this.matchOver
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchProcessId = matchProcessId ?? this.matchProcessId
      ..matchStatusId = matchStatusId ?? this.matchStatusId
      ..matchTestScore = matchTestScore ?? this.matchTestScore
      ..matchType = matchType ?? this.matchType
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..oddFinally = oddFinally ?? this.oddFinally
      ..oddsValue = oddsValue ?? this.oddsValue
      ..optionValue = optionValue ?? this.optionValue
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderSettleRemark = orderSettleRemark ?? this.orderSettleRemark
      ..originalMarketValue = originalMarketValue ?? this.originalMarketValue
      ..outrightYear = outrightYear ?? this.outrightYear
      ..phase = phase ?? this.phase
      ..placeNum = placeNum ?? this.placeNum
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptions = playOptions ?? this.playOptions
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..playOptionsRange = playOptionsRange ?? this.playOptionsRange
      ..remark = remark ?? this.remark
      ..riskEvent = riskEvent ?? this.riskEvent
      ..score = score ?? this.score
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..secondNum = secondNum ?? this.secondNum
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
      ..settleScore = settleScore ?? this.settleScore
      ..sportId = sportId ?? this.sportId
      ..sportName = sportName ?? this.sportName
      ..startTime = startTime ?? this.startTime
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..uid = uid ?? this.uid
      ..userId = userId ?? this.userId;
  }
}

GetRhgyMatchTestScoreDataRecordx20251202 $GetRhgyMatchTestScoreDataRecordx20251202FromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251202 getRhgyMatchTestScoreDataRecordx20251202 = GetRhgyMatchTestScoreDataRecordx20251202();
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202.preBetAmount = preBetAmount;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202.maxWinAmount = maxWinAmount;
  }
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202.betAmount = betAmount;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251202Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251202Data>(
          e) as GetRhgyMatchTestScoreDataRecordx20251202Data).toList();
  if (data != null) {
    getRhgyMatchTestScoreDataRecordx20251202.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyMatchTestScoreDataRecordx20251202.totalOrders = totalOrders;
  }
  return getRhgyMatchTestScoreDataRecordx20251202;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251202ToJson(
    GetRhgyMatchTestScoreDataRecordx20251202 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['preBetAmount'] = entity.preBetAmount;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251202Extension on GetRhgyMatchTestScoreDataRecordx20251202 {
  GetRhgyMatchTestScoreDataRecordx20251202 copyWith({
    double? preBetAmount,
    double? maxWinAmount,
    double? betAmount,
    List<GetRhgyMatchTestScoreDataRecordx20251202Data>? data,
    int? totalOrders,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251202()
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders;
  }
}

GetRhgyMatchTestScoreDataRecordx20251202Data $GetRhgyMatchTestScoreDataRecordx20251202DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251202Data getRhgyMatchTestScoreDataRecordx20251202Data = GetRhgyMatchTestScoreDataRecordx20251202Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251202DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251202DataDetailList>(
          e) as GetRhgyMatchTestScoreDataRecordx20251202DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.detailList = detailList;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.id = id;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.languageName = languageName;
  }
  final dynamic managerCode = json['managerCode'];
  if (managerCode != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.marketType = marketType;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.matchType = matchType;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.orderType = orderType;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.outcome = outcome;
  }
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.preOrder = preOrder;
  }
  final int? preOrderStatus = jsonConvert.convert<int>(json['preOrderStatus']);
  if (preOrderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.preSettle = preSettle;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202Data.settledAmount = settledAmount;
  }
  return getRhgyMatchTestScoreDataRecordx20251202Data;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251202DataToJson(
    GetRhgyMatchTestScoreDataRecordx20251202Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acCode'] = entity.acCode;
  data['addition'] = entity.addition;
  data['backAmount'] = entity.backAmount;
  data['beginTime'] = entity.beginTime;
  data['beginTimeStr'] = entity.beginTimeStr;
  data['betTime'] = entity.betTime;
  data['betTimeStr'] = entity.betTimeStr;
  data['cashOutTimes'] = entity.cashOutTimes;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['id'] = entity.id;
  data['langCode'] = entity.langCode;
  data['languageName'] = entity.languageName;
  data['managerCode'] = entity.managerCode;
  data['marketType'] = entity.marketType;
  data['matchType'] = entity.matchType;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['modifyTime'] = entity.modifyTime;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['odds'] = entity.odds;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['orderType'] = entity.orderType;
  data['outcome'] = entity.outcome;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrder'] = entity.preOrder;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['preOrderVoList'] = entity.preOrderVoList;
  data['preSettle'] = entity.preSettle;
  data['profitAmount'] = entity.profitAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValue'] = entity.seriesValue;
  data['settleTime'] = entity.settleTime;
  data['settleType'] = entity.settleType;
  data['settledAmount'] = entity.settledAmount;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251202DataExtension on GetRhgyMatchTestScoreDataRecordx20251202Data {
  GetRhgyMatchTestScoreDataRecordx20251202Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetRhgyMatchTestScoreDataRecordx20251202DataDetailList>? detailList,
    String? id,
    String? langCode,
    String? languageName,
    dynamic managerCode,
    String? marketType,
    int? matchType,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic outcome,
    double? preBetAmount,
    dynamic preOrder,
    int? preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    int? settleType,
    dynamic settledAmount,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251202Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
      ..detailList = detailList ?? this.detailList
      ..id = id ?? this.id
      ..langCode = langCode ?? this.langCode
      ..languageName = languageName ?? this.languageName
      ..managerCode = managerCode ?? this.managerCode
      ..marketType = marketType ?? this.marketType
      ..matchType = matchType ?? this.matchType
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..odds = odds ?? this.odds
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderType = orderType ?? this.orderType
      ..outcome = outcome ?? this.outcome
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrder = preOrder ?? this.preOrder
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..preOrderVoList = preOrderVoList ?? this.preOrderVoList
      ..preSettle = preSettle ?? this.preSettle
      ..profitAmount = profitAmount ?? this.profitAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleTime = settleTime ?? this.settleTime
      ..settleType = settleType ?? this.settleType
      ..settledAmount = settledAmount ?? this.settledAmount;
  }
}

GetRhgyMatchTestScoreDataRecordx20251202DataDetailList $GetRhgyMatchTestScoreDataRecordx20251202DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251202DataDetailList getRhgyMatchTestScoreDataRecordx20251202DataDetailList = GetRhgyMatchTestScoreDataRecordx20251202DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.cancelType =
        cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.childPlayId =
        childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchInfo =
        matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchName =
        matchName;
  }
  final dynamic matchOver = json['matchOver'];
  if (matchOver != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchOver =
        matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.secondNum =
        secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.startTime =
        startTime;
  }
  final dynamic thirdMatchId = json['thirdMatchId'];
  if (thirdMatchId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.tournamentId =
        tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyMatchTestScoreDataRecordx20251202DataDetailList.userId = userId;
  }
  return getRhgyMatchTestScoreDataRecordx20251202DataDetailList;
}

Map<String,
    dynamic> $GetRhgyMatchTestScoreDataRecordx20251202DataDetailListToJson(
    GetRhgyMatchTestScoreDataRecordx20251202DataDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acceptBetOdds'] = entity.acceptBetOdds;
  data['awayName'] = entity.awayName;
  data['backAmount'] = entity.backAmount;
  data['batchNo'] = entity.batchNo;
  data['beginTime'] = entity.beginTime;
  data['betAmount'] = entity.betAmount;
  data['betNo'] = entity.betNo;
  data['betResult'] = entity.betResult;
  data['betStatus'] = entity.betStatus;
  data['betTime'] = entity.betTime;
  data['cancelType'] = entity.cancelType;
  data['childPlayId'] = entity.childPlayId;
  data['closingTime'] = entity.closingTime;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eov'] = entity.eov;
  data['extJson'] = entity.extJson;
  data['firstNum'] = entity.firstNum;
  data['homeName'] = entity.homeName;
  data['isValid'] = entity.isValid;
  data['marketId'] = entity.marketId;
  data['marketName'] = entity.marketName;
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchDay'] = entity.matchDay;
  data['matchId'] = entity.matchId;
  data['matchInfo'] = entity.matchInfo;
  data['matchManageType'] = entity.matchManageType;
  data['matchName'] = entity.matchName;
  data['matchOver'] = entity.matchOver;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchProcessId'] = entity.matchProcessId;
  data['matchStatusId'] = entity.matchStatusId;
  data['matchTestScore'] = entity.matchTestScore;
  data['matchType'] = entity.matchType;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['oddFinally'] = entity.oddFinally;
  data['oddsValue'] = entity.oddsValue;
  data['optionValue'] = entity.optionValue;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderSettleRemark'] = entity.orderSettleRemark;
  data['originalMarketValue'] = entity.originalMarketValue;
  data['outrightYear'] = entity.outrightYear;
  data['phase'] = entity.phase;
  data['placeNum'] = entity.placeNum;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  data['playOptionName'] = entity.playOptionName;
  data['playOptions'] = entity.playOptions;
  data['playOptionsId'] = entity.playOptionsId;
  data['playOptionsRange'] = entity.playOptionsRange;
  data['remark'] = entity.remark;
  data['riskEvent'] = entity.riskEvent;
  data['score'] = entity.score;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['secondNum'] = entity.secondNum;
  data['secondsMatchStart'] = entity.secondsMatchStart;
  data['settleScore'] = entity.settleScore;
  data['sportId'] = entity.sportId;
  data['sportName'] = entity.sportName;
  data['startTime'] = entity.startTime;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentPic'] = entity.tournamentPic;
  data['uid'] = entity.uid;
  data['userId'] = entity.userId;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251202DataDetailListExtension on GetRhgyMatchTestScoreDataRecordx20251202DataDetailList {
  GetRhgyMatchTestScoreDataRecordx20251202DataDetailList copyWith({
    dynamic acceptBetOdds,
    String? awayName,
    String? backAmount,
    String? batchNo,
    String? beginTime,
    String? betAmount,
    String? betNo,
    int? betResult,
    int? betStatus,
    dynamic betTime,
    int? cancelType,
    dynamic childPlayId,
    dynamic closingTime,
    dynamic createTime,
    String? dataSourceCode,
    String? eov,
    String? extJson,
    dynamic firstNum,
    String? homeName,
    dynamic isValid,
    String? marketId,
    String? marketName,
    String? marketType,
    String? marketValue,
    String? matchDay,
    String? matchId,
    String? matchInfo,
    dynamic matchManageType,
    String? matchName,
    dynamic matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    double? oddsValue,
    String? optionValue,
    String? orderAmountTotal,
    String? orderNo,
    String? orderSettleRemark,
    String? originalMarketValue,
    String? outrightYear,
    String? phase,
    dynamic placeNum,
    int? playId,
    String? playName,
    String? playOptionName,
    String? playOptions,
    String? playOptionsId,
    String? playOptionsRange,
    String? remark,
    String? riskEvent,
    String? score,
    String? scoreBenchmark,
    dynamic secondNum,
    dynamic secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    dynamic thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251202DataDetailList()
      ..acceptBetOdds = acceptBetOdds ?? this.acceptBetOdds
      ..awayName = awayName ?? this.awayName
      ..backAmount = backAmount ?? this.backAmount
      ..batchNo = batchNo ?? this.batchNo
      ..beginTime = beginTime ?? this.beginTime
      ..betAmount = betAmount ?? this.betAmount
      ..betNo = betNo ?? this.betNo
      ..betResult = betResult ?? this.betResult
      ..betStatus = betStatus ?? this.betStatus
      ..betTime = betTime ?? this.betTime
      ..cancelType = cancelType ?? this.cancelType
      ..childPlayId = childPlayId ?? this.childPlayId
      ..closingTime = closingTime ?? this.closingTime
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eov = eov ?? this.eov
      ..extJson = extJson ?? this.extJson
      ..firstNum = firstNum ?? this.firstNum
      ..homeName = homeName ?? this.homeName
      ..isValid = isValid ?? this.isValid
      ..marketId = marketId ?? this.marketId
      ..marketName = marketName ?? this.marketName
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchDay = matchDay ?? this.matchDay
      ..matchId = matchId ?? this.matchId
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchManageType = matchManageType ?? this.matchManageType
      ..matchName = matchName ?? this.matchName
      ..matchOver = matchOver ?? this.matchOver
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchProcessId = matchProcessId ?? this.matchProcessId
      ..matchStatusId = matchStatusId ?? this.matchStatusId
      ..matchTestScore = matchTestScore ?? this.matchTestScore
      ..matchType = matchType ?? this.matchType
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..oddFinally = oddFinally ?? this.oddFinally
      ..oddsValue = oddsValue ?? this.oddsValue
      ..optionValue = optionValue ?? this.optionValue
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderSettleRemark = orderSettleRemark ?? this.orderSettleRemark
      ..originalMarketValue = originalMarketValue ?? this.originalMarketValue
      ..outrightYear = outrightYear ?? this.outrightYear
      ..phase = phase ?? this.phase
      ..placeNum = placeNum ?? this.placeNum
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptions = playOptions ?? this.playOptions
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..playOptionsRange = playOptionsRange ?? this.playOptionsRange
      ..remark = remark ?? this.remark
      ..riskEvent = riskEvent ?? this.riskEvent
      ..score = score ?? this.score
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..secondNum = secondNum ?? this.secondNum
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
      ..settleScore = settleScore ?? this.settleScore
      ..sportId = sportId ?? this.sportId
      ..sportName = sportName ?? this.sportName
      ..startTime = startTime ?? this.startTime
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..uid = uid ?? this.uid
      ..userId = userId ?? this.userId;
  }
}

GetRhgyMatchTestScoreDataRecordx20251130 $GetRhgyMatchTestScoreDataRecordx20251130FromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251130 getRhgyMatchTestScoreDataRecordx20251130 = GetRhgyMatchTestScoreDataRecordx20251130();
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130.preBetAmount = preBetAmount;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130.maxWinAmount = maxWinAmount;
  }
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130.betAmount = betAmount;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251130Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251130Data>(
          e) as GetRhgyMatchTestScoreDataRecordx20251130Data).toList();
  if (data != null) {
    getRhgyMatchTestScoreDataRecordx20251130.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyMatchTestScoreDataRecordx20251130.totalOrders = totalOrders;
  }
  return getRhgyMatchTestScoreDataRecordx20251130;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251130ToJson(
    GetRhgyMatchTestScoreDataRecordx20251130 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['preBetAmount'] = entity.preBetAmount;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251130Extension on GetRhgyMatchTestScoreDataRecordx20251130 {
  GetRhgyMatchTestScoreDataRecordx20251130 copyWith({
    double? preBetAmount,
    double? maxWinAmount,
    double? betAmount,
    List<GetRhgyMatchTestScoreDataRecordx20251130Data>? data,
    int? totalOrders,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251130()
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders;
  }
}

GetRhgyMatchTestScoreDataRecordx20251130Data $GetRhgyMatchTestScoreDataRecordx20251130DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251130Data getRhgyMatchTestScoreDataRecordx20251130Data = GetRhgyMatchTestScoreDataRecordx20251130Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251130DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251130DataDetailList>(
          e) as GetRhgyMatchTestScoreDataRecordx20251130DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.detailList = detailList;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.id = id;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.languageName = languageName;
  }
  final dynamic managerCode = json['managerCode'];
  if (managerCode != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.marketType = marketType;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.matchType = matchType;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.orderType = orderType;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.outcome = outcome;
  }
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.preOrder = preOrder;
  }
  final int? preOrderStatus = jsonConvert.convert<int>(json['preOrderStatus']);
  if (preOrderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.preSettle = preSettle;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130Data.settledAmount = settledAmount;
  }
  return getRhgyMatchTestScoreDataRecordx20251130Data;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251130DataToJson(
    GetRhgyMatchTestScoreDataRecordx20251130Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acCode'] = entity.acCode;
  data['addition'] = entity.addition;
  data['backAmount'] = entity.backAmount;
  data['beginTime'] = entity.beginTime;
  data['beginTimeStr'] = entity.beginTimeStr;
  data['betTime'] = entity.betTime;
  data['betTimeStr'] = entity.betTimeStr;
  data['cashOutTimes'] = entity.cashOutTimes;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['id'] = entity.id;
  data['langCode'] = entity.langCode;
  data['languageName'] = entity.languageName;
  data['managerCode'] = entity.managerCode;
  data['marketType'] = entity.marketType;
  data['matchType'] = entity.matchType;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['modifyTime'] = entity.modifyTime;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['odds'] = entity.odds;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['orderType'] = entity.orderType;
  data['outcome'] = entity.outcome;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrder'] = entity.preOrder;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['preOrderVoList'] = entity.preOrderVoList;
  data['preSettle'] = entity.preSettle;
  data['profitAmount'] = entity.profitAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValue'] = entity.seriesValue;
  data['settleTime'] = entity.settleTime;
  data['settleType'] = entity.settleType;
  data['settledAmount'] = entity.settledAmount;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251130DataExtension on GetRhgyMatchTestScoreDataRecordx20251130Data {
  GetRhgyMatchTestScoreDataRecordx20251130Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetRhgyMatchTestScoreDataRecordx20251130DataDetailList>? detailList,
    String? id,
    String? langCode,
    String? languageName,
    dynamic managerCode,
    String? marketType,
    int? matchType,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic outcome,
    double? preBetAmount,
    dynamic preOrder,
    int? preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    int? settleType,
    dynamic settledAmount,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251130Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
      ..detailList = detailList ?? this.detailList
      ..id = id ?? this.id
      ..langCode = langCode ?? this.langCode
      ..languageName = languageName ?? this.languageName
      ..managerCode = managerCode ?? this.managerCode
      ..marketType = marketType ?? this.marketType
      ..matchType = matchType ?? this.matchType
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..odds = odds ?? this.odds
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderType = orderType ?? this.orderType
      ..outcome = outcome ?? this.outcome
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrder = preOrder ?? this.preOrder
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..preOrderVoList = preOrderVoList ?? this.preOrderVoList
      ..preSettle = preSettle ?? this.preSettle
      ..profitAmount = profitAmount ?? this.profitAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleTime = settleTime ?? this.settleTime
      ..settleType = settleType ?? this.settleType
      ..settledAmount = settledAmount ?? this.settledAmount;
  }
}

GetRhgyMatchTestScoreDataRecordx20251130DataDetailList $GetRhgyMatchTestScoreDataRecordx20251130DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251130DataDetailList getRhgyMatchTestScoreDataRecordx20251130DataDetailList = GetRhgyMatchTestScoreDataRecordx20251130DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.cancelType =
        cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.childPlayId =
        childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchInfo =
        matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchName =
        matchName;
  }
  final dynamic matchOver = json['matchOver'];
  if (matchOver != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchOver =
        matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.secondNum =
        secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.startTime =
        startTime;
  }
  final dynamic thirdMatchId = json['thirdMatchId'];
  if (thirdMatchId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.tournamentId =
        tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyMatchTestScoreDataRecordx20251130DataDetailList.userId = userId;
  }
  return getRhgyMatchTestScoreDataRecordx20251130DataDetailList;
}

Map<String,
    dynamic> $GetRhgyMatchTestScoreDataRecordx20251130DataDetailListToJson(
    GetRhgyMatchTestScoreDataRecordx20251130DataDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acceptBetOdds'] = entity.acceptBetOdds;
  data['awayName'] = entity.awayName;
  data['backAmount'] = entity.backAmount;
  data['batchNo'] = entity.batchNo;
  data['beginTime'] = entity.beginTime;
  data['betAmount'] = entity.betAmount;
  data['betNo'] = entity.betNo;
  data['betResult'] = entity.betResult;
  data['betStatus'] = entity.betStatus;
  data['betTime'] = entity.betTime;
  data['cancelType'] = entity.cancelType;
  data['childPlayId'] = entity.childPlayId;
  data['closingTime'] = entity.closingTime;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eov'] = entity.eov;
  data['extJson'] = entity.extJson;
  data['firstNum'] = entity.firstNum;
  data['homeName'] = entity.homeName;
  data['isValid'] = entity.isValid;
  data['marketId'] = entity.marketId;
  data['marketName'] = entity.marketName;
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchDay'] = entity.matchDay;
  data['matchId'] = entity.matchId;
  data['matchInfo'] = entity.matchInfo;
  data['matchManageType'] = entity.matchManageType;
  data['matchName'] = entity.matchName;
  data['matchOver'] = entity.matchOver;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchProcessId'] = entity.matchProcessId;
  data['matchStatusId'] = entity.matchStatusId;
  data['matchTestScore'] = entity.matchTestScore;
  data['matchType'] = entity.matchType;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['oddFinally'] = entity.oddFinally;
  data['oddsValue'] = entity.oddsValue;
  data['optionValue'] = entity.optionValue;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderSettleRemark'] = entity.orderSettleRemark;
  data['originalMarketValue'] = entity.originalMarketValue;
  data['outrightYear'] = entity.outrightYear;
  data['phase'] = entity.phase;
  data['placeNum'] = entity.placeNum;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  data['playOptionName'] = entity.playOptionName;
  data['playOptions'] = entity.playOptions;
  data['playOptionsId'] = entity.playOptionsId;
  data['playOptionsRange'] = entity.playOptionsRange;
  data['remark'] = entity.remark;
  data['riskEvent'] = entity.riskEvent;
  data['score'] = entity.score;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['secondNum'] = entity.secondNum;
  data['secondsMatchStart'] = entity.secondsMatchStart;
  data['settleScore'] = entity.settleScore;
  data['sportId'] = entity.sportId;
  data['sportName'] = entity.sportName;
  data['startTime'] = entity.startTime;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentPic'] = entity.tournamentPic;
  data['uid'] = entity.uid;
  data['userId'] = entity.userId;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251130DataDetailListExtension on GetRhgyMatchTestScoreDataRecordx20251130DataDetailList {
  GetRhgyMatchTestScoreDataRecordx20251130DataDetailList copyWith({
    dynamic acceptBetOdds,
    String? awayName,
    String? backAmount,
    String? batchNo,
    String? beginTime,
    String? betAmount,
    String? betNo,
    int? betResult,
    int? betStatus,
    dynamic betTime,
    int? cancelType,
    dynamic childPlayId,
    dynamic closingTime,
    dynamic createTime,
    String? dataSourceCode,
    String? eov,
    String? extJson,
    dynamic firstNum,
    String? homeName,
    dynamic isValid,
    String? marketId,
    String? marketName,
    String? marketType,
    String? marketValue,
    String? matchDay,
    String? matchId,
    String? matchInfo,
    dynamic matchManageType,
    String? matchName,
    dynamic matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    double? oddsValue,
    String? optionValue,
    String? orderAmountTotal,
    String? orderNo,
    String? orderSettleRemark,
    String? originalMarketValue,
    String? outrightYear,
    String? phase,
    dynamic placeNum,
    int? playId,
    String? playName,
    String? playOptionName,
    String? playOptions,
    String? playOptionsId,
    String? playOptionsRange,
    String? remark,
    String? riskEvent,
    String? score,
    String? scoreBenchmark,
    dynamic secondNum,
    dynamic secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    dynamic thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251130DataDetailList()
      ..acceptBetOdds = acceptBetOdds ?? this.acceptBetOdds
      ..awayName = awayName ?? this.awayName
      ..backAmount = backAmount ?? this.backAmount
      ..batchNo = batchNo ?? this.batchNo
      ..beginTime = beginTime ?? this.beginTime
      ..betAmount = betAmount ?? this.betAmount
      ..betNo = betNo ?? this.betNo
      ..betResult = betResult ?? this.betResult
      ..betStatus = betStatus ?? this.betStatus
      ..betTime = betTime ?? this.betTime
      ..cancelType = cancelType ?? this.cancelType
      ..childPlayId = childPlayId ?? this.childPlayId
      ..closingTime = closingTime ?? this.closingTime
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eov = eov ?? this.eov
      ..extJson = extJson ?? this.extJson
      ..firstNum = firstNum ?? this.firstNum
      ..homeName = homeName ?? this.homeName
      ..isValid = isValid ?? this.isValid
      ..marketId = marketId ?? this.marketId
      ..marketName = marketName ?? this.marketName
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchDay = matchDay ?? this.matchDay
      ..matchId = matchId ?? this.matchId
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchManageType = matchManageType ?? this.matchManageType
      ..matchName = matchName ?? this.matchName
      ..matchOver = matchOver ?? this.matchOver
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchProcessId = matchProcessId ?? this.matchProcessId
      ..matchStatusId = matchStatusId ?? this.matchStatusId
      ..matchTestScore = matchTestScore ?? this.matchTestScore
      ..matchType = matchType ?? this.matchType
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..oddFinally = oddFinally ?? this.oddFinally
      ..oddsValue = oddsValue ?? this.oddsValue
      ..optionValue = optionValue ?? this.optionValue
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderSettleRemark = orderSettleRemark ?? this.orderSettleRemark
      ..originalMarketValue = originalMarketValue ?? this.originalMarketValue
      ..outrightYear = outrightYear ?? this.outrightYear
      ..phase = phase ?? this.phase
      ..placeNum = placeNum ?? this.placeNum
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptions = playOptions ?? this.playOptions
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..playOptionsRange = playOptionsRange ?? this.playOptionsRange
      ..remark = remark ?? this.remark
      ..riskEvent = riskEvent ?? this.riskEvent
      ..score = score ?? this.score
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..secondNum = secondNum ?? this.secondNum
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
      ..settleScore = settleScore ?? this.settleScore
      ..sportId = sportId ?? this.sportId
      ..sportName = sportName ?? this.sportName
      ..startTime = startTime ?? this.startTime
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..uid = uid ?? this.uid
      ..userId = userId ?? this.userId;
  }
}

GetRhgyMatchTestScoreDataRecordx20251026 $GetRhgyMatchTestScoreDataRecordx20251026FromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251026 getRhgyMatchTestScoreDataRecordx20251026 = GetRhgyMatchTestScoreDataRecordx20251026();
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026.preBetAmount = preBetAmount;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026.maxWinAmount = maxWinAmount;
  }
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026.betAmount = betAmount;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251026Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251026Data>(
          e) as GetRhgyMatchTestScoreDataRecordx20251026Data).toList();
  if (data != null) {
    getRhgyMatchTestScoreDataRecordx20251026.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyMatchTestScoreDataRecordx20251026.totalOrders = totalOrders;
  }
  return getRhgyMatchTestScoreDataRecordx20251026;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251026ToJson(
    GetRhgyMatchTestScoreDataRecordx20251026 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['preBetAmount'] = entity.preBetAmount;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251026Extension on GetRhgyMatchTestScoreDataRecordx20251026 {
  GetRhgyMatchTestScoreDataRecordx20251026 copyWith({
    double? preBetAmount,
    double? maxWinAmount,
    double? betAmount,
    List<GetRhgyMatchTestScoreDataRecordx20251026Data>? data,
    int? totalOrders,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251026()
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders;
  }
}

GetRhgyMatchTestScoreDataRecordx20251026Data $GetRhgyMatchTestScoreDataRecordx20251026DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251026Data getRhgyMatchTestScoreDataRecordx20251026Data = GetRhgyMatchTestScoreDataRecordx20251026Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetRhgyMatchTestScoreDataRecordx20251026DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyMatchTestScoreDataRecordx20251026DataDetailList>(
          e) as GetRhgyMatchTestScoreDataRecordx20251026DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.detailList = detailList;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.id = id;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.languageName = languageName;
  }
  final dynamic managerCode = json['managerCode'];
  if (managerCode != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.marketType = marketType;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.matchType = matchType;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.orderType = orderType;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.outcome = outcome;
  }
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.preOrder = preOrder;
  }
  final int? preOrderStatus = jsonConvert.convert<int>(json['preOrderStatus']);
  if (preOrderStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.preSettle = preSettle;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026Data.settledAmount = settledAmount;
  }
  return getRhgyMatchTestScoreDataRecordx20251026Data;
}

Map<String, dynamic> $GetRhgyMatchTestScoreDataRecordx20251026DataToJson(
    GetRhgyMatchTestScoreDataRecordx20251026Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acCode'] = entity.acCode;
  data['addition'] = entity.addition;
  data['backAmount'] = entity.backAmount;
  data['beginTime'] = entity.beginTime;
  data['beginTimeStr'] = entity.beginTimeStr;
  data['betTime'] = entity.betTime;
  data['betTimeStr'] = entity.betTimeStr;
  data['cashOutTimes'] = entity.cashOutTimes;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['id'] = entity.id;
  data['langCode'] = entity.langCode;
  data['languageName'] = entity.languageName;
  data['managerCode'] = entity.managerCode;
  data['marketType'] = entity.marketType;
  data['matchType'] = entity.matchType;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['modifyTime'] = entity.modifyTime;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['odds'] = entity.odds;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['orderType'] = entity.orderType;
  data['outcome'] = entity.outcome;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrder'] = entity.preOrder;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['preOrderVoList'] = entity.preOrderVoList;
  data['preSettle'] = entity.preSettle;
  data['profitAmount'] = entity.profitAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValue'] = entity.seriesValue;
  data['settleTime'] = entity.settleTime;
  data['settleType'] = entity.settleType;
  data['settledAmount'] = entity.settledAmount;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251026DataExtension on GetRhgyMatchTestScoreDataRecordx20251026Data {
  GetRhgyMatchTestScoreDataRecordx20251026Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetRhgyMatchTestScoreDataRecordx20251026DataDetailList>? detailList,
    String? id,
    String? langCode,
    String? languageName,
    dynamic managerCode,
    String? marketType,
    int? matchType,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic outcome,
    double? preBetAmount,
    dynamic preOrder,
    int? preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    int? settleType,
    dynamic settledAmount,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251026Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
      ..detailList = detailList ?? this.detailList
      ..id = id ?? this.id
      ..langCode = langCode ?? this.langCode
      ..languageName = languageName ?? this.languageName
      ..managerCode = managerCode ?? this.managerCode
      ..marketType = marketType ?? this.marketType
      ..matchType = matchType ?? this.matchType
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..odds = odds ?? this.odds
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderType = orderType ?? this.orderType
      ..outcome = outcome ?? this.outcome
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrder = preOrder ?? this.preOrder
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..preOrderVoList = preOrderVoList ?? this.preOrderVoList
      ..preSettle = preSettle ?? this.preSettle
      ..profitAmount = profitAmount ?? this.profitAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleTime = settleTime ?? this.settleTime
      ..settleType = settleType ?? this.settleType
      ..settledAmount = settledAmount ?? this.settledAmount;
  }
}

GetRhgyMatchTestScoreDataRecordx20251026DataDetailList $GetRhgyMatchTestScoreDataRecordx20251026DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyMatchTestScoreDataRecordx20251026DataDetailList getRhgyMatchTestScoreDataRecordx20251026DataDetailList = GetRhgyMatchTestScoreDataRecordx20251026DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.cancelType =
        cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.childPlayId =
        childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchInfo =
        matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchName =
        matchName;
  }
  final dynamic matchOver = json['matchOver'];
  if (matchOver != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchOver =
        matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.secondNum =
        secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.startTime =
        startTime;
  }
  final dynamic thirdMatchId = json['thirdMatchId'];
  if (thirdMatchId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.tournamentId =
        tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyMatchTestScoreDataRecordx20251026DataDetailList.userId = userId;
  }
  return getRhgyMatchTestScoreDataRecordx20251026DataDetailList;
}

Map<String,
    dynamic> $GetRhgyMatchTestScoreDataRecordx20251026DataDetailListToJson(
    GetRhgyMatchTestScoreDataRecordx20251026DataDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acceptBetOdds'] = entity.acceptBetOdds;
  data['awayName'] = entity.awayName;
  data['backAmount'] = entity.backAmount;
  data['batchNo'] = entity.batchNo;
  data['beginTime'] = entity.beginTime;
  data['betAmount'] = entity.betAmount;
  data['betNo'] = entity.betNo;
  data['betResult'] = entity.betResult;
  data['betStatus'] = entity.betStatus;
  data['betTime'] = entity.betTime;
  data['cancelType'] = entity.cancelType;
  data['childPlayId'] = entity.childPlayId;
  data['closingTime'] = entity.closingTime;
  data['createTime'] = entity.createTime;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eov'] = entity.eov;
  data['extJson'] = entity.extJson;
  data['firstNum'] = entity.firstNum;
  data['homeName'] = entity.homeName;
  data['isValid'] = entity.isValid;
  data['marketId'] = entity.marketId;
  data['marketName'] = entity.marketName;
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchDay'] = entity.matchDay;
  data['matchId'] = entity.matchId;
  data['matchInfo'] = entity.matchInfo;
  data['matchManageType'] = entity.matchManageType;
  data['matchName'] = entity.matchName;
  data['matchOver'] = entity.matchOver;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchProcessId'] = entity.matchProcessId;
  data['matchStatusId'] = entity.matchStatusId;
  data['matchTestScore'] = entity.matchTestScore;
  data['matchType'] = entity.matchType;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['oddFinally'] = entity.oddFinally;
  data['oddsValue'] = entity.oddsValue;
  data['optionValue'] = entity.optionValue;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderSettleRemark'] = entity.orderSettleRemark;
  data['originalMarketValue'] = entity.originalMarketValue;
  data['outrightYear'] = entity.outrightYear;
  data['phase'] = entity.phase;
  data['placeNum'] = entity.placeNum;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  data['playOptionName'] = entity.playOptionName;
  data['playOptions'] = entity.playOptions;
  data['playOptionsId'] = entity.playOptionsId;
  data['playOptionsRange'] = entity.playOptionsRange;
  data['remark'] = entity.remark;
  data['riskEvent'] = entity.riskEvent;
  data['score'] = entity.score;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['secondNum'] = entity.secondNum;
  data['secondsMatchStart'] = entity.secondsMatchStart;
  data['settleScore'] = entity.settleScore;
  data['sportId'] = entity.sportId;
  data['sportName'] = entity.sportName;
  data['startTime'] = entity.startTime;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['tournamentPic'] = entity.tournamentPic;
  data['uid'] = entity.uid;
  data['userId'] = entity.userId;
  return data;
}

extension GetRhgyMatchTestScoreDataRecordx20251026DataDetailListExtension on GetRhgyMatchTestScoreDataRecordx20251026DataDetailList {
  GetRhgyMatchTestScoreDataRecordx20251026DataDetailList copyWith({
    dynamic acceptBetOdds,
    String? awayName,
    String? backAmount,
    String? batchNo,
    String? beginTime,
    String? betAmount,
    String? betNo,
    int? betResult,
    int? betStatus,
    dynamic betTime,
    int? cancelType,
    dynamic childPlayId,
    dynamic closingTime,
    dynamic createTime,
    String? dataSourceCode,
    String? eov,
    String? extJson,
    dynamic firstNum,
    String? homeName,
    dynamic isValid,
    String? marketId,
    String? marketName,
    String? marketType,
    String? marketValue,
    String? matchDay,
    String? matchId,
    String? matchInfo,
    dynamic matchManageType,
    String? matchName,
    dynamic matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    double? oddsValue,
    String? optionValue,
    String? orderAmountTotal,
    String? orderNo,
    String? orderSettleRemark,
    String? originalMarketValue,
    String? outrightYear,
    String? phase,
    dynamic placeNum,
    int? playId,
    String? playName,
    String? playOptionName,
    String? playOptions,
    String? playOptionsId,
    String? playOptionsRange,
    String? remark,
    String? riskEvent,
    String? score,
    String? scoreBenchmark,
    dynamic secondNum,
    dynamic secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    dynamic thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetRhgyMatchTestScoreDataRecordx20251026DataDetailList()
      ..acceptBetOdds = acceptBetOdds ?? this.acceptBetOdds
      ..awayName = awayName ?? this.awayName
      ..backAmount = backAmount ?? this.backAmount
      ..batchNo = batchNo ?? this.batchNo
      ..beginTime = beginTime ?? this.beginTime
      ..betAmount = betAmount ?? this.betAmount
      ..betNo = betNo ?? this.betNo
      ..betResult = betResult ?? this.betResult
      ..betStatus = betStatus ?? this.betStatus
      ..betTime = betTime ?? this.betTime
      ..cancelType = cancelType ?? this.cancelType
      ..childPlayId = childPlayId ?? this.childPlayId
      ..closingTime = closingTime ?? this.closingTime
      ..createTime = createTime ?? this.createTime
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eov = eov ?? this.eov
      ..extJson = extJson ?? this.extJson
      ..firstNum = firstNum ?? this.firstNum
      ..homeName = homeName ?? this.homeName
      ..isValid = isValid ?? this.isValid
      ..marketId = marketId ?? this.marketId
      ..marketName = marketName ?? this.marketName
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchDay = matchDay ?? this.matchDay
      ..matchId = matchId ?? this.matchId
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchManageType = matchManageType ?? this.matchManageType
      ..matchName = matchName ?? this.matchName
      ..matchOver = matchOver ?? this.matchOver
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchProcessId = matchProcessId ?? this.matchProcessId
      ..matchStatusId = matchStatusId ?? this.matchStatusId
      ..matchTestScore = matchTestScore ?? this.matchTestScore
      ..matchType = matchType ?? this.matchType
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..oddFinally = oddFinally ?? this.oddFinally
      ..oddsValue = oddsValue ?? this.oddsValue
      ..optionValue = optionValue ?? this.optionValue
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderSettleRemark = orderSettleRemark ?? this.orderSettleRemark
      ..originalMarketValue = originalMarketValue ?? this.originalMarketValue
      ..outrightYear = outrightYear ?? this.outrightYear
      ..phase = phase ?? this.phase
      ..placeNum = placeNum ?? this.placeNum
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptions = playOptions ?? this.playOptions
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..playOptionsRange = playOptionsRange ?? this.playOptionsRange
      ..remark = remark ?? this.remark
      ..riskEvent = riskEvent ?? this.riskEvent
      ..score = score ?? this.score
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..secondNum = secondNum ?? this.secondNum
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
      ..settleScore = settleScore ?? this.settleScore
      ..sportId = sportId ?? this.sportId
      ..sportName = sportName ?? this.sportName
      ..startTime = startTime ?? this.startTime
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..uid = uid ?? this.uid
      ..userId = userId ?? this.userId;
  }
}