import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/order_status_entity.dart';

OrderStatusEntity $OrderStatusEntityFromJson(Map<String, dynamic> json) {
  final OrderStatusEntity orderStatusEntity = OrderStatusEntity();
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    orderStatusEntity.betNo = betNo;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    orderStatusEntity.betTime = betTime;
  }
  final dynamic ctsOrder = json['ctsOrder'];
  if (ctsOrder != null) {
    orderStatusEntity.ctsOrder = ctsOrder;
  }
  final String? currentEvent = jsonConvert.convert<String>(
      json['currentEvent']);
  if (currentEvent != null) {
    orderStatusEntity.currentEvent = currentEvent;
  }
  final String? exception = jsonConvert.convert<String>(json['exception']);
  if (exception != null) {
    orderStatusEntity.exception = exception;
  }
  final dynamic ftsOrder = json['ftsOrder'];
  if (ftsOrder != null) {
    orderStatusEntity.ftsOrder = ftsOrder;
  }
  final dynamic handleTime = json['handleTime'];
  if (handleTime != null) {
    orderStatusEntity.handleTime = handleTime;
  }
  final dynamic infoCode = json['infoCode'];
  if (infoCode != null) {
    orderStatusEntity.infoCode = infoCode;
  }
  final String? infoMsg = jsonConvert.convert<String>(json['infoMsg']);
  if (infoMsg != null) {
    orderStatusEntity.infoMsg = infoMsg;
  }
  final dynamic infoStatus = json['infoStatus'];
  if (infoStatus != null) {
    orderStatusEntity.infoStatus = infoStatus;
  }
  final bool? isOddsChange = jsonConvert.convert<bool>(json['isOddsChange']);
  if (isOddsChange != null) {
    orderStatusEntity.isOddsChange = isOddsChange;
  }
  final int? isSeries = jsonConvert.convert<int>(json['isSeries']);
  if (isSeries != null) {
    orderStatusEntity.isSeries = isSeries;
  }
  final dynamic mtsIsCache = json['mtsIsCache'];
  if (mtsIsCache != null) {
    orderStatusEntity.mtsIsCache = mtsIsCache;
  }
  final double? newMaxWinAmount = jsonConvert.convert<double>(
      json['newMaxWinAmount']);
  if (newMaxWinAmount != null) {
    orderStatusEntity.newMaxWinAmount = newMaxWinAmount;
  }
  final int? newProcessOrder = jsonConvert.convert<int>(
      json['newProcessOrder']);
  if (newProcessOrder != null) {
    orderStatusEntity.newProcessOrder = newProcessOrder;
  }
  final dynamic noSettleOrderSum = json['noSettleOrderSum'];
  if (noSettleOrderSum != null) {
    orderStatusEntity.noSettleOrderSum = noSettleOrderSum;
  }
  final dynamic oddsChange = json['oddsChange'];
  if (oddsChange != null) {
    orderStatusEntity.oddsChange = oddsChange;
  }
  final dynamic oddsChange2 = json['oddsChange2'];
  if (oddsChange2 != null) {
    orderStatusEntity.oddsChange2 = oddsChange2;
  }
  final List<
      OrderStatusOddsChangeList>? oddsChangeList = (json['oddsChangeList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<OrderStatusOddsChangeList>(
          e) as OrderStatusOddsChangeList).toList();
  if (oddsChangeList != null) {
    orderStatusEntity.oddsChangeList = oddsChangeList;
  }
  final dynamic oddsRange = json['oddsRange'];
  if (oddsRange != null) {
    orderStatusEntity.oddsRange = oddsRange;
  }
  final dynamic operationUserId = json['operationUserId'];
  if (operationUserId != null) {
    orderStatusEntity.operationUserId = operationUserId;
  }
  final String? orderGroup = jsonConvert.convert<String>(json['orderGroup']);
  if (orderGroup != null) {
    orderStatusEntity.orderGroup = orderGroup;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    orderStatusEntity.orderNo = orderNo;
  }
  final dynamic reTryCount = json['reTryCount'];
  if (reTryCount != null) {
    orderStatusEntity.reTryCount = reTryCount;
  }
  final String? refuseCode = jsonConvert.convert<String>(json['refuseCode']);
  if (refuseCode != null) {
    orderStatusEntity.refuseCode = refuseCode;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    orderStatusEntity.remark = remark;
  }
  final dynamic sendBssMqTime = json['sendBssMqTime'];
  if (sendBssMqTime != null) {
    orderStatusEntity.sendBssMqTime = sendBssMqTime;
  }
  final int? sendTimes = jsonConvert.convert<int>(json['sendTimes']);
  if (sendTimes != null) {
    orderStatusEntity.sendTimes = sendTimes;
  }
  final String? sendWSTime = jsonConvert.convert<String>(json['sendWSTime']);
  if (sendWSTime != null) {
    orderStatusEntity.sendWSTime = sendWSTime;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    orderStatusEntity.status = status;
  }
  final dynamic transferMode = json['transferMode'];
  if (transferMode != null) {
    orderStatusEntity.transferMode = transferMode;
  }
  final int? tryNewProcessBet = jsonConvert.convert<int>(
      json['tryNewProcessBet']);
  if (tryNewProcessBet != null) {
    orderStatusEntity.tryNewProcessBet = tryNewProcessBet;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    orderStatusEntity.userId = userId;
  }
  final dynamic varOrder = json['varOrder'];
  if (varOrder != null) {
    orderStatusEntity.varOrder = varOrder;
  }
  return orderStatusEntity;
}

