import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_user_annual_report_template_entity.dart';

GetUserAnnualReportTemplateEntity $GetUserAnnualReportTemplateEntityFromJson(
    Map<String, dynamic> json) {
  final GetUserAnnualReportTemplateEntity getUserAnnualReportTemplateEntity = GetUserAnnualReportTemplateEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getUserAnnualReportTemplateEntity.code = code;
  }
  final GetUserAnnualReportTemplateData? data = jsonConvert.convert<
      GetUserAnnualReportTemplateData>(json['data']);
  if (data != null) {
    getUserAnnualReportTemplateEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getUserAnnualReportTemplateEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getUserAnnualReportTemplateEntity.ts = ts;
  }
  return getUserAnnualReportTemplateEntity;
}

Map<String, dynamic> $GetUserAnnualReportTemplateEntityToJson(
    GetUserAnnualReportTemplateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetUserAnnualReportTemplateEntityExtension on GetUserAnnualReportTemplateEntity {
  GetUserAnnualReportTemplateEntity copyWith({
    String? code,
    GetUserAnnualReportTemplateData? data,
    String? msg,
    int? ts,
  }) {
    return GetUserAnnualReportTemplateEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetUserAnnualReportTemplateData $GetUserAnnualReportTemplateDataFromJson(
    Map<String, dynamic> json) {
  final GetUserAnnualReportTemplateData getUserAnnualReportTemplateData = GetUserAnnualReportTemplateData();
  final int? isOpen = jsonConvert.convert<int>(json['isOpen']);
  if (isOpen != null) {
    getUserAnnualReportTemplateData.isOpen = isOpen;
  }
  final List<
      GetUserAnnualReportTemplateDataReportPO>? reportPO = (json['reportPO'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetUserAnnualReportTemplateDataReportPO>(
          e) as GetUserAnnualReportTemplateDataReportPO).toList();
  if (reportPO != null) {
    getUserAnnualReportTemplateData.reportPO = reportPO;
  }
  return getUserAnnualReportTemplateData;
}

Map<String, dynamic> $GetUserAnnualReportTemplateDataToJson(
    GetUserAnnualReportTemplateData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isOpen'] = entity.isOpen;
  data['reportPO'] = entity.reportPO.map((v) => v.toJson()).toList();
  return data;
}

extension GetUserAnnualReportTemplateDataExtension on GetUserAnnualReportTemplateData {
  GetUserAnnualReportTemplateData copyWith({
    int? isOpen,
    List<GetUserAnnualReportTemplateDataReportPO>? reportPO,
  }) {
    return GetUserAnnualReportTemplateData()
      ..isOpen = isOpen ?? this.isOpen
      ..reportPO = reportPO ?? this.reportPO;
  }
}

GetUserAnnualReportTemplateDataReportPO $GetUserAnnualReportTemplateDataReportPOFromJson(
    Map<String, dynamic> json) {
  final GetUserAnnualReportTemplateDataReportPO getUserAnnualReportTemplateDataReportPO = GetUserAnnualReportTemplateDataReportPO();
  final GetUserAnnualReportTemplateDataReportPOAnnualParamVO? annualParamVO = jsonConvert
      .convert<GetUserAnnualReportTemplateDataReportPOAnnualParamVO>(
      json['annualParamVO']);
  if (annualParamVO != null) {
    getUserAnnualReportTemplateDataReportPO.annualParamVO = annualParamVO;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    getUserAnnualReportTemplateDataReportPO.content = content;
  }
  final String? contentEn = jsonConvert.convert<String>(json['contentEn']);
  if (contentEn != null) {
    getUserAnnualReportTemplateDataReportPO.contentEn = contentEn;
  }
  final String? contentTw = jsonConvert.convert<String>(json['contentTw']);
  if (contentTw != null) {
    getUserAnnualReportTemplateDataReportPO.contentTw = contentTw;
  }
  final String? contentZh = jsonConvert.convert<String>(json['contentZh']);
  if (contentZh != null) {
    getUserAnnualReportTemplateDataReportPO.contentZh = contentZh;
  }
  final String? endTime = jsonConvert.convert<String>(json['endTime']);
  if (endTime != null) {
    getUserAnnualReportTemplateDataReportPO.endTime = endTime;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserAnnualReportTemplateDataReportPO.id = id;
  }
  final int? isOpen = jsonConvert.convert<int>(json['isOpen']);
  if (isOpen != null) {
    getUserAnnualReportTemplateDataReportPO.isOpen = isOpen;
  }
  final String? language = jsonConvert.convert<String>(json['language']);
  if (language != null) {
    getUserAnnualReportTemplateDataReportPO.language = language;
  }
  final int? orderNo = jsonConvert.convert<int>(json['orderNo']);
  if (orderNo != null) {
    getUserAnnualReportTemplateDataReportPO.orderNo = orderNo;
  }
  final int? pageNo = jsonConvert.convert<int>(json['pageNo']);
  if (pageNo != null) {
    getUserAnnualReportTemplateDataReportPO.pageNo = pageNo;
  }
  final dynamic size = json['size'];
  if (size != null) {
    getUserAnnualReportTemplateDataReportPO.size = size;
  }
  final dynamic start = json['start'];
  if (start != null) {
    getUserAnnualReportTemplateDataReportPO.start = start;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getUserAnnualReportTemplateDataReportPO.startTime = startTime;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getUserAnnualReportTemplateDataReportPO.status = status;
  }
  final int? year = jsonConvert.convert<int>(json['year']);
  if (year != null) {
    getUserAnnualReportTemplateDataReportPO.year = year;
  }
  return getUserAnnualReportTemplateDataReportPO;
}

Map<String, dynamic> $GetUserAnnualReportTemplateDataReportPOToJson(
    GetUserAnnualReportTemplateDataReportPO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['annualParamVO'] = entity.annualParamVO.toJson();
  data['content'] = entity.content;
  data['contentEn'] = entity.contentEn;
  data['contentTw'] = entity.contentTw;
  data['contentZh'] = entity.contentZh;
  data['endTime'] = entity.endTime;
  data['id'] = entity.id;
  data['isOpen'] = entity.isOpen;
  data['language'] = entity.language;
  data['orderNo'] = entity.orderNo;
  data['pageNo'] = entity.pageNo;
  data['size'] = entity.size;
  data['start'] = entity.start;
  data['startTime'] = entity.startTime;
  data['status'] = entity.status;
  data['year'] = entity.year;
  return data;
}

extension GetUserAnnualReportTemplateDataReportPOExtension on GetUserAnnualReportTemplateDataReportPO {
  GetUserAnnualReportTemplateDataReportPO copyWith({
    GetUserAnnualReportTemplateDataReportPOAnnualParamVO? annualParamVO,
    String? content,
    String? contentEn,
    String? contentTw,
    String? contentZh,
    String? endTime,
    int? id,
    int? isOpen,
    String? language,
    int? orderNo,
    int? pageNo,
    dynamic size,
    dynamic start,
    String? startTime,
    int? status,
    int? year,
  }) {
    return GetUserAnnualReportTemplateDataReportPO()
      ..annualParamVO = annualParamVO ?? this.annualParamVO
      ..content = content ?? this.content
      ..contentEn = contentEn ?? this.contentEn
      ..contentTw = contentTw ?? this.contentTw
      ..contentZh = contentZh ?? this.contentZh
      ..endTime = endTime ?? this.endTime
      ..id = id ?? this.id
      ..isOpen = isOpen ?? this.isOpen
      ..language = language ?? this.language
      ..orderNo = orderNo ?? this.orderNo
      ..pageNo = pageNo ?? this.pageNo
      ..size = size ?? this.size
      ..start = start ?? this.start
      ..startTime = startTime ?? this.startTime
      ..status = status ?? this.status
      ..year = year ?? this.year;
  }
}

GetUserAnnualReportTemplateDataReportPOAnnualParamVO $GetUserAnnualReportTemplateDataReportPOAnnualParamVOFromJson(
    Map<String, dynamic> json) {
  final GetUserAnnualReportTemplateDataReportPOAnnualParamVO getUserAnnualReportTemplateDataReportPOAnnualParamVO = GetUserAnnualReportTemplateDataReportPOAnnualParamVO();
  final int? pageNo = jsonConvert.convert<int>(json['pageNo']);
  if (pageNo != null) {
    getUserAnnualReportTemplateDataReportPOAnnualParamVO.pageNo = pageNo;
  }
  final String? paramContent = jsonConvert.convert<String>(
      json['paramContent']);
  if (paramContent != null) {
    getUserAnnualReportTemplateDataReportPOAnnualParamVO.paramContent =
        paramContent;
  }
  final String? paramContentEn = jsonConvert.convert<String>(
      json['paramContentEn']);
  if (paramContentEn != null) {
    getUserAnnualReportTemplateDataReportPOAnnualParamVO.paramContentEn =
        paramContentEn;
  }
  final String? paramContentTw = jsonConvert.convert<String>(
      json['paramContentTw']);
  if (paramContentTw != null) {
    getUserAnnualReportTemplateDataReportPOAnnualParamVO.paramContentTw =
        paramContentTw;
  }
  final String? paramContentZh = jsonConvert.convert<String>(
      json['paramContentZh']);
  if (paramContentZh != null) {
    getUserAnnualReportTemplateDataReportPOAnnualParamVO.paramContentZh =
        paramContentZh;
  }
  final int? pid = jsonConvert.convert<int>(json['pid']);
  if (pid != null) {
    getUserAnnualReportTemplateDataReportPOAnnualParamVO.pid = pid;
  }
  final dynamic year = json['year'];
  if (year != null) {
    getUserAnnualReportTemplateDataReportPOAnnualParamVO.year = year;
  }
  return getUserAnnualReportTemplateDataReportPOAnnualParamVO;
}

Map<String,
    dynamic> $GetUserAnnualReportTemplateDataReportPOAnnualParamVOToJson(
    GetUserAnnualReportTemplateDataReportPOAnnualParamVO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pageNo'] = entity.pageNo;
  data['paramContent'] = entity.paramContent;
  data['paramContentEn'] = entity.paramContentEn;
  data['paramContentTw'] = entity.paramContentTw;
  data['paramContentZh'] = entity.paramContentZh;
  data['pid'] = entity.pid;
  data['year'] = entity.year;
  return data;
}

extension GetUserAnnualReportTemplateDataReportPOAnnualParamVOExtension on GetUserAnnualReportTemplateDataReportPOAnnualParamVO {
  GetUserAnnualReportTemplateDataReportPOAnnualParamVO copyWith({
    int? pageNo,
    String? paramContent,
    String? paramContentEn,
    String? paramContentTw,
    String? paramContentZh,
    int? pid,
    dynamic year,
  }) {
    return GetUserAnnualReportTemplateDataReportPOAnnualParamVO()
      ..pageNo = pageNo ?? this.pageNo
      ..paramContent = paramContent ?? this.paramContent
      ..paramContentEn = paramContentEn ?? this.paramContentEn
      ..paramContentTw = paramContentTw ?? this.paramContentTw
      ..paramContentZh = paramContentZh ?? this.paramContentZh
      ..pid = pid ?? this.pid
      ..year = year ?? this.year;
  }
}