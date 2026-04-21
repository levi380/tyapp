import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/query_market_info_by_match_id_and_play_id_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_h5_pre_bet_orderlist_entity.g.dart';
export 'package:flutter_ty_app/generated/json/get_h5_pre_bet_orderlist_entity.g.dart';

@JsonSerializable()
class GetH5PreBetOrderlistEntity {
	late String code;
	late GetH5PreBetOrderlistData data;
	late String msg;
	late int ts;

	GetH5PreBetOrderlistEntity();

	factory GetH5PreBetOrderlistEntity.fromJson(Map<String, dynamic> json) => $GetH5PreBetOrderlistEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetH5PreBetOrderlistEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5PreBetOrderlistData {
	dynamic ascs;
	late String betTotalAmount;
	late String maxWinTotalAmount;
	late String current;
	dynamic descs;
	late bool hasNext;
	late bool hasPrevious;
	late bool optimizeCountSql;
	late String pages;
	late String preBetTotalAmount;
	late String profit;
	@JSONField(name:"record")
	 Map<String,GetH5PreBetOrderlistDataRecordx?>? record;
	late List<dynamic> records;
	late bool searchCount;
	late String size;
	late String total;

	GetH5PreBetOrderlistData();

	factory GetH5PreBetOrderlistData.fromJson(Map<String, dynamic> json) => $GetH5PreBetOrderlistDataFromJson(json);

	Map<String, dynamic> toJson() => $GetH5PreBetOrderlistDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}


@JsonSerializable()
class GetH5PreBetOrderlistDataRecordx {
	late double betAmount;
	late List<GetH5PreBetOrderlistDataRecordxData> data;
	late int totalOrders;

	GetH5PreBetOrderlistDataRecordx();

	factory GetH5PreBetOrderlistDataRecordx.fromJson(Map<String, dynamic> json) => $GetH5PreBetOrderlistDataRecordxFromJson(json);

	Map<String, dynamic> toJson() => $GetH5PreBetOrderlistDataRecordxToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5PreBetOrderlistDataRecordxData {
	///canBeModified自己新增加的，用来可以修改赔率的状态。false初始化不展示修改界面，点击修改就改变成true，展示修改赔率界面。(只有未结注单，预约中才有)
	late bool canBeModified = false;

	///isOnKeyboard自己新增加的，用来展示键盘展示状态。true初始化展示键盘，false收起键盘(只有未结注单，预约中才有)
	late	var isOnKeyboard = true.obs;

	///isChangeAmount 金额是否低于限额最少金额,记录是否低于最少额度（当最少金额，金额框变红标识）。
	late var isChangeAmount = false.obs;

	///isChangeOdds赔率是否走就近原则,用来表示赔率有没走就近原则（当走了就近原则，赔率框变红）。
	late var isChangeOdds = false.obs;

	///isCutoverAmountodds  记录当前更改的是（0：金额，1：盘口，2赔率）
	late  var	isCutoverAmountodds  = 0.obs;

  late String acCode;
	late int addition;
	dynamic backAmount;
	dynamic beginTime;
	late String beginTimeStr;
	late String betTime;
	late String betTimeStr;
	late List<GetH5PreBetOrderlistDataRecordxDataDetailList> detailList;
	late String id;
	late String langCode;
	dynamic managerCode;
	late String marketType;
	dynamic matchType;
	late double maxWinAmount;
	late String modifyTime;
	late String modifyTimeStr;
	late double orderAmountTotal;
	late String orderNo;
	late String orderStatus;
	dynamic outcome;
	dynamic preBetAmount;
	dynamic preOrder;
	late int preOrderStatus;
	dynamic preOrderVoList;
	dynamic preSettle;
	dynamic profitAmount;
	late int seriesSum;
	late String seriesType;
	late String seriesValue;
	dynamic settleTime;
	dynamic settleType;
	dynamic settledAmount;
	///盘口列表
	late QueryMarketInfoByMatchIdAndPlayIdData  queryMarketInfoByMatchIdAndPlayIdData;

	GetH5PreBetOrderlistDataRecordxData();

	factory GetH5PreBetOrderlistDataRecordxData.fromJson(Map<String, dynamic> json) => $GetH5PreBetOrderlistDataRecordxDataFromJson(json);

	Map<String, dynamic> toJson() => $GetH5PreBetOrderlistDataRecordxDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetH5PreBetOrderlistDataRecordxDataDetailList {
	///最小限制额度
	late var orderLeastPay = "".obs;
	///最大限制额度
	late var orderMaxPay = "".obs;
	///修改投注额
	late var modifyBetAmount = "".obs;
	
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
	dynamic firstNum;
	late String homeName;
	dynamic isValid;
	late String marketId;
	late String marketName;
	late String marketType;
	late String marketValue;
	late String matchId;
	late String matchInfo;
	late String matchName;
	dynamic matchOver;
	dynamic matchStatusId;
	late int matchType;
	late String oddFinally;
	///oddFinallyChange自己增加的用来修改赔率的用的，初始化付值赔率，后面动态更改(只有未结注单，预约中才有)
	late var oddFinallyChange = oddFinally.obs;
	///malayOddsValue自己增加的,通过接口获取的，现在赛事实时赔率
	late double RealTimeOddsValue;
	///soore自己增加的,通过接口获取的，赛事比分
	late String RealTimeScore;
	///marketValueChange自己增加的，调整分盘口值
	late var marketValueChange="".obs;

  late double oddsValue;
	late String optionValue;
	late String orderAmountTotal;
	late String orderNo;
	late String outrightYear;
	late String phase;
	dynamic placeNum;
	late int playId;
	String originalMarketValue ="";
	late String playName;
	late String playOptionName;
	late String playOptions;
	late String playOptionsId;
	late String playOptionsRange;
	late String remark;
	late String riskEvent;
	late String score = "";
	String scoreBenchmark ="";
	dynamic secondNum;
	late String settleScore;
	late int sportId;
	late String sportName;
	late String startTime;
	late String tournamentId;
	late String tournamentPic;
	dynamic uid;
	late String userId;

	GetH5PreBetOrderlistDataRecordxDataDetailList();

	factory GetH5PreBetOrderlistDataRecordxDataDetailList.fromJson(Map<String, dynamic> json) => $GetH5PreBetOrderlistDataRecordxDataDetailListFromJson(json);

	Map<String, dynamic> toJson() => $GetH5PreBetOrderlistDataRecordxDataDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

