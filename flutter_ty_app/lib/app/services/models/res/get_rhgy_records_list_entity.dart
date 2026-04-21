import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_records_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_records_list_entity.g.dart';

@JsonSerializable()
class GetRhgyRecordsListEntity {
	late String code;
	late GetRhgyRecordsListData data;
	late String msg;
	late int ts;

	GetRhgyRecordsListEntity();

	factory GetRhgyRecordsListEntity.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListData {
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
	late GetRhgyRecordsListDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgyRecordsListData();

	factory GetRhgyRecordsListData.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListDataRecord {
	@JSONField(name: '2025-09-21')
	late GetRhgyRecordsListDataRecordx20250921 x20250921;
	@JSONField(name: '2025-09-20')
	late GetRhgyRecordsListDataRecordx20250920 x20250920;

	GetRhgyRecordsListDataRecord();

	factory GetRhgyRecordsListDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListDataRecordx20250921 {
	late double betAmount;
	late List<GetRhgyRecordsListDataRecordx20250921Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyRecordsListDataRecordx20250921();

	factory GetRhgyRecordsListDataRecordx20250921.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataRecordx20250921FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataRecordx20250921ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListDataRecordx20250921Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetRhgyRecordsListDataRecordx20250921DataDetailList> detailList;
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

	GetRhgyRecordsListDataRecordx20250921Data();

	factory GetRhgyRecordsListDataRecordx20250921Data.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataRecordx20250921DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataRecordx20250921DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListDataRecordx20250921DataDetailList {
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

	GetRhgyRecordsListDataRecordx20250921DataDetailList();

	factory GetRhgyRecordsListDataRecordx20250921DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataRecordx20250921DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataRecordx20250921DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListDataRecordx20250920 {
	late double betAmount;
	late List<GetRhgyRecordsListDataRecordx20250920Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyRecordsListDataRecordx20250920();

	factory GetRhgyRecordsListDataRecordx20250920.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataRecordx20250920FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataRecordx20250920ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListDataRecordx20250920Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetRhgyRecordsListDataRecordx20250920DataDetailList> detailList;
	late bool enablePreSettle;
	late String id;
	late bool initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	late int matchType;
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
	late int preSettle;
	late double preSettleBetAmount;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgyRecordsListDataRecordx20250920Data();

	factory GetRhgyRecordsListDataRecordx20250920Data.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataRecordx20250920DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataRecordx20250920DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordsListDataRecordx20250920DataDetailList {
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

	GetRhgyRecordsListDataRecordx20250920DataDetailList();

	factory GetRhgyRecordsListDataRecordx20250920DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyRecordsListDataRecordx20250920DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordsListDataRecordx20250920DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}