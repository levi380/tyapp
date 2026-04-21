import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_filter_match_lists_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_filter_match_lists_entity.g.dart';

@JsonSerializable()
class GetFilterMatchListsEntity {
	late String code;
	late List<GetFilterMatchListsData> data;
	late String msg;
	late int ts;

	GetFilterMatchListsEntity();

	factory GetFilterMatchListsEntity.fromJson(Map<String, dynamic> json) => $GetFilterMatchListsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListsData {
	late String en;
	late String id;
	late String introduction;
	late String spell;
	late List<GetFilterMatchListsDataSportVOs> sportVOs;
	late String zh;

	GetFilterMatchListsData();

	factory GetFilterMatchListsData.fromJson(Map<String, dynamic> json) => $GetFilterMatchListsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListsDataSportVOs {
	late String id;
	late String nameText;
	late int orderNum;
	late String spell;
	late List<GetFilterMatchListsDataSportVOsTournamentList> tournamentList;

	GetFilterMatchListsDataSportVOs();

	factory GetFilterMatchListsDataSportVOs.fromJson(Map<String, dynamic> json) => $GetFilterMatchListsDataSportVOsFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListsDataSportVOsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListsDataSportVOsTournamentList {
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

	GetFilterMatchListsDataSportVOsTournamentList();

	factory GetFilterMatchListsDataSportVOsTournamentList.fromJson(Map<String, dynamic> json) => $GetFilterMatchListsDataSportVOsTournamentListFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListsDataSportVOsTournamentListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}