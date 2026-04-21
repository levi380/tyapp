import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_user_info_zr_entity.dart';

GetUserInfoZrEntity $GetUserInfoZrEntityFromJson(Map<String, dynamic> json) {
  final GetUserInfoZrEntity getUserInfoZrEntity = GetUserInfoZrEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    getUserInfoZrEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getUserInfoZrEntity.message = message;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getUserInfoZrEntity.code = code;
  }
  final GetUserInfoZrData? data = jsonConvert.convert<GetUserInfoZrData>(
      json['data']);
  if (data != null) {
    getUserInfoZrEntity.data = data;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    getUserInfoZrEntity.serverTime = serverTime;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getUserInfoZrEntity.msg = msg;
  }
  return getUserInfoZrEntity;
}

Map<String, dynamic> $GetUserInfoZrEntityToJson(GetUserInfoZrEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['serverTime'] = entity.serverTime;
  data['msg'] = entity.msg;
  return data;
}

extension GetUserInfoZrEntityExtension on GetUserInfoZrEntity {
  GetUserInfoZrEntity copyWith({
    bool? status,
    String? message,
    String? code,
    GetUserInfoZrData? data,
    int? serverTime,
    String? msg,
  }) {
    return GetUserInfoZrEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..serverTime = serverTime ?? this.serverTime
      ..msg = msg ?? this.msg;
  }
}

GetUserInfoZrData $GetUserInfoZrDataFromJson(Map<String, dynamic> json) {
  final GetUserInfoZrData getUserInfoZrData = GetUserInfoZrData();
  final String? timestamp = jsonConvert.convert<String>(json['timestamp']);
  if (timestamp != null) {
    getUserInfoZrData.timestamp = timestamp;
  }
  final String? loginName = jsonConvert.convert<String>(json['loginName']);
  if (loginName != null) {
    getUserInfoZrData.loginName = loginName;
  }
  final List<
      GetUserInfoZrDataPlayerSettingList>? playerSettingList = (json['playerSettingList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetUserInfoZrDataPlayerSettingList>(
          e) as GetUserInfoZrDataPlayerSettingList).toList();
  if (playerSettingList != null) {
    getUserInfoZrData.playerSettingList = playerSettingList;
  }
  return getUserInfoZrData;
}

Map<String, dynamic> $GetUserInfoZrDataToJson(GetUserInfoZrData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['timestamp'] = entity.timestamp;
  data['loginName'] = entity.loginName;
  data['playerSettingList'] =
      entity.playerSettingList.map((v) => v.toJson()).toList();
  return data;
}

extension GetUserInfoZrDataExtension on GetUserInfoZrData {
  GetUserInfoZrData copyWith({
    String? timestamp,
    String? loginName,
    List<GetUserInfoZrDataPlayerSettingList>? playerSettingList,
  }) {
    return GetUserInfoZrData()
      ..timestamp = timestamp ?? this.timestamp
      ..loginName = loginName ?? this.loginName
      ..playerSettingList = playerSettingList ?? this.playerSettingList;
  }
}

GetUserInfoZrDataPlayerSettingList $GetUserInfoZrDataPlayerSettingListFromJson(
    Map<String, dynamic> json) {
  final GetUserInfoZrDataPlayerSettingList getUserInfoZrDataPlayerSettingList = GetUserInfoZrDataPlayerSettingList();
  final dynamic timestamp = json['timestamp'];
  if (timestamp != null) {
    getUserInfoZrDataPlayerSettingList.timestamp = timestamp;
  }
  final dynamic loginName = json['loginName'];
  if (loginName != null) {
    getUserInfoZrDataPlayerSettingList.loginName = loginName;
  }
  final dynamic playerSettingList = json['playerSettingList'];
  if (playerSettingList != null) {
    getUserInfoZrDataPlayerSettingList.playerSettingList = playerSettingList;
  }
  final int? settingType = jsonConvert.convert<int>(json['settingType']);
  if (settingType != null) {
    getUserInfoZrDataPlayerSettingList.settingType = settingType;
  }
  final int? settingObject = jsonConvert.convert<int>(json['settingObject']);
  if (settingObject != null) {
    getUserInfoZrDataPlayerSettingList.settingObject = settingObject;
  }
  final int? deviceType = jsonConvert.convert<int>(json['deviceType']);
  if (deviceType != null) {
    getUserInfoZrDataPlayerSettingList.deviceType = deviceType;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    getUserInfoZrDataPlayerSettingList.value = value;
  }
  final int? playerId = jsonConvert.convert<int>(json['playerId']);
  if (playerId != null) {
    getUserInfoZrDataPlayerSettingList.playerId = playerId;
  }
  final String? defaultValue = jsonConvert.convert<String>(
      json['defaultValue']);
  if (defaultValue != null) {
    getUserInfoZrDataPlayerSettingList.defaultValue = defaultValue;
  }
  final bool? userDefault = jsonConvert.convert<bool>(json['userDefault']);
  if (userDefault != null) {
    getUserInfoZrDataPlayerSettingList.userDefault = userDefault;
  }
  return getUserInfoZrDataPlayerSettingList;
}

Map<String, dynamic> $GetUserInfoZrDataPlayerSettingListToJson(
    GetUserInfoZrDataPlayerSettingList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['timestamp'] = entity.timestamp;
  data['loginName'] = entity.loginName;
  data['playerSettingList'] = entity.playerSettingList;
  data['settingType'] = entity.settingType;
  data['settingObject'] = entity.settingObject;
  data['deviceType'] = entity.deviceType;
  data['value'] = entity.value;
  data['playerId'] = entity.playerId;
  data['defaultValue'] = entity.defaultValue;
  data['userDefault'] = entity.userDefault;
  return data;
}

extension GetUserInfoZrDataPlayerSettingListExtension on GetUserInfoZrDataPlayerSettingList {
  GetUserInfoZrDataPlayerSettingList copyWith({
    dynamic timestamp,
    dynamic loginName,
    dynamic playerSettingList,
    int? settingType,
    int? settingObject,
    int? deviceType,
    String? value,
    int? playerId,
    String? defaultValue,
    bool? userDefault,
  }) {
    return GetUserInfoZrDataPlayerSettingList()
      ..timestamp = timestamp ?? this.timestamp
      ..loginName = loginName ?? this.loginName
      ..playerSettingList = playerSettingList ?? this.playerSettingList
      ..settingType = settingType ?? this.settingType
      ..settingObject = settingObject ?? this.settingObject
      ..deviceType = deviceType ?? this.deviceType
      ..value = value ?? this.value
      ..playerId = playerId ?? this.playerId
      ..defaultValue = defaultValue ?? this.defaultValue
      ..userDefault = userDefault ?? this.userDefault;
  }
}