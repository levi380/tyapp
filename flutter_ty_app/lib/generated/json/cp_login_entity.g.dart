import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_login_entity.dart';

CpLoginEntity $CpLoginEntityFromJson(Map<String, dynamic> json) {
  final CpLoginEntity cpLoginEntity = CpLoginEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    cpLoginEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    cpLoginEntity.message = message;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    cpLoginEntity.code = code;
  }
  final CpLoginData? data = jsonConvert.convert<CpLoginData>(json['data']);
  if (data != null) {
    cpLoginEntity.data = data;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    cpLoginEntity.serverTime = serverTime;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    cpLoginEntity.msg = msg;
  }
  return cpLoginEntity;
}

Map<String, dynamic> $CpLoginEntityToJson(CpLoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['serverTime'] = entity.serverTime;
  data['msg'] = entity.msg;
  return data;
}

extension CpLoginEntityExtension on CpLoginEntity {
  CpLoginEntity copyWith({
    bool? status,
    String? message,
    String? code,
    CpLoginData? data,
    int? serverTime,
    String? msg,
  }) {
    return CpLoginEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..serverTime = serverTime ?? this.serverTime
      ..msg = msg ?? this.msg;
  }
}

CpLoginData $CpLoginDataFromJson(Map<String, dynamic> json) {
  final CpLoginData cpLoginData = CpLoginData();
  final String? pc = jsonConvert.convert<String>(json['pc']);
  if (pc != null) {
    cpLoginData.pc = pc;
  }
  final String? h5 = jsonConvert.convert<String>(json['h5']);
  if (h5 != null) {
    cpLoginData.h5 = h5;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    cpLoginData.token = token;
  }
  return cpLoginData;
}

Map<String, dynamic> $CpLoginDataToJson(CpLoginData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pc'] = entity.pc;
  data['h5'] = entity.h5;
  data['token'] = entity.token;
  return data;
}

extension CpLoginDataExtension on CpLoginData {
  CpLoginData copyWith({
    String? pc,
    String? h5,
    String? token,
  }) {
    return CpLoginData()
      ..pc = pc ?? this.pc
      ..h5 = h5 ?? this.h5
      ..token = token ?? this.token;
  }
}