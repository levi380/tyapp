import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_record_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_record_list_entity.g.dart';

@JsonSerializable()
class GetRhgyRecordListEntity {
	late String code;
	late GetRhgyRecordListData data;
	late String msg;
	late int ts;

	GetRhgyRecordListEntity();

	factory GetRhgyRecordListEntity.fromJson(Map<String, dynamic> json) => $GetRhgyRecordListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordListData {
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
	late GetRhgyRecordListDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgyRecordListData();

	factory GetRhgyRecordListData.fromJson(Map<String, dynamic> json) => $GetRhgyRecordListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordListDataRecord {
	@JSONField(name: '2025-09-15')
	late GetRhgyRecordListDataRecordx20250915 x20250915;

	GetRhgyRecordListDataRecord();

	factory GetRhgyRecordListDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgyRecordListDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordListDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordListDataRecordx20250915 {
	late double betAmount;
	late List<GetRhgyRecordListDataRecordx20250915Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyRecordListDataRecordx20250915();

	factory GetRhgyRecordListDataRecordx20250915.fromJson(Map<String, dynamic> json) => $GetRhgyRecordListDataRecordx20250915FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordListDataRecordx20250915ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordListDataRecordx20250915Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetRhgyRecordListDataRecordx20250915DataDetailList> detailList;
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

	GetRhgyRecordListDataRecordx20250915Data();

	factory GetRhgyRecordListDataRecordx20250915Data.fromJson(Map<String, dynamic> json) => $GetRhgyRecordListDataRecordx20250915DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordListDataRecordx20250915DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyRecordListDataRecordx20250915DataDetailList {
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

	GetRhgyRecordListDataRecordx20250915DataDetailList();

	factory GetRhgyRecordListDataRecordx20250915DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyRecordListDataRecordx20250915DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyRecordListDataRecordx20250915DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}