Map<String, dynamic> $OrderStatusEntityToJson(OrderStatusEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betNo'] = entity.betNo;
  data['betTime'] = entity.betTime;
  data['ctsOrder'] = entity.ctsOrder;
  data['currentEvent'] = entity.currentEvent;
  data['exception'] = entity.exception;
  data['ftsOrder'] = entity.ftsOrder;
  data['handleTime'] = entity.handleTime;
  data['infoCode'] = entity.infoCode;
  data['infoMsg'] = entity.infoMsg;
  data['infoStatus'] = entity.infoStatus;
  data['isOddsChange'] = entity.isOddsChange;
  data['isSeries'] = entity.isSeries;
  data['mtsIsCache'] = entity.mtsIsCache;
  data['newMaxWinAmount'] = entity.newMaxWinAmount;
  data['newProcessOrder'] = entity.newProcessOrder;
  data['noSettleOrderSum'] = entity.noSettleOrderSum;
  data['oddsChange'] = entity.oddsChange;
  data['oddsChange2'] = entity.oddsChange2;
  data['oddsChangeList'] =
      entity.oddsChangeList.map((v) => v.toJson()).toList();
  data['oddsRange'] = entity.oddsRange;
  data['operationUserId'] = entity.operationUserId;
  data['orderGroup'] = entity.orderGroup;
  data['orderNo'] = entity.orderNo;
  data['reTryCount'] = entity.reTryCount;
  data['refuseCode'] = entity.refuseCode;
  data['remark'] = entity.remark;
  data['sendBssMqTime'] = entity.sendBssMqTime;
  data['sendTimes'] = entity.sendTimes;
  data['sendWSTime'] = entity.sendWSTime;
  data['status'] = entity.status;
  data['transferMode'] = entity.transferMode;
  data['tryNewProcessBet'] = entity.tryNewProcessBet;
  data['userId'] = entity.userId;
  data['varOrder'] = entity.varOrder;
  return data;
}

