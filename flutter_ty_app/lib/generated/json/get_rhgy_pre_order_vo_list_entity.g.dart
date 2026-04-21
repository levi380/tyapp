import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_rhgy_pre_order_vo_list_entity.dart';

GetRhgyPreOrderVoListEntity $GetRhgyPreOrderVoListEntityFromJson(
    Map<String, dynamic> json) {
  final GetRhgyPreOrderVoListEntity getRhgyPreOrderVoListEntity = GetRhgyPreOrderVoListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getRhgyPreOrderVoListEntity.code = code;
  }
  final GetRhgyPreOrderVoListData? data = jsonConvert.convert<
      GetRhgyPreOrderVoListData>(json['data']);
  if (data != null) {
    getRhgyPreOrderVoListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getRhgyPreOrderVoListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getRhgyPreOrderVoListEntity.ts = ts;
  }
  return getRhgyPreOrderVoListEntity;
}

Map<String, dynamic> $GetRhgyPreOrderVoListEntityToJson(
    GetRhgyPreOrderVoListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetRhgyPreOrderVoListEntityExtension on GetRhgyPreOrderVoListEntity {
  GetRhgyPreOrderVoListEntity copyWith({
    String? code,
    GetRhgyPreOrderVoListData? data,
    String? msg,
    int? ts,
  }) {
    return GetRhgyPreOrderVoListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetRhgyPreOrderVoListData $GetRhgyPreOrderVoListDataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyPreOrderVoListData getRhgyPreOrderVoListData = GetRhgyPreOrderVoListData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getRhgyPreOrderVoListData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getRhgyPreOrderVoListData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getRhgyPreOrderVoListData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getRhgyPreOrderVoListData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getRhgyPreOrderVoListData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getRhgyPreOrderVoListData.hasPrevious = hasPrevious;
  }
  final String? maxWinTotalAmount = jsonConvert.convert<String>(
      json['maxWinTotalAmount']);
  if (maxWinTotalAmount != null) {
    getRhgyPreOrderVoListData.maxWinTotalAmount = maxWinTotalAmount;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getRhgyPreOrderVoListData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getRhgyPreOrderVoListData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getRhgyPreOrderVoListData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getRhgyPreOrderVoListData.profit = profit;
  }
  final GetRhgyPreOrderVoListDataRecord? record = jsonConvert.convert<
      GetRhgyPreOrderVoListDataRecord>(json['record']);
  if (record != null) {
    getRhgyPreOrderVoListData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getRhgyPreOrderVoListData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getRhgyPreOrderVoListData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getRhgyPreOrderVoListData.size = size;
  }
  final String? subOrderTotal = jsonConvert.convert<String>(
      json['subOrderTotal']);
  if (subOrderTotal != null) {
    getRhgyPreOrderVoListData.subOrderTotal = subOrderTotal;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getRhgyPreOrderVoListData.total = total;
  }
  return getRhgyPreOrderVoListData;
}

Map<String, dynamic> $GetRhgyPreOrderVoListDataToJson(
    GetRhgyPreOrderVoListData entity) {
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

extension GetRhgyPreOrderVoListDataExtension on GetRhgyPreOrderVoListData {
  GetRhgyPreOrderVoListData copyWith({
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
    GetRhgyPreOrderVoListDataRecord? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? subOrderTotal,
    String? total,
  }) {
    return GetRhgyPreOrderVoListData()
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

GetRhgyPreOrderVoListDataRecord $GetRhgyPreOrderVoListDataRecordFromJson(
    Map<String, dynamic> json) {
  final GetRhgyPreOrderVoListDataRecord getRhgyPreOrderVoListDataRecord = GetRhgyPreOrderVoListDataRecord();
  final GetRhgyPreOrderVoListDataRecordx20250921? x20250921 = jsonConvert
      .convert<GetRhgyPreOrderVoListDataRecordx20250921>(json['2025-09-21']);
  if (x20250921 != null) {
    getRhgyPreOrderVoListDataRecord.x20250921 = x20250921;
  }
  return getRhgyPreOrderVoListDataRecord;
}

Map<String, dynamic> $GetRhgyPreOrderVoListDataRecordToJson(
    GetRhgyPreOrderVoListDataRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['2025-09-21'] = entity.x20250921.toJson();
  return data;
}

extension GetRhgyPreOrderVoListDataRecordExtension on GetRhgyPreOrderVoListDataRecord {
  GetRhgyPreOrderVoListDataRecord copyWith({
    GetRhgyPreOrderVoListDataRecordx20250921? x20250921,
  }) {
    return GetRhgyPreOrderVoListDataRecord()
      ..x20250921 = x20250921 ?? this.x20250921;
  }
}

GetRhgyPreOrderVoListDataRecordx20250921 $GetRhgyPreOrderVoListDataRecordx20250921FromJson(
    Map<String, dynamic> json) {
  final GetRhgyPreOrderVoListDataRecordx20250921 getRhgyPreOrderVoListDataRecordx20250921 = GetRhgyPreOrderVoListDataRecordx20250921();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921.betAmount = betAmount;
  }
  final List<
      GetRhgyPreOrderVoListDataRecordx20250921Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyPreOrderVoListDataRecordx20250921Data>(
          e) as GetRhgyPreOrderVoListDataRecordx20250921Data).toList();
  if (data != null) {
    getRhgyPreOrderVoListDataRecordx20250921.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyPreOrderVoListDataRecordx20250921.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgyPreOrderVoListDataRecordx20250921.profit = profit;
  }
  return getRhgyPreOrderVoListDataRecordx20250921;
}

Map<String, dynamic> $GetRhgyPreOrderVoListDataRecordx20250921ToJson(
    GetRhgyPreOrderVoListDataRecordx20250921 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgyPreOrderVoListDataRecordx20250921Extension on GetRhgyPreOrderVoListDataRecordx20250921 {
  GetRhgyPreOrderVoListDataRecordx20250921 copyWith({
    double? betAmount,
    List<GetRhgyPreOrderVoListDataRecordx20250921Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgyPreOrderVoListDataRecordx20250921()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgyPreOrderVoListDataRecordx20250921Data $GetRhgyPreOrderVoListDataRecordx20250921DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyPreOrderVoListDataRecordx20250921Data getRhgyPreOrderVoListDataRecordx20250921Data = GetRhgyPreOrderVoListDataRecordx20250921Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.betTimeStr = betTimeStr;
  }
  final List<
      GetRhgyPreOrderVoListDataRecordx20250921DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyPreOrderVoListDataRecordx20250921DataDetailList>(
          e) as GetRhgyPreOrderVoListDataRecordx20250921DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.enablePreSettle =
        enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.initPresettleWs =
        initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.preBetAmount = preBetAmount;
  }
  final int? preOrder = jsonConvert.convert<int>(json['preOrder']);
  if (preOrder != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921Data.settledAmount = settledAmount;
  }
  return getRhgyPreOrderVoListDataRecordx20250921Data;
}

Map<String, dynamic> $GetRhgyPreOrderVoListDataRecordx20250921DataToJson(
    GetRhgyPreOrderVoListDataRecordx20250921Data entity) {
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

extension GetRhgyPreOrderVoListDataRecordx20250921DataExtension on GetRhgyPreOrderVoListDataRecordx20250921Data {
  GetRhgyPreOrderVoListDataRecordx20250921Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetRhgyPreOrderVoListDataRecordx20250921DataDetailList>? detailList,
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
    dynamic preBetAmount,
    int? preOrder,
    dynamic preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic preSettleBetAmount,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    int? settleType,
    dynamic settledAmount,
  }) {
    return GetRhgyPreOrderVoListDataRecordx20250921Data()
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

GetRhgyPreOrderVoListDataRecordx20250921DataDetailList $GetRhgyPreOrderVoListDataRecordx20250921DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyPreOrderVoListDataRecordx20250921DataDetailList getRhgyPreOrderVoListDataRecordx20250921DataDetailList = GetRhgyPreOrderVoListDataRecordx20250921DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.cancelType =
        cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchInfo =
        matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchName =
        matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchOver =
        matchOver;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.secondNum =
        secondNum;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.startTime =
        startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyPreOrderVoListDataRecordx20250921DataDetailList.userId = userId;
  }
  return getRhgyPreOrderVoListDataRecordx20250921DataDetailList;
}

Map<String,
    dynamic> $GetRhgyPreOrderVoListDataRecordx20250921DataDetailListToJson(
    GetRhgyPreOrderVoListDataRecordx20250921DataDetailList entity) {
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

extension GetRhgyPreOrderVoListDataRecordx20250921DataDetailListExtension on GetRhgyPreOrderVoListDataRecordx20250921DataDetailList {
  GetRhgyPreOrderVoListDataRecordx20250921DataDetailList copyWith({
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
    return GetRhgyPreOrderVoListDataRecordx20250921DataDetailList()
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