import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/notice_type_name_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/notice_type_name_entity.g.dart';

@JsonSerializable()
class NoticeTypeNameEntity {
	late String code;
	late NoticeTypeNameData data;
	late String msg;
	late int ts;

	NoticeTypeNameEntity();

	factory NoticeTypeNameEntity.fromJson(Map<String, dynamic> json) => $NoticeTypeNameEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameData {
	late List<NoticeTypeNameDataNb> nb;
	late List<NoticeTypeNameDataNt> nt;
	late List<NoticeTypeNameDataNl> nl;

	NoticeTypeNameData();

	factory NoticeTypeNameData.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late NoticeTypeNameDataNbOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeTypeNameDataNb();

	factory NoticeTypeNameDataNb.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNbFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNbOrderInfo {
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
	late List<NoticeTypeNameDataNbOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	NoticeTypeNameDataNbOrderInfo();

	factory NoticeTypeNameDataNbOrderInfo.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNbOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNbOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNbOrderInfoDetailList {
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

	NoticeTypeNameDataNbOrderInfoDetailList();

	factory NoticeTypeNameDataNbOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNbOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNbOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNt {
	late String enType;
	late int id;
	late String type;

	NoticeTypeNameDataNt();

	factory NoticeTypeNameDataNt.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNtFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNl {
	late List<NoticeTypeNameDataNlMtl> mtl;
	late String nen;
	late int net;

	NoticeTypeNameDataNl();

	factory NoticeTypeNameDataNl.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late NoticeTypeNameDataNlMtlOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	NoticeTypeNameDataNlMtl();

	factory NoticeTypeNameDataNlMtl.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNlMtlOrderInfo {
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
	late List<NoticeTypeNameDataNlMtlOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	NoticeTypeNameDataNlMtlOrderInfo();

	factory NoticeTypeNameDataNlMtlOrderInfo.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNlMtlOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNlMtlOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NoticeTypeNameDataNlMtlOrderInfoDetailList {
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

	NoticeTypeNameDataNlMtlOrderInfoDetailList();

	factory NoticeTypeNameDataNlMtlOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $NoticeTypeNameDataNlMtlOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $NoticeTypeNameDataNlMtlOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}