import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_enable_pre_settle_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_enable_pre_settle_entity.g.dart';

@JsonSerializable()
class GetRhgyEnablePreSettleEntity {
	late String code;
	late GetRhgyEnablePreSettleData data;
	late String msg;
	late int ts;

	GetRhgyEnablePreSettleEntity();

	factory GetRhgyEnablePreSettleEntity.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleData {
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
	late GetRhgyEnablePreSettleDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgyEnablePreSettleData();

	factory GetRhgyEnablePreSettleData.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecord {
	@JSONField(name: '2026-01-09')
	late GetRhgyEnablePreSettleDataRecordx20260109 x20260109;
	@JSONField(name: '2026-01-06')
	late GetRhgyEnablePreSettleDataRecordx20260106 x20260106;
	@JSONField(name: '2026-01-04')
	late GetRhgyEnablePreSettleDataRecordx20260104 x20260104;
	@JSONField(name: '2026-01-03')
	late GetRhgyEnablePreSettleDataRecordx20260103 x20260103;

	GetRhgyEnablePreSettleDataRecord();

	factory GetRhgyEnablePreSettleDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260109 {
	late double betAmount;
	late List<GetRhgyEnablePreSettleDataRecordx20260109Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyEnablePreSettleDataRecordx20260109();

	factory GetRhgyEnablePreSettleDataRecordx20260109.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260109FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260109ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260109Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	late String beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyEnablePreSettleDataRecordx20260109DataDetailList> detailList;
	late bool enablePreSettle;
	late String id;
	late bool initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	late int maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	late int orderType;
	dynamic orderVOS;
	dynamic outcome;
	late int preBetAmount;
	dynamic preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	late double preSettleBetAmount;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgyEnablePreSettleDataRecordx20260109Data();

	factory GetRhgyEnablePreSettleDataRecordx20260109Data.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260109DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260109DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260109DataDetailList {
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
	late String childPlayId;
	late String closingTime;
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
	late int matchManageType;
	late String matchName;
	late int matchOver;
	late String matchPeriodId;
	late int matchProcessId;
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
	late String secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	late String thirdMatchId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgyEnablePreSettleDataRecordx20260109DataDetailList();

	factory GetRhgyEnablePreSettleDataRecordx20260109DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260109DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260109DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260106 {
	late double betAmount;
	late List<GetRhgyEnablePreSettleDataRecordx20260106Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyEnablePreSettleDataRecordx20260106();

	factory GetRhgyEnablePreSettleDataRecordx20260106.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260106FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260106ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260106Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	late String beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyEnablePreSettleDataRecordx20260106DataDetailList> detailList;
	late bool enablePreSettle;
	late String id;
	late bool initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	late double maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	late int orderType;
	dynamic orderVOS;
	dynamic outcome;
	late int preBetAmount;
	dynamic preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	late double preSettleBetAmount;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgyEnablePreSettleDataRecordx20260106Data();

	factory GetRhgyEnablePreSettleDataRecordx20260106Data.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260106DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260106DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260106DataDetailList {
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
	late String childPlayId;
	late String closingTime;
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
	late int matchManageType;
	late String matchName;
	late int matchOver;
	late String matchPeriodId;
	late int matchProcessId;
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
	late String secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	late String thirdMatchId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgyEnablePreSettleDataRecordx20260106DataDetailList();

	factory GetRhgyEnablePreSettleDataRecordx20260106DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260106DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260106DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260104 {
	late double betAmount;
	late List<GetRhgyEnablePreSettleDataRecordx20260104Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyEnablePreSettleDataRecordx20260104();

	factory GetRhgyEnablePreSettleDataRecordx20260104.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260104FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260104ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260104Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	late String beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyEnablePreSettleDataRecordx20260104DataDetailList> detailList;
	late bool enablePreSettle;
	late String id;
	late bool initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	late int maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	late int orderType;
	dynamic orderVOS;
	dynamic outcome;
	late int preBetAmount;
	late int preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	late double preSettleBetAmount;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgyEnablePreSettleDataRecordx20260104Data();

	factory GetRhgyEnablePreSettleDataRecordx20260104Data.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260104DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260104DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260104DataDetailList {
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
	late String childPlayId;
	late String closingTime;
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
	late int matchManageType;
	late String matchName;
	late int matchOver;
	late String matchPeriodId;
	late int matchProcessId;
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
	late String secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	late String thirdMatchId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgyEnablePreSettleDataRecordx20260104DataDetailList();

	factory GetRhgyEnablePreSettleDataRecordx20260104DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260104DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260104DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260103 {
	late double betAmount;
	late List<GetRhgyEnablePreSettleDataRecordx20260103Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyEnablePreSettleDataRecordx20260103();

	factory GetRhgyEnablePreSettleDataRecordx20260103.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260103FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260103ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260103Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	late String beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetRhgyEnablePreSettleDataRecordx20260103DataDetailList> detailList;
	late bool enablePreSettle;
	late String id;
	late bool initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	late int maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	late int orderType;
	dynamic orderVOS;
	dynamic outcome;
	late int preBetAmount;
	dynamic preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	late double preSettleBetAmount;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgyEnablePreSettleDataRecordx20260103Data();

	factory GetRhgyEnablePreSettleDataRecordx20260103Data.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260103DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260103DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyEnablePreSettleDataRecordx20260103DataDetailList {
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
	late String childPlayId;
	late String closingTime;
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
	late int matchManageType;
	late String matchName;
	late int matchOver;
	late String matchPeriodId;
	late int matchProcessId;
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
	late String secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	late String thirdMatchId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgyEnablePreSettleDataRecordx20260103DataDetailList();

	factory GetRhgyEnablePreSettleDataRecordx20260103DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyEnablePreSettleDataRecordx20260103DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyEnablePreSettleDataRecordx20260103DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}