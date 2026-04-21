import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_filter_match_list_all_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_filter_match_list_all_entity.g.dart';

@JsonSerializable()
class GetFilterMatchListAllEntity {
	late String code;
	late List<GetFilterMatchListAllData> data;
	late String msg;
	late int ts;

	GetFilterMatchListAllEntity();

	factory GetFilterMatchListAllEntity.fromJson(Map<String, dynamic> json) => $GetFilterMatchListAllEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListAllEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListAllData {
	late String en;
	late String id;
	late String introduction;
	dynamic nameCode;
	late String spell;
	late List<GetFilterMatchListAllDataSportVOs> sportVOs;
	late String zh;

	GetFilterMatchListAllData();

	factory GetFilterMatchListAllData.fromJson(Map<String, dynamic> json) => $GetFilterMatchListAllDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListAllDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListAllDataSportVOs {
	late String id;
	late String nameText;
	late String spell;
	late List<GetFilterMatchListAllDataSportVOsTournamentList> tournamentList;
	bool isSelect = false;
	bool isExpand=false;
	GetFilterMatchListAllDataSportVOs();

	factory GetFilterMatchListAllDataSportVOs.fromJson(Map<String, dynamic> json) => $GetFilterMatchListAllDataSportVOsFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListAllDataSportVOsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListAllDataSportVOsTournamentList {
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
	bool isExpand=false;
	GetFilterMatchListAllDataSportVOsTournamentList();

	factory GetFilterMatchListAllDataSportVOsTournamentList.fromJson(Map<String, dynamic> json) => $GetFilterMatchListAllDataSportVOsTournamentListFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListAllDataSportVOsTournamentListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}