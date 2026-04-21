import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/cp_order_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/cp_order_list_entity.g.dart';

@JsonSerializable()
class CpOrderListEntity {
  late double total = 0;
  late double totalBetAmount = 0;
  late double totalValidBetAmount = 0;
  late double totalWinAmount = 0;
  dynamic totalCanWinAmount;
  late List<CpOrderListList> list = [];

  CpOrderListEntity();

	factory CpOrderListEntity.fromJson(Map<String, dynamic> json) => $CpOrderListEntityFromJson(json);

	Map<String, dynamic> toJson() => $CpOrderListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CpOrderListList {
  late String chaseId = ""; // 追号注单号
  late String orderId = ""; // 注单号
  late String chasePlanId = "";
  late int chaseOrderStatus = 0;
  late double finishAmount = 0.0;
  late int totalPlanNoCount = 0;
  late String startTicketPlanNo = "";
  late String ticketPlanNo = "";
  late double totalWinAmount = 0;
  late String type = "";
  late String odd = "";
  late String uid = "";
  late int finishPlanNoCount = 0;
  late int createTime = 0;
  late String playLevel = "";
  late int cancelPlanNoCount = 0;
  late double totalValidBetAmount = 0.0;
  late String betTime = "";
  late double cancelWinAmount = 0;
  late int winAmountPlanNoCount = 0;
  late int betStatus = 0;
  late double totalBetAmount = 0.0;
  late double betMoney = 0.0; // 未开奖投注额
  late double maxWinAmount = 0.0; // 可赢额
  late String betContent = "";
  late String ticketName = "";
  late String playName = "";

  /// 展开收缩状态
  @JSONField(serialize: false, deserialize: false)
  bool isExpand = true;

  CpOrderListList();

	factory CpOrderListList.fromJson(Map<String, dynamic> json) => $CpOrderListListFromJson(json);

	Map<String, dynamic> toJson() => $CpOrderListListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}