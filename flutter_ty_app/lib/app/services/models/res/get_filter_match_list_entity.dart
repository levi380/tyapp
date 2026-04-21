import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_filter_match_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_filter_match_list_entity.g.dart';

@JsonSerializable()
class GetFilterMatchListEntity {
	late String code;
	late List<GetFilterMatchListData> data;
	late String msg;
	late int ts;

	GetFilterMatchListEntity();

	factory GetFilterMatchListEntity.fromJson(Map<String, dynamic> json) => $GetFilterMatchListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListData {
	late String en;
	late String id;
	late String introduction;
	late String nameCode = '';
	late String spell;
	late List<GetFilterMatchListDataSportVOs> sportVOs;
	late String zh;
	bool isSelect=false;
	bool isExpand=false;
	GetFilterMatchListData();

	factory GetFilterMatchListData.fromJson(Map<String, dynamic> json) => $GetFilterMatchListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListDataSportVOs {
	late String id;
	late String nameText;
	late String spell;
	late List<GetFilterMatchListDataSportVOsTournamentList> tournamentList;

	GetFilterMatchListDataSportVOs();

	factory GetFilterMatchListDataSportVOs.fromJson(Map<String, dynamic> json) => $GetFilterMatchListDataSportVOsFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListDataSportVOsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListDataSportVOsTournamentList {
	late int hotStatus;
	late String id;
	dynamic nameCode;
	late String nameText;
	late int num;
	late String picUrlthumb;
	late String regionId;
	late String sportId;
	late String tnjc = '';
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentName;
	bool isSelect = false;
	GetFilterMatchListDataSportVOsTournamentList();

	factory GetFilterMatchListDataSportVOsTournamentList.fromJson(Map<String, dynamic> json) => $GetFilterMatchListDataSportVOsTournamentListFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListDataSportVOsTournamentListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}