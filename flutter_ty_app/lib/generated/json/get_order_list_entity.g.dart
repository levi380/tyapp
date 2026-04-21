import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_list_entity.dart';

GetOrderListEntity $GetOrderListEntityFromJson(Map<String, dynamic> json) {
  final GetOrderListEntity getOrderListEntity = GetOrderListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getOrderListEntity.code = code;
  }
  final GetOrderListData? data = jsonConvert.convert<GetOrderListData>(
      json['data']);
  if (data != null) {
    getOrderListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getOrderListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getOrderListEntity.ts = ts;
  }
  return getOrderListEntity;
}

Map<String, dynamic> $GetOrderListEntityToJson(GetOrderListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetOrderListEntityExtension on GetOrderListEntity {
  GetOrderListEntity copyWith({
    String? code,
    GetOrderListData? data,
    String? msg,
    int? ts,
  }) {
    return GetOrderListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetOrderListData $GetOrderListDataFromJson(Map<String, dynamic> json) {
  final GetOrderListData getOrderListData = GetOrderListData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getOrderListData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getOrderListData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getOrderListData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getOrderListData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getOrderListData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getOrderListData.hasPrevious = hasPrevious;
  }
  final String? maxWinTotalAmount = jsonConvert.convert<String>(
      json['maxWinTotalAmount']);
  if (maxWinTotalAmount != null) {
    getOrderListData.maxWinTotalAmount = maxWinTotalAmount;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getOrderListData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getOrderListData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getOrderListData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getOrderListData.profit = profit;
  }
  final GetOrderListDataRecord? record = jsonConvert.convert<
      GetOrderListDataRecord>(json['record']);
  if (record != null) {
    getOrderListData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getOrderListData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getOrderListData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getOrderListData.size = size;
  }
  final String? subOrderTotal = jsonConvert.convert<String>(
      json['subOrderTotal']);
  if (subOrderTotal != null) {
    getOrderListData.subOrderTotal = subOrderTotal;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getOrderListData.total = total;
  }
  return getOrderListData;
}

Map<String, dynamic> $GetOrderListDataToJson(GetOrderListData entity) {
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

extension GetOrderListDataExtension on GetOrderListData {
  GetOrderListData copyWith({
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
    GetOrderListDataRecord? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? subOrderTotal,
    String? total,
  }) {
    return GetOrderListData()
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

GetOrderListDataRecord $GetOrderListDataRecordFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecord getOrderListDataRecord = GetOrderListDataRecord();
  final GetOrderListDataRecordx20260116? x20260116 = jsonConvert.convert<
      GetOrderListDataRecordx20260116>(json['2026-01-16']);
  if (x20260116 != null) {
    getOrderListDataRecord.x20260116 = x20260116;
  }
  final GetOrderListDataRecordx20260115? x20260115 = jsonConvert.convert<
      GetOrderListDataRecordx20260115>(json['2026-01-15']);
  if (x20260115 != null) {
    getOrderListDataRecord.x20260115 = x20260115;
  }
  final GetOrderListDataRecordx20260112? x20260112 = jsonConvert.convert<
      GetOrderListDataRecordx20260112>(json['2026-01-12']);
  if (x20260112 != null) {
    getOrderListDataRecord.x20260112 = x20260112;
  }
  final GetOrderListDataRecordx20260111? x20260111 = jsonConvert.convert<
      GetOrderListDataRecordx20260111>(json['2026-01-11']);
  if (x20260111 != null) {
    getOrderListDataRecord.x20260111 = x20260111;
  }
  return getOrderListDataRecord;
}

Map<String, dynamic> $GetOrderListDataRecordToJson(
    GetOrderListDataRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['2026-01-16'] = entity.x20260116.toJson();
  data['2026-01-15'] = entity.x20260115.toJson();
  data['2026-01-12'] = entity.x20260112.toJson();
  data['2026-01-11'] = entity.x20260111.toJson();
  return data;
}

extension GetOrderListDataRecordExtension on GetOrderListDataRecord {
  GetOrderListDataRecord copyWith({
    GetOrderListDataRecordx20260116? x20260116,
    GetOrderListDataRecordx20260115? x20260115,
    GetOrderListDataRecordx20260112? x20260112,
    GetOrderListDataRecordx20260111? x20260111,
  }) {
    return GetOrderListDataRecord()
      ..x20260116 = x20260116 ?? this.x20260116
      ..x20260115 = x20260115 ?? this.x20260115
      ..x20260112 = x20260112 ?? this.x20260112
      ..x20260111 = x20260111 ?? this.x20260111;
  }
}

GetOrderListDataRecordx20260116 $GetOrderListDataRecordx20260116FromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260116 getOrderListDataRecordx20260116 = GetOrderListDataRecordx20260116();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260116.betAmount = betAmount;
  }
  final List<GetOrderListDataRecordx20260116Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetOrderListDataRecordx20260116Data>(
          e) as GetOrderListDataRecordx20260116Data).toList();
  if (data != null) {
    getOrderListDataRecordx20260116.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getOrderListDataRecordx20260116.totalOrders = totalOrders;
  }
  final double? profit = jsonConvert.convert<double>(json['profit']);
  if (profit != null) {
    getOrderListDataRecordx20260116.profit = profit;
  }
  return getOrderListDataRecordx20260116;
}

Map<String, dynamic> $GetOrderListDataRecordx20260116ToJson(
    GetOrderListDataRecordx20260116 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetOrderListDataRecordx20260116Extension on GetOrderListDataRecordx20260116 {
  GetOrderListDataRecordx20260116 copyWith({
    double? betAmount,
    List<GetOrderListDataRecordx20260116Data>? data,
    int? totalOrders,
    double? profit,
  }) {
    return GetOrderListDataRecordx20260116()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetOrderListDataRecordx20260116Data $GetOrderListDataRecordx20260116DataFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260116Data getOrderListDataRecordx20260116Data = GetOrderListDataRecordx20260116Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getOrderListDataRecordx20260116Data.acCode = acCode;
  }
  final dynamic addition = json['addition'];
  if (addition != null) {
    getOrderListDataRecordx20260116Data.addition = addition;
  }
  final double? backAmount = jsonConvert.convert<double>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260116Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getOrderListDataRecordx20260116Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getOrderListDataRecordx20260116Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getOrderListDataRecordx20260116Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getOrderListDataRecordx20260116Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getOrderListDataRecordx20260116Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetOrderListDataRecordx20260116DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetOrderListDataRecordx20260116DataDetailList>(
          e) as GetOrderListDataRecordx20260116DataDetailList).toList();
  if (detailList != null) {
    getOrderListDataRecordx20260116Data.detailList = detailList;
  }
  final dynamic enablePreSettle = json['enablePreSettle'];
  if (enablePreSettle != null) {
    getOrderListDataRecordx20260116Data.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getOrderListDataRecordx20260116Data.id = id;
  }
  final dynamic initPresettleWs = json['initPresettleWs'];
  if (initPresettleWs != null) {
    getOrderListDataRecordx20260116Data.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getOrderListDataRecordx20260116Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getOrderListDataRecordx20260116Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getOrderListDataRecordx20260116Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260116Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getOrderListDataRecordx20260116Data.matchType = matchType;
  }
  final dynamic maxCashout = json['maxCashout'];
  if (maxCashout != null) {
    getOrderListDataRecordx20260116Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getOrderListDataRecordx20260116Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getOrderListDataRecordx20260116Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getOrderListDataRecordx20260116Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getOrderListDataRecordx20260116Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260116Data.orderAmountTotal = orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260116Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getOrderListDataRecordx20260116Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getOrderListDataRecordx20260116Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getOrderListDataRecordx20260116Data.orderVOS = orderVOS;
  }
  final int? outcome = jsonConvert.convert<int>(json['outcome']);
  if (outcome != null) {
    getOrderListDataRecordx20260116Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getOrderListDataRecordx20260116Data.preBetAmount = preBetAmount;
  }
  final int? preOrder = jsonConvert.convert<int>(json['preOrder']);
  if (preOrder != null) {
    getOrderListDataRecordx20260116Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getOrderListDataRecordx20260116Data.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getOrderListDataRecordx20260116Data.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getOrderListDataRecordx20260116Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getOrderListDataRecordx20260116Data.preSettleBetAmount = preSettleBetAmount;
  }
  final double? profitAmount = jsonConvert.convert<double>(
      json['profitAmount']);
  if (profitAmount != null) {
    getOrderListDataRecordx20260116Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getOrderListDataRecordx20260116Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getOrderListDataRecordx20260116Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getOrderListDataRecordx20260116Data.seriesValue = seriesValue;
  }
  final String? settleTime = jsonConvert.convert<String>(json['settleTime']);
  if (settleTime != null) {
    getOrderListDataRecordx20260116Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getOrderListDataRecordx20260116Data.settleType = settleType;
  }
  final double? settledAmount = jsonConvert.convert<double>(
      json['settledAmount']);
  if (settledAmount != null) {
    getOrderListDataRecordx20260116Data.settledAmount = settledAmount;
  }
  return getOrderListDataRecordx20260116Data;
}

Map<String, dynamic> $GetOrderListDataRecordx20260116DataToJson(
    GetOrderListDataRecordx20260116Data entity) {
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

extension GetOrderListDataRecordx20260116DataExtension on GetOrderListDataRecordx20260116Data {
  GetOrderListDataRecordx20260116Data copyWith({
    String? acCode,
    dynamic addition,
    double? backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetOrderListDataRecordx20260116DataDetailList>? detailList,
    dynamic enablePreSettle,
    String? id,
    dynamic initPresettleWs,
    String? langCode,
    String? languageName,
    int? managerCode,
    String? marketType,
    dynamic matchType,
    dynamic maxCashout,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic orderVOS,
    int? outcome,
    dynamic preBetAmount,
    int? preOrder,
    dynamic preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic preSettleBetAmount,
    double? profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    String? settleTime,
    int? settleType,
    double? settledAmount,
  }) {
    return GetOrderListDataRecordx20260116Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
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

GetOrderListDataRecordx20260116DataDetailList $GetOrderListDataRecordx20260116DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260116DataDetailList getOrderListDataRecordx20260116DataDetailList = GetOrderListDataRecordx20260116DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getOrderListDataRecordx20260116DataDetailList.acceptBetOdds = acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getOrderListDataRecordx20260116DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260116DataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getOrderListDataRecordx20260116DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getOrderListDataRecordx20260116DataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260116DataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getOrderListDataRecordx20260116DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getOrderListDataRecordx20260116DataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getOrderListDataRecordx20260116DataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getOrderListDataRecordx20260116DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getOrderListDataRecordx20260116DataDetailList.cancelType = cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getOrderListDataRecordx20260116DataDetailList.childPlayId = childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getOrderListDataRecordx20260116DataDetailList.closingTime = closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getOrderListDataRecordx20260116DataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getOrderListDataRecordx20260116DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getOrderListDataRecordx20260116DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getOrderListDataRecordx20260116DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getOrderListDataRecordx20260116DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getOrderListDataRecordx20260116DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getOrderListDataRecordx20260116DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getOrderListDataRecordx20260116DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getOrderListDataRecordx20260116DataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260116DataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getOrderListDataRecordx20260116DataDetailList.marketValue = marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getOrderListDataRecordx20260116DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getOrderListDataRecordx20260116DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getOrderListDataRecordx20260116DataDetailList.matchInfo = matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getOrderListDataRecordx20260116DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getOrderListDataRecordx20260116DataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getOrderListDataRecordx20260116DataDetailList.matchOver = matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getOrderListDataRecordx20260116DataDetailList.matchPeriodId = matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getOrderListDataRecordx20260116DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getOrderListDataRecordx20260116DataDetailList.matchStatusId = matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getOrderListDataRecordx20260116DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getOrderListDataRecordx20260116DataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getOrderListDataRecordx20260116DataDetailList.matchVideoTag = matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getOrderListDataRecordx20260116DataDetailList.oddFinally = oddFinally;
  }
  final String? oddsDataSourse = jsonConvert.convert<String>(
      json['oddsDataSourse']);
  if (oddsDataSourse != null) {
    getOrderListDataRecordx20260116DataDetailList.oddsDataSourse =
        oddsDataSourse;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getOrderListDataRecordx20260116DataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getOrderListDataRecordx20260116DataDetailList.optionValue = optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260116DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260116DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getOrderListDataRecordx20260116DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getOrderListDataRecordx20260116DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getOrderListDataRecordx20260116DataDetailList.outrightYear = outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getOrderListDataRecordx20260116DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getOrderListDataRecordx20260116DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getOrderListDataRecordx20260116DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getOrderListDataRecordx20260116DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getOrderListDataRecordx20260116DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getOrderListDataRecordx20260116DataDetailList.playOptions = playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getOrderListDataRecordx20260116DataDetailList.playOptionsId = playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getOrderListDataRecordx20260116DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getOrderListDataRecordx20260116DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getOrderListDataRecordx20260116DataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getOrderListDataRecordx20260116DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getOrderListDataRecordx20260116DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getOrderListDataRecordx20260116DataDetailList.secondNum = secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getOrderListDataRecordx20260116DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getOrderListDataRecordx20260116DataDetailList.settleScore = settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getOrderListDataRecordx20260116DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getOrderListDataRecordx20260116DataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getOrderListDataRecordx20260116DataDetailList.startTime = startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getOrderListDataRecordx20260116DataDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getOrderListDataRecordx20260116DataDetailList.tournamentId = tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getOrderListDataRecordx20260116DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getOrderListDataRecordx20260116DataDetailList.tournamentPic = tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getOrderListDataRecordx20260116DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getOrderListDataRecordx20260116DataDetailList.userId = userId;
  }
  return getOrderListDataRecordx20260116DataDetailList;
}

Map<String, dynamic> $GetOrderListDataRecordx20260116DataDetailListToJson(
    GetOrderListDataRecordx20260116DataDetailList entity) {
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
  data['oddsDataSourse'] = entity.oddsDataSourse;
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

extension GetOrderListDataRecordx20260116DataDetailListExtension on GetOrderListDataRecordx20260116DataDetailList {
  GetOrderListDataRecordx20260116DataDetailList copyWith({
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
    int? matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    String? oddsDataSourse,
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
    String? thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetOrderListDataRecordx20260116DataDetailList()
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
      ..oddsDataSourse = oddsDataSourse ?? this.oddsDataSourse
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

GetOrderListDataRecordx20260115 $GetOrderListDataRecordx20260115FromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260115 getOrderListDataRecordx20260115 = GetOrderListDataRecordx20260115();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260115.betAmount = betAmount;
  }
  final List<GetOrderListDataRecordx20260115Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetOrderListDataRecordx20260115Data>(
          e) as GetOrderListDataRecordx20260115Data).toList();
  if (data != null) {
    getOrderListDataRecordx20260115.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getOrderListDataRecordx20260115.totalOrders = totalOrders;
  }
  final double? profit = jsonConvert.convert<double>(json['profit']);
  if (profit != null) {
    getOrderListDataRecordx20260115.profit = profit;
  }
  return getOrderListDataRecordx20260115;
}

Map<String, dynamic> $GetOrderListDataRecordx20260115ToJson(
    GetOrderListDataRecordx20260115 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetOrderListDataRecordx20260115Extension on GetOrderListDataRecordx20260115 {
  GetOrderListDataRecordx20260115 copyWith({
    double? betAmount,
    List<GetOrderListDataRecordx20260115Data>? data,
    int? totalOrders,
    double? profit,
  }) {
    return GetOrderListDataRecordx20260115()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetOrderListDataRecordx20260115Data $GetOrderListDataRecordx20260115DataFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260115Data getOrderListDataRecordx20260115Data = GetOrderListDataRecordx20260115Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getOrderListDataRecordx20260115Data.acCode = acCode;
  }
  final dynamic addition = json['addition'];
  if (addition != null) {
    getOrderListDataRecordx20260115Data.addition = addition;
  }
  final double? backAmount = jsonConvert.convert<double>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260115Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getOrderListDataRecordx20260115Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getOrderListDataRecordx20260115Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getOrderListDataRecordx20260115Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getOrderListDataRecordx20260115Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getOrderListDataRecordx20260115Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetOrderListDataRecordx20260115DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetOrderListDataRecordx20260115DataDetailList>(
          e) as GetOrderListDataRecordx20260115DataDetailList).toList();
  if (detailList != null) {
    getOrderListDataRecordx20260115Data.detailList = detailList;
  }
  final dynamic enablePreSettle = json['enablePreSettle'];
  if (enablePreSettle != null) {
    getOrderListDataRecordx20260115Data.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getOrderListDataRecordx20260115Data.id = id;
  }
  final dynamic initPresettleWs = json['initPresettleWs'];
  if (initPresettleWs != null) {
    getOrderListDataRecordx20260115Data.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getOrderListDataRecordx20260115Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getOrderListDataRecordx20260115Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getOrderListDataRecordx20260115Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260115Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getOrderListDataRecordx20260115Data.matchType = matchType;
  }
  final dynamic maxCashout = json['maxCashout'];
  if (maxCashout != null) {
    getOrderListDataRecordx20260115Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getOrderListDataRecordx20260115Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getOrderListDataRecordx20260115Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getOrderListDataRecordx20260115Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getOrderListDataRecordx20260115Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260115Data.orderAmountTotal = orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260115Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getOrderListDataRecordx20260115Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getOrderListDataRecordx20260115Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getOrderListDataRecordx20260115Data.orderVOS = orderVOS;
  }
  final int? outcome = jsonConvert.convert<int>(json['outcome']);
  if (outcome != null) {
    getOrderListDataRecordx20260115Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getOrderListDataRecordx20260115Data.preBetAmount = preBetAmount;
  }
  final int? preOrder = jsonConvert.convert<int>(json['preOrder']);
  if (preOrder != null) {
    getOrderListDataRecordx20260115Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getOrderListDataRecordx20260115Data.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getOrderListDataRecordx20260115Data.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getOrderListDataRecordx20260115Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getOrderListDataRecordx20260115Data.preSettleBetAmount = preSettleBetAmount;
  }
  final double? profitAmount = jsonConvert.convert<double>(
      json['profitAmount']);
  if (profitAmount != null) {
    getOrderListDataRecordx20260115Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getOrderListDataRecordx20260115Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getOrderListDataRecordx20260115Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getOrderListDataRecordx20260115Data.seriesValue = seriesValue;
  }
  final String? settleTime = jsonConvert.convert<String>(json['settleTime']);
  if (settleTime != null) {
    getOrderListDataRecordx20260115Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getOrderListDataRecordx20260115Data.settleType = settleType;
  }
  final double? settledAmount = jsonConvert.convert<double>(
      json['settledAmount']);
  if (settledAmount != null) {
    getOrderListDataRecordx20260115Data.settledAmount = settledAmount;
  }
  return getOrderListDataRecordx20260115Data;
}

Map<String, dynamic> $GetOrderListDataRecordx20260115DataToJson(
    GetOrderListDataRecordx20260115Data entity) {
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

extension GetOrderListDataRecordx20260115DataExtension on GetOrderListDataRecordx20260115Data {
  GetOrderListDataRecordx20260115Data copyWith({
    String? acCode,
    dynamic addition,
    double? backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetOrderListDataRecordx20260115DataDetailList>? detailList,
    dynamic enablePreSettle,
    String? id,
    dynamic initPresettleWs,
    String? langCode,
    String? languageName,
    int? managerCode,
    String? marketType,
    dynamic matchType,
    dynamic maxCashout,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic orderVOS,
    int? outcome,
    dynamic preBetAmount,
    int? preOrder,
    dynamic preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic preSettleBetAmount,
    double? profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    String? settleTime,
    int? settleType,
    double? settledAmount,
  }) {
    return GetOrderListDataRecordx20260115Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
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

GetOrderListDataRecordx20260115DataDetailList $GetOrderListDataRecordx20260115DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260115DataDetailList getOrderListDataRecordx20260115DataDetailList = GetOrderListDataRecordx20260115DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getOrderListDataRecordx20260115DataDetailList.acceptBetOdds = acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getOrderListDataRecordx20260115DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260115DataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getOrderListDataRecordx20260115DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getOrderListDataRecordx20260115DataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260115DataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getOrderListDataRecordx20260115DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getOrderListDataRecordx20260115DataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getOrderListDataRecordx20260115DataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getOrderListDataRecordx20260115DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getOrderListDataRecordx20260115DataDetailList.cancelType = cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getOrderListDataRecordx20260115DataDetailList.childPlayId = childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getOrderListDataRecordx20260115DataDetailList.closingTime = closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getOrderListDataRecordx20260115DataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getOrderListDataRecordx20260115DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getOrderListDataRecordx20260115DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getOrderListDataRecordx20260115DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getOrderListDataRecordx20260115DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getOrderListDataRecordx20260115DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getOrderListDataRecordx20260115DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getOrderListDataRecordx20260115DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getOrderListDataRecordx20260115DataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260115DataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getOrderListDataRecordx20260115DataDetailList.marketValue = marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getOrderListDataRecordx20260115DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getOrderListDataRecordx20260115DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getOrderListDataRecordx20260115DataDetailList.matchInfo = matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getOrderListDataRecordx20260115DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getOrderListDataRecordx20260115DataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getOrderListDataRecordx20260115DataDetailList.matchOver = matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getOrderListDataRecordx20260115DataDetailList.matchPeriodId = matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getOrderListDataRecordx20260115DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getOrderListDataRecordx20260115DataDetailList.matchStatusId = matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getOrderListDataRecordx20260115DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getOrderListDataRecordx20260115DataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getOrderListDataRecordx20260115DataDetailList.matchVideoTag = matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getOrderListDataRecordx20260115DataDetailList.oddFinally = oddFinally;
  }
  final String? oddsDataSourse = jsonConvert.convert<String>(
      json['oddsDataSourse']);
  if (oddsDataSourse != null) {
    getOrderListDataRecordx20260115DataDetailList.oddsDataSourse =
        oddsDataSourse;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getOrderListDataRecordx20260115DataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getOrderListDataRecordx20260115DataDetailList.optionValue = optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260115DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260115DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getOrderListDataRecordx20260115DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getOrderListDataRecordx20260115DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getOrderListDataRecordx20260115DataDetailList.outrightYear = outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getOrderListDataRecordx20260115DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getOrderListDataRecordx20260115DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getOrderListDataRecordx20260115DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getOrderListDataRecordx20260115DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getOrderListDataRecordx20260115DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getOrderListDataRecordx20260115DataDetailList.playOptions = playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getOrderListDataRecordx20260115DataDetailList.playOptionsId = playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getOrderListDataRecordx20260115DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getOrderListDataRecordx20260115DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getOrderListDataRecordx20260115DataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getOrderListDataRecordx20260115DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getOrderListDataRecordx20260115DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getOrderListDataRecordx20260115DataDetailList.secondNum = secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getOrderListDataRecordx20260115DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getOrderListDataRecordx20260115DataDetailList.settleScore = settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getOrderListDataRecordx20260115DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getOrderListDataRecordx20260115DataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getOrderListDataRecordx20260115DataDetailList.startTime = startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getOrderListDataRecordx20260115DataDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getOrderListDataRecordx20260115DataDetailList.tournamentId = tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getOrderListDataRecordx20260115DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getOrderListDataRecordx20260115DataDetailList.tournamentPic = tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getOrderListDataRecordx20260115DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getOrderListDataRecordx20260115DataDetailList.userId = userId;
  }
  return getOrderListDataRecordx20260115DataDetailList;
}

Map<String, dynamic> $GetOrderListDataRecordx20260115DataDetailListToJson(
    GetOrderListDataRecordx20260115DataDetailList entity) {
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
  data['oddsDataSourse'] = entity.oddsDataSourse;
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

extension GetOrderListDataRecordx20260115DataDetailListExtension on GetOrderListDataRecordx20260115DataDetailList {
  GetOrderListDataRecordx20260115DataDetailList copyWith({
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
    int? matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    String? oddsDataSourse,
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
    String? thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetOrderListDataRecordx20260115DataDetailList()
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
      ..oddsDataSourse = oddsDataSourse ?? this.oddsDataSourse
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

GetOrderListDataRecordx20260112 $GetOrderListDataRecordx20260112FromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260112 getOrderListDataRecordx20260112 = GetOrderListDataRecordx20260112();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260112.betAmount = betAmount;
  }
  final List<GetOrderListDataRecordx20260112Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetOrderListDataRecordx20260112Data>(
          e) as GetOrderListDataRecordx20260112Data).toList();
  if (data != null) {
    getOrderListDataRecordx20260112.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getOrderListDataRecordx20260112.totalOrders = totalOrders;
  }
  final double? profit = jsonConvert.convert<double>(json['profit']);
  if (profit != null) {
    getOrderListDataRecordx20260112.profit = profit;
  }
  return getOrderListDataRecordx20260112;
}

Map<String, dynamic> $GetOrderListDataRecordx20260112ToJson(
    GetOrderListDataRecordx20260112 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetOrderListDataRecordx20260112Extension on GetOrderListDataRecordx20260112 {
  GetOrderListDataRecordx20260112 copyWith({
    double? betAmount,
    List<GetOrderListDataRecordx20260112Data>? data,
    int? totalOrders,
    double? profit,
  }) {
    return GetOrderListDataRecordx20260112()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetOrderListDataRecordx20260112Data $GetOrderListDataRecordx20260112DataFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260112Data getOrderListDataRecordx20260112Data = GetOrderListDataRecordx20260112Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getOrderListDataRecordx20260112Data.acCode = acCode;
  }
  final dynamic addition = json['addition'];
  if (addition != null) {
    getOrderListDataRecordx20260112Data.addition = addition;
  }
  final double? backAmount = jsonConvert.convert<double>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260112Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getOrderListDataRecordx20260112Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getOrderListDataRecordx20260112Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getOrderListDataRecordx20260112Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getOrderListDataRecordx20260112Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getOrderListDataRecordx20260112Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetOrderListDataRecordx20260112DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetOrderListDataRecordx20260112DataDetailList>(
          e) as GetOrderListDataRecordx20260112DataDetailList).toList();
  if (detailList != null) {
    getOrderListDataRecordx20260112Data.detailList = detailList;
  }
  final dynamic enablePreSettle = json['enablePreSettle'];
  if (enablePreSettle != null) {
    getOrderListDataRecordx20260112Data.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getOrderListDataRecordx20260112Data.id = id;
  }
  final dynamic initPresettleWs = json['initPresettleWs'];
  if (initPresettleWs != null) {
    getOrderListDataRecordx20260112Data.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getOrderListDataRecordx20260112Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getOrderListDataRecordx20260112Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getOrderListDataRecordx20260112Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260112Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getOrderListDataRecordx20260112Data.matchType = matchType;
  }
  final dynamic maxCashout = json['maxCashout'];
  if (maxCashout != null) {
    getOrderListDataRecordx20260112Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getOrderListDataRecordx20260112Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getOrderListDataRecordx20260112Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getOrderListDataRecordx20260112Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getOrderListDataRecordx20260112Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260112Data.orderAmountTotal = orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260112Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getOrderListDataRecordx20260112Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getOrderListDataRecordx20260112Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getOrderListDataRecordx20260112Data.orderVOS = orderVOS;
  }
  final int? outcome = jsonConvert.convert<int>(json['outcome']);
  if (outcome != null) {
    getOrderListDataRecordx20260112Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getOrderListDataRecordx20260112Data.preBetAmount = preBetAmount;
  }
  final int? preOrder = jsonConvert.convert<int>(json['preOrder']);
  if (preOrder != null) {
    getOrderListDataRecordx20260112Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getOrderListDataRecordx20260112Data.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getOrderListDataRecordx20260112Data.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getOrderListDataRecordx20260112Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getOrderListDataRecordx20260112Data.preSettleBetAmount = preSettleBetAmount;
  }
  final double? profitAmount = jsonConvert.convert<double>(
      json['profitAmount']);
  if (profitAmount != null) {
    getOrderListDataRecordx20260112Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getOrderListDataRecordx20260112Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getOrderListDataRecordx20260112Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getOrderListDataRecordx20260112Data.seriesValue = seriesValue;
  }
  final String? settleTime = jsonConvert.convert<String>(json['settleTime']);
  if (settleTime != null) {
    getOrderListDataRecordx20260112Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getOrderListDataRecordx20260112Data.settleType = settleType;
  }
  final double? settledAmount = jsonConvert.convert<double>(
      json['settledAmount']);
  if (settledAmount != null) {
    getOrderListDataRecordx20260112Data.settledAmount = settledAmount;
  }
  return getOrderListDataRecordx20260112Data;
}

Map<String, dynamic> $GetOrderListDataRecordx20260112DataToJson(
    GetOrderListDataRecordx20260112Data entity) {
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

extension GetOrderListDataRecordx20260112DataExtension on GetOrderListDataRecordx20260112Data {
  GetOrderListDataRecordx20260112Data copyWith({
    String? acCode,
    dynamic addition,
    double? backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetOrderListDataRecordx20260112DataDetailList>? detailList,
    dynamic enablePreSettle,
    String? id,
    dynamic initPresettleWs,
    String? langCode,
    String? languageName,
    int? managerCode,
    String? marketType,
    dynamic matchType,
    dynamic maxCashout,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic orderVOS,
    int? outcome,
    dynamic preBetAmount,
    int? preOrder,
    dynamic preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic preSettleBetAmount,
    double? profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    String? settleTime,
    int? settleType,
    double? settledAmount,
  }) {
    return GetOrderListDataRecordx20260112Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
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

GetOrderListDataRecordx20260112DataDetailList $GetOrderListDataRecordx20260112DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260112DataDetailList getOrderListDataRecordx20260112DataDetailList = GetOrderListDataRecordx20260112DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getOrderListDataRecordx20260112DataDetailList.acceptBetOdds = acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getOrderListDataRecordx20260112DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260112DataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getOrderListDataRecordx20260112DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getOrderListDataRecordx20260112DataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260112DataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getOrderListDataRecordx20260112DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getOrderListDataRecordx20260112DataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getOrderListDataRecordx20260112DataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getOrderListDataRecordx20260112DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getOrderListDataRecordx20260112DataDetailList.cancelType = cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getOrderListDataRecordx20260112DataDetailList.childPlayId = childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getOrderListDataRecordx20260112DataDetailList.closingTime = closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getOrderListDataRecordx20260112DataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getOrderListDataRecordx20260112DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getOrderListDataRecordx20260112DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getOrderListDataRecordx20260112DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getOrderListDataRecordx20260112DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getOrderListDataRecordx20260112DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getOrderListDataRecordx20260112DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getOrderListDataRecordx20260112DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getOrderListDataRecordx20260112DataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260112DataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getOrderListDataRecordx20260112DataDetailList.marketValue = marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getOrderListDataRecordx20260112DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getOrderListDataRecordx20260112DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getOrderListDataRecordx20260112DataDetailList.matchInfo = matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getOrderListDataRecordx20260112DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getOrderListDataRecordx20260112DataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getOrderListDataRecordx20260112DataDetailList.matchOver = matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getOrderListDataRecordx20260112DataDetailList.matchPeriodId = matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getOrderListDataRecordx20260112DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getOrderListDataRecordx20260112DataDetailList.matchStatusId = matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getOrderListDataRecordx20260112DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getOrderListDataRecordx20260112DataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getOrderListDataRecordx20260112DataDetailList.matchVideoTag = matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getOrderListDataRecordx20260112DataDetailList.oddFinally = oddFinally;
  }
  final String? oddsDataSourse = jsonConvert.convert<String>(
      json['oddsDataSourse']);
  if (oddsDataSourse != null) {
    getOrderListDataRecordx20260112DataDetailList.oddsDataSourse =
        oddsDataSourse;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getOrderListDataRecordx20260112DataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getOrderListDataRecordx20260112DataDetailList.optionValue = optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260112DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260112DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getOrderListDataRecordx20260112DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getOrderListDataRecordx20260112DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getOrderListDataRecordx20260112DataDetailList.outrightYear = outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getOrderListDataRecordx20260112DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getOrderListDataRecordx20260112DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getOrderListDataRecordx20260112DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getOrderListDataRecordx20260112DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getOrderListDataRecordx20260112DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getOrderListDataRecordx20260112DataDetailList.playOptions = playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getOrderListDataRecordx20260112DataDetailList.playOptionsId = playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getOrderListDataRecordx20260112DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getOrderListDataRecordx20260112DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getOrderListDataRecordx20260112DataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getOrderListDataRecordx20260112DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getOrderListDataRecordx20260112DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getOrderListDataRecordx20260112DataDetailList.secondNum = secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getOrderListDataRecordx20260112DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getOrderListDataRecordx20260112DataDetailList.settleScore = settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getOrderListDataRecordx20260112DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getOrderListDataRecordx20260112DataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getOrderListDataRecordx20260112DataDetailList.startTime = startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getOrderListDataRecordx20260112DataDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getOrderListDataRecordx20260112DataDetailList.tournamentId = tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getOrderListDataRecordx20260112DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getOrderListDataRecordx20260112DataDetailList.tournamentPic = tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getOrderListDataRecordx20260112DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getOrderListDataRecordx20260112DataDetailList.userId = userId;
  }
  return getOrderListDataRecordx20260112DataDetailList;
}

Map<String, dynamic> $GetOrderListDataRecordx20260112DataDetailListToJson(
    GetOrderListDataRecordx20260112DataDetailList entity) {
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
  data['oddsDataSourse'] = entity.oddsDataSourse;
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

extension GetOrderListDataRecordx20260112DataDetailListExtension on GetOrderListDataRecordx20260112DataDetailList {
  GetOrderListDataRecordx20260112DataDetailList copyWith({
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
    dynamic matchManageType,
    String? matchName,
    int? matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    String? oddsDataSourse,
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
    String? thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetOrderListDataRecordx20260112DataDetailList()
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
      ..oddsDataSourse = oddsDataSourse ?? this.oddsDataSourse
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

GetOrderListDataRecordx20260111 $GetOrderListDataRecordx20260111FromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260111 getOrderListDataRecordx20260111 = GetOrderListDataRecordx20260111();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260111.betAmount = betAmount;
  }
  final List<GetOrderListDataRecordx20260111Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetOrderListDataRecordx20260111Data>(
          e) as GetOrderListDataRecordx20260111Data).toList();
  if (data != null) {
    getOrderListDataRecordx20260111.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getOrderListDataRecordx20260111.totalOrders = totalOrders;
  }
  final double? profit = jsonConvert.convert<double>(json['profit']);
  if (profit != null) {
    getOrderListDataRecordx20260111.profit = profit;
  }
  return getOrderListDataRecordx20260111;
}

Map<String, dynamic> $GetOrderListDataRecordx20260111ToJson(
    GetOrderListDataRecordx20260111 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetOrderListDataRecordx20260111Extension on GetOrderListDataRecordx20260111 {
  GetOrderListDataRecordx20260111 copyWith({
    double? betAmount,
    List<GetOrderListDataRecordx20260111Data>? data,
    int? totalOrders,
    double? profit,
  }) {
    return GetOrderListDataRecordx20260111()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetOrderListDataRecordx20260111Data $GetOrderListDataRecordx20260111DataFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260111Data getOrderListDataRecordx20260111Data = GetOrderListDataRecordx20260111Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getOrderListDataRecordx20260111Data.acCode = acCode;
  }
  final dynamic addition = json['addition'];
  if (addition != null) {
    getOrderListDataRecordx20260111Data.addition = addition;
  }
  final double? backAmount = jsonConvert.convert<double>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260111Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getOrderListDataRecordx20260111Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getOrderListDataRecordx20260111Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getOrderListDataRecordx20260111Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getOrderListDataRecordx20260111Data.betTimeStr = betTimeStr;
  }
  final String? cashOutTimes = jsonConvert.convert<String>(
      json['cashOutTimes']);
  if (cashOutTimes != null) {
    getOrderListDataRecordx20260111Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetOrderListDataRecordx20260111DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetOrderListDataRecordx20260111DataDetailList>(
          e) as GetOrderListDataRecordx20260111DataDetailList).toList();
  if (detailList != null) {
    getOrderListDataRecordx20260111Data.detailList = detailList;
  }
  final dynamic enablePreSettle = json['enablePreSettle'];
  if (enablePreSettle != null) {
    getOrderListDataRecordx20260111Data.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getOrderListDataRecordx20260111Data.id = id;
  }
  final dynamic initPresettleWs = json['initPresettleWs'];
  if (initPresettleWs != null) {
    getOrderListDataRecordx20260111Data.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getOrderListDataRecordx20260111Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getOrderListDataRecordx20260111Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getOrderListDataRecordx20260111Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260111Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getOrderListDataRecordx20260111Data.matchType = matchType;
  }
  final dynamic maxCashout = json['maxCashout'];
  if (maxCashout != null) {
    getOrderListDataRecordx20260111Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getOrderListDataRecordx20260111Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getOrderListDataRecordx20260111Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getOrderListDataRecordx20260111Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getOrderListDataRecordx20260111Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260111Data.orderAmountTotal = orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260111Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getOrderListDataRecordx20260111Data.orderStatus = orderStatus;
  }
  final dynamic orderType = json['orderType'];
  if (orderType != null) {
    getOrderListDataRecordx20260111Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getOrderListDataRecordx20260111Data.orderVOS = orderVOS;
  }
  final int? outcome = jsonConvert.convert<int>(json['outcome']);
  if (outcome != null) {
    getOrderListDataRecordx20260111Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getOrderListDataRecordx20260111Data.preBetAmount = preBetAmount;
  }
  final int? preOrder = jsonConvert.convert<int>(json['preOrder']);
  if (preOrder != null) {
    getOrderListDataRecordx20260111Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getOrderListDataRecordx20260111Data.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getOrderListDataRecordx20260111Data.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getOrderListDataRecordx20260111Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getOrderListDataRecordx20260111Data.preSettleBetAmount = preSettleBetAmount;
  }
  final double? profitAmount = jsonConvert.convert<double>(
      json['profitAmount']);
  if (profitAmount != null) {
    getOrderListDataRecordx20260111Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getOrderListDataRecordx20260111Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getOrderListDataRecordx20260111Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getOrderListDataRecordx20260111Data.seriesValue = seriesValue;
  }
  final String? settleTime = jsonConvert.convert<String>(json['settleTime']);
  if (settleTime != null) {
    getOrderListDataRecordx20260111Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getOrderListDataRecordx20260111Data.settleType = settleType;
  }
  final double? settledAmount = jsonConvert.convert<double>(
      json['settledAmount']);
  if (settledAmount != null) {
    getOrderListDataRecordx20260111Data.settledAmount = settledAmount;
  }
  return getOrderListDataRecordx20260111Data;
}

Map<String, dynamic> $GetOrderListDataRecordx20260111DataToJson(
    GetOrderListDataRecordx20260111Data entity) {
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

extension GetOrderListDataRecordx20260111DataExtension on GetOrderListDataRecordx20260111Data {
  GetOrderListDataRecordx20260111Data copyWith({
    String? acCode,
    dynamic addition,
    double? backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    String? cashOutTimes,
    List<GetOrderListDataRecordx20260111DataDetailList>? detailList,
    dynamic enablePreSettle,
    String? id,
    dynamic initPresettleWs,
    String? langCode,
    String? languageName,
    int? managerCode,
    String? marketType,
    dynamic matchType,
    dynamic maxCashout,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    String? odds,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic orderType,
    dynamic orderVOS,
    int? outcome,
    dynamic preBetAmount,
    int? preOrder,
    dynamic preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic preSettleBetAmount,
    double? profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    String? settleTime,
    int? settleType,
    double? settledAmount,
  }) {
    return GetOrderListDataRecordx20260111Data()
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..cashOutTimes = cashOutTimes ?? this.cashOutTimes
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

GetOrderListDataRecordx20260111DataDetailList $GetOrderListDataRecordx20260111DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetOrderListDataRecordx20260111DataDetailList getOrderListDataRecordx20260111DataDetailList = GetOrderListDataRecordx20260111DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getOrderListDataRecordx20260111DataDetailList.acceptBetOdds = acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getOrderListDataRecordx20260111DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getOrderListDataRecordx20260111DataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getOrderListDataRecordx20260111DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getOrderListDataRecordx20260111DataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getOrderListDataRecordx20260111DataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getOrderListDataRecordx20260111DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getOrderListDataRecordx20260111DataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getOrderListDataRecordx20260111DataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getOrderListDataRecordx20260111DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getOrderListDataRecordx20260111DataDetailList.cancelType = cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getOrderListDataRecordx20260111DataDetailList.childPlayId = childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getOrderListDataRecordx20260111DataDetailList.closingTime = closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getOrderListDataRecordx20260111DataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getOrderListDataRecordx20260111DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getOrderListDataRecordx20260111DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getOrderListDataRecordx20260111DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getOrderListDataRecordx20260111DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getOrderListDataRecordx20260111DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getOrderListDataRecordx20260111DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getOrderListDataRecordx20260111DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getOrderListDataRecordx20260111DataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getOrderListDataRecordx20260111DataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getOrderListDataRecordx20260111DataDetailList.marketValue = marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getOrderListDataRecordx20260111DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getOrderListDataRecordx20260111DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getOrderListDataRecordx20260111DataDetailList.matchInfo = matchInfo;
  }
  final dynamic matchManageType = json['matchManageType'];
  if (matchManageType != null) {
    getOrderListDataRecordx20260111DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getOrderListDataRecordx20260111DataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getOrderListDataRecordx20260111DataDetailList.matchOver = matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getOrderListDataRecordx20260111DataDetailList.matchPeriodId = matchPeriodId;
  }
  final dynamic matchProcessId = json['matchProcessId'];
  if (matchProcessId != null) {
    getOrderListDataRecordx20260111DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getOrderListDataRecordx20260111DataDetailList.matchStatusId = matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getOrderListDataRecordx20260111DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getOrderListDataRecordx20260111DataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getOrderListDataRecordx20260111DataDetailList.matchVideoTag = matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getOrderListDataRecordx20260111DataDetailList.oddFinally = oddFinally;
  }
  final String? oddsDataSourse = jsonConvert.convert<String>(
      json['oddsDataSourse']);
  if (oddsDataSourse != null) {
    getOrderListDataRecordx20260111DataDetailList.oddsDataSourse =
        oddsDataSourse;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getOrderListDataRecordx20260111DataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getOrderListDataRecordx20260111DataDetailList.optionValue = optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getOrderListDataRecordx20260111DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getOrderListDataRecordx20260111DataDetailList.orderNo = orderNo;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    getOrderListDataRecordx20260111DataDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getOrderListDataRecordx20260111DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getOrderListDataRecordx20260111DataDetailList.outrightYear = outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getOrderListDataRecordx20260111DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getOrderListDataRecordx20260111DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getOrderListDataRecordx20260111DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getOrderListDataRecordx20260111DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getOrderListDataRecordx20260111DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getOrderListDataRecordx20260111DataDetailList.playOptions = playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getOrderListDataRecordx20260111DataDetailList.playOptionsId = playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getOrderListDataRecordx20260111DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getOrderListDataRecordx20260111DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getOrderListDataRecordx20260111DataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getOrderListDataRecordx20260111DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getOrderListDataRecordx20260111DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getOrderListDataRecordx20260111DataDetailList.secondNum = secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getOrderListDataRecordx20260111DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getOrderListDataRecordx20260111DataDetailList.settleScore = settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getOrderListDataRecordx20260111DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getOrderListDataRecordx20260111DataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getOrderListDataRecordx20260111DataDetailList.startTime = startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getOrderListDataRecordx20260111DataDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getOrderListDataRecordx20260111DataDetailList.tournamentId = tournamentId;
  }
  final dynamic tournamentLevel = json['tournamentLevel'];
  if (tournamentLevel != null) {
    getOrderListDataRecordx20260111DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getOrderListDataRecordx20260111DataDetailList.tournamentPic = tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getOrderListDataRecordx20260111DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getOrderListDataRecordx20260111DataDetailList.userId = userId;
  }
  return getOrderListDataRecordx20260111DataDetailList;
}

Map<String, dynamic> $GetOrderListDataRecordx20260111DataDetailListToJson(
    GetOrderListDataRecordx20260111DataDetailList entity) {
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
  data['oddsDataSourse'] = entity.oddsDataSourse;
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

extension GetOrderListDataRecordx20260111DataDetailListExtension on GetOrderListDataRecordx20260111DataDetailList {
  GetOrderListDataRecordx20260111DataDetailList copyWith({
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
    dynamic matchManageType,
    String? matchName,
    int? matchOver,
    dynamic matchPeriodId,
    dynamic matchProcessId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
    String? oddsDataSourse,
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
    String? thirdMatchId,
    String? tournamentId,
    dynamic tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetOrderListDataRecordx20260111DataDetailList()
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
      ..oddsDataSourse = oddsDataSourse ?? this.oddsDataSourse
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