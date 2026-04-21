import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_user_annual_report_template_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_user_annual_report_template_entity.g.dart';

@JsonSerializable()
class GetUserAnnualReportTemplateEntity {
	late String code;
	late GetUserAnnualReportTemplateData data;
	late String msg;
	late int ts;

	GetUserAnnualReportTemplateEntity();

	factory GetUserAnnualReportTemplateEntity.fromJson(Map<String, dynamic> json) => $GetUserAnnualReportTemplateEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserAnnualReportTemplateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserAnnualReportTemplateData {
	late int isOpen;
	late List<GetUserAnnualReportTemplateDataReportPO> reportPO = [];

	GetUserAnnualReportTemplateData();

	factory GetUserAnnualReportTemplateData.fromJson(Map<String, dynamic> json) => $GetUserAnnualReportTemplateDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserAnnualReportTemplateDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserAnnualReportTemplateDataReportPO {
	late GetUserAnnualReportTemplateDataReportPOAnnualParamVO annualParamVO;
	late String content;
	late String contentEn;
	late String contentTw;
	late String contentZh;
	late String endTime;
	late int id;
	late int isOpen;
	late String language;
	late int orderNo;
	late int pageNo;
	dynamic size;
	dynamic start;
	late String startTime;
	late int status;
	late int year;

	GetUserAnnualReportTemplateDataReportPO();

	factory GetUserAnnualReportTemplateDataReportPO.fromJson(Map<String, dynamic> json) => $GetUserAnnualReportTemplateDataReportPOFromJson(json);

	Map<String, dynamic> toJson() => $GetUserAnnualReportTemplateDataReportPOToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserAnnualReportTemplateDataReportPOAnnualParamVO {
	late int pageNo;
	late String paramContent;
	late String paramContentEn;
	late String paramContentTw;
	late String paramContentZh;
	late int pid;
	dynamic year;

	GetUserAnnualReportTemplateDataReportPOAnnualParamVO();

	factory GetUserAnnualReportTemplateDataReportPOAnnualParamVO.fromJson(Map<String, dynamic> json) => $GetUserAnnualReportTemplateDataReportPOAnnualParamVOFromJson(json);

	Map<String, dynamic> toJson() => $GetUserAnnualReportTemplateDataReportPOAnnualParamVOToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}