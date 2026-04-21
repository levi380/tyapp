import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_order_list_zr_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_order_list_zr_entity.g.dart';

@JsonSerializable()
class GetOrderListZrEntity {
	late bool status;
	late String message;
	late String code;
	late GetOrderListZrData data;
	late int serverTime;
	late String msg;

	GetOrderListZrEntity();

	factory GetOrderListZrEntity.fromJson(Map<String, dynamic> json) => $GetOrderListZrEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListZrEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListZrData {
	late int total;
	late int totalBetAmount;
	late int totalValidBetAmount;
	late int totalWinAmount;
	late int totalCanWinAmount;
	late List<GetOrderListZrDataList> list;

	GetOrderListZrData();

	factory GetOrderListZrData.fromJson(Map<String, dynamic> json) => $GetOrderListZrDataFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListZrDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOrderListZrDataList {
	late String roundNo;
	late String gameTypeId;
	late String gameTypeName;
	late String platformId;
	late String platformName;
	late String tableCode;
	late String tableName;
	late String betPointId;
	late String betPointName;
	late String betStatus;
	late int createTime;
	late int updateTime;
	late String betAmount;
	late String payAmount;
	late String netAmount;
	late String validBetAmount;
	dynamic videoPath;
	dynamic odds;
	dynamic judgeResult;
	late String roundResult;
	late String roundResult2;
	late int maxWinAmount = 0;

	/// 展开收缩状态
	@JSONField(serialize: false, deserialize: false)
	bool isExpand = true;

	GetOrderListZrDataList();

	factory GetOrderListZrDataList.fromJson(Map<String, dynamic> json) => $GetOrderListZrDataListFromJson(json);

	Map<String, dynamic> toJson() => $GetOrderListZrDataListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}