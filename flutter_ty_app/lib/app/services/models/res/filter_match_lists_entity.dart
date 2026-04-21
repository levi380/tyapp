import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/filter_match_lists_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/filter_match_lists_entity.g.dart';

@JsonSerializable()
class FilterMatchListsEntity {
	late String code;
	late List<FilterMatchListsData> data;
	late String msg;
	late int ts;

	FilterMatchListsEntity();

	factory FilterMatchListsEntity.fromJson(Map<String, dynamic> json) => $FilterMatchListsEntityFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchListsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FilterMatchListsData {
	late String en;
	late String id;
	late String introduction;
	late String spell;
	late List<FilterMatchListsDataSportVOs> sportVOs;
	late String zh;

	FilterMatchListsData();

	factory FilterMatchListsData.fromJson(Map<String, dynamic> json) => $FilterMatchListsDataFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchListsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FilterMatchListsDataSportVOs {
	late String id;
	late String nameText;
	late int orderNum;
	late String spell;
	late List<FilterMatchListsDataSportVOsTournamentList> tournamentList;

	FilterMatchListsDataSportVOs();

	factory FilterMatchListsDataSportVOs.fromJson(Map<String, dynamic> json) => $FilterMatchListsDataSportVOsFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchListsDataSportVOsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FilterMatchListsDataSportVOsTournamentList {
	late int hotStatus;
	late String id;
	dynamic nameCode;
	late String nameText;
	late int num;
	late String picUrlthumb;
	late String regionId;
	late String sportId;
	late String tnjc;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentName;

	FilterMatchListsDataSportVOsTournamentList();

	factory FilterMatchListsDataSportVOsTournamentList.fromJson(Map<String, dynamic> json) => $FilterMatchListsDataSportVOsTournamentListFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchListsDataSportVOsTournamentListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}