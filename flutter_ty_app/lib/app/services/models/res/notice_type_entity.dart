import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_type_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_type_entity.g.dart';

@JsonSerializable()
class NoticeTypeEntity {
	late String code;
	late NoticeTypeData data;
	late String msg;
	late int ts;

	NoticeTypeEntity();

	factory NoticeTypeEntity.fromJson(Map<String, dynamic> json) => $NoticeTypeEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeData {
	late List<NoticeTypeDataNb> nb;
	late List<NoticeTypeDataNt> nt;
	late List<NoticeTypeDataNl> nl;

	NoticeTypeData();

	factory NoticeTypeData.fromJson(Map<String, dynamic> json) => $NoticeTypeDataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late NoticeTypeDataNbOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeTypeDataNb();

	factory NoticeTypeDataNb.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNbFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNbOrderInfo {
	late int orderType;
	late String langCode;
	late String orderStatus;
	late bool initPresettleWs;
	late int orderClass;
	late String marketType;
	late int preBetAmount;
	late String modifyTime;
	late String orderClassStr;
	late bool enablePreSettle;
	late String modifyTimeStr;
	late String seriesType;
	late int seriesSum;
	late double orderAmountTotal;
	late String beginTime;
	late String id;
	late int addition;
	late String betTimeStr;
	late String orderNo;
	late double maxWinAmount;
	late double preSettleBetAmount;
	late int managerCode;
	late String betTime;
	late List<NoticeTypeDataNbOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	NoticeTypeDataNbOrderInfo();

	factory NoticeTypeDataNbOrderInfo.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNbOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNbOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNbOrderInfoDetailList {
	late int betResult;
	late String matchPeriodId;
	late int matchType;
	late String matchInfo;
	late String homeName;
	late String extJson;
	late int matchManageType;
	late String dataSourceCode;
	late String eov;
	late String marketType;
	late String playOptionName;
	late String playOptionsId;
	late String score;
	late String closingTime;
	late String thirdMatchId;
	late String tournamentId;
	late double oddsValue;
	late String beginTime;
	late String matchTestScore;
	late String tournamentPic;
	late String betNo;
	late String playName;
	late int matchOver;
	late int matchProcessId;
	late String oddFinally;
	late String awayName;
	late String betAmount;
	late String sportName;
	late String childPlayId;
	late int cancelType;
	late String marketId;
	late int playId;
	late String matchId;
	late String secondsMatchStart;
	late String matchName;
	late String marketValue;
	late int betStatus;
	late int matchVideoTag;
	late String playOptions;
	late int sportId;
	late String settleScore;
	late int tournamentLevel;
	late String originalMarketValue;

	NoticeTypeDataNbOrderInfoDetailList();

	factory NoticeTypeDataNbOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNbOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNbOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNt {
	late String enType;
	late int id;
	late String type;

	NoticeTypeDataNt();

	factory NoticeTypeDataNt.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNtFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNl {
	late List<NoticeTypeDataNlMtl> mtl;
	late String nen;
	late int net;

	NoticeTypeDataNl();

	factory NoticeTypeDataNl.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late NoticeTypeDataNlMtlOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeTypeDataNlMtl();

	factory NoticeTypeDataNlMtl.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNlMtlOrderInfo {
	late int orderType;
	late String langCode;
	late String orderStatus;
	late bool initPresettleWs;
	late int orderClass;
	late String marketType;
	late int preBetAmount;
	late String modifyTime;
	late String orderClassStr;
	late bool enablePreSettle;
	late String modifyTimeStr;
	late String seriesType;
	late int seriesSum;
	late double orderAmountTotal;
	late String beginTime;
	late String id;
	late int addition;
	late String betTimeStr;
	late String orderNo;
	late double maxWinAmount;
	late double preSettleBetAmount;
	late int managerCode;
	late String betTime;
	late List<NoticeTypeDataNlMtlOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	NoticeTypeDataNlMtlOrderInfo();

	factory NoticeTypeDataNlMtlOrderInfo.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNlMtlOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNlMtlOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeDataNlMtlOrderInfoDetailList {
	late int betResult;
	late String matchPeriodId;
	late int matchType;
	late String matchInfo;
	late String homeName;
	late String extJson;
	late int matchManageType;
	late String dataSourceCode;
	late String eov;
	late String marketType;
	late String playOptionName;
	late String playOptionsId;
	late String score;
	late String closingTime;
	late String thirdMatchId;
	late String tournamentId;
	late double oddsValue;
	late String beginTime;
	late String matchTestScore;
	late String tournamentPic;
	late String betNo;
	late String playName;
	late int matchOver;
	late int matchProcessId;
	late String oddFinally;
	late String awayName;
	late String betAmount;
	late String sportName;
	late String childPlayId;
	late int cancelType;
	late String marketId;
	late int playId;
	late String matchId;
	late String secondsMatchStart;
	late String matchName;
	late String marketValue;
	late int betStatus;
	late int matchVideoTag;
	late String playOptions;
	late int sportId;
	late String settleScore;
	late int tournamentLevel;
	late String originalMarketValue;

	NoticeTypeDataNlMtlOrderInfoDetailList();

	factory NoticeTypeDataNlMtlOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $NoticeTypeDataNlMtlOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeDataNlMtlOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}