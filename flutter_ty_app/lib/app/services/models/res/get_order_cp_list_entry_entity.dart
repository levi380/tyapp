import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_order_cp_list_entry_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_order_cp_list_entry_entity.g.dart';

@JsonSerializable()
class GetOrderCpListEntryEntity {
	int? total = 0;
	double? totalBetAmount;
	double? totalValidBetAmount;
	double? totalWinAmount;
	double? totalCanWinAmount;
	List<GetOrderCpListEntryList>? list = [];

	GetOrderCpListEntryEntity();

	factory GetOrderCpListEntryEntity.fromJson(Map<String, dynamic> json) => $GetOrderCpListEntryEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderCpListEntryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderCpListEntryList {
	String? uid = '';
	String? orderId = '';
	String? playId = '';
	String? playItemId = '';
	int? ticketId = 0;
	String? playLevelId = '';
	String? ticketPlanNo = '';
	String? memberId = '';
	double? betMoney;
	int? validBetMoney = 0;
	String? betNum = '';
	int? seriesId = 0;
	String? seriesName = '';
	String? betTime = '';
	int? betNums = 0;
	int? betMultiple = 0;
	dynamic betPointId;
	double? betModel;
	double? betRebate;
	String? betPrize = '';
	String? odd = '';
	int? betStatus = 0;
	bool? cancelStatus = false;
	int? cancelType = 0;
	int? riskStatus = 0;
	String? riskUnlockBy = '';
	String? riskUnlockAt = '';
	String? ticketName = '';
	String? playLevel = '';
	String? playName = '';
	String? betContent = '';
	bool? singleGame = false;
	double? profitAmount;
	String? baseRate = '';
	String? bonusReduceRate = '';
	bool? directlyMode = false;
	double? memberRebate;
	String? ticketResult = '';
	double? winAmount;
	int? winNums = 0;
	bool? solo = false;
	String? chaseId = '';
	String? chasePlanId = '';
	int? groupMode = 0;
	int? device = 0;
	bool? seriesType = false;
	String? cancelBy = '';
	String? cancelAt = '';
	String? cancelDesc = '';
	bool? tester = false;
	int? currencyType = 0;
	bool? chaseOrder = false;
	int? updateTime = 0;
	int? createTime = 0;
	double? maxWinAmount;

	GetOrderCpListEntryList();

	factory GetOrderCpListEntryList.fromJson(Map<String, dynamic> json) => $GetOrderCpListEntryListFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderCpListEntryListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}