extension OrderStatusEntityExtension on OrderStatusEntity {
  OrderStatusEntity copyWith({
    String? betNo,
    dynamic betTime,
    dynamic ctsOrder,
    String? currentEvent,
    String? exception,
    dynamic ftsOrder,
    dynamic handleTime,
    dynamic infoCode,
    String? infoMsg,
    dynamic infoStatus,
    bool? isOddsChange,
    int? isSeries,
    dynamic mtsIsCache,
    double? newMaxWinAmount,
    int? newProcessOrder,
    dynamic noSettleOrderSum,
    dynamic oddsChange,
    dynamic oddsChange2,
    List<OrderStatusOddsChangeList>? oddsChangeList,
    dynamic oddsRange,
    dynamic operationUserId,
    String? orderGroup,
    String? orderNo,
    dynamic reTryCount,
    String? refuseCode,
    String? remark,
    dynamic sendBssMqTime,
    int? sendTimes,
    String? sendWSTime,
    int? status,
    dynamic transferMode,
    int? tryNewProcessBet,
    String? userId,
    dynamic varOrder,
  }) {
    return OrderStatusEntity()
      ..betNo = betNo ?? this.betNo
      ..betTime = betTime ?? this.betTime
      ..ctsOrder = ctsOrder ?? this.ctsOrder
      ..currentEvent = currentEvent ?? this.currentEvent
      ..exception = exception ?? this.exception
      ..ftsOrder = ftsOrder ?? this.ftsOrder
      ..handleTime = handleTime ?? this.handleTime
      ..infoCode = infoCode ?? this.infoCode
      ..infoMsg = infoMsg ?? this.infoMsg
      ..infoStatus = infoStatus ?? this.infoStatus
      ..isOddsChange = isOddsChange ?? this.isOddsChange
      ..isSeries = isSeries ?? this.isSeries
      ..mtsIsCache = mtsIsCache ?? this.mtsIsCache
      ..newMaxWinAmount = newMaxWinAmount ?? this.newMaxWinAmount
      ..newProcessOrder = newProcessOrder ?? this.newProcessOrder
      ..noSettleOrderSum = noSettleOrderSum ?? this.noSettleOrderSum
      ..oddsChange = oddsChange ?? this.oddsChange
      ..oddsChange2 = oddsChange2 ?? this.oddsChange2
      ..oddsChangeList = oddsChangeList ?? this.oddsChangeList
      ..oddsRange = oddsRange ?? this.oddsRange
      ..operationUserId = operationUserId ?? this.operationUserId
      ..orderGroup = orderGroup ?? this.orderGroup
      ..orderNo = orderNo ?? this.orderNo
      ..reTryCount = reTryCount ?? this.reTryCount
      ..refuseCode = refuseCode ?? this.refuseCode
      ..remark = remark ?? this.remark
      ..sendBssMqTime = sendBssMqTime ?? this.sendBssMqTime
      ..sendTimes = sendTimes ?? this.sendTimes
      ..sendWSTime = sendWSTime ?? this.sendWSTime
      ..status = status ?? this.status
      ..transferMode = transferMode ?? this.transferMode
      ..tryNewProcessBet = tryNewProcessBet ?? this.tryNewProcessBet
      ..userId = userId ?? this.userId
      ..varOrder = varOrder ?? this.varOrder;
  }
}

OrderStatusOddsChangeList $OrderStatusOddsChangeListFromJson(
    Map<String, dynamic> json) {
  final OrderStatusOddsChangeList orderStatusOddsChangeList = OrderStatusOddsChangeList();
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    orderStatusOddsChangeList.betNo = betNo;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    orderStatusOddsChangeList.playOptionsId = playOptionsId;
  }
  final String? requestedOdds = jsonConvert.convert<String>(
      json['requestedOdds']);
  if (requestedOdds != null) {
    orderStatusOddsChangeList.requestedOdds = requestedOdds;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    orderStatusOddsChangeList.riskEvent = riskEvent;
  }
  final String? usedOdds = jsonConvert.convert<String>(json['usedOdds']);
  if (usedOdds != null) {
    orderStatusOddsChangeList.usedOdds = usedOdds;
  }
  return orderStatusOddsChangeList;
}

Map<String, dynamic> $OrderStatusOddsChangeListToJson(
    OrderStatusOddsChangeList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betNo'] = entity.betNo;
  data['playOptionsId'] = entity.playOptionsId;
  data['requestedOdds'] = entity.requestedOdds;
  data['riskEvent'] = entity.riskEvent;
  data['usedOdds'] = entity.usedOdds;
  return data;
}

extension OrderStatusOddsChangeListExtension on OrderStatusOddsChangeList {
  OrderStatusOddsChangeList copyWith({
    String? betNo,
    String? playOptionsId,
    String? requestedOdds,
    String? riskEvent,
    String? usedOdds,
  }) {
    return OrderStatusOddsChangeList()
      ..betNo = betNo ?? this.betNo
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..requestedOdds = requestedOdds ?? this.requestedOdds
      ..riskEvent = riskEvent ?? this.riskEvent
      ..usedOdds = usedOdds ?? this.usedOdds;
  }
}