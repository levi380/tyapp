import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_pre_settle_order_detail_entity.dart';

GetPreSettleOrderDetailEntity $GetPreSettleOrderDetailEntityFromJson(
    Map<String, dynamic> json) {
  final GetPreSettleOrderDetailEntity getPreSettleOrderDetailEntity = GetPreSettleOrderDetailEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getPreSettleOrderDetailEntity.code = code;
  }
  final List<GetPreSettleOrderDetailData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetPreSettleOrderDetailData>(
          e) as GetPreSettleOrderDetailData).toList();
  if (data != null) {
    getPreSettleOrderDetailEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getPreSettleOrderDetailEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getPreSettleOrderDetailEntity.ts = ts;
  }
  return getPreSettleOrderDetailEntity;
}

Map<String, dynamic> $GetPreSettleOrderDetailEntityToJson(
    GetPreSettleOrderDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetPreSettleOrderDetailEntityExtension on GetPreSettleOrderDetailEntity {
  GetPreSettleOrderDetailEntity copyWith({
    String? code,
    List<GetPreSettleOrderDetailData>? data,
    String? msg,
    int? ts,
  }) {
    return GetPreSettleOrderDetailEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetPreSettleOrderDetailData $GetPreSettleOrderDetailDataFromJson(
    Map<String, dynamic> json) {
  final GetPreSettleOrderDetailData getPreSettleOrderDetailData = GetPreSettleOrderDetailData();
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    getPreSettleOrderDetailData.createTime = createTime;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getPreSettleOrderDetailData.orderNo = orderNo;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    getPreSettleOrderDetailData.orderStatus = orderStatus;
  }
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    getPreSettleOrderDetailData.preBetAmount = preBetAmount;
  }
  final String? preOrderNo = jsonConvert.convert<String>(json['preOrderNo']);
  if (preOrderNo != null) {
    getPreSettleOrderDetailData.preOrderNo = preOrderNo;
  }
  final double? profit = jsonConvert.convert<double>(json['profit']);
  if (profit != null) {
    getPreSettleOrderDetailData.profit = profit;
  }
  final double? remainingBetAmount = jsonConvert.convert<double>(
      json['remainingBetAmount']);
  if (remainingBetAmount != null) {
    getPreSettleOrderDetailData.remainingBetAmount = remainingBetAmount;
  }
  final double? settleAmount = jsonConvert.convert<double>(
      json['settleAmount']);
  if (settleAmount != null) {
    getPreSettleOrderDetailData.settleAmount = settleAmount;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getPreSettleOrderDetailData.settleType = settleType;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    getPreSettleOrderDetailData.type = type;
  }
  return getPreSettleOrderDetailData;
}

Map<String, dynamic> $GetPreSettleOrderDetailDataToJson(
    GetPreSettleOrderDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createTime'] = entity.createTime;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrderNo'] = entity.preOrderNo;
  data['profit'] = entity.profit;
  data['remainingBetAmount'] = entity.remainingBetAmount;
  data['settleAmount'] = entity.settleAmount;
  data['settleType'] = entity.settleType;
  data['type'] = entity.type;
  return data;
}

extension GetPreSettleOrderDetailDataExtension on GetPreSettleOrderDetailData {
  GetPreSettleOrderDetailData copyWith({
    String? createTime,
    String? orderNo,
    int? orderStatus,
    double? preBetAmount,
    String? preOrderNo,
    double? profit,
    double? remainingBetAmount,
    double? settleAmount,
    int? settleType,
    int? type,
  }) {
    return GetPreSettleOrderDetailData()
      ..createTime = createTime ?? this.createTime
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrderNo = preOrderNo ?? this.preOrderNo
      ..profit = profit ?? this.profit
      ..remainingBetAmount = remainingBetAmount ?? this.remainingBetAmount
      ..settleAmount = settleAmount ?? this.settleAmount
      ..settleType = settleType ?? this.settleType
      ..type = type ?? this.type;
  }
}