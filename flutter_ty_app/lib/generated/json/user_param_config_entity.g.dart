import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/user_param_config_entity.dart';

UserParamConfigEntity $UserParamConfigEntityFromJson(
    Map<String, dynamic> json) {
  final UserParamConfigEntity userParamConfigEntity = UserParamConfigEntity();
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    userParamConfigEntity.createTime = createTime;
  }
  final String? createUser = jsonConvert.convert<String>(json['createUser']);
  if (createUser != null) {
    userParamConfigEntity.createUser = createUser;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userParamConfigEntity.id = id;
  }
  final bool? ifNullMerchantDefaultValue = jsonConvert.convert<bool>(
      json['ifNullMerchantDefaultValue']);
  if (ifNullMerchantDefaultValue != null) {
    userParamConfigEntity.ifNullMerchantDefaultValue =
        ifNullMerchantDefaultValue;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    userParamConfigEntity.modifyTime = modifyTime;
  }
  final String? modifyUser = jsonConvert.convert<String>(json['modifyUser']);
  if (modifyUser != null) {
    userParamConfigEntity.modifyUser = modifyUser;
  }
  final String? paramKey = jsonConvert.convert<String>(json['paramKey']);
  if (paramKey != null) {
    userParamConfigEntity.paramKey = paramKey;
  }
  final String? paramValue = jsonConvert.convert<String>(json['paramValue']);
  if (paramValue != null) {
    userParamConfigEntity.paramValue = paramValue;
  }
  final String? shardUid = jsonConvert.convert<String>(json['shardUid']);
  if (shardUid != null) {
    userParamConfigEntity.shardUid = shardUid;
  }
  final String? shardUserCreateDate = jsonConvert.convert<String>(
      json['shardUserCreateDate']);
  if (shardUserCreateDate != null) {
    userParamConfigEntity.shardUserCreateDate = shardUserCreateDate;
  }
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    userParamConfigEntity.uid = uid;
  }
  final dynamic userPO = json['userPO'];
  if (userPO != null) {
    userParamConfigEntity.userPO = userPO;
  }
  return userParamConfigEntity;
}

Map<String, dynamic> $UserParamConfigEntityToJson(
    UserParamConfigEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createTime'] = entity.createTime;
  data['createUser'] = entity.createUser;
  data['id'] = entity.id;
  data['ifNullMerchantDefaultValue'] = entity.ifNullMerchantDefaultValue;
  data['modifyTime'] = entity.modifyTime;
  data['modifyUser'] = entity.modifyUser;
  data['paramKey'] = entity.paramKey;
  data['paramValue'] = entity.paramValue;
  data['shardUid'] = entity.shardUid;
  data['shardUserCreateDate'] = entity.shardUserCreateDate;
  data['uid'] = entity.uid;
  data['userPO'] = entity.userPO;
  return data;
}

extension UserParamConfigEntityExtension on UserParamConfigEntity {
  UserParamConfigEntity copyWith({
    String? createTime,
    String? createUser,
    String? id,
    bool? ifNullMerchantDefaultValue,
    String? modifyTime,
    String? modifyUser,
    String? paramKey,
    String? paramValue,
    String? shardUid,
    String? shardUserCreateDate,
    String? uid,
    dynamic userPO,
  }) {
    return UserParamConfigEntity()
      ..createTime = createTime ?? this.createTime
      ..createUser = createUser ?? this.createUser
      ..id = id ?? this.id
      ..ifNullMerchantDefaultValue = ifNullMerchantDefaultValue ??
          this.ifNullMerchantDefaultValue
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyUser = modifyUser ?? this.modifyUser
      ..paramKey = paramKey ?? this.paramKey
      ..paramValue = paramValue ?? this.paramValue
      ..shardUid = shardUid ?? this.shardUid
      ..shardUserCreateDate = shardUserCreateDate ?? this.shardUserCreateDate
      ..uid = uid ?? this.uid
      ..userPO = userPO ?? this.userPO;
  }
}