import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/all_order_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/all_order_list_entity.g.dart';

@JsonSerializable()
class AllOrderListEntity {
	late List<AllOrderListList> list = [];
	late String total = '';

	AllOrderListEntity();

	factory AllOrderListEntity.fromJson(Map<String, dynamic> json) => $AllOrderListEntityFromJson(json);

	Map<String, dynamic> toJson() => $AllOrderListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AllOrderListList {
	late String betAmount = '';
	late String betTime = '';
	late String maxWinAmount = '';
	AllOrderListListOrderCashOutInVO? orderCashOutInVO;
	late List<AllOrderListListOrderMixExtendVOList> orderMixExtendVOList = [];
	late String orderNo = '';
	late int orderStatus = 0;
	late String orderType = '';
	late String seriesValue = '';

	AllOrderListList();

	factory AllOrderListList.fromJson(Map<String, dynamic> json) => $AllOrderListListFromJson(json);

	Map<String, dynamic> toJson() => $AllOrderListListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AllOrderListListOrderMixExtendVOList {
	late String marketType = '';
	late String marketValue = '';
	late String matchInfo = '';
	late String matchName = '';
	late int matchType = 0;
	late String matchId = '';
	late int playId = 0;
	late String playOptionsId = '';
	late String odds = '';
	late String playName = '';
	late String playOptions = '';
	late String scoreBenchmark = '';
	late int sportId = 0;
	late String sportName = '';
	late String betContent = '';
	late String ticketName = '';
	late String ticketPlanNo = '';
	late String startTicketPlanNo = '';
	late String tableName = '';
	late int totalWinAmount = 0;
	late int finishPlanNoCount = 0;
	late int cancelPlanNoCount = 0;
	late double finishAmount = 0.0;
	late int cancelWinAmount = 0;
	late String playLevel = "";
	late String gameName = "";
	late int winAmountPlanNoCount = 0;
	late String beginTime = "";
	late String eov = "";
	//目前接口并未返回此字段
	late String batchNo = "";

	AllOrderListListOrderMixExtendVOList();

	factory AllOrderListListOrderMixExtendVOList.fromJson(Map<String, dynamic> json) => $AllOrderListListOrderMixExtendVOListFromJson(json);

	Map<String, dynamic> toJson() => $AllOrderListListOrderMixExtendVOListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AllOrderListListOrderCashOutInVO {
	late bool enablePreSettle = false;
	late bool initPresettleWs = false;
	late double maxCashout = 0.0;
	late double preBetAmount = 0.0;
	late String preOrderNo = "";
	dynamic preSettle;
	late double preSettleBetAmount = 0.0;

	AllOrderListListOrderCashOutInVO();

	factory AllOrderListListOrderCashOutInVO.fromJson(Map<String, dynamic> json) => $AllOrderListListOrderCashOutInVOFromJson(json);

	Map<String, dynamic> toJson() => $AllOrderListListOrderCashOutInVOToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}