import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/save_user_info_zr_entity.dart';

SaveUserInfoZrEntity $SaveUserInfoZrEntityFromJson(Map<String, dynamic> json) {
  final SaveUserInfoZrEntity saveUserInfoZrEntity = SaveUserInfoZrEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    saveUserInfoZrEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    saveUserInfoZrEntity.message = message;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    saveUserInfoZrEntity.code = code;
  }
  final SaveUserInfoZrData? data = jsonConvert.convert<SaveUserInfoZrData>(
      json['data']);
  if (data != null) {
    saveUserInfoZrEntity.data = data;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    saveUserInfoZrEntity.serverTime = serverTime;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    saveUserInfoZrEntity.msg = msg;
  }
  return saveUserInfoZrEntity;
}

Map<String, dynamic> $SaveUserInfoZrEntityToJson(SaveUserInfoZrEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['serverTime'] = entity.serverTime;
  data['msg'] = entity.msg;
  return data;
}

extension SaveUserInfoZrEntityExtension on SaveUserInfoZrEntity {
  SaveUserInfoZrEntity copyWith({
    bool? status,
    String? message,
    String? code,
    SaveUserInfoZrData? data,
    int? serverTime,
    String? msg,
  }) {
    return SaveUserInfoZrEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..serverTime = serverTime ?? this.serverTime
      ..msg = msg ?? this.msg;
  }
}

SaveUserInfoZrData $SaveUserInfoZrDataFromJson(Map<String, dynamic> json) {
  final SaveUserInfoZrData saveUserInfoZrData = SaveUserInfoZrData();
  final String? timestamp = jsonConvert.convert<String>(json['timestamp']);
  if (timestamp != null) {
    saveUserInfoZrData.timestamp = timestamp;
  }
  final String? loginName = jsonConvert.convert<String>(json['loginName']);
  if (loginName != null) {
    saveUserInfoZrData.loginName = loginName;
  }
  final List<
      SaveUserInfoZrDataPlayerSettingList>? playerSettingList = (json['playerSettingList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SaveUserInfoZrDataPlayerSettingList>(
          e) as SaveUserInfoZrDataPlayerSettingList).toList();
  if (playerSettingList != null) {
    saveUserInfoZrData.playerSettingList = playerSettingList;
  }
  return saveUserInfoZrData;
}

Map<String, dynamic> $SaveUserInfoZrDataToJson(SaveUserInfoZrData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['timestamp'] = entity.timestamp;
  data['loginName'] = entity.loginName;
  data['playerSettingList'] =
      entity.playerSettingList.map((v) => v.toJson()).toList();
  return data;
}

extension SaveUserInfoZrDataExtension on SaveUserInfoZrData {
  SaveUserInfoZrData copyWith({
    String? timestamp,
    String? loginName,
    List<SaveUserInfoZrDataPlayerSettingList>? playerSettingList,
  }) {
    return SaveUserInfoZrData()
      ..timestamp = timestamp ?? this.timestamp
      ..loginName = loginName ?? this.loginName
      ..playerSettingList = playerSettingList ?? this.playerSettingList;
  }
}

SaveUserInfoZrDataPlayerSettingList $SaveUserInfoZrDataPlayerSettingListFromJson(
    Map<String, dynamic> json) {
  final SaveUserInfoZrDataPlayerSettingList saveUserInfoZrDataPlayerSettingList = SaveUserInfoZrDataPlayerSettingList();
  final dynamic timestamp = json['timestamp'];
  if (timestamp != null) {
    saveUserInfoZrDataPlayerSettingList.timestamp = timestamp;
  }
  final dynamic loginName = json['loginName'];
  if (loginName != null) {
    saveUserInfoZrDataPlayerSettingList.loginName = loginName;
  }
  final dynamic playerSettingList = json['playerSettingList'];
  if (playerSettingList != null) {
    saveUserInfoZrDataPlayerSettingList.playerSettingList = playerSettingList;
  }
  final String? settingType = jsonConvert.convert<String>(json['settingType']);
  if (settingType != null) {
    saveUserInfoZrDataPlayerSettingList.settingType = settingType;
  }
  final String? settingObject = jsonConvert.convert<String>(
      json['settingObject']);
  if (settingObject != null) {
    saveUserInfoZrDataPlayerSettingList.settingObject = settingObject;
  }
  final int? deviceType = jsonConvert.convert<int>(json['deviceType']);
  if (deviceType != null) {
    saveUserInfoZrDataPlayerSettingList.deviceType = deviceType;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    saveUserInfoZrDataPlayerSettingList.value = value;
  }
  final dynamic playerId = json['playerId'];
  if (playerId != null) {
    saveUserInfoZrDataPlayerSettingList.playerId = playerId;
  }
  final dynamic defaultValue = json['defaultValue'];
  if (defaultValue != null) {
    saveUserInfoZrDataPlayerSettingList.defaultValue = defaultValue;
  }
  final bool? userDefault = jsonConvert.convert<bool>(json['userDefault']);
  if (userDefault != null) {
    saveUserInfoZrDataPlayerSettingList.userDefault = userDefault;
  }
  return saveUserInfoZrDataPlayerSettingList;
}

Map<String, dynamic> $SaveUserInfoZrDataPlayerSettingListToJson(
    SaveUserInfoZrDataPlayerSettingList entity) {
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

extension SaveUserInfoZrDataPlayerSettingListExtension on SaveUserInfoZrDataPlayerSettingList {
  SaveUserInfoZrDataPlayerSettingList copyWith({
    dynamic timestamp,
    dynamic loginName,
    dynamic playerSettingList,
    String? settingType,
    String? settingObject,
    int? deviceType,
    String? value,
    dynamic playerId,
    dynamic defaultValue,
    bool? userDefault,
  }) {
    return SaveUserInfoZrDataPlayerSettingList()
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