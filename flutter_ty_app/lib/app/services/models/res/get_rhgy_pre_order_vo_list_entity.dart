import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_pre_order_vo_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_pre_order_vo_list_entity.g.dart';

@JsonSerializable()
class GetRhgyPreOrderVoListEntity {
	late String code;
	late GetRhgyPreOrderVoListData data;
	late String msg;
	late int ts;

	GetRhgyPreOrderVoListEntity();

	factory GetRhgyPreOrderVoListEntity.fromJson(Map<String, dynamic> json) => $GetRhgyPreOrderVoListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyPreOrderVoListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyPreOrderVoListData {
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
	late GetRhgyPreOrderVoListDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgyPreOrderVoListData();

	factory GetRhgyPreOrderVoListData.fromJson(Map<String, dynamic> json) => $GetRhgyPreOrderVoListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyPreOrderVoListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyPreOrderVoListDataRecord {
	@JSONField(name: '2025-09-21')
	late GetRhgyPreOrderVoListDataRecordx20250921 x20250921;

	GetRhgyPreOrderVoListDataRecord();

	factory GetRhgyPreOrderVoListDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgyPreOrderVoListDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyPreOrderVoListDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyPreOrderVoListDataRecordx20250921 {
	late double betAmount;
	late List<GetRhgyPreOrderVoListDataRecordx20250921Data> data;
	late int totalOrders;
	late int profit;

	GetRhgyPreOrderVoListDataRecordx20250921();

	factory GetRhgyPreOrderVoListDataRecordx20250921.fromJson(Map<String, dynamic> json) => $GetRhgyPreOrderVoListDataRecordx20250921FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyPreOrderVoListDataRecordx20250921ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyPreOrderVoListDataRecordx20250921Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetRhgyPreOrderVoListDataRecordx20250921DataDetailList> detailList;
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
	dynamic preBetAmount;
	late int preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic preSettleBetAmount;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	late int settleType;
	dynamic settledAmount;

	GetRhgyPreOrderVoListDataRecordx20250921Data();

	factory GetRhgyPreOrderVoListDataRecordx20250921Data.fromJson(Map<String, dynamic> json) => $GetRhgyPreOrderVoListDataRecordx20250921DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyPreOrderVoListDataRecordx20250921DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyPreOrderVoListDataRecordx20250921DataDetailList {
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

	GetRhgyPreOrderVoListDataRecordx20250921DataDetailList();

	factory GetRhgyPreOrderVoListDataRecordx20250921DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgyPreOrderVoListDataRecordx20250921DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyPreOrderVoListDataRecordx20250921DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}