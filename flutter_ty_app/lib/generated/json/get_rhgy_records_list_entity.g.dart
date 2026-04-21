import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_rhgy_records_list_entity.dart';

GetRhgyRecordsListEntity $GetRhgyRecordsListEntityFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListEntity getRhgyRecordsListEntity = GetRhgyRecordsListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getRhgyRecordsListEntity.code = code;
  }
  final GetRhgyRecordsListData? data = jsonConvert.convert<
      GetRhgyRecordsListData>(json['data']);
  if (data != null) {
    getRhgyRecordsListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getRhgyRecordsListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getRhgyRecordsListEntity.ts = ts;
  }
  return getRhgyRecordsListEntity;
}

Map<String, dynamic> $GetRhgyRecordsListEntityToJson(
    GetRhgyRecordsListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetRhgyRecordsListEntityExtension on GetRhgyRecordsListEntity {
  GetRhgyRecordsListEntity copyWith({
    String? code,
    GetRhgyRecordsListData? data,
    String? msg,
    int? ts,
  }) {
    return GetRhgyRecordsListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetRhgyRecordsListData $GetRhgyRecordsListDataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListData getRhgyRecordsListData = GetRhgyRecordsListData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getRhgyRecordsListData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getRhgyRecordsListData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getRhgyRecordsListData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getRhgyRecordsListData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getRhgyRecordsListData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getRhgyRecordsListData.hasPrevious = hasPrevious;
  }
  final String? maxWinTotalAmount = jsonConvert.convert<String>(
      json['maxWinTotalAmount']);
  if (maxWinTotalAmount != null) {
    getRhgyRecordsListData.maxWinTotalAmount = maxWinTotalAmount;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getRhgyRecordsListData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getRhgyRecordsListData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getRhgyRecordsListData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getRhgyRecordsListData.profit = profit;
  }
  final GetRhgyRecordsListDataRecord? record = jsonConvert.convert<
      GetRhgyRecordsListDataRecord>(json['record']);
  if (record != null) {
    getRhgyRecordsListData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getRhgyRecordsListData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getRhgyRecordsListData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getRhgyRecordsListData.size = size;
  }
  final String? subOrderTotal = jsonConvert.convert<String>(
      json['subOrderTotal']);
  if (subOrderTotal != null) {
    getRhgyRecordsListData.subOrderTotal = subOrderTotal;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getRhgyRecordsListData.total = total;
  }
  return getRhgyRecordsListData;
}

Map<String, dynamic> $GetRhgyRecordsListDataToJson(
    GetRhgyRecordsListData entity) {
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

extension GetRhgyRecordsListDataExtension on GetRhgyRecordsListData {
  GetRhgyRecordsListData copyWith({
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
    GetRhgyRecordsListDataRecord? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? subOrderTotal,
    String? total,
  }) {
    return GetRhgyRecordsListData()
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

GetRhgyRecordsListDataRecord $GetRhgyRecordsListDataRecordFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListDataRecord getRhgyRecordsListDataRecord = GetRhgyRecordsListDataRecord();
  final GetRhgyRecordsListDataRecordx20250921? x20250921 = jsonConvert.convert<
      GetRhgyRecordsListDataRecordx20250921>(json['2025-09-21']);
  if (x20250921 != null) {
    getRhgyRecordsListDataRecord.x20250921 = x20250921;
  }
  final GetRhgyRecordsListDataRecordx20250920? x20250920 = jsonConvert.convert<
      GetRhgyRecordsListDataRecordx20250920>(json['2025-09-20']);
  if (x20250920 != null) {
    getRhgyRecordsListDataRecord.x20250920 = x20250920;
  }
  return getRhgyRecordsListDataRecord;
}

Map<String, dynamic> $GetRhgyRecordsListDataRecordToJson(
    GetRhgyRecordsListDataRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['2025-09-21'] = entity.x20250921.toJson();
  data['2025-09-20'] = entity.x20250920.toJson();
  return data;
}

extension GetRhgyRecordsListDataRecordExtension on GetRhgyRecordsListDataRecord {
  GetRhgyRecordsListDataRecord copyWith({
    GetRhgyRecordsListDataRecordx20250921? x20250921,
    GetRhgyRecordsListDataRecordx20250920? x20250920,
  }) {
    return GetRhgyRecordsListDataRecord()
      ..x20250921 = x20250921 ?? this.x20250921
      ..x20250920 = x20250920 ?? this.x20250920;
  }
}

GetRhgyRecordsListDataRecordx20250921 $GetRhgyRecordsListDataRecordx20250921FromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListDataRecordx20250921 getRhgyRecordsListDataRecordx20250921 = GetRhgyRecordsListDataRecordx20250921();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyRecordsListDataRecordx20250921.betAmount = betAmount;
  }
  final List<
      GetRhgyRecordsListDataRecordx20250921Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetRhgyRecordsListDataRecordx20250921Data>(
          e) as GetRhgyRecordsListDataRecordx20250921Data).toList();
  if (data != null) {
    getRhgyRecordsListDataRecordx20250921.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyRecordsListDataRecordx20250921.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgyRecordsListDataRecordx20250921.profit = profit;
  }
  return getRhgyRecordsListDataRecordx20250921;
}

