import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_filter_match_list_new_base_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_filter_match_list_new_base_entity.g.dart';

@JsonSerializable()
class GetFilterMatchListNewBaseEntity {
	late String code;
	late List<GetFilterMatchListNewBaseData> data;
	late String msg;
	late int ts;

	GetFilterMatchListNewBaseEntity();

	factory GetFilterMatchListNewBaseEntity.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewBaseEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewBaseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListNewBaseData {
	late String en;
	late String id;
	late String introduction;
	late String nameCode;
	late String spell;
	late String spellOrder;
	late List<GetFilterMatchListNewBaseDataTournaments> tournaments;
	late String zh;
	bool isSelect=false;
	bool isExpand=false;
	GetFilterMatchListNewBaseData();

	factory GetFilterMatchListNewBaseData.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewBaseDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewBaseDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListNewBaseDataTournaments {
	late int hotStatus;
	late String id;
	late String nameCode;
	late String nameText;
	late int? num;
	late String picUrlthumb;
	late String regionId;
	late String spell;
	late String sportId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentName;
	bool isSelect = false;
	GetFilterMatchListNewBaseDataTournaments();

	factory GetFilterMatchListNewBaseDataTournaments.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewBaseDataTournamentsFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewBaseDataTournamentsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}