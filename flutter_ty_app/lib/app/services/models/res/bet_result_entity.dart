import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/bet_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/bet_result_entity.g.dart';
import 'package:get/get.dart';

@JsonSerializable()
class BetResultEntity {
	late String betMoneyTotal = '';
	late String globalId = '';
	late int lock = 0;
	late String maxWinMoneyTotal = '';
	late List<BetResultOrderDetailRespList> orderDetailRespList = [];
	late List<BetResultSeriesOrderRespList> seriesOrderRespList = [];

	BetResultEntity();

	factory BetResultEntity.fromJson(Map<String, dynamic> json) => $BetResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $BetResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

//附加字段，不走JsonSerializable
class BetResultOrderDetailRespSuper{
	String? riskEvent;
	String shopCartItemId = '';
	String handicap = '';
	String oldHandicapHv = '';
	RxString newHandicapHv = ''.obs;
	String oldOddsValues = '';
	RxString newOddsValues = ''.obs;
	int newOdds = 0;	//万位赔率，实际未用到
	String sportId = "";
	String playId = ""; //玩法ID
	String oldPlayOptionName = ""; //盘口名
	String oldMarketValue = ""; //盘口值
	String orgOddFinally = "";
	String vrNo = "";
}

@JsonSerializable()
class BetResultOrderDetailRespList extends BetResultOrderDetailRespSuper{
	late String addition = '';
	late String batchNum = '';
	late String betMoney = '';
	late String marketType = '';
	late String marketValues = '';
	late String matchDay = '';
	dynamic matchDetailType;
	late String matchInfo = '';
	late String matchName = '';
	late int matchStatus = 0;
	late int matchType = 0;
	late String maxWinMoney = '';
	late String oddsType = '';
	late String oddsValues = '';
	late String orderNo = '';
	late int orderStatusCode;
	late String playName = '';
	late String playOptionName = '';
	late String playOptionsId = '';
	dynamic preOrderDetailStatus;
	late String scoreBenchmark = '';
	late String teamName = '';
	late int oddsChange = 0;


	BetResultOrderDetailRespList();

	@JSONField(serialize: false, deserialize: false)
	int removeCountdown = 3; // 一键投注移除倒计时 默认3秒

	@JSONField(serialize: false, deserialize: false)
	int remainCountdown = 0; // 订单存在时间

	@JSONField(serialize: false, deserialize: false)
	String sendWSTime = ""; // 用于记录数据时间，用于判断是否需要更新数据

	@JSONField(serialize: false, deserialize: false)
	int preBetOrder  = 0; // 是否是预约投注订单,1是,其他非不是

	factory BetResultOrderDetailRespList.fromJson(Map<String, dynamic> json) => $BetResultOrderDetailRespListFromJson(json);

	Map<String, dynamic> toJson() => $BetResultOrderDetailRespListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BetResultSeriesOrderRespList{
	late String betAmount = '';
	late String marketType = '';
	late String maxWinAmount = '';
	late String orderNo = '';
	late int orderStatusCode = 0;
	late String seriesBetAmount = '';
	late int seriesSum = 0;
	late String seriesValue = '';

	@JSONField(serialize: false, deserialize: false)
	String? riskEvent;

	@JSONField(serialize: false, deserialize: false)
	String sendWSTime = ""; // 用于记录数据时间，用于判断是否需要更新数据

	@JSONField(serialize: false, deserialize: false)
	int preBetOrder  = 0; // 一直是0，串关没有预约


	BetResultSeriesOrderRespList();

	factory BetResultSeriesOrderRespList.fromJson(Map<String, dynamic> json) => $BetResultSeriesOrderRespListFromJson(json);

	Map<String, dynamic> toJson() => $BetResultSeriesOrderRespListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}