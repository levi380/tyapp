import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/front_list_notice_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/front_list_notice_entity.g.dart';

@JsonSerializable()
class FrontListNoticeEntity {
	late String code;
	late FrontListNoticeData data;
	late String msg;
	late int ts;

	FrontListNoticeEntity();

	factory FrontListNoticeEntity.fromJson(Map<String, dynamic> json) => $FrontListNoticeEntityFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeData {
	late List<FrontListNoticeDataNb> nb;
	late List<FrontListNoticeDataNt> nt;
	late List<FrontListNoticeDataNl> nl;

	FrontListNoticeData();

	factory FrontListNoticeData.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late FrontListNoticeDataNbOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListNoticeDataNb();

	factory FrontListNoticeDataNb.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNbFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNbOrderInfo {
	late int orderType;
	late String langCode;
	late String orderStatus;
	late bool initPresettleWs;
	late int orderClass;
	late String marketType;
	late String modifyTime;
	late String orderClassStr;
	late bool enablePreSettle;
	late String modifyTimeStr;
	late String seriesType;
	late String odds;
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
	late List<FrontListNoticeDataNbOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	FrontListNoticeDataNbOrderInfo();

	factory FrontListNoticeDataNbOrderInfo.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNbOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNbOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNbOrderInfoDetailList {
	late int betResult;
	late int matchType;
	late String matchInfo;
	late String homeName;
	late String extJson;
	late int matchManageType;
	late String eov;
	late String marketType;
	late String playOptionName;
	late String playOptionsId;
	late String score;
	late String closingTime;
	late String tournamentId;
	late double oddsValue;
	late String beginTime;
	late String matchTestScore;
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
	late String matchName;
	late String marketValue;
	late int betStatus;
	late int matchVideoTag;
	late String playOptions;
	late int sportId;
	late String settleScore;
	late int tournamentLevel;
	late String originalMarketValue;

	FrontListNoticeDataNbOrderInfoDetailList();

	factory FrontListNoticeDataNbOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNbOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNbOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNt {
	late String enType;
	late int id;
	late String type;

	FrontListNoticeDataNt();

	factory FrontListNoticeDataNt.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNtFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNl {
	late List<FrontListNoticeDataNlMtl> mtl;
	late String nen;
	late int net;

	FrontListNoticeDataNl();

	factory FrontListNoticeDataNl.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late FrontListNoticeDataNlMtlOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListNoticeDataNlMtl();

	factory FrontListNoticeDataNlMtl.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNlMtlOrderInfo {
	late String langCode;
	late String orderStatus;
	late int orderClass;
	late String marketType;
	late double preBetAmount;
	late String modifyTime;
	late String orderClassStr;
	late String modifyTimeStr;
	late String seriesType;
	late int seriesSum;
	late double orderAmountTotal;
	late String id;
	late int addition;
	late String betTimeStr;
	late String orderNo;
	late double maxWinAmount;
	late int preOrderStatus;
	late String betTime;
	late List<FrontListNoticeDataNlMtlOrderInfoDetailList> detailList;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	FrontListNoticeDataNlMtlOrderInfo();

	factory FrontListNoticeDataNlMtlOrderInfo.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNlMtlOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNlMtlOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListNoticeDataNlMtlOrderInfoDetailList {
	late int betResult;
	late int matchType;
	late String matchInfo;
	late String homeName;
	late String eov;
	late String marketType;
	late String playOptionName;
	late String playOptionsId;
	late String tournamentId;
	late double oddsValue;
	late String beginTime;
	late String tournamentPic;
	late String betNo;
	late String playName;
	late String oddFinally;
	late String awayName;
	late String betAmount;
	late String sportName;
	late int cancelType;
	late String marketId;
	late int playId;
	late String matchId;
	late String scoreBenchmark;
	late String matchName;
	late String marketValue;
	late int betStatus;
	late int matchVideoTag;
	late String playOptions;
	late int sportId;
	late String settleScore;
	late String originalMarketValue;

	FrontListNoticeDataNlMtlOrderInfoDetailList();

	factory FrontListNoticeDataNlMtlOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $FrontListNoticeDataNlMtlOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $FrontListNoticeDataNlMtlOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}