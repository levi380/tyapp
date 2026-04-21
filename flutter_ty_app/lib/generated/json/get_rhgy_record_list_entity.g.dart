import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_rhgy_record_list_entity.dart';

GetRhgyRecordListEntity $GetRhgyRecordListEntityFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordListEntity getRhgyRecordListEntity = GetRhgyRecordListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getRhgyRecordListEntity.code = code;
  }
  final GetRhgyRecordListData? data = jsonConvert.convert<
      GetRhgyRecordListData>(json['data']);
  if (data != null) {
    getRhgyRecordListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getRhgyRecordListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getRhgyRecordListEntity.ts = ts;
  }
  return getRhgyRecordListEntity;
}

Map<String, dynamic> $GetRhgyRecordListEntityToJson(
    GetRhgyRecordListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetRhgyRecordListEntityExtension on GetRhgyRecordListEntity {
  GetRhgyRecordListEntity copyWith({
    String? code,
    GetRhgyRecordListData? data,
    String? msg,
    int? ts,
  }) {
    return GetRhgyRecordListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetRhgyRecordListData $GetRhgyRecordListDataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordListData getRhgyRecordListData = GetRhgyRecordListData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getRhgyRecordListData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getRhgyRecordListData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getRhgyRecordListData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getRhgyRecordListData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getRhgyRecordListData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getRhgyRecordListData.hasPrevious = hasPrevious;
  }
  final String? maxWinTotalAmount = jsonConvert.convert<String>(
      json['maxWinTotalAmount']);
  if (maxWinTotalAmount != null) {
    getRhgyRecordListData.maxWinTotalAmount = maxWinTotalAmount;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getRhgyRecordListData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getRhgyRecordListData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getRhgyRecordListData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getRhgyRecordListData.profit = profit;
  }
  final GetRhgyRecordListDataRecord? record = jsonConvert.convert<
      GetRhgyRecordListDataRecord>(json['record']);
  if (record != null) {
    getRhgyRecordListData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getRhgyRecordListData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getRhgyRecordListData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getRhgyRecordListData.size = size;
  }
  final String? subOrderTotal = jsonConvert.convert<String>(
      json['subOrderTotal']);
  if (subOrderTotal != null) {
    getRhgyRecordListData.subOrderTotal = subOrderTotal;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getRhgyRecordListData.total = total;
  }
  return getRhgyRecordListData;
}

Map<String, dynamic> $GetRhgyRecordListDataToJson(
    GetRhgyRecordListData entity) {
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

extension GetRhgyRecordListDataExtension on GetRhgyRecordListData {
  GetRhgyRecordListData copyWith({
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
    GetRhgyRecordListDataRecord? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? subOrderTotal,
    String? total,
  }) {
    return GetRhgyRecordListData()
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

GetRhgyRecordListDataRecord $GetRhgyRecordListDataRecordFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordListDataRecord getRhgyRecordListDataRecord = GetRhgyRecordListDataRecord();
  final GetRhgyRecordListDataRecordx20250915? x20250915 = jsonConvert.convert<
      GetRhgyRecordListDataRecordx20250915>(json['2025-09-15']);
  if (x20250915 != null) {
    getRhgyRecordListDataRecord.x20250915 = x20250915;
  }
  return getRhgyRecordListDataRecord;
}

Map<String, dynamic> $GetRhgyRecordListDataRecordToJson(
    GetRhgyRecordListDataRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['2025-09-15'] = entity.x20250915.toJson();
  return data;
}

extension GetRhgyRecordListDataRecordExtension on GetRhgyRecordListDataRecord {
  GetRhgyRecordListDataRecord copyWith({
    GetRhgyRecordListDataRecordx20250915? x20250915,
  }) {
    return GetRhgyRecordListDataRecord()
      ..x20250915 = x20250915 ?? this.x20250915;
  }
}

GetRhgyRecordListDataRecordx20250915 $GetRhgyRecordListDataRecordx20250915FromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordListDataRecordx20250915 getRhgyRecordListDataRecordx20250915 = GetRhgyRecordListDataRecordx20250915();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyRecordListDataRecordx20250915.betAmount = betAmount;
  }
  final List<
      GetRhgyRecordListDataRecordx20250915Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetRhgyRecordListDataRecordx20250915Data>(
          e) as GetRhgyRecordListDataRecordx20250915Data).toList();
  if (data != null) {
    getRhgyRecordListDataRecordx20250915.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyRecordListDataRecordx20250915.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgyRecordListDataRecordx20250915.profit = profit;
  }
  return getRhgyRecordListDataRecordx20250915;
}

