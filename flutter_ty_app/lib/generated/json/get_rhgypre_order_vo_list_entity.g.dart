import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_rhgypre_order_vo_list_entity.dart';

GetRhgypreOrderVoListEntity $GetRhgypreOrderVoListEntityFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListEntity getRhgypreOrderVoListEntity = GetRhgypreOrderVoListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getRhgypreOrderVoListEntity.code = code;
  }
  final GetRhgypreOrderVoListData? data = jsonConvert.convert<
      GetRhgypreOrderVoListData>(json['data']);
  if (data != null) {
    getRhgypreOrderVoListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getRhgypreOrderVoListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getRhgypreOrderVoListEntity.ts = ts;
  }
  return getRhgypreOrderVoListEntity;
}

Map<String, dynamic> $GetRhgypreOrderVoListEntityToJson(
    GetRhgypreOrderVoListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetRhgypreOrderVoListEntityExtension on GetRhgypreOrderVoListEntity {
  GetRhgypreOrderVoListEntity copyWith({
    String? code,
    GetRhgypreOrderVoListData? data,
    String? msg,
    int? ts,
  }) {
    return GetRhgypreOrderVoListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetRhgypreOrderVoListData $GetRhgypreOrderVoListDataFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListData getRhgypreOrderVoListData = GetRhgypreOrderVoListData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getRhgypreOrderVoListData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getRhgypreOrderVoListData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getRhgypreOrderVoListData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getRhgypreOrderVoListData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getRhgypreOrderVoListData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getRhgypreOrderVoListData.hasPrevious = hasPrevious;
  }
  final String? maxWinTotalAmount = jsonConvert.convert<String>(
      json['maxWinTotalAmount']);
  if (maxWinTotalAmount != null) {
    getRhgypreOrderVoListData.maxWinTotalAmount = maxWinTotalAmount;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getRhgypreOrderVoListData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getRhgypreOrderVoListData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getRhgypreOrderVoListData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getRhgypreOrderVoListData.profit = profit;
  }
  final GetRhgypreOrderVoListDataRecord? record = jsonConvert.convert<
      GetRhgypreOrderVoListDataRecord>(json['record']);
  if (record != null) {
    getRhgypreOrderVoListData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getRhgypreOrderVoListData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getRhgypreOrderVoListData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getRhgypreOrderVoListData.size = size;
  }
  final String? subOrderTotal = jsonConvert.convert<String>(
      json['subOrderTotal']);
  if (subOrderTotal != null) {
    getRhgypreOrderVoListData.subOrderTotal = subOrderTotal;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getRhgypreOrderVoListData.total = total;
  }
  return getRhgypreOrderVoListData;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataToJson(
    GetRhgypreOrderVoListData entity) {
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

extension GetRhgypreOrderVoListDataExtension on GetRhgypreOrderVoListData {
  GetRhgypreOrderVoListData copyWith({
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
    GetRhgypreOrderVoListDataRecord? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? subOrderTotal,
    String? total,
  }) {
    return GetRhgypreOrderVoListData()
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

GetRhgypreOrderVoListDataRecord $GetRhgypreOrderVoListDataRecordFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecord getRhgypreOrderVoListDataRecord = GetRhgypreOrderVoListDataRecord();
  final GetRhgypreOrderVoListDataRecordx20251107? x20251107 = jsonConvert
      .convert<GetRhgypreOrderVoListDataRecordx20251107>(json['2025-11-07']);
  if (x20251107 != null) {
    getRhgypreOrderVoListDataRecord.x20251107 = x20251107;
  }
  final GetRhgypreOrderVoListDataRecordx20251102? x20251102 = jsonConvert
      .convert<GetRhgypreOrderVoListDataRecordx20251102>(json['2025-11-02']);
  if (x20251102 != null) {
    getRhgypreOrderVoListDataRecord.x20251102 = x20251102;
  }
  final GetRhgypreOrderVoListDataRecordx20251026? x20251026 = jsonConvert
      .convert<GetRhgypreOrderVoListDataRecordx20251026>(json['2025-10-26']);
  if (x20251026 != null) {
    getRhgypreOrderVoListDataRecord.x20251026 = x20251026;
  }
  return getRhgypreOrderVoListDataRecord;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataRecordToJson(
    GetRhgypreOrderVoListDataRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['2025-11-07'] = entity.x20251107.toJson();
  data['2025-11-02'] = entity.x20251102.toJson();
  data['2025-10-26'] = entity.x20251026.toJson();
  return data;
}

extension GetRhgypreOrderVoListDataRecordExtension on GetRhgypreOrderVoListDataRecord {
  GetRhgypreOrderVoListDataRecord copyWith({
    GetRhgypreOrderVoListDataRecordx20251107? x20251107,
    GetRhgypreOrderVoListDataRecordx20251102? x20251102,
    GetRhgypreOrderVoListDataRecordx20251026? x20251026,
  }) {
    return GetRhgypreOrderVoListDataRecord()
      ..x20251107 = x20251107 ?? this.x20251107
      ..x20251102 = x20251102 ?? this.x20251102
      ..x20251026 = x20251026 ?? this.x20251026;
  }
}

GetRhgypreOrderVoListDataRecordx20251107 $GetRhgypreOrderVoListDataRecordx20251107FromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251107 getRhgypreOrderVoListDataRecordx20251107 = GetRhgypreOrderVoListDataRecordx20251107();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107.betAmount = betAmount;
  }
  final List<
      GetRhgypreOrderVoListDataRecordx20251107Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgypreOrderVoListDataRecordx20251107Data>(
          e) as GetRhgypreOrderVoListDataRecordx20251107Data).toList();
  if (data != null) {
    getRhgypreOrderVoListDataRecordx20251107.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgypreOrderVoListDataRecordx20251107.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgypreOrderVoListDataRecordx20251107.profit = profit;
  }
  return getRhgypreOrderVoListDataRecordx20251107;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataRecordx20251107ToJson(
    GetRhgypreOrderVoListDataRecordx20251107 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgypreOrderVoListDataRecordx20251107Extension on GetRhgypreOrderVoListDataRecordx20251107 {
  GetRhgypreOrderVoListDataRecordx20251107 copyWith({
    double? betAmount,
    List<GetRhgypreOrderVoListDataRecordx20251107Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgypreOrderVoListDataRecordx20251107()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgypreOrderVoListDataRecordx20251107Data $GetRhgypreOrderVoListDataRecordx20251107DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251107Data getRhgypreOrderVoListDataRecordx20251107Data = GetRhgypreOrderVoListDataRecordx20251107Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.betTimeStr = betTimeStr;
  }
  final List<
      GetRhgypreOrderVoListDataRecordx20251107DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgypreOrderVoListDataRecordx20251107DataDetailList>(
          e) as GetRhgypreOrderVoListDataRecordx20251107DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.enablePreSettle =
        enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.initPresettleWs =
        initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107Data.settledAmount = settledAmount;
  }
  return getRhgypreOrderVoListDataRecordx20251107Data;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataRecordx20251107DataToJson(
    GetRhgypreOrderVoListDataRecordx20251107Data entity) {
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

extension GetRhgypreOrderVoListDataRecordx20251107DataExtension on GetRhgypreOrderVoListDataRecordx20251107Data {
  GetRhgypreOrderVoListDataRecordx20251107Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetRhgypreOrderVoListDataRecordx20251107DataDetailList>? detailList,
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
    dynamic preOrder,
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
    return GetRhgypreOrderVoListDataRecordx20251107Data()
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

GetRhgypreOrderVoListDataRecordx20251107DataDetailList $GetRhgypreOrderVoListDataRecordx20251107DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251107DataDetailList getRhgypreOrderVoListDataRecordx20251107DataDetailList = GetRhgypreOrderVoListDataRecordx20251107DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.cancelType =
        cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchInfo =
        matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchName =
        matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchOver =
        matchOver;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.secondNum =
        secondNum;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.startTime =
        startTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgypreOrderVoListDataRecordx20251107DataDetailList.userId = userId;
  }
  return getRhgypreOrderVoListDataRecordx20251107DataDetailList;
}

Map<String,
    dynamic> $GetRhgypreOrderVoListDataRecordx20251107DataDetailListToJson(
    GetRhgypreOrderVoListDataRecordx20251107DataDetailList entity) {
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

extension GetRhgypreOrderVoListDataRecordx20251107DataDetailListExtension on GetRhgypreOrderVoListDataRecordx20251107DataDetailList {
  GetRhgypreOrderVoListDataRecordx20251107DataDetailList copyWith({
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
    return GetRhgypreOrderVoListDataRecordx20251107DataDetailList()
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

GetRhgypreOrderVoListDataRecordx20251102 $GetRhgypreOrderVoListDataRecordx20251102FromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251102 getRhgypreOrderVoListDataRecordx20251102 = GetRhgypreOrderVoListDataRecordx20251102();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102.betAmount = betAmount;
  }
  final List<
      GetRhgypreOrderVoListDataRecordx20251102Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgypreOrderVoListDataRecordx20251102Data>(
          e) as GetRhgypreOrderVoListDataRecordx20251102Data).toList();
  if (data != null) {
    getRhgypreOrderVoListDataRecordx20251102.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgypreOrderVoListDataRecordx20251102.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgypreOrderVoListDataRecordx20251102.profit = profit;
  }
  return getRhgypreOrderVoListDataRecordx20251102;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataRecordx20251102ToJson(
    GetRhgypreOrderVoListDataRecordx20251102 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgypreOrderVoListDataRecordx20251102Extension on GetRhgypreOrderVoListDataRecordx20251102 {
  GetRhgypreOrderVoListDataRecordx20251102 copyWith({
    double? betAmount,
    List<GetRhgypreOrderVoListDataRecordx20251102Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgypreOrderVoListDataRecordx20251102()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgypreOrderVoListDataRecordx20251102Data $GetRhgypreOrderVoListDataRecordx20251102DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251102Data getRhgypreOrderVoListDataRecordx20251102Data = GetRhgypreOrderVoListDataRecordx20251102Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.betTimeStr = betTimeStr;
  }
  final List<
      GetRhgypreOrderVoListDataRecordx20251102DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgypreOrderVoListDataRecordx20251102DataDetailList>(
          e) as GetRhgypreOrderVoListDataRecordx20251102DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.enablePreSettle =
        enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.initPresettleWs =
        initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.marketType = marketType;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102Data.settledAmount = settledAmount;
  }
  return getRhgypreOrderVoListDataRecordx20251102Data;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataRecordx20251102DataToJson(
    GetRhgypreOrderVoListDataRecordx20251102Data entity) {
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

extension GetRhgypreOrderVoListDataRecordx20251102DataExtension on GetRhgypreOrderVoListDataRecordx20251102Data {
  GetRhgypreOrderVoListDataRecordx20251102Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetRhgypreOrderVoListDataRecordx20251102DataDetailList>? detailList,
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
    dynamic preBetAmount,
    dynamic preOrder,
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
    return GetRhgypreOrderVoListDataRecordx20251102Data()
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

GetRhgypreOrderVoListDataRecordx20251102DataDetailList $GetRhgypreOrderVoListDataRecordx20251102DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251102DataDetailList getRhgypreOrderVoListDataRecordx20251102DataDetailList = GetRhgypreOrderVoListDataRecordx20251102DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.cancelType =
        cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchInfo =
        matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchName =
        matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchOver =
        matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.secondNum =
        secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.startTime =
        startTime;
  }
  final dynamic thirdMatchId = json['thirdMatchId'];
  if (thirdMatchId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgypreOrderVoListDataRecordx20251102DataDetailList.userId = userId;
  }
  return getRhgypreOrderVoListDataRecordx20251102DataDetailList;
}

Map<String,
    dynamic> $GetRhgypreOrderVoListDataRecordx20251102DataDetailListToJson(
    GetRhgypreOrderVoListDataRecordx20251102DataDetailList entity) {
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

extension GetRhgypreOrderVoListDataRecordx20251102DataDetailListExtension on GetRhgypreOrderVoListDataRecordx20251102DataDetailList {
  GetRhgypreOrderVoListDataRecordx20251102DataDetailList copyWith({
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
    dynamic matchPeriodId,
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
    dynamic secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    dynamic thirdMatchId,
    String? tournamentId,
    int? tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetRhgypreOrderVoListDataRecordx20251102DataDetailList()
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

GetRhgypreOrderVoListDataRecordx20251026 $GetRhgypreOrderVoListDataRecordx20251026FromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251026 getRhgypreOrderVoListDataRecordx20251026 = GetRhgypreOrderVoListDataRecordx20251026();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026.betAmount = betAmount;
  }
  final List<
      GetRhgypreOrderVoListDataRecordx20251026Data>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgypreOrderVoListDataRecordx20251026Data>(
          e) as GetRhgypreOrderVoListDataRecordx20251026Data).toList();
  if (data != null) {
    getRhgypreOrderVoListDataRecordx20251026.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getRhgypreOrderVoListDataRecordx20251026.totalOrders = totalOrders;
  }
  final int? profit = jsonConvert.convert<int>(json['profit']);
  if (profit != null) {
    getRhgypreOrderVoListDataRecordx20251026.profit = profit;
  }
  return getRhgypreOrderVoListDataRecordx20251026;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataRecordx20251026ToJson(
    GetRhgypreOrderVoListDataRecordx20251026 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetRhgypreOrderVoListDataRecordx20251026Extension on GetRhgypreOrderVoListDataRecordx20251026 {
  GetRhgypreOrderVoListDataRecordx20251026 copyWith({
    double? betAmount,
    List<GetRhgypreOrderVoListDataRecordx20251026Data>? data,
    int? totalOrders,
    int? profit,
  }) {
    return GetRhgypreOrderVoListDataRecordx20251026()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetRhgypreOrderVoListDataRecordx20251026Data $GetRhgypreOrderVoListDataRecordx20251026DataFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251026Data getRhgypreOrderVoListDataRecordx20251026Data = GetRhgypreOrderVoListDataRecordx20251026Data();
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.betTimeStr = betTimeStr;
  }
  final List<
      GetRhgypreOrderVoListDataRecordx20251026DataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          GetRhgypreOrderVoListDataRecordx20251026DataDetailList>(
          e) as GetRhgypreOrderVoListDataRecordx20251026DataDetailList)
      .toList();
  if (detailList != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.enablePreSettle =
        enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.initPresettleWs =
        initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.langCode = langCode;
  }
  final String? languageName = jsonConvert.convert<String>(
      json['languageName']);
  if (languageName != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.languageName = languageName;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.marketType = marketType;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.matchType = matchType;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.modifyTimeStr = modifyTimeStr;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.odds = odds;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.orderType = orderType;
  }
  final dynamic orderVOS = json['orderVOS'];
  if (orderVOS != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.orderVOS = orderVOS;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.preOrderStatus =
        preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.preOrderVoList =
        preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.preSettleBetAmount =
        preSettleBetAmount;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026Data.settledAmount = settledAmount;
  }
  return getRhgypreOrderVoListDataRecordx20251026Data;
}

Map<String, dynamic> $GetRhgypreOrderVoListDataRecordx20251026DataToJson(
    GetRhgypreOrderVoListDataRecordx20251026Data entity) {
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

extension GetRhgypreOrderVoListDataRecordx20251026DataExtension on GetRhgypreOrderVoListDataRecordx20251026Data {
  GetRhgypreOrderVoListDataRecordx20251026Data copyWith({
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetRhgypreOrderVoListDataRecordx20251026DataDetailList>? detailList,
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
    dynamic preBetAmount,
    dynamic preOrder,
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
    return GetRhgypreOrderVoListDataRecordx20251026Data()
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

GetRhgypreOrderVoListDataRecordx20251026DataDetailList $GetRhgypreOrderVoListDataRecordx20251026DataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetRhgypreOrderVoListDataRecordx20251026DataDetailList getRhgypreOrderVoListDataRecordx20251026DataDetailList = GetRhgypreOrderVoListDataRecordx20251026DataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.acceptBetOdds =
        acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.backAmount =
        backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.beginTime =
        beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.betAmount =
        betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.betResult =
        betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.betStatus =
        betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.cancelType =
        cancelType;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.childPlayId =
        childPlayId;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.closingTime =
        closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.createTime =
        createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.eov = eov;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.extJson = extJson;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.marketName =
        marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.marketType =
        marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.marketValue =
        marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchInfo =
        matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchManageType =
        matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchName =
        matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchOver =
        matchOver;
  }
  final dynamic matchPeriodId = json['matchPeriodId'];
  if (matchPeriodId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchProcessId =
        matchProcessId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchStatusId =
        matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchTestScore =
        matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchType =
        matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.oddFinally =
        oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.oddsValue =
        oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.optionValue =
        optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.orderNo = orderNo;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.originalMarketValue =
        originalMarketValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.outrightYear =
        outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.playOptions =
        playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.playOptionsId =
        playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.riskEvent =
        riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.secondNum =
        secondNum;
  }
  final dynamic secondsMatchStart = json['secondsMatchStart'];
  if (secondsMatchStart != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.settleScore =
        settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.sportName =
        sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.startTime =
        startTime;
  }
  final dynamic thirdMatchId = json['thirdMatchId'];
  if (thirdMatchId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.thirdMatchId =
        thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.tournamentId =
        tournamentId;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.tournamentPic =
        tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getRhgypreOrderVoListDataRecordx20251026DataDetailList.userId = userId;
  }
  return getRhgypreOrderVoListDataRecordx20251026DataDetailList;
}

Map<String,
    dynamic> $GetRhgypreOrderVoListDataRecordx20251026DataDetailListToJson(
    GetRhgypreOrderVoListDataRecordx20251026DataDetailList entity) {
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

extension GetRhgypreOrderVoListDataRecordx20251026DataDetailListExtension on GetRhgypreOrderVoListDataRecordx20251026DataDetailList {
  GetRhgypreOrderVoListDataRecordx20251026DataDetailList copyWith({
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
    dynamic matchPeriodId,
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
    dynamic secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    dynamic thirdMatchId,
    String? tournamentId,
    int? tournamentLevel,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetRhgypreOrderVoListDataRecordx20251026DataDetailList()
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