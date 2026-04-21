import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/filter_match_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/filter_match_entity.g.dart';

@JsonSerializable()
class FilterMatchEntity {
	late String code;
	late List<FilterMatchData> data;
	late String msg;
	late int ts;

	FilterMatchEntity();

	factory FilterMatchEntity.fromJson(Map<String, dynamic> json) => $FilterMatchEntityFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FilterMatchData {
	late String en;
	late String id;
	late String introduction;
	late String spell;
	late List<FilterMatchDataSportVOs> sportVOs;
	late String zh;

	FilterMatchData();

	factory FilterMatchData.fromJson(Map<String, dynamic> json) => $FilterMatchDataFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FilterMatchDataSportVOs {
	late String id;
	late String nameText;
	late int orderNum;
	late String spell;
	late List<FilterMatchDataSportVOsTournamentList> tournamentList;

	FilterMatchDataSportVOs();

	factory FilterMatchDataSportVOs.fromJson(Map<String, dynamic> json) => $FilterMatchDataSportVOsFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchDataSportVOsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FilterMatchDataSportVOsTournamentList {
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

	FilterMatchDataSportVOsTournamentList();

	factory FilterMatchDataSportVOsTournamentList.fromJson(Map<String, dynamic> json) => $FilterMatchDataSportVOsTournamentListFromJson(json);

	Map<String, dynamic> toJson() => $FilterMatchDataSportVOsTournamentListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}