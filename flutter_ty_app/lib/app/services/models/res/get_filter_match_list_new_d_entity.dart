import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_filter_match_list_new_d_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_filter_match_list_new_d_entity.g.dart';

@JsonSerializable()
class GetFilterMatchListNewDEntity {
	late String code;
	late List<GetFilterMatchListNewDData> data;
	late String msg;
	late int ts;

	GetFilterMatchListNewDEntity();

	factory GetFilterMatchListNewDEntity.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewDEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewDEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListNewDData {
	late String en;
	late String id;
	late String introduction;

	late String nameCode = '';
	late String spell;
	late String spellOrder;
	late List<GetFilterMatchListNewDDataTournaments> tournaments;
	late String zh;

	bool isSelect=false;
	bool isExpand=false;
	GetFilterMatchListNewDData();

	factory GetFilterMatchListNewDData.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewDDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewDDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListNewDDataTournaments {
	late int hotStatus;
	late String id;
	dynamic nameCode;
	late String nameText;
	late int num;
	late String picUrlthumb;
	late String regionId;
	late String spell;
	late String sportId;
	late String tnjc = '';
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentName;
	bool isSelect = false;

	GetFilterMatchListNewDDataTournaments();

	factory GetFilterMatchListNewDDataTournaments.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewDDataTournamentsFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewDDataTournamentsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}