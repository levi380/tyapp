import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/bet_req.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/bet_req.g.dart';

@JsonSerializable()
class BetReq {
	int? useAcceptOdds;
	late int acceptOdds = 0;
	late int tenantId = 0;
	late int deviceType = 0;
	late String currencyCode = '';
	late String deviceImei = '';
	late String fpId = '';
	int? openMiltSingle ;
	int? preBet ;
	int? timeZone;
	String? fastBet;

	late List<BetReqSeriesOrders> seriesOrders = [];

	BetReq();

	factory BetReq.fromJson(Map<String, dynamic> json) => $BetReqFromJson(json);

	Map<String, dynamic> toJson() => $BetReqToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BetReqSeriesOrders {
	late int seriesSum = 0;
	late int seriesType = 0;
	late String seriesValues = '';
	late int fullBet = 0;
	late List<BetReqSeriesOrdersOrderDetailList> orderDetailList = [];

	BetReqSeriesOrders();

	factory BetReqSeriesOrders.fromJson(Map<String, dynamic> json) => $BetReqSeriesOrdersFromJson(json);

	Map<String, dynamic> toJson() => $BetReqSeriesOrdersToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

/*
因不支持 @JsonKey(ignore: true)
定义一个类来放不参与JsonSerializable的字段
 */
class BetReqSeriesOrdersOrderDetailSuper{
	String shopCartItemId = '';
	String handicapHv = '';
	String orgOddFinally = '';
	String vrNo = "";
}

@JsonSerializable()
class BetReqSeriesOrdersOrderDetailList extends BetReqSeriesOrdersOrderDetailSuper {
	late String sportId = '';
	late String matchId = '';
	late String tournamentId = '';
	late String scoreBenchmark = '';
	late String betAmount = '';
	late String placeNum = '';
	late String marketId = '';
	late String playOptionsId = '';
	late String marketTypeFinally = '';
	late String marketValue = '';
	late int odds = 0;
	late String oddFinally = '';
	late String playName = '';
	late String sportName = '';
	late int matchType = 0;
	late String matchName = '';
	late String playOptionName = '';
	late String playOptions = '';
	late int tournamentLevel = 0;
	late String playId = '';
	late String dataSource = '';
	late int excellentOddsBet = 0;

	BetReqSeriesOrdersOrderDetailList();

	factory BetReqSeriesOrdersOrderDetailList.fromJson(Map<String, dynamic> json) => $BetReqSeriesOrdersOrderDetailListFromJson(json);

	Map<String, dynamic> toJson() => $BetReqSeriesOrdersOrderDetailListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}