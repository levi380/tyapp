import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/odd_report_analyze_data_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/odd_report_analyze_data_entity.g.dart';

@JsonSerializable()
class OddReportAnalyzeDataEntity {
	OddReportAnalyzeDataMarket? market;
	OddReportAnalyzeDataOdds? odds;

	OddReportAnalyzeDataEntity();

	factory OddReportAnalyzeDataEntity.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OddReportAnalyzeDataMarket {
	String? code = '';
	List<String>? data = [];
	String? linkId = '';
	String? msg = '';
	bool? success = false;

	OddReportAnalyzeDataMarket();

	factory OddReportAnalyzeDataMarket.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataMarketFromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataMarketToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OddReportAnalyzeDataOdds {
	String? code = '';
	OddReportAnalyzeDataOddsData? data;
	String? linkId = '';
	String? msg = '';
	bool? success = false;

	OddReportAnalyzeDataOdds();

	factory OddReportAnalyzeDataOdds.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataOddsFromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataOddsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OddReportAnalyzeDataOddsData {
	List<OddReportAnalyzeDataOddsDataAverageList>? averageList = [];
	Map<String,dynamic>? fieldOddsValueList;
	List<OddReportAnalyzeDataOddsDataOnSaleOddsList>? onSaleOddsList = [];
	String? period = '';

	OddReportAnalyzeDataOddsData();

	factory OddReportAnalyzeDataOddsData.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataOddsDataFromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataOddsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OddReportAnalyzeDataOddsDataAverageList {
	dynamic average;
	String? formatTime = '';
	String? oddsValue = '';
	String? time = '';
	String? timeMillis = '';
	String? dataSourceTime = '';
	String? dataSourceCode = '';

	OddReportAnalyzeDataOddsDataAverageList();

	factory OddReportAnalyzeDataOddsDataAverageList.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataOddsDataAverageListFromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataOddsDataAverageListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OddReportAnalyzeDataOddsDataFieldOddsValueList {
	@JSONField(name: "L01_FonBet")
	dynamic l01Fonbet;
	@JSONField(name: "N02")
	dynamic n02;
	@JSONField(name: "A01")
	dynamic a01;
	@JSONField(name: "L01_Bet365")
	dynamic l01Bet365;
	@JSONField(name: "G01")
	List<OddReportAnalyzeDataOddsDataFieldOddsValueListG01>? g01 = [];
	@JSONField(name: "L01_1XBet")
	dynamic l011xbet;
	@JSONField(name: "L01_188Bet")
	dynamic l01188bet;
	@JSONField(name: "T01_IBCBet")
	dynamic t01Ibcbet;
	@JSONField(name: "T01_188Bet")
	dynamic t01188bet;
	@JSONField(name: "N01")
	dynamic n01;

	OddReportAnalyzeDataOddsDataFieldOddsValueList();

	factory OddReportAnalyzeDataOddsDataFieldOddsValueList.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataOddsDataFieldOddsValueListFromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataOddsDataFieldOddsValueListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OddReportAnalyzeDataOddsDataFieldOddsValueListG01 {
	String? average = '';
	String? formatTime = '';
	String? dataSourceCode = '';
	String? oddsValue = '';
	String? time = '';
	String? timeMillis = '';

	OddReportAnalyzeDataOddsDataFieldOddsValueListG01();

	factory OddReportAnalyzeDataOddsDataFieldOddsValueListG01.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataOddsDataFieldOddsValueListG01FromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataOddsDataFieldOddsValueListG01ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OddReportAnalyzeDataOddsDataOnSaleOddsList {
	String? average = '';
	String? dataSourceCode = '';
	String? formatTime = '';
	String? oddsValue = '';
	String? time = '';
	String? timeMillis = '';

	OddReportAnalyzeDataOddsDataOnSaleOddsList();

	factory OddReportAnalyzeDataOddsDataOnSaleOddsList.fromJson(Map<String, dynamic> json) => $OddReportAnalyzeDataOddsDataOnSaleOddsListFromJson(json);

	Map<String, dynamic> toJson() => $OddReportAnalyzeDataOddsDataOnSaleOddsListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}