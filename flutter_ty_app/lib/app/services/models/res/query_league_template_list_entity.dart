import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/query_league_template_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/query_league_template_list_entity.g.dart';

@JsonSerializable()
class QueryLeagueTemplateListEntity {
	late String code;
	late List<QueryLeagueTemplateListData> data = [];
	late String msg;
	late int ts;

	QueryLeagueTemplateListEntity();

	factory QueryLeagueTemplateListEntity.fromJson(Map<String, dynamic> json) => $QueryLeagueTemplateListEntityFromJson(json);

	Map<String, dynamic> toJson() => $QueryLeagueTemplateListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryLeagueTemplateListData {
	late String activityTemplateImageH5Sdk;
	late String activityTemplateImagePc;
	late List<dynamic> championBettingIdList;
	late List<String> leagueIdList;
	late int leagueTemplateId;
	late String pcSpecialPageBanner;
	late int scoreboard;
	late List<String> selectModules;
	late int sort;
	late int templateStatus;
	late String themeColor;
	late String themeColorBottom;
	late String themeColorGradientEnd;
	late String themeColorGradientStart;
	late String themeColorTop;
	late int themeType;
	late String tid;

	QueryLeagueTemplateListData();

	factory QueryLeagueTemplateListData.fromJson(Map<String, dynamic> json) => $QueryLeagueTemplateListDataFromJson(json);

	Map<String, dynamic> toJson() => $QueryLeagueTemplateListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}