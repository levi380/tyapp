import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/zr_order_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/zr_order_list_entity.g.dart';

@JsonSerializable()
class ZrOrderListEntity {
	late int total;
	late double totalBetAmount;
	late double totalValidBetAmount;
	late double totalWinAmount;
	late double totalCanWinAmount;
	late List<ZrOrderListList> list;

	ZrOrderListEntity();

	factory ZrOrderListEntity.fromJson(Map<String, dynamic> json) => $ZrOrderListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ZrOrderListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ZrOrderListList {
	dynamic uid;
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
	late String odds;
	late String judgeResult;
	late String roundResult;
	late String roundResult2;
	dynamic maxWinAmount;

	ZrOrderListList();

	factory ZrOrderListList.fromJson(Map<String, dynamic> json) => $ZrOrderListListFromJson(json);

	Map<String, dynamic> toJson() => $ZrOrderListListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}