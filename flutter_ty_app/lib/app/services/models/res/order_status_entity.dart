import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/order_status_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/order_status_entity.g.dart';

@JsonSerializable()
class OrderStatusEntity {
	late String betNo = '';
	dynamic betTime;
	dynamic ctsOrder;
	late String currentEvent = '';
	late String exception = '';
	dynamic ftsOrder;
	dynamic handleTime;
	dynamic infoCode;
	late String infoMsg = '';
	dynamic infoStatus;
	late bool isOddsChange = false;
	late int isSeries = 0;
	dynamic mtsIsCache;
	late double newMaxWinAmount;
	late int newProcessOrder = 0;
	dynamic noSettleOrderSum;
	dynamic oddsChange;
	dynamic oddsChange2;
	late List<OrderStatusOddsChangeList> oddsChangeList = [];
	dynamic oddsRange;
	dynamic operationUserId;
	late String orderGroup = '';
	late String orderNo = '';
	dynamic reTryCount;
	late String refuseCode = '';
	late String remark = '';
	dynamic sendBssMqTime;
	late int sendTimes = 0;
	late String sendWSTime = '';
	late int status = 0;
	dynamic transferMode;
	late int tryNewProcessBet = 0;
	late String userId = '';
	dynamic varOrder;

	OrderStatusEntity();

	factory OrderStatusEntity.fromJson(Map<String, dynamic> json) => $OrderStatusEntityFromJson(json);

	Map<String, dynamic> toJson() => $OrderStatusEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderStatusOddsChangeList {
	late String betNo = '';
	late String playOptionsId = '';
	late String requestedOdds = '';
	late String riskEvent = '';
	late String usedOdds = '';

	OrderStatusOddsChangeList();

	factory OrderStatusOddsChangeList.fromJson(Map<String, dynamic> json) => $OrderStatusOddsChangeListFromJson(json);

	Map<String, dynamic> toJson() => $OrderStatusOddsChangeListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}