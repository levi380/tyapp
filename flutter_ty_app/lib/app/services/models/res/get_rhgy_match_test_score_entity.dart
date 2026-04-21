import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_match_test_score_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_match_test_score_entity.g.dart';

@JsonSerializable()
class GetRhgyMatchTestScoreEntity {
	late String code;
	late GetRhgyMatchTestScoreData data;
	late String msg;
	late int ts;

	GetRhgyMatchTestScoreEntity();

	factory GetRhgyMatchTestScoreEntity.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreData {
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
	late GetRhgyMatchTestScoreDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgyMatchTestScoreData();

	factory GetRhgyMatchTestScoreData.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecord {
	@JSONField(name: '2025-12-12')
	late GetRhgyMatchTestScoreDataRecordx20251212 x20251212;
	@JSONField(name: '2025-12-02')
	late GetRhgyMatchTestScoreDataRecordx20251202 x20251202;
	@JSONField(name: '2025-11-30')
	late GetRhgyMatchTestScoreDataRecordx20251130 x20251130;
	@JSONField(name: '2025-10-26')
	late GetRhgyMatchTestScoreDataRecordx20251026 x20251026;

	GetRhgyMatchTestScoreDataRecord();

	factory GetRhgyMatchTestScoreDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251212 {
	late double preBetAmount;
	late double maxWinAmount;
	late double betAmount;
	late List<GetRhgyMatchTestScoreDataRecordx20251212Data> data;
	late int totalOrders;

	GetRhgyMatchTestScoreDataRecordx20251212();

	factory GetRhgyMatchTestScoreDataRecordx20251212.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251212FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251212ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251212Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyMatchTestScoreDataRecordx20251212DataDetailList> detailList;
	late String id;
	late String langCode;
	late String languageName;
	dynamic managerCode;
	late String marketType;
	dynamic matchType;
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

	GetRhgyMatchTestScoreDataRecordx20251212Data();

	factory GetRhgyMatchTestScoreDataRecordx20251212Data.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251212DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251212DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251212DataDetailList {
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

	GetRhgyMatchTestScoreDataRecordx20251212DataDetailList();

	factory GetRhgyMatchTestScoreDataRecordx20251212DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251212DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251212DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251202 {
	late double preBetAmount;
	late double maxWinAmount;
	late double betAmount;
	late List<GetRhgyMatchTestScoreDataRecordx20251202Data> data;
	late int totalOrders;

	GetRhgyMatchTestScoreDataRecordx20251202();

	factory GetRhgyMatchTestScoreDataRecordx20251202.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251202FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251202ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251202Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyMatchTestScoreDataRecordx20251202DataDetailList> detailList;
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

	GetRhgyMatchTestScoreDataRecordx20251202Data();

	factory GetRhgyMatchTestScoreDataRecordx20251202Data.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251202DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251202DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251202DataDetailList {
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

	GetRhgyMatchTestScoreDataRecordx20251202DataDetailList();

	factory GetRhgyMatchTestScoreDataRecordx20251202DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251202DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251202DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251130 {
	late double preBetAmount;
	late double maxWinAmount;
	late double betAmount;
	late List<GetRhgyMatchTestScoreDataRecordx20251130Data> data;
	late int totalOrders;

	GetRhgyMatchTestScoreDataRecordx20251130();

	factory GetRhgyMatchTestScoreDataRecordx20251130.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251130FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251130ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251130Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyMatchTestScoreDataRecordx20251130DataDetailList> detailList;
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

	GetRhgyMatchTestScoreDataRecordx20251130Data();

	factory GetRhgyMatchTestScoreDataRecordx20251130Data.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251130DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251130DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251130DataDetailList {
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

	GetRhgyMatchTestScoreDataRecordx20251130DataDetailList();

	factory GetRhgyMatchTestScoreDataRecordx20251130DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251130DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251130DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251026 {
	late double preBetAmount;
	late double maxWinAmount;
	late double betAmount;
	late List<GetRhgyMatchTestScoreDataRecordx20251026Data> data;
	late int totalOrders;

	GetRhgyMatchTestScoreDataRecordx20251026();

	factory GetRhgyMatchTestScoreDataRecordx20251026.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251026FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251026ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251026Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyMatchTestScoreDataRecordx20251026DataDetailList> detailList;
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

	GetRhgyMatchTestScoreDataRecordx20251026Data();

	factory GetRhgyMatchTestScoreDataRecordx20251026Data.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251026DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251026DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyMatchTestScoreDataRecordx20251026DataDetailList {
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

	GetRhgyMatchTestScoreDataRecordx20251026DataDetailList();

	factory GetRhgyMatchTestScoreDataRecordx20251026DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyMatchTestScoreDataRecordx20251026DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyMatchTestScoreDataRecordx20251026DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}