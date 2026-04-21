import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_reserve_cashout_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_reserve_cashout_list_entity.g.dart';

@JsonSerializable()
class GetReserveCashoutListEntity {
	late String code;
	late List<GetReserveCashoutListData> data;
	late String msg;
	late int ts;

	GetReserveCashoutListEntity();

	factory GetReserveCashoutListEntity.fromJson(Map<String, dynamic> json) => $GetReserveCashoutListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetReserveCashoutListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetReserveCashoutListData {
	late String orderNo;
	late String reserveCashOutAmount;
	late String reserveCashOutNo;
	late int reserveStatus;

	GetReserveCashoutListData();

	factory GetReserveCashoutListData.fromJson(Map<String, dynamic> json) => $GetReserveCashoutListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetReserveCashoutListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}