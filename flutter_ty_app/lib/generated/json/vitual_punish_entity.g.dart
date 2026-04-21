import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/mockdata/vitual_punish_entity.dart';

VitualPunishEntity $VitualPunishEntityFromJson(Map<String, dynamic> json) {
  final VitualPunishEntity vitualPunishEntity = VitualPunishEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    vitualPunishEntity.code = code;
  }
  final List<VitualPunishData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<VitualPunishData>(e) as VitualPunishData)
      .toList();
  if (data != null) {
    vitualPunishEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    vitualPunishEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    vitualPunishEntity.ts = ts;
  }
  return vitualPunishEntity;
}

Map<String, dynamic> $VitualPunishEntityToJson(VitualPunishEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension VitualPunishEntityExtension on VitualPunishEntity {
  VitualPunishEntity copyWith({
    String? code,
    List<VitualPunishData>? data,
    String? msg,
    int? ts,
  }) {
    return VitualPunishEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

VitualPunishData $VitualPunishDataFromJson(Map<String, dynamic> json) {
  final VitualPunishData vitualPunishData = VitualPunishData();
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    vitualPunishData.marketName = marketName;
  }
  final int? orderNo = jsonConvert.convert<int>(json['orderNo']);
  if (orderNo != null) {
    vitualPunishData.orderNo = orderNo;
  }
  final List<int>? plays = (json['plays'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (plays != null) {
    vitualPunishData.plays = plays;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    vitualPunishData.id = id;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    vitualPunishData.label = label;
  }
  return vitualPunishData;
}

Map<String, dynamic> $VitualPunishDataToJson(VitualPunishData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['marketName'] = entity.marketName;
  data['orderNo'] = entity.orderNo;
  data['plays'] = entity.plays;
  data['id'] = entity.id;
  data['label'] = entity.label;
  return data;
}

extension VitualPunishDataExtension on VitualPunishData {
  VitualPunishData copyWith({
    String? marketName,
    int? orderNo,
    List<int>? plays,
    String? id,
    String? label,
  }) {
    return VitualPunishData()
      ..marketName = marketName ?? this.marketName
      ..orderNo = orderNo ?? this.orderNo
      ..plays = plays ?? this.plays
      ..id = id ?? this.id
      ..label = label ?? this.label;
  }
}