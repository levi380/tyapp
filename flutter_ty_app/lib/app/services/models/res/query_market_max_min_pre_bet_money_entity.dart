import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/query_market_max_min_pre_bet_money_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/query_market_max_min_pre_bet_money_entity.g.dart';

@JsonSerializable()
class QueryMarketMaxMinPreBetMoneyEntity {
	late String code;
	late List<QueryMarketMaxMinPreBetMoneyData> data;
	late String msg;
	late int ts;

	QueryMarketMaxMinPreBetMoneyEntity();

	factory QueryMarketMaxMinPreBetMoneyEntity.fromJson(Map<String, dynamic> json) => $QueryMarketMaxMinPreBetMoneyEntityFromJson(json);

	Map<String, dynamic> toJson() => $QueryMarketMaxMinPreBetMoneyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryMarketMaxMinPreBetMoneyData {
	late int code;
	late String globalId;
	late String minBet;
	late String orderMaxPay;
	late String playId;
	late String playOptionsId;
	late String seriesOdds;
	dynamic strayMaxOdds;
	late String type;

	QueryMarketMaxMinPreBetMoneyData();

	factory QueryMarketMaxMinPreBetMoneyData.fromJson(Map<String, dynamic> json) => $QueryMarketMaxMinPreBetMoneyDataFromJson(json);

	Map<String, dynamic> toJson() => $QueryMarketMaxMinPreBetMoneyDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}