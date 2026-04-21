import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_rhgy_search_count_list_entity.dart';

GetRhgySearchCountListEntity $GetRhgySearchCountListEntityFromJson(
    Map<String, dynamic> json) {
  final GetRhgySearchCountListEntity getRhgySearchCountListEntity = GetRhgySearchCountListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getRhgySearchCountListEntity.code = code;
  }
  final GetRhgySearchCountListData? data = jsonConvert.convert<
      GetRhgySearchCountListData>(json['data']);
  if (data != null) {
    getRhgySearchCountListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getRhgySearchCountListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getRhgySearchCountListEntity.ts = ts;
  }
  return getRhgySearchCountListEntity;
}

Map<String, dynamic> $GetRhgySearchCountListEntityToJson(
    GetRhgySearchCountListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetRhgySearchCountListEntityExtension on GetRhgySearchCountListEntity {
  GetRhgySearchCountListEntity copyWith({
    String? code,
    GetRhgySearchCountListData? data,
    String? msg,
    int? ts,
  }) {
    return GetRhgySearchCountListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetRhgySearchCountListData $GetRhgySearchCountListDataFromJson(
    Map<String, dynamic> json) {
  final GetRhgySearchCountListData getRhgySearchCountListData = GetRhgySearchCountListData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getRhgySearchCountListData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getRhgySearchCountListData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getRhgySearchCountListData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getRhgySearchCountListData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getRhgySearchCountListData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getRhgySearchCountListData.hasPrevious = hasPrevious;
  }
  final String? maxWinTotalAmount = jsonConvert.convert<String>(
      json['maxWinTotalAmount']);
  if (maxWinTotalAmount != null) {
    getRhgySearchCountListData.maxWinTotalAmount = maxWinTotalAmount;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getRhgySearchCountListData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getRhgySearchCountListData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getRhgySearchCountListData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getRhgySearchCountListData.profit = profit;
  }
  final GetRhgySearchCountListDataRecord? record = jsonConvert.convert<
      GetRhgySearchCountListDataRecord>(json['record']);
  if (record != null) {
    getRhgySearchCountListData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getRhgySearchCountListData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getRhgySearchCountListData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getRhgySearchCountListData.size = size;
  }
  final String? subOrderTotal = jsonConvert.convert<String>(
      json['subOrderTotal']);
  if (subOrderTotal != null) {
    getRhgySearchCountListData.subOrderTotal = subOrderTotal;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getRhgySearchCountListData.total = total;
  }
  return getRhgySearchCountListData;
}

Map<String, dynamic> $GetRhgySearchCountListDataToJson(
    GetRhgySearchCountListData entity) {
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

extension GetRhgySearchCountListDataExtension on GetRhgySearchCountListData {
  GetRhgySearchCountListData copyWith({
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
    GetRhgySearchCountListDataRecord? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? subOrderTotal,
    String? total,
  }) {
    return GetRhgySearchCountListData()
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

GetRhgySearchCountListDataRecord $GetRhgySearchCountListDataRecordFromJson(
    Map<String, dynamic> json) {
  final GetRhgySearchCountListDataRecord getRhgySearchCountListDataRecord = GetRhgySearchCountListDataRecord();
  final GetRhgySearchCountListDataRecordx20251004? x20251004 = jsonConvert
      .convert<GetRhgySearchCountListDataRecordx20251004>(json['2025-10-04']);
  if (x20251004 != null) {
    getRhgySearchCountListDataRecord.x20251004 = x20251004;
  }
  return getRhgySearchCountListDataRecord;
}

Map<String, dynamic> $GetRhgySearchCountListDataRecordToJson(
    GetRhgySearchCountListDataRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['2025-10-04'] = entity.x20251004.toJson();
  return data;
}

extension GetRhgySearchCountListDataRecordExtension on GetRhgySearchCountListDataRecord {
  GetRhgySearchCountListDataRecord copyWith({
    GetRhgySearchCountListDataRecordx20251004? x20251004,
  }) {
    return GetRhgySearchCountListDataRecord()
      ..x20251004 = x20251004 ?? this.x20251004;
  }
}

GetRhgySearchCountListDataRecordx20251004 $GetRhgySearchCountListDataRecordx20251004FromJson(
    Map<String, dynamic> json) {
  final GetRhgySearchCountListDataRecordx20251004 getRhgySearchCountListDataRecordx20251004 = GetRhgySearchCountListDataRecordx20251004();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgySearchCountListDataRecordx20251004.betAmount = betAmount;
  }
  final List<
      GetRhgySearchCountListDataRecordx20251004Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgySearchCountListDataRecordx20251004Data>(
          e) as GetRhgySearchCountListDataRecordx20251004Data).toList();
  if (data != null) {
    getRhgySearchCountListDataRecordx20251004.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgySearchCountListDataRecordx20251004.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgySearchCountListDataRecordx20251004.profit = profit;
  }
  return getRhgySearchCountListDataRecordx20251004;
}

Map<String, dynamic> $GetRhgySearchCountListDataRecordx20251004ToJson(
    GetRhgySearchCountListDataRecordx20251004 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgySearchCountListDataRecordx20251004Extension on GetRhgySearchCountListDataRecordx20251004 {
  GetRhgySearchCountListDataRecordx20251004 copyWith({
    double? betAmount,
    List<GetRhgySearchCountListDataRecordx20251004Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgySearchCountListDataRecordx20251004()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgySearchCountListDataRecordx20251004Data $GetRhgySearchCountListDataRecordx20251004DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgySearchCountListDataRecordx20251004Data getRhgySearchCountListDataRecordx20251004Data = GetRhgySearchCountListDataRecordx20251004Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgySearchCountListDataRecordx20251004Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgySearchCountListDataRecordx20251004Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgySearchCountListDataRecordx20251004Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgySearchCountListDataRecordx20251004Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgySearchCountListDataRecordx20251004Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgySearchCountListDataRecordx20251004Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgySearchCountListDataRecordx20251004Data.betTimeStr = betTimeStr;
  }
  final int? cashOutTimes = jsonConvert.convert<int>(json['cashOutTimes']);
  if (cashOutTimes != null) {
    getRhgySearchCountListDataRecordx20251004Data.cashOutTimes = cashOutTimes;
  }
  final List<
      GetRhgySearchCountListDataRecordx20251004DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgySearchCountListDataRecordx20251004DataDetailList>(
          e) as GetRhgySearchCountListDataRecordx20251004DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgySearchCountListDataRecordx20251004Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgySearchCountListDataRecordx20251004Data.enablePreSettle =
        enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgySearchCountListDataRecordx20251004Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgySearchCountListDataRecordx20251004Data.initPresettleWs =
        initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgySearchCountListDataRecordx20251004Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgySearchCountListDataRecordx20251004Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgySearchCountListDataRecordx20251004Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgySearchCountListDataRecordx20251004Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getRhgySearchCountListDataRecordx20251004Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgySearchCountListDataRecordx20251004Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgySearchCountListDataRecordx20251004Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgySearchCountListDataRecordx20251004Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgySearchCountListDataRecordx20251004Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgySearchCountListDataRecordx20251004Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgySearchCountListDataRecordx20251004Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgySearchCountListDataRecordx20251004Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgySearchCountListDataRecordx20251004Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgySearchCountListDataRecordx20251004Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgySearchCountListDataRecordx20251004Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgySearchCountListDataRecordx20251004Data.outcome = outcome;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgySearchCountListDataRecordx20251004Data.preBetAmount = preBetAmount;
  }
  final int? preOrder = jsonConvert.convert<int>(json['preOrder']);
  if (preOrder != null) {
    getRhgySearchCountListDataRecordx20251004Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgySearchCountListDataRecordx20251004Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgySearchCountListDataRecordx20251004Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgySearchCountListDataRecordx20251004Data.preSettle = preSettle;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getRhgySearchCountListDataRecordx20251004Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgySearchCountListDataRecordx20251004Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgySearchCountListDataRecordx20251004Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgySearchCountListDataRecordx20251004Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgySearchCountListDataRecordx20251004Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgySearchCountListDataRecordx20251004Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgySearchCountListDataRecordx20251004Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgySearchCountListDataRecordx20251004Data.settledAmount = settledAmount;
  }
  return getRhgySearchCountListDataRecordx20251004Data;
}

Map<String, dynamic> $GetRhgySearchCountListDataRecordx20251004DataToJson(
    GetRhgySearchCountListDataRecordx20251004Data entity) {
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

extension GetRhgySearchCountListDataRecordx20251004DataExtension on GetRhgySearchCountListDataRecordx20251004Data {
  GetRhgySearchCountListDataRecordx20251004Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    int? cashOutTimes,
    List<GetRhgySearchCountListDataRecordx20251004DataDetailList>? detailList,
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
    int? preOrder,
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
    return GetRhgySearchCountListDataRecordx20251004Data()
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

GetRhgySearchCountListDataRecordx20251004DataDetailList $GetRhgySearchCountListDataRecordx20251004DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgySearchCountListDataRecordx20251004DataDetailList getRhgySearchCountListDataRecordx20251004DataDetailList = GetRhgySearchCountListDataRecordx20251004DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.cancelType =
        cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchInfo =
        matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchName =
        matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchOver =
        matchOver;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList
        .originalMarketValue = originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.secondNum =
        secondNum;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.startTime =
        startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgySearchCountListDataRecordx20251004DataDetailList.userId = userId;
  }
  return getRhgySearchCountListDataRecordx20251004DataDetailList;
}

Map<String,
    dynamic> $GetRhgySearchCountListDataRecordx20251004DataDetailListToJson(
    GetRhgySearchCountListDataRecordx20251004DataDetailList entity) {
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

extension GetRhgySearchCountListDataRecordx20251004DataDetailListExtension on GetRhgySearchCountListDataRecordx20251004DataDetailList {
  GetRhgySearchCountListDataRecordx20251004DataDetailList copyWith({
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
    return GetRhgySearchCountListDataRecordx20251004DataDetailList()
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