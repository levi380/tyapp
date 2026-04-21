import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/championship_results_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/championship_results_entity.g.dart';

@JsonSerializable()
class ChampionshipResultsEntity {
	late String code;
	late ChampionshipResultsData data;
	late String msg;
	late int ts;

	ChampionshipResultsEntity();

	factory ChampionshipResultsEntity.fromJson(Map<String, dynamic> json) => $ChampionshipResultsEntityFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsData {
	late List<ChampionshipResultsDataNb> nb;
	late List<ChampionshipResultsDataNt> nt;
	late List<ChampionshipResultsDataNl> nl;

	ChampionshipResultsData();

	factory ChampionshipResultsData.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNb {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late ChampionshipResultsDataNbOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	ChampionshipResultsDataNb();

	factory ChampionshipResultsDataNb.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNbFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNbOrderInfo {
	late int orderType;
	late String matchIds;
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
	late List<ChampionshipResultsDataNbOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;

	ChampionshipResultsDataNbOrderInfo();

	factory ChampionshipResultsDataNbOrderInfo.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNbOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNbOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNbOrderInfoDetailList {
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
	late String orderSettleRemark;
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

	ChampionshipResultsDataNbOrderInfoDetailList();

	factory ChampionshipResultsDataNbOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNbOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNbOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNt {
	late String enType;
	late int id;
	late String type;

	ChampionshipResultsDataNt();

	factory ChampionshipResultsDataNt.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNtFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNl {
	late List<ChampionshipResultsDataNlMtl> mtl;
	late String nen;
	late int net;

	ChampionshipResultsDataNl();

	factory ChampionshipResultsDataNl.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNlFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late ChampionshipResultsDataNlMtlOrderInfo orderInfo;
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;

	ChampionshipResultsDataNlMtl();

	factory ChampionshipResultsDataNlMtl.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNlMtlOrderInfo {
	late int orderType;
	late String matchIds;
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
	late List<ChampionshipResultsDataNlMtlOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;

	ChampionshipResultsDataNlMtlOrderInfo();

	factory ChampionshipResultsDataNlMtlOrderInfo.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNlMtlOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNlMtlOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChampionshipResultsDataNlMtlOrderInfoDetailList {
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
	late String orderSettleRemark;
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

	ChampionshipResultsDataNlMtlOrderInfoDetailList();

	factory ChampionshipResultsDataNlMtlOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $ChampionshipResultsDataNlMtlOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $ChampionshipResultsDataNlMtlOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}