Map<String, dynamic> $GetRhgyRecordsListDataRecordx20250921ToJson(
    GetRhgyRecordsListDataRecordx20250921 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgyRecordsListDataRecordx20250921Extension on GetRhgyRecordsListDataRecordx20250921 {
  GetRhgyRecordsListDataRecordx20250921 copyWith({
    double? betAmount,
    List<GetRhgyRecordsListDataRecordx20250921Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgyRecordsListDataRecordx20250921()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgyRecordsListDataRecordx20250921Data $GetRhgyRecordsListDataRecordx20250921DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListDataRecordx20250921Data getRhgyRecordsListDataRecordx20250921Data = GetRhgyRecordsListDataRecordx20250921Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyRecordsListDataRecordx20250921Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyRecordsListDataRecordx20250921Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyRecordsListDataRecordx20250921Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyRecordsListDataRecordx20250921Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyRecordsListDataRecordx20250921Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyRecordsListDataRecordx20250921Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyRecordsListDataRecordx20250921Data.betTimeStr = betTimeStr;
  }
  final List<
      GetRhgyRecordsListDataRecordx20250921DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyRecordsListDataRecordx20250921DataDetailList>(
          e) as GetRhgyRecordsListDataRecordx20250921DataDetailList).toList();
  if (detailList != null) {
    getRhgyRecordsListDataRecordx20250921Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgyRecordsListDataRecordx20250921Data.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyRecordsListDataRecordx20250921Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgyRecordsListDataRecordx20250921Data.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyRecordsListDataRecordx20250921Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyRecordsListDataRecordx20250921Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgyRecordsListDataRecordx20250921Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyRecordsListDataRecordx20250921Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getRhgyRecordsListDataRecordx20250921Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgyRecordsListDataRecordx20250921Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyRecordsListDataRecordx20250921Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyRecordsListDataRecordx20250921Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyRecordsListDataRecordx20250921Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyRecordsListDataRecordx20250921Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyRecordsListDataRecordx20250921Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyRecordsListDataRecordx20250921Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyRecordsListDataRecordx20250921Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgyRecordsListDataRecordx20250921Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgyRecordsListDataRecordx20250921Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyRecordsListDataRecordx20250921Data.outcome = outcome;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyRecordsListDataRecordx20250921Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgyRecordsListDataRecordx20250921Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgyRecordsListDataRecordx20250921Data.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyRecordsListDataRecordx20250921Data.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgyRecordsListDataRecordx20250921Data.preSettle = preSettle;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getRhgyRecordsListDataRecordx20250921Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyRecordsListDataRecordx20250921Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyRecordsListDataRecordx20250921Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyRecordsListDataRecordx20250921Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyRecordsListDataRecordx20250921Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyRecordsListDataRecordx20250921Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyRecordsListDataRecordx20250921Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyRecordsListDataRecordx20250921Data.settledAmount = settledAmount;
  }
  return getRhgyRecordsListDataRecordx20250921Data;
}

Map<String, dynamic> $GetRhgyRecordsListDataRecordx20250921DataToJson(
    GetRhgyRecordsListDataRecordx20250921Data entity) {
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

extension GetRhgyRecordsListDataRecordx20250921DataExtension on GetRhgyRecordsListDataRecordx20250921Data {
  GetRhgyRecordsListDataRecordx20250921Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetRhgyRecordsListDataRecordx20250921DataDetailList>? detailList,
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
    return GetRhgyRecordsListDataRecordx20250921Data()
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

GetRhgyRecordsListDataRecordx20250921DataDetailList $GetRhgyRecordsListDataRecordx20250921DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListDataRecordx20250921DataDetailList getRhgyRecordsListDataRecordx20250921DataDetailList = GetRhgyRecordsListDataRecordx20250921DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.cancelType = cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchInfo = matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchOver = matchOver;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.oddFinally = oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.secondNum = secondNum;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.startTime = startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyRecordsListDataRecordx20250921DataDetailList.userId = userId;
  }
  return getRhgyRecordsListDataRecordx20250921DataDetailList;
}

Map<String, dynamic> $GetRhgyRecordsListDataRecordx20250921DataDetailListToJson(
    GetRhgyRecordsListDataRecordx20250921DataDetailList entity) {
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

extension GetRhgyRecordsListDataRecordx20250921DataDetailListExtension on GetRhgyRecordsListDataRecordx20250921DataDetailList {
  GetRhgyRecordsListDataRecordx20250921DataDetailList copyWith({
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
    return GetRhgyRecordsListDataRecordx20250921DataDetailList()
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

GetRhgyRecordsListDataRecordx20250920 $GetRhgyRecordsListDataRecordx20250920FromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListDataRecordx20250920 getRhgyRecordsListDataRecordx20250920 = GetRhgyRecordsListDataRecordx20250920();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgyRecordsListDataRecordx20250920.betAmount = betAmount;
  }
  final List<
      GetRhgyRecordsListDataRecordx20250920Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetRhgyRecordsListDataRecordx20250920Data>(
          e) as GetRhgyRecordsListDataRecordx20250920Data).toList();
  if (data != null) {
    getRhgyRecordsListDataRecordx20250920.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgyRecordsListDataRecordx20250920.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgyRecordsListDataRecordx20250920.profit = profit;
  }
  return getRhgyRecordsListDataRecordx20250920;
}

Map<String, dynamic> $GetRhgyRecordsListDataRecordx20250920ToJson(
    GetRhgyRecordsListDataRecordx20250920 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgyRecordsListDataRecordx20250920Extension on GetRhgyRecordsListDataRecordx20250920 {
  GetRhgyRecordsListDataRecordx20250920 copyWith({
    double? betAmount,
    List<GetRhgyRecordsListDataRecordx20250920Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgyRecordsListDataRecordx20250920()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgyRecordsListDataRecordx20250920Data $GetRhgyRecordsListDataRecordx20250920DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListDataRecordx20250920Data getRhgyRecordsListDataRecordx20250920Data = GetRhgyRecordsListDataRecordx20250920Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgyRecordsListDataRecordx20250920Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgyRecordsListDataRecordx20250920Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgyRecordsListDataRecordx20250920Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgyRecordsListDataRecordx20250920Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgyRecordsListDataRecordx20250920Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgyRecordsListDataRecordx20250920Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgyRecordsListDataRecordx20250920Data.betTimeStr = betTimeStr;
  }
  final List<
      GetRhgyRecordsListDataRecordx20250920DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgyRecordsListDataRecordx20250920DataDetailList>(
          e) as GetRhgyRecordsListDataRecordx20250920DataDetailList).toList();
  if (detailList != null) {
    getRhgyRecordsListDataRecordx20250920Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgyRecordsListDataRecordx20250920Data.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgyRecordsListDataRecordx20250920Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgyRecordsListDataRecordx20250920Data.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgyRecordsListDataRecordx20250920Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgyRecordsListDataRecordx20250920Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgyRecordsListDataRecordx20250920Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyRecordsListDataRecordx20250920Data.marketType = marketType;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyRecordsListDataRecordx20250920Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgyRecordsListDataRecordx20250920Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgyRecordsListDataRecordx20250920Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgyRecordsListDataRecordx20250920Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgyRecordsListDataRecordx20250920Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgyRecordsListDataRecordx20250920Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyRecordsListDataRecordx20250920Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyRecordsListDataRecordx20250920Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgyRecordsListDataRecordx20250920Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgyRecordsListDataRecordx20250920Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgyRecordsListDataRecordx20250920Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgyRecordsListDataRecordx20250920Data.outcome = outcome;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getRhgyRecordsListDataRecordx20250920Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgyRecordsListDataRecordx20250920Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgyRecordsListDataRecordx20250920Data.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgyRecordsListDataRecordx20250920Data.preOrderVoList = preOrderVoList;
  }
  final int? preSettle = jsonConvert.convert<int>(json['preSettle']);
  if (preSettle != null) {
    getRhgyRecordsListDataRecordx20250920Data.preSettle = preSettle;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getRhgyRecordsListDataRecordx20250920Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgyRecordsListDataRecordx20250920Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgyRecordsListDataRecordx20250920Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgyRecordsListDataRecordx20250920Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgyRecordsListDataRecordx20250920Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgyRecordsListDataRecordx20250920Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgyRecordsListDataRecordx20250920Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgyRecordsListDataRecordx20250920Data.settledAmount = settledAmount;
  }
  return getRhgyRecordsListDataRecordx20250920Data;
}

Map<String, dynamic> $GetRhgyRecordsListDataRecordx20250920DataToJson(
    GetRhgyRecordsListDataRecordx20250920Data entity) {
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

extension GetRhgyRecordsListDataRecordx20250920DataExtension on GetRhgyRecordsListDataRecordx20250920Data {
  GetRhgyRecordsListDataRecordx20250920Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetRhgyRecordsListDataRecordx20250920DataDetailList>? detailList,
    bool? enablePreSettle,
    String? id,
    bool? initPresettleWs,
    String? langCode,
    String? languageName,
    int? managerCode,
    String? marketType,
    int? matchType,
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
    int? preSettle,
    double? preSettleBetAmount,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    int? settleType,
    dynamic settledAmount,
  }) {
    return GetRhgyRecordsListDataRecordx20250920Data()
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

GetRhgyRecordsListDataRecordx20250920DataDetailList $GetRhgyRecordsListDataRecordx20250920DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgyRecordsListDataRecordx20250920DataDetailList getRhgyRecordsListDataRecordx20250920DataDetailList = GetRhgyRecordsListDataRecordx20250920DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.cancelType = cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchInfo = matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchOver = matchOver;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.oddFinally = oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.secondNum = secondNum;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.startTime = startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgyRecordsListDataRecordx20250920DataDetailList.userId = userId;
  }
  return getRhgyRecordsListDataRecordx20250920DataDetailList;
}

Map<String, dynamic> $GetRhgyRecordsListDataRecordx20250920DataDetailListToJson(
    GetRhgyRecordsListDataRecordx20250920DataDetailList entity) {
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

extension GetRhgyRecordsListDataRecordx20250920DataDetailListExtension on GetRhgyRecordsListDataRecordx20250920DataDetailList {
  GetRhgyRecordsListDataRecordx20250920DataDetailList copyWith({
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
    return GetRhgyRecordsListDataRecordx20250920DataDetailList()
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