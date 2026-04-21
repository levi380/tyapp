import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/user_param_config_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/user_param_config_entity.g.dart';

@JsonSerializable()
class UserParamConfigEntity {
	late String createTime = '';
	late String createUser = '';
	late String id = '';
	late bool ifNullMerchantDefaultValue = false;
	late String modifyTime = '';
	late String modifyUser = '';
	late String paramKey = '';
	late String paramValue = '';
	late String shardUid = '';
	late String shardUserCreateDate = '';
	late String uid = '';
	dynamic userPO;

	UserParamConfigEntity();

	factory UserParamConfigEntity.fromJson(Map<String, dynamic> json) => $UserParamConfigEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserParamConfigEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}