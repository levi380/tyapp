import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_front_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_front_list_entity.g.dart';

@JsonSerializable()
class GetFrontListEntity {
	late String code;
	late GetFrontListData data;
	late String msg;
	late int ts;

	GetFrontListEntity();

	factory GetFrontListEntity.fromJson(Map<String, dynamic> json) => $GetFrontListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListData {
	late List<GetFrontListDataNb> nb;
	late List<GetFrontListDataNt> nt;
	late List<GetFrontListDataNl> nl;

	GetFrontListData();

	factory GetFrontListData.fromJson(Map<String, dynamic> json) => $GetFrontListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late GetFrontListDataNbOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	GetFrontListDataNb();

	factory GetFrontListDataNb.fromJson(Map<String, dynamic> json) => $GetFrontListDataNbFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNbOrderInfo {
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
	late List<GetFrontListDataNbOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	GetFrontListDataNbOrderInfo();

	factory GetFrontListDataNbOrderInfo.fromJson(Map<String, dynamic> json) => $GetFrontListDataNbOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNbOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNbOrderInfoDetailList {
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
	late String scoreBenchmark;
	late String matchName;
	late String marketValue;
	late int betStatus;
	late int matchVideoTag;
	late String playOptions;
	late int sportId;
	late String settleScore;
	late int tournamentLevel;
	late String originalMarketValue;

	GetFrontListDataNbOrderInfoDetailList();

	factory GetFrontListDataNbOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $GetFrontListDataNbOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNbOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNt {
	late String enType;
	late int id;
	late String type;

	GetFrontListDataNt();

	factory GetFrontListDataNt.fromJson(Map<String, dynamic> json) => $GetFrontListDataNtFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNl {
	late List<GetFrontListDataNlMtl> mtl;
	late String nen;
	late int net;

	GetFrontListDataNl();

	factory GetFrontListDataNl.fromJson(Map<String, dynamic> json) => $GetFrontListDataNlFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late GetFrontListDataNlMtlOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	GetFrontListDataNlMtl();

	factory GetFrontListDataNlMtl.fromJson(Map<String, dynamic> json) => $GetFrontListDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNlMtlOrderInfo {
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
	late List<GetFrontListDataNlMtlOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	GetFrontListDataNlMtlOrderInfo();

	factory GetFrontListDataNlMtlOrderInfo.fromJson(Map<String, dynamic> json) => $GetFrontListDataNlMtlOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNlMtlOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFrontListDataNlMtlOrderInfoDetailList {
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
	late String scoreBenchmark;
	late String matchName;
	late String marketValue;
	late int betStatus;
	late int matchVideoTag;
	late String playOptions;
	late int sportId;
	late String settleScore;
	late int tournamentLevel;
	late String originalMarketValue;

	GetFrontListDataNlMtlOrderInfoDetailList();

	factory GetFrontListDataNlMtlOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $GetFrontListDataNlMtlOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetFrontListDataNlMtlOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}