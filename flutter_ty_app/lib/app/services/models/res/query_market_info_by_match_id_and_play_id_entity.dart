import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/query_market_info_by_match_id_and_play_id_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/query_market_info_by_match_id_and_play_id_entity.g.dart';

@JsonSerializable()
class QueryMarketInfoByMatchIdAndPlayIdEntity {
	late String code;
	late QueryMarketInfoByMatchIdAndPlayIdData data;
	late String msg;
	late String tips;
	late String traceId;
	late int ts;

	QueryMarketInfoByMatchIdAndPlayIdEntity();

	factory QueryMarketInfoByMatchIdAndPlayIdEntity.fromJson(Map<String, dynamic> json) => $QueryMarketInfoByMatchIdAndPlayIdEntityFromJson(json);

	Map<String, dynamic> toJson() => $QueryMarketInfoByMatchIdAndPlayIdEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryMarketInfoByMatchIdAndPlayIdData {
	late String away;
	late String home;
	late String matchInfoId;
	late String playId;
	late String playName;
	late List<QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO> queryMarketDetailVO;
	late int sportId;

	QueryMarketInfoByMatchIdAndPlayIdData();

	factory QueryMarketInfoByMatchIdAndPlayIdData.fromJson(Map<String, dynamic> json) => $QueryMarketInfoByMatchIdAndPlayIdDataFromJson(json);

	Map<String, dynamic> toJson() => $QueryMarketInfoByMatchIdAndPlayIdDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO {
	late String id;
	late String marketValue;
	late String playId;
	late List<QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList> queryMarketOddsVOList;

	QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO();

	factory QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO.fromJson(Map<String, dynamic> json) => $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOFromJson(json);

	Map<String, dynamic> toJson() => $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList {
	late String id;
	late String oddsType;
	late int oddsValue;
	late String playOptions;

	QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList();

	factory QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList.fromJson(Map<String, dynamic> json) => $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOListFromJson(json);

	Map<String, dynamic> toJson() => $QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}