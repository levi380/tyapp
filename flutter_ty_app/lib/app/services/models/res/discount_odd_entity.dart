import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/discount_odd_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/discount_odd_entity.g.dart';

@JsonSerializable()
class DiscountOddEntity {
	late int count;
	late List<MatchEntity> data;

	DiscountOddEntity();

	factory DiscountOddEntity.fromJson(Map<String, dynamic> json) => $DiscountOddEntityFromJson(json);

	Map<String, dynamic> toJson() => $DiscountOddEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}