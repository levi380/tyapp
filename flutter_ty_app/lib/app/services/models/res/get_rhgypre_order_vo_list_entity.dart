import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgypre_order_vo_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgypre_order_vo_list_entity.g.dart';

@JsonSerializable()
class GetRhgypreOrderVoListEntity {
	late String code;
	late GetRhgypreOrderVoListData data;
	late String msg;
	late int ts;

	GetRhgypreOrderVoListEntity();

	factory GetRhgypreOrderVoListEntity.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListData {
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
	late GetRhgypreOrderVoListDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetRhgypreOrderVoListData();

	factory GetRhgypreOrderVoListData.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecord {
	@JSONField(name: '2025-11-07')
	late GetRhgypreOrderVoListDataRecordx20251107 x20251107;
	@JSONField(name: '2025-11-02')
	late GetRhgypreOrderVoListDataRecordx20251102 x20251102;
	@JSONField(name: '2025-10-26')
	late GetRhgypreOrderVoListDataRecordx20251026 x20251026;

	GetRhgypreOrderVoListDataRecord();

	factory GetRhgypreOrderVoListDataRecord.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251107 {
	late double betAmount;
	late List<GetRhgypreOrderVoListDataRecordx20251107Data> data;
	late int totalOrders;
	late int profit;

	GetRhgypreOrderVoListDataRecordx20251107();

	factory GetRhgypreOrderVoListDataRecordx20251107.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251107FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251107ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251107Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetRhgypreOrderVoListDataRecordx20251107DataDetailList> detailList;
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
	dynamic preOrder;
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

	GetRhgypreOrderVoListDataRecordx20251107Data();

	factory GetRhgypreOrderVoListDataRecordx20251107Data.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251107DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251107DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251107DataDetailList {
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

	GetRhgypreOrderVoListDataRecordx20251107DataDetailList();

	factory GetRhgypreOrderVoListDataRecordx20251107DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251107DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251107DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251102 {
	late double betAmount;
	late List<GetRhgypreOrderVoListDataRecordx20251102Data> data;
	late int totalOrders;
	late int profit;

	GetRhgypreOrderVoListDataRecordx20251102();

	factory GetRhgypreOrderVoListDataRecordx20251102.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251102FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251102ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251102Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetRhgypreOrderVoListDataRecordx20251102DataDetailList> detailList;
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
	dynamic preBetAmount;
	dynamic preOrder;
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

	GetRhgypreOrderVoListDataRecordx20251102Data();

	factory GetRhgypreOrderVoListDataRecordx20251102Data.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251102DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251102DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251102DataDetailList {
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
	dynamic matchPeriodId;
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
	dynamic secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	dynamic thirdMatchId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgypreOrderVoListDataRecordx20251102DataDetailList();

	factory GetRhgypreOrderVoListDataRecordx20251102DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251102DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251102DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251026 {
	late double betAmount;
	late List<GetRhgypreOrderVoListDataRecordx20251026Data> data;
	late int totalOrders;
	late int profit;

	GetRhgypreOrderVoListDataRecordx20251026();

	factory GetRhgypreOrderVoListDataRecordx20251026.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251026FromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251026ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251026Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetRhgypreOrderVoListDataRecordx20251026DataDetailList> detailList;
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
	dynamic preBetAmount;
	dynamic preOrder;
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

	GetRhgypreOrderVoListDataRecordx20251026Data();

	factory GetRhgypreOrderVoListDataRecordx20251026Data.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251026DataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251026DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgypreOrderVoListDataRecordx20251026DataDetailList {
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
	dynamic matchPeriodId;
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
	dynamic secondsMatchStart;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	dynamic thirdMatchId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetRhgypreOrderVoListDataRecordx20251026DataDetailList();

	factory GetRhgypreOrderVoListDataRecordx20251026DataDetailList.fromJson(Map<String, dynamic> json) => $GetRhgypreOrderVoListDataRecordx20251026DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgypreOrderVoListDataRecordx20251026DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}