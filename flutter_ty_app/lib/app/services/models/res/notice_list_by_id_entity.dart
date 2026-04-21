import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_list_by_id_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_list_by_id_entity.g.dart';

@JsonSerializable()
class NoticeListByIdEntity {
	late String code;
	late NoticeListByIdData data;
	late String msg;
	late int ts;

	NoticeListByIdEntity();

	factory NoticeListByIdEntity.fromJson(Map<String, dynamic> json) => $NoticeListByIdEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdData {
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
	late NoticeListByIdDataRecord record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String subOrderTotal;
	late String total;

	NoticeListByIdData();

	factory NoticeListByIdData.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdDataRecord {
	@JSONField(name: '2025-12-02')
	late NoticeListByIdDataRecordx20251202 x20251202;
	@JSONField(name: '2025-11-14')
	late NoticeListByIdDataRecordx20251114 x20251114;

	NoticeListByIdDataRecord();

	factory NoticeListByIdDataRecord.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataRecordFromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdDataRecordx20251202 {
	late double betAmount;
	late List<NoticeListByIdDataRecordx20251202Data> data;
	late int totalOrders;
	late int profit;

	NoticeListByIdDataRecordx20251202();

	factory NoticeListByIdDataRecordx20251202.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataRecordx20251202FromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataRecordx20251202ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdDataRecordx20251202Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<NoticeListByIdDataRecordx20251202DataDetailList> detailList;
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

	NoticeListByIdDataRecordx20251202Data();

	factory NoticeListByIdDataRecordx20251202Data.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataRecordx20251202DataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataRecordx20251202DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdDataRecordx20251202DataDetailList {
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

	NoticeListByIdDataRecordx20251202DataDetailList();

	factory NoticeListByIdDataRecordx20251202DataDetailList.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataRecordx20251202DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataRecordx20251202DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdDataRecordx20251114 {
	late double betAmount;
	late List<NoticeListByIdDataRecordx20251114Data> data;
	late int totalOrders;
	late int profit;

	NoticeListByIdDataRecordx20251114();

	factory NoticeListByIdDataRecordx20251114.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataRecordx20251114FromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataRecordx20251114ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdDataRecordx20251114Data {
	late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<NoticeListByIdDataRecordx20251114DataDetailList> detailList;
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

	NoticeListByIdDataRecordx20251114Data();

	factory NoticeListByIdDataRecordx20251114Data.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataRecordx20251114DataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataRecordx20251114DataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeListByIdDataRecordx20251114DataDetailList {
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

	NoticeListByIdDataRecordx20251114DataDetailList();

	factory NoticeListByIdDataRecordx20251114DataDetailList.fromJson(Map<String, dynamic> json) => $NoticeListByIdDataRecordx20251114DataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $NoticeListByIdDataRecordx20251114DataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}