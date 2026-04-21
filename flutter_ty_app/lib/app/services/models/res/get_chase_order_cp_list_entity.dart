import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_chase_order_cp_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_chase_order_cp_list_entity.g.dart';

@JsonSerializable()
class GetChaseOrderCpListEntity {
	late bool status;
	late String message;
	late String code;
	late GetChaseOrderCpListData data;
	late int serverTime;
	late String msg;

	GetChaseOrderCpListEntity();

	factory GetChaseOrderCpListEntity.fromJson(Map<String, dynamic> json) => $GetChaseOrderCpListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetChaseOrderCpListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetChaseOrderCpListData {
	late int total;
	late double totalBetAmount;
	late double totalValidBetAmount;
	late int totalWinAmount;
	dynamic totalCanWinAmount;
	late List<GetChaseOrderCpListDataList> list;

	GetChaseOrderCpListData();

	factory GetChaseOrderCpListData.fromJson(Map<String, dynamic> json) => $GetChaseOrderCpListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetChaseOrderCpListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetChaseOrderCpListDataList {
	late String uid;
	late String chaseId;
	late String chasePlanId;
	late String ticketName;
	late String startTicketPlanNo;
	late String playLevel;
	late String odd;
	late int totalPlanNoCount;
	late int winAmountPlanNoCount;
	late int finishPlanNoCount;
	late int cancelPlanNoCount;
	late double totalBetAmount;
	late double totalValidBetAmount;
	late int totalWinAmount;
	late double finishAmount;
	late int cancelWinAmount;
	late int chaseOrderStatus;
	late int createTime;
	late String betTime;
	late String betContent;

	GetChaseOrderCpListDataList();

	factory GetChaseOrderCpListDataList.fromJson(Map<String, dynamic> json) => $GetChaseOrderCpListDataListFromJson(json);

	Map<String, dynamic> toJson() => $GetChaseOrderCpListDataListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}