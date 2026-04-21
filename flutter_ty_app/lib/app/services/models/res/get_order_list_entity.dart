import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_order_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_order_list_entity.g.dart';

@JsonSerializable()
class GetOrderListEntity {
	late String code;
	late GetOrderListData data;
	late String msg;
	late int ts;

	GetOrderListEntity();

	factory GetOrderListEntity.fromJson(Map<String, dynamic> json) => $GetOrderListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListData {
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
	late GetOrderListDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	GetOrderListData();

	factory GetOrderListData.fromJson(Map<String, dynamic> json) => $GetOrderListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecord {
	@JSONField(name: '2026-01-16')
	late GetOrderListDataRecordx20260116 x20260116;
	@JSONField(name: '2026-01-15')
	late GetOrderListDataRecordx20260115 x20260115;
	@JSONField(name: '2026-01-12')
	late GetOrderListDataRecordx20260112 x20260112;
	@JSONField(name: '2026-01-11')
	late GetOrderListDataRecordx20260111 x20260111;

	GetOrderListDataRecord();

	factory GetOrderListDataRecord.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260116 {
	late double betAmount;
	late List<GetOrderListDataRecordx20260116Data> data;
	late int totalOrders;
	late double profit;

	GetOrderListDataRecordx20260116();

	factory GetOrderListDataRecordx20260116.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260116FromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260116ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260116Data {
	late String acCode;
	dynamic addition;
	late double backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetOrderListDataRecordx20260116DataDetailList> detailList;
	dynamic enablePreSettle;
	late String id;
	dynamic initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	dynamic maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic orderType;
	dynamic orderVOS;
	late int outcome;
	dynamic preBetAmount;
	late int preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic preSettleBetAmount;
	late double profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	late String settleTime;
	late int settleType;
	late double settledAmount;

	GetOrderListDataRecordx20260116Data();

	factory GetOrderListDataRecordx20260116Data.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260116DataFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260116DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260116DataDetailList {
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
	late int matchOver;
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
	late String thirdMatchId;
	late String tournamentId;
	dynamic tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetOrderListDataRecordx20260116DataDetailList();

	factory GetOrderListDataRecordx20260116DataDetailList.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260116DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260116DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260115 {
	late double betAmount;
	late List<GetOrderListDataRecordx20260115Data> data;
	late int totalOrders;
	late double profit;

	GetOrderListDataRecordx20260115();

	factory GetOrderListDataRecordx20260115.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260115FromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260115ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260115Data {
	late String acCode;
	dynamic addition;
	late double backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetOrderListDataRecordx20260115DataDetailList> detailList;
	dynamic enablePreSettle;
	late String id;
	dynamic initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	dynamic maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic orderType;
	dynamic orderVOS;
	late int outcome;
	dynamic preBetAmount;
	late int preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic preSettleBetAmount;
	late double profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	late String settleTime;
	late int settleType;
	late double settledAmount;

	GetOrderListDataRecordx20260115Data();

	factory GetOrderListDataRecordx20260115Data.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260115DataFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260115DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260115DataDetailList {
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
	late int matchOver;
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
	late String thirdMatchId;
	late String tournamentId;
	dynamic tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetOrderListDataRecordx20260115DataDetailList();

	factory GetOrderListDataRecordx20260115DataDetailList.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260115DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260115DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260112 {
	late double betAmount;
	late List<GetOrderListDataRecordx20260112Data> data;
	late int totalOrders;
	late double profit;

	GetOrderListDataRecordx20260112();

	factory GetOrderListDataRecordx20260112.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260112FromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260112ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260112Data {
	late String acCode;
	dynamic addition;
	late double backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetOrderListDataRecordx20260112DataDetailList> detailList;
	dynamic enablePreSettle;
	late String id;
	dynamic initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	dynamic maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic orderType;
	dynamic orderVOS;
	late int outcome;
	dynamic preBetAmount;
	late int preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic preSettleBetAmount;
	late double profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	late String settleTime;
	late int settleType;
	late double settledAmount;

	GetOrderListDataRecordx20260112Data();

	factory GetOrderListDataRecordx20260112Data.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260112DataFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260112DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260112DataDetailList {
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
	dynamic matchManageType;
	late String matchName;
	late int matchOver;
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
	late String thirdMatchId;
	late String tournamentId;
	dynamic tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetOrderListDataRecordx20260112DataDetailList();

	factory GetOrderListDataRecordx20260112DataDetailList.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260112DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260112DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260111 {
	late double betAmount;
	late List<GetOrderListDataRecordx20260111Data> data;
	late int totalOrders;
	late double profit;

	GetOrderListDataRecordx20260111();

	factory GetOrderListDataRecordx20260111.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260111FromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260111ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260111Data {
	late String acCode;
	dynamic addition;
	late double backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late String cashOutTimes;
	late List<GetOrderListDataRecordx20260111DataDetailList> detailList;
	dynamic enablePreSettle;
	late String id;
	dynamic initPresettleWs;
	late String langCode;
	late String languageName;
	late int managerCode;
	late String marketType;
	dynamic matchType;
	dynamic maxCashout;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late String odds;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic orderType;
	dynamic orderVOS;
	late int outcome;
	dynamic preBetAmount;
	late int preOrder;
	dynamic preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic preSettleBetAmount;
	late double profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	late String settleTime;
	late int settleType;
	late double settledAmount;

	GetOrderListDataRecordx20260111Data();

	factory GetOrderListDataRecordx20260111Data.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260111DataFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260111DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListDataRecordx20260111DataDetailList {
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
	dynamic matchManageType;
	late String matchName;
	late int matchOver;
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
	late String thirdMatchId;
	late String tournamentId;
	dynamic tournamentLevel;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetOrderListDataRecordx20260111DataDetailList();

	factory GetOrderListDataRecordx20260111DataDetailList.fromJson(Map<String, dynamic> json) => $GetOrderListDataRecordx20260111DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListDataRecordx20260111DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}