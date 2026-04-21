import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/exist_match_result_entity.dart';

ExistMatchResultEntity $ExistMatchResultEntityFromJson(
    Map<String, dynamic> json) {
  final ExistMatchResultEntity existMatchResultEntity = ExistMatchResultEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    existMatchResultEntity.code = code;
  }
  final ExistMatchResultData? data = jsonConvert.convert<ExistMatchResultData>(
      json['data']);
  if (data != null) {
    existMatchResultEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    existMatchResultEntity.msg = msg;
  }
  final String? tips = jsonConvert.convert<String>(json['tips']);
  if (tips != null) {
    existMatchResultEntity.tips = tips;
  }
  final String? traceId = jsonConvert.convert<String>(json['traceId']);
  if (traceId != null) {
    existMatchResultEntity.traceId = traceId;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    existMatchResultEntity.ts = ts;
  }
  return existMatchResultEntity;
}

Map<String, dynamic> $ExistMatchResultEntityToJson(
    ExistMatchResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['tips'] = entity.tips;
  data['traceId'] = entity.traceId;
  data['ts'] = entity.ts;
  return data;
}

extension ExistMatchResultEntityExtension on ExistMatchResultEntity {
  ExistMatchResultEntity copyWith({
    String? code,
    ExistMatchResultData? data,
    String? msg,
    String? tips,
    String? traceId,
    int? ts,
  }) {
    return ExistMatchResultEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..tips = tips ?? this.tips
      ..traceId = traceId ?? this.traceId
      ..ts = ts ?? this.ts;
  }
}

ExistMatchResultData $ExistMatchResultDataFromJson(Map<String, dynamic> json) {
  final ExistMatchResultData existMatchResultData = ExistMatchResultData();
  final int? matchHandicapStatus = jsonConvert.convert<int>(
      json['matchHandicapStatus']);
  if (matchHandicapStatus != null) {
    existMatchResultData.matchHandicapStatus = matchHandicapStatus;
  }
  final bool? matchEnd = jsonConvert.convert<bool>(json['matchEnd']);
  if (matchEnd != null) {
    existMatchResultData.matchEnd = matchEnd;
  }
  final bool? marketResult = jsonConvert.convert<bool>(json['marketResult']);
  if (marketResult != null) {
    existMatchResultData.marketResult = marketResult;
  }
  return existMatchResultData;
}

Map<String, dynamic> $ExistMatchResultDataToJson(ExistMatchResultData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['matchHandicapStatus'] = entity.matchHandicapStatus;
  data['matchEnd'] = entity.matchEnd;
  data['marketResult'] = entity.marketResult;
  return data;
}

extension ExistMatchResultDataExtension on ExistMatchResultData {
  ExistMatchResultData copyWith({
    int? matchHandicapStatus,
    bool? matchEnd,
    bool? marketResult,
  }) {
    return ExistMatchResultData()
      ..matchHandicapStatus = matchHandicapStatus ?? this.matchHandicapStatus
      ..matchEnd = matchEnd ?? this.matchEnd
      ..marketResult = marketResult ?? this.marketResult;
  }
}