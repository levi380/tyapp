import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_notice_front_list_new_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_notice_front_list_new_entity.g.dart';

@JsonSerializable()
class GetNoticeFrontListNewEntity {
	late String code;
	late GetNoticeFrontListNewData data;
	late String msg;
	late int ts;

	GetNoticeFrontListNewEntity();

	factory GetNoticeFrontListNewEntity.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewData {
	late List<GetNoticeFrontListNewDataNb> nb;
	late List<GetNoticeFrontListNewDataNt> nt;
	late List<GetNoticeFrontListNewDataNl> nl;

	GetNoticeFrontListNewData();

	factory GetNoticeFrontListNewData.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNb {
	late String context;
	late String context1 = '';
	late String context2 = '';
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
	late GetNoticeFrontListNewDataNbOrderInfo orderInfo = new GetNoticeFrontListNewDataNbOrderInfo();
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;
  late bool displayDate = false;

	GetNoticeFrontListNewDataNb();

	factory GetNoticeFrontListNewDataNb.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNbFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNbToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNbOrderInfo {
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
	late String id = '';
	late int addition;
	late String betTimeStr;
	late String orderNo;
	late double maxWinAmount;
	late double preSettleBetAmount;
	late int managerCode;
	late String betTime;
	late List<GetNoticeFrontListNewDataNbOrderInfoDetailList> detailList = [];
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	GetNoticeFrontListNewDataNbOrderInfo();

	factory GetNoticeFrontListNewDataNbOrderInfo.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNbOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNbOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNbOrderInfoDetailList {
	late int betResult;
	late int matchType;
	late String matchInfo;
	late String homeName;
	late String extJson;
	late String eov;
	late String marketType;
	late String playOptionName;
	late String playOptionsId;
	late String tournamentId;
	late double oddsValue;
	late String beginTime;
	late String betNo;
	late String playName;
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

	GetNoticeFrontListNewDataNbOrderInfoDetailList();

	factory GetNoticeFrontListNewDataNbOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNbOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNbOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNt {
	late String enType;
	late int id;
	late String type;

	GetNoticeFrontListNewDataNt();

	factory GetNoticeFrontListNewDataNt.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNtFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNtToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNl {
	late List<GetNoticeFrontListNewDataNlMtl> mtl = [];
	late String nen;
	late String net;

	GetNoticeFrontListNewDataNl();

	factory GetNoticeFrontListNewDataNl.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNlFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNlMtl {
	late String context;
	late String id;
	late int isShuf;
	late int isTop;
	late String matchManageId;
	late int noticeType;
	late String noticeTypeName;
  late GetNoticeFrontListNewDataNlMtlOrderInfo orderInfo = GetNoticeFrontListNewDataNlMtlOrderInfo();
	late String searchKey;
	late String sendTime;
	late String sendTimeOther;
	late String title;
  late bool displayDate = false;

	GetNoticeFrontListNewDataNlMtl();

	factory GetNoticeFrontListNewDataNlMtl.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNlMtlFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNlMtlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNlMtlOrderInfo {
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
	late String id;
	late int addition;
	late String betTimeStr;
	late String orderNo;
	late double maxWinAmount;
	late double preSettleBetAmount;
	late int managerCode;
	late String betTime;
	late List<GetNoticeFrontListNewDataNlMtlOrderInfoDetailList> detailList;
	late int maxCashout;
	late String seriesValue;
	late int settleType;
	late String matchIds;

	GetNoticeFrontListNewDataNlMtlOrderInfo();

	factory GetNoticeFrontListNewDataNlMtlOrderInfo.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNlMtlOrderInfoFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNlMtlOrderInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNoticeFrontListNewDataNlMtlOrderInfoDetailList {
	late int betResult;
	late int matchType;
	late String matchInfo;
	late String homeName;
	late String extJson;
	late String eov;
	late String marketType;
	late String playOptionName;
	late String playOptionsId;
	late String tournamentId;
	late double oddsValue;
	late String beginTime;
	late String betNo;
	late String playName;
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

	GetNoticeFrontListNewDataNlMtlOrderInfoDetailList();

	factory GetNoticeFrontListNewDataNlMtlOrderInfoDetailList.fromJson(Map<String, dynamic> json) => $GetNoticeFrontListNewDataNlMtlOrderInfoDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetNoticeFrontListNewDataNlMtlOrderInfoDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}