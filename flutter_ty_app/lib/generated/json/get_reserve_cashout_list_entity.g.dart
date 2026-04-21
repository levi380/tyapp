import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_reserve_cashout_list_entity.dart';

GetReserveCashoutListEntity $GetReserveCashoutListEntityFromJson(
    Map<String, dynamic> json) {
  final GetReserveCashoutListEntity getReserveCashoutListEntity = GetReserveCashoutListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getReserveCashoutListEntity.code = code;
  }
  final List<GetReserveCashoutListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetReserveCashoutListData>(
          e) as GetReserveCashoutListData)
      .toList();
  if (data != null) {
    getReserveCashoutListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getReserveCashoutListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getReserveCashoutListEntity.ts = ts;
  }
  return getReserveCashoutListEntity;
}

Map<String, dynamic> $GetReserveCashoutListEntityToJson(
    GetReserveCashoutListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetReserveCashoutListEntityExtension on GetReserveCashoutListEntity {
  GetReserveCashoutListEntity copyWith({
    String? code,
    List<GetReserveCashoutListData>? data,
    String? msg,
    int? ts,
  }) {
    return GetReserveCashoutListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetReserveCashoutListData $GetReserveCashoutListDataFromJson(
    Map<String, dynamic> json) {
  final GetReserveCashoutListData getReserveCashoutListData = GetReserveCashoutListData();
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getReserveCashoutListData.orderNo = orderNo;
  }
  final String? reserveCashOutAmount = jsonConvert.convert<String>(
      json['reserveCashOutAmount']);
  if (reserveCashOutAmount != null) {
    getReserveCashoutListData.reserveCashOutAmount = reserveCashOutAmount;
  }
  final String? reserveCashOutNo = jsonConvert.convert<String>(
      json['reserveCashOutNo']);
  if (reserveCashOutNo != null) {
    getReserveCashoutListData.reserveCashOutNo = reserveCashOutNo;
  }
  final int? reserveStatus = jsonConvert.convert<int>(json['reserveStatus']);
  if (reserveStatus != null) {
    getReserveCashoutListData.reserveStatus = reserveStatus;
  }
  return getReserveCashoutListData;
}

Map<String, dynamic> $GetReserveCashoutListDataToJson(
    GetReserveCashoutListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderNo'] = entity.orderNo;
  data['reserveCashOutAmount'] = entity.reserveCashOutAmount;
  data['reserveCashOutNo'] = entity.reserveCashOutNo;
  data['reserveStatus'] = entity.reserveStatus;
  return data;
}

extension GetReserveCashoutListDataExtension on GetReserveCashoutListData {
  GetReserveCashoutListData copyWith({
    String? orderNo,
    String? reserveCashOutAmount,
    String? reserveCashOutNo,
    int? reserveStatus,
  }) {
    return GetReserveCashoutListData()
      ..orderNo = orderNo ?? this.orderNo
      ..reserveCashOutAmount = reserveCashOutAmount ?? this.reserveCashOutAmount
      ..reserveCashOutNo = reserveCashOutNo ?? this.reserveCashOutNo
      ..reserveStatus = reserveStatus ?? this.reserveStatus;
  }
}