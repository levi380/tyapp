import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_odd_count_bean_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_odd_count_bean_entity.g.dart';

@JsonSerializable()
class GetOddCountBeanEntity {
	List<GetOddCountBeanStatInfoList>? statInfoList = [];

	GetOddCountBeanEntity();

	factory GetOddCountBeanEntity.fromJson(Map<String, dynamic> json) => $GetOddCountBeanEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetOddCountBeanEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetOddCountBeanStatInfoList {
	int? orderCount = 0;
	String? playOptionId = '';
	String? orderCountAlias = "0";
	GetOddCountBeanStatInfoList();

	factory GetOddCountBeanStatInfoList.fromJson(Map<String, dynamic> json) => $GetOddCountBeanStatInfoListFromJson(json);

	Map<String, dynamic> toJson() => $GetOddCountBeanStatInfoListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}