import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/report_info_entity.dart';

ReportInfoEntity $ReportInfoEntityFromJson(Map<String, dynamic> json) {
  final ReportInfoEntity reportInfoEntity = ReportInfoEntity();
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    reportInfoEntity.msg = msg;
  }
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    reportInfoEntity.code = code;
  }
  final ReportInfoData? data = jsonConvert.convert<ReportInfoData>(
      json['data']);
  if (data != null) {
    reportInfoEntity.data = data;
  }
  return reportInfoEntity;
}

Map<String, dynamic> $ReportInfoEntityToJson(ReportInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msg'] = entity.msg;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  return data;
}

extension ReportInfoEntityExtension on ReportInfoEntity {
  ReportInfoEntity copyWith({
    String? msg,
    int? code,
    ReportInfoData? data,
  }) {
    return ReportInfoEntity()
      ..msg = msg ?? this.msg
      ..code = code ?? this.code
      ..data = data ?? this.data;
  }
}

ReportInfoData $ReportInfoDataFromJson(Map<String, dynamic> json) {
  final ReportInfoData reportInfoData = ReportInfoData();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    reportInfoData.url = url;
  }
  return reportInfoData;
}

Map<String, dynamic> $ReportInfoDataToJson(ReportInfoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  return data;
}

extension ReportInfoDataExtension on ReportInfoData {
  ReportInfoData copyWith({
    String? url,
  }) {
    return ReportInfoData()
      ..url = url ?? this.url;
  }
}