import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_pre_settle_order_detail_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_pre_settle_order_detail_entity.g.dart';

@JsonSerializable()
class GetPreSettleOrderDetailEntity {
	late String code;
	late List<GetPreSettleOrderDetailData> data;
	late String msg;
	late int ts;

	GetPreSettleOrderDetailEntity();

	factory GetPreSettleOrderDetailEntity.fromJson(Map<String, dynamic> json) => $GetPreSettleOrderDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetPreSettleOrderDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetPreSettleOrderDetailData {
	late String createTime;
	late String orderNo;
	late int orderStatus;
	late double preBetAmount;
	late String preOrderNo;
	late double profit;
	late double remainingBetAmount;
	late double settleAmount;
	late int settleType;
	late int type;

	GetPreSettleOrderDetailData();

	factory GetPreSettleOrderDetailData.fromJson(Map<String, dynamic> json) => $GetPreSettleOrderDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $GetPreSettleOrderDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}