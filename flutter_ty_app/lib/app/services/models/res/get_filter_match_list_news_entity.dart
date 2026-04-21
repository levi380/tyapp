import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_filter_match_list_news_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_filter_match_list_news_entity.g.dart';

@JsonSerializable()
class GetFilterMatchListNewsEntity {
	late String code;
	late List<GetFilterMatchListNewsData> data;
	late String msg;
	late int ts;

	GetFilterMatchListNewsEntity();

	factory GetFilterMatchListNewsEntity.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListNewsData {
	late String en;
	late String id;
	late String introduction;
	late String nameCode;
	late String spell;
	late List<GetFilterMatchListNewsDataTournaments> tournaments;
	late String zh;
	bool isSelect=false;
	bool isExpand=false;
	GetFilterMatchListNewsData();

	factory GetFilterMatchListNewsData.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListNewsDataTournaments {
	late int hotStatus;
	late String id;
	dynamic nameCode;
	late String nameText;
	late int num;
	late String picUrlthumb;
	late String regionId;
	late String spell;
	late String sportId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentName;
	bool isSelect = false;
	GetFilterMatchListNewsDataTournaments();

	factory GetFilterMatchListNewsDataTournaments.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewsDataTournamentsFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewsDataTournamentsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}