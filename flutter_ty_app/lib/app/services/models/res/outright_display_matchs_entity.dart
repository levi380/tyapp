import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/outright_display_matchs_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/outright_display_matchs_entity.g.dart';

@JsonSerializable()
class OutrightDisplayMatchsEntity {
	late List<OutrightDisplayMatchsHandicaplist> handicaplist = [];
	late List<MatchEntity> data = [];

	OutrightDisplayMatchsEntity();

	factory OutrightDisplayMatchsEntity.fromJson(Map<String, dynamic> json) => $OutrightDisplayMatchsEntityFromJson(json);

	Map<String, dynamic> toJson() => $OutrightDisplayMatchsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OutrightDisplayMatchsHandicaplist {
	late String linkId = '';
	late String matchId = '';
	late int relationStatus = 0;
	late String standardMarketId = '';
	late String tournamentId = '';

	OutrightDisplayMatchsHandicaplist();

	factory OutrightDisplayMatchsHandicaplist.fromJson(Map<String, dynamic> json) => $OutrightDisplayMatchsHandicaplistFromJson(json);

	Map<String, dynamic> toJson() => $OutrightDisplayMatchsHandicaplistToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}