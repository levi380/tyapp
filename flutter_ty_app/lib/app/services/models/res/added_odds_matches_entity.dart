import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/added_odds_matches_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AddedOddsMatchesEntity {
	late List<MatchEntity> data = [];
	late int count = 0;

	AddedOddsMatchesEntity();

	factory AddedOddsMatchesEntity.fromJson(Map<String, dynamic> json) => $AddedOddsMatchesEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddedOddsMatchesEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}