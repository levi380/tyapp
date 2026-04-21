import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_search_count_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_search_count_entity.g.dart';

@JsonSerializable()
class GetRhgySearchCountEntity {
	late String code;
	late GetRhgySearchCountData data;
	late String msg;
	late int ts;

	GetRhgySearchCountEntity();

	factory GetRhgySearchCountEntity.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountData {
	dynamic ascs;
	late String betTotalAmount;
	late String current;
	dynamic descs;
	late bool hasNext;
	late bool hasPrevious;
	late String maxWinTotalAmount;
	late bool optimizeCountSql;
	late String pages;
	late String preBetTotalAmount;
	late String profit;
	late GetRhgySearchCountDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgySearchCountData();

	factory GetRhgySearchCountData.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecord {
	@JSONField(name: '2025-12-02')
	late GetRhgySearchCountDataRecordx20251202 x20251202;
	@JSONField(name: '2025-11-30')
	late GetRhgySearchCountDataRecordx20251130 x20251130;
	@JSONField(name: '2025-10-26')
	late GetRhgySearchCountDataRecordx20251026 x20251026;

	GetRhgySearchCountDataRecord();

	factory GetRhgySearchCountDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251202 {
	late double preBetAmount;
	late double maxWinAmount;
	late double betAmount;
	late List<GetRhgySearchCountDataRecordx20251202Data> data;
	late int totalOrders;

	GetRhgySearchCountDataRecordx20251202();

	factory GetRhgySearchCountDataRecordx20251202.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251202FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251202ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251202Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgySearchCountDataRecordx20251202DataDetailList> detailList;
	late String id;
	late String langCode;
	late String languageName;
	dynamic managerCode;
	late String marketType;
	late int matchType;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic orderType;
	dynamic outcome;
	late double preBetAmount;
	dynamic preOrder;
	late int preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgySearchCountDataRecordx20251202Data();

	factory GetRhgySearchCountDataRecordx20251202Data.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251202DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251202DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251202DataDetailList {
	dynamic acceptBetOdds;
	late String awayName;
	late String backAmount;
	late String batchNo;
	late String beginTime;
	late String betAmount;
	late String betNo;
	late int betResult;
	late int betStatus;
	dynamic betTime;
	late int cancelType;
	dynamic childPlayId;
	dynamic closingTime;
	dynamic createTime;
	late String dataSourceCode;
	late String eov;
	late String extJson;
	dynamic firstNum;
	late String homeName;
	dynamic isValid;
	late String marketId;
	late String marketName;
	late String marketType;
	late String marketValue;
	late String matchDay;
	late String matchId;
	late String matchInfo;
	dynamic matchManageType;
	late String matchName;
	dynamic matchOver;
	dynamic matchPeriodId;
	dynamic matchProcessId;
	dynamic matchStatusId;
	late String matchTestScore;
	late int matchType;
	late int matchVideoTag;
	late String oddFinally;
	late String oddsDataSourse;
	late double oddsValue;
	late String optionValue;
	late String orderAmountTotal;
	late String orderNo;
	late String orderSettleRemark;
	late String originalMarketValue;
	late String outrightYear;
	late String phase;
	dynamic placeNum;
	late int playId;
	late String playName;
	late String playOptionName;
	late String playOptions;
	late String playOptionsId;
	late String playOptionsRange;
	late String remark;
	late String riskEvent;
	late String score;
	late String scoreBenchmark;
	dynamic secondNum;
	dynamic secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	dynamic thirdMatchId;
	late String tournamentId;
	dynamic tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgySearchCountDataRecordx20251202DataDetailList();

	factory GetRhgySearchCountDataRecordx20251202DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251202DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251202DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251130 {
	late double preBetAmount;
	late double maxWinAmount;
	late double betAmount;
	late List<GetRhgySearchCountDataRecordx20251130Data> data;
	late int totalOrders;

	GetRhgySearchCountDataRecordx20251130();

	factory GetRhgySearchCountDataRecordx20251130.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251130FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251130ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251130Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgySearchCountDataRecordx20251130DataDetailList> detailList;
	late String id;
	late String langCode;
	late String languageName;
	dynamic managerCode;
	late String marketType;
	late int matchType;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic orderType;
	dynamic outcome;
	late double preBetAmount;
	dynamic preOrder;
	late int preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgySearchCountDataRecordx20251130Data();

	factory GetRhgySearchCountDataRecordx20251130Data.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251130DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251130DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251130DataDetailList {
	dynamic acceptBetOdds;
	late String awayName;
	late String backAmount;
	late String batchNo;
	late String beginTime;
	late String betAmount;
	late String betNo;
	late int betResult;
	late int betStatus;
	dynamic betTime;
	late int cancelType;
	dynamic childPlayId;
	dynamic closingTime;
	dynamic createTime;
	late String dataSourceCode;
	late String eov;
	late String extJson;
	dynamic firstNum;
	late String homeName;
	dynamic isValid;
	late String marketId;
	late String marketName;
	late String marketType;
	late String marketValue;
	late String matchDay;
	late String matchId;
	late String matchInfo;
	dynamic matchManageType;
	late String matchName;
	dynamic matchOver;
	dynamic matchPeriodId;
	dynamic matchProcessId;
	dynamic matchStatusId;
	late String matchTestScore;
	late int matchType;
	late int matchVideoTag;
	late String oddFinally;
	late String oddsDataSourse;
	late double oddsValue;
	late String optionValue;
	late String orderAmountTotal;
	late String orderNo;
	late String orderSettleRemark;
	late String originalMarketValue;
	late String outrightYear;
	late String phase;
	dynamic placeNum;
	late int playId;
	late String playName;
	late String playOptionName;
	late String playOptions;
	late String playOptionsId;
	late String playOptionsRange;
	late String remark;
	late String riskEvent;
	late String score;
	late String scoreBenchmark;
	dynamic secondNum;
	dynamic secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	dynamic thirdMatchId;
	late String tournamentId;
	dynamic tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgySearchCountDataRecordx20251130DataDetailList();

	factory GetRhgySearchCountDataRecordx20251130DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251130DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251130DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251026 {
	late double preBetAmount;
	late double maxWinAmount;
	late double betAmount;
	late List<GetRhgySearchCountDataRecordx20251026Data> data;
	late int totalOrders;

	GetRhgySearchCountDataRecordx20251026();

	factory GetRhgySearchCountDataRecordx20251026.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251026FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251026ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251026Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgySearchCountDataRecordx20251026DataDetailList> detailList;
	late String id;
	late String langCode;
	late String languageName;
	dynamic managerCode;
	late String marketType;
	late int matchType;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic orderType;
	dynamic outcome;
	late double preBetAmount;
	dynamic preOrder;
	late int preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgySearchCountDataRecordx20251026Data();

	factory GetRhgySearchCountDataRecordx20251026Data.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251026DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251026DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountDataRecordx20251026DataDetailList {
	dynamic acceptBetOdds;
	late String awayName;
	late String backAmount;
	late String batchNo;
	late String beginTime;
	late String betAmount;
	late String betNo;
	late int betResult;
	late int betStatus;
	dynamic betTime;
	late int cancelType;
	dynamic childPlayId;
	dynamic closingTime;
	dynamic createTime;
	late String dataSourceCode;
	late String eov;
	late String extJson;
	dynamic firstNum;
	late String homeName;
	dynamic isValid;
	late String marketId;
	late String marketName;
	late String marketType;
	late String marketValue;
	late String matchDay;
	late String matchId;
	late String matchInfo;
	dynamic matchManageType;
	late String matchName;
	dynamic matchOver;
	dynamic matchPeriodId;
	dynamic matchProcessId;
	dynamic matchStatusId;
	late String matchTestScore;
	late int matchType;
	late int matchVideoTag;
	late String oddFinally;
	late String oddsDataSourse;
	late double oddsValue;
	late String optionValue;
	late String orderAmountTotal;
	late String orderNo;
	late String orderSettleRemark;
	late String originalMarketValue;
	late String outrightYear;
	late String phase;
	dynamic placeNum;
	late int playId;
	late String playName;
	late String playOptionName;
	late String playOptions;
	late String playOptionsId;
	late String playOptionsRange;
	late String remark;
	late String riskEvent;
	late String score;
	late String scoreBenchmark;
	dynamic secondNum;
	dynamic secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	dynamic thirdMatchId;
	late String tournamentId;
	dynamic tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgySearchCountDataRecordx20251026DataDetailList();

	factory GetRhgySearchCountDataRecordx20251026DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountDataRecordx20251026DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountDataRecordx20251026DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}