Map<String, dynamic> $GetRhgyRecordListDataRecordx20250915ToJson(
    GetRhgyRecordListDataRecordx20250915 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgyRecordListDataRecordx20250915Extension on GetRhgyRecordListDataRecordx20250915 {
  GetRhgyRecordListDataRecordx20250915 copyWith({
    double? betAmount,
    List<GetRhgyRecordListDataRecordx20250915Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgyRecordListDataRecordx20250915()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgyRecordListDataRecordx20250915Data $GetRhgyRecordListDataRecordx20250915DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordListDataRecordx20250915Data getRhgyRecordListDataRecordx20250915Data = GetRhgyRecordListDataRecordx20250915Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyRecordListDataRecordx20250915Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyRecordListDataRecordx20250915Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyRecordListDataRecordx20250915Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyRecordListDataRecordx20250915Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyRecordListDataRecordx20250915Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyRecordListDataRecordx20250915Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyRecordListDataRecordx20250915Data.betTimeStr = betTimeStr;
  }
  final List<
      GetRhgyRecordListDataRecordx20250915DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyRecordListDataRecordx20250915DataDetailList>(
          e) as GetRhgyRecordListDataRecordx20250915DataDetailList).toList();
  if (detailList != null) {
    getRhgyRecordListDataRecordx20250915Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgyRecordListDataRecordx20250915Data.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyRecordListDataRecordx20250915Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgyRecordListDataRecordx20250915Data.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyRecordListDataRecordx20250915Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyRecordListDataRecordx20250915Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgyRecordListDataRecordx20250915Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyRecordListDataRecordx20250915Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getRhgyRecordListDataRecordx20250915Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgyRecordListDataRecordx20250915Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyRecordListDataRecordx20250915Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyRecordListDataRecordx20250915Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyRecordListDataRecordx20250915Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyRecordListDataRecordx20250915Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyRecordListDataRecordx20250915Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyRecordListDataRecordx20250915Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyRecordListDataRecordx20250915Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgyRecordListDataRecordx20250915Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgyRecordListDataRecordx20250915Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyRecordListDataRecordx20250915Data.outcome = outcome;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyRecordListDataRecordx20250915Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgyRecordListDataRecordx20250915Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgyRecordListDataRecordx20250915Data.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyRecordListDataRecordx20250915Data.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgyRecordListDataRecordx20250915Data.preSettle = preSettle;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getRhgyRecordListDataRecordx20250915Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyRecordListDataRecordx20250915Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyRecordListDataRecordx20250915Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyRecordListDataRecordx20250915Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyRecordListDataRecordx20250915Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyRecordListDataRecordx20250915Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyRecordListDataRecordx20250915Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyRecordListDataRecordx20250915Data.settledAmount = settledAmount;
  }
  return getRhgyRecordListDataRecordx20250915Data;
}

Map<String, dynamic> $GetRhgyRecordListDataRecordx20250915DataToJson(
    GetRhgyRecordListDataRecordx20250915Data entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acCode'] = entity.acCode;
  data['addition'] = entity.addition;
  data['backAmount'] = entity.backAmount;
  data['beginTime'] = entity.beginTime;
  data['beginTimeStr'] = entity.beginTimeStr;
  data['betTime'] = entity.betTime;
  data['betTimeStr'] = entity.betTimeStr;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['enablePreSettle'] = entity.enablePreSettle;
  data['id'] = entity.id;
  data['initPresettleWs'] = entity.initPresettleWs;
  data['langCode'] = entity.langCode;
  data['languageName'] = entity.languageName;
  data['managerCode'] = entity.managerCode;
  data['marketType'] = entity.marketType;
  data['matchType'] = entity.matchType;
  data['maxCashout'] = entity.maxCashout;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['modifyTime'] = entity.modifyTime;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['odds'] = entity.odds;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['orderType'] = entity.orderType;
  data['orderVOS'] = entity.orderVOS;
  data['outcome'] = entity.outcome;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrder'] = entity.preOrder;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['preOrderVoList'] = entity.preOrderVoList;
  data['preSettle'] = entity.preSettle;
  data['preSettleBetAmount'] = entity.preSettleBetAmount;
  data['profitAmount'] = entity.profitAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValue'] = entity.seriesValue;
  data['settleTime'] = entity.settleTime;
  data['settleType'] = entity.settleType;
  data['settledAmount'] = entity.settledAmount;
  return data;
}

extension GetRhgyRecordListDataRecordx20250915DataExtension on GetRhgyRecordListDataRecordx20250915Data {
  GetRhgyRecordListDataRecordx20250915Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetRhgyRecordListDataRecordx20250915DataDetailList>? detailList,
    bool? enablePreSettle,
    String? id,
    bool? initPresettleWs,
    String? langCode,
    String? languageName,
    int? managerCode,
    String? marketType,
    dynamic matchType,
    int? maxCashout,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    int? orderType,
    dynamic orderVOS,
    dynamic outcome,
    int? preBetAmount,
    dynamic preOrder,
    dynamic preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    double? preSettleBetAmount,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    int? settleType,
    dynamic settledAmount,
  }) {
    return GetRhgyRecordListDataRecordx20250915Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..detailList = detailList ?? this.detailList
      ..enablePreSettle = enablePreSettle ?? this.enablePreSettle
      ..id = id ?? this.id
      ..initPresettleWs = initPresettleWs ?? this.initPresettleWs
      ..langCode = langCode ?? this.langCode
      ..languageName = languageName ?? this.languageName
      ..managerCode = managerCode ?? this.managerCode
      ..marketType = marketType ?? this.marketType
      ..matchType = matchType ?? this.matchType
      ..maxCashout = maxCashout ?? this.maxCashout
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..odds = odds ?? this.odds
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderType = orderType ?? this.orderType
      ..orderVOS = orderVOS ?? this.orderVOS
      ..outcome = outcome ?? this.outcome
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrder = preOrder ?? this.preOrder
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..preOrderVoList = preOrderVoList ?? this.preOrderVoList
      ..preSettle = preSettle ?? this.preSettle
      ..preSettleBetAmount = preSettleBetAmount ?? this.preSettleBetAmount
      ..profitAmount = profitAmount ?? this.profitAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleTime = settleTime ?? this.settleTime
      ..settleType = settleType ?? this.settleType
      ..settledAmount = settledAmount ?? this.settledAmount;
  }
}

GetRhgyRecordListDataRecordx20250915DataDetailList $GetRhgyRecordListDataRecordx20250915DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordListDataRecordx20250915DataDetailList getRhgyRecordListDataRecordx20250915DataDetailList = GetRhgyRecordListDataRecordx20250915DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.cancelType = cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchInfo = matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchOver = matchOver;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.oddFinally = oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.secondNum = secondNum;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.startTime = startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyRecordListDataRecordx20250915DataDetailList.userId = userId;
  }
  return getRhgyRecordListDataRecordx20250915DataDetailList;
}

Map<String, dynamic> $GetRhgyRecordListDataRecordx20250915DataDetailListToJson(
    GetRhgyRecordListDataRecordx20250915DataDetailList entity) {
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

extension GetRhgyRecordListDataRecordx20250915DataDetailListExtension on GetRhgyRecordListDataRecordx20250915DataDetailList {
  GetRhgyRecordListDataRecordx20250915DataDetailList copyWith({
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
    String? childPlayId,
    String? closingTime,
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
    int? matchManageType,
    String? matchName,
    int? matchOver,
    String? matchPeriodId,
    int? matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    double? oddsValue,
    String? optionValue,
    String? orderAmountTotal,
    String? orderNo,
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
    String? secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    String? thirdMatchId,
    String? tournamentId,
    int? tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetRhgyRecordListDataRecordx20250915DataDetailList()
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