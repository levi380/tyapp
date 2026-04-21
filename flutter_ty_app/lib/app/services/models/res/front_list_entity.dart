import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/front_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/front_list_entity.g.dart';

@JsonSerializable()
class FrontListEntity {
	late String code;
	late FrontListData data;
	late String msg;
	late int ts;

	FrontListEntity();

	factory FrontListEntity.fromJson(Map<String, dynamic> json) => $FrontListEntityFromJson(json);

	Map<String, dynamic> toJson() => $FrontListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListData {
	late List<FrontListDataNb> nb;
	late List<FrontListDataNt> nt;
	late List<FrontListDataNl> nl;

	FrontListData();

	factory FrontListData.fromJson(Map<String, dynamic> json) => $FrontListDataFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late FrontListDataNbOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListDataNb();

	factory FrontListDataNb.fromJson(Map<String, dynamic> json) => $FrontListDataNbFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNbOrderInfo {
	late int orderType;
	late String matchIds;
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
	late List<FrontListDataNbOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;

	FrontListDataNbOrderInfo();

	factory FrontListDataNbOrderInfo.fromJson(Map<String, dynamic> json) => $FrontListDataNbOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNbOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNbOrderInfoDetailList {
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

	FrontListDataNbOrderInfoDetailList();

	factory FrontListDataNbOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $FrontListDataNbOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNbOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNt {
	late String enType;
	late int id;
	late String type;

	FrontListDataNt();

	factory FrontListDataNt.fromJson(Map<String, dynamic> json) => $FrontListDataNtFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNl {
	late List<FrontListDataNlMtl> mtl;
	late String nen;
	late int net;

	FrontListDataNl();

	factory FrontListDataNl.fromJson(Map<String, dynamic> json) => $FrontListDataNlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late FrontListDataNlMtlOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	FrontListDataNlMtl();

	factory FrontListDataNlMtl.fromJson(Map<String, dynamic> json) => $FrontListDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNlMtlOrderInfo {
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
	late List<FrontListDataNlMtlOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	FrontListDataNlMtlOrderInfo();

	factory FrontListDataNlMtlOrderInfo.fromJson(Map<String, dynamic> json) => $FrontListDataNlMtlOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNlMtlOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FrontListDataNlMtlOrderInfoDetailList {
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

	FrontListDataNlMtlOrderInfoDetailList();

	factory FrontListDataNlMtlOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $FrontListDataNlMtlOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $FrontListDataNlMtlOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}