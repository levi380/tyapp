import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_search_count_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_search_count_list_entity.g.dart';

@JsonSerializable()
class GetRhgySearchCountListEntity {
	late String code;
	late GetRhgySearchCountListData data;
	late String msg;
	late int ts;

	GetRhgySearchCountListEntity();

	factory GetRhgySearchCountListEntity.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountListData {
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
	late GetRhgySearchCountListDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgySearchCountListData();

	factory GetRhgySearchCountListData.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountListDataRecord {
	@JSONField(name: '2025-10-04')
	late GetRhgySearchCountListDataRecordx20251004 x20251004;

	GetRhgySearchCountListDataRecord();

	factory GetRhgySearchCountListDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountListDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountListDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountListDataRecordx20251004 {
	late double betAmount;
	late List<GetRhgySearchCountListDataRecordx20251004Data> data;
	late int totalOrders;
	late int profit;

	GetRhgySearchCountListDataRecordx20251004();

	factory GetRhgySearchCountListDataRecordx20251004.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountListDataRecordx20251004FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountListDataRecordx20251004ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountListDataRecordx20251004Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late int cashOutTimes;
	late List<GetRhgySearchCountListDataRecordx20251004DataDetailList> detailList;
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

	GetRhgySearchCountListDataRecordx20251004Data();

	factory GetRhgySearchCountListDataRecordx20251004Data.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountListDataRecordx20251004DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountListDataRecordx20251004DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgySearchCountListDataRecordx20251004DataDetailList {
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

	GetRhgySearchCountListDataRecordx20251004DataDetailList();

	factory GetRhgySearchCountListDataRecordx20251004DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgySearchCountListDataRecordx20251004DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgySearchCountListDataRecordx20251004DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}