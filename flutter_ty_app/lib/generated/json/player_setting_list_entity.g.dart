import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/player_setting_list_entity.dart';

PlayerSettingListEntity $PlayerSettingListEntityFromJson(
    Map<String, dynamic> json) {
  final PlayerSettingListEntity playerSettingListEntity = PlayerSettingListEntity();
  final List<
      PlayerSettingListPlayerSettingList>? playerSettingList = (json['playerSettingList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<PlayerSettingListPlayerSettingList>(
          e) as PlayerSettingListPlayerSettingList).toList();
  if (playerSettingList != null) {
    playerSettingListEntity.playerSettingList = playerSettingList;
  }
  final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
  if (timestamp != null) {
    playerSettingListEntity.timestamp = timestamp;
  }
  return playerSettingListEntity;
}

Map<String, dynamic> $PlayerSettingListEntityToJson(
    PlayerSettingListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['playerSettingList'] =
      entity.playerSettingList.map((v) => v.toJson()).toList();
  data['timestamp'] = entity.timestamp;
  return data;
}

extension PlayerSettingListEntityExtension on PlayerSettingListEntity {
  PlayerSettingListEntity copyWith({
    List<PlayerSettingListPlayerSettingList>? playerSettingList,
    int? timestamp,
  }) {
    return PlayerSettingListEntity()
      ..playerSettingList = playerSettingList ?? this.playerSettingList
      ..timestamp = timestamp ?? this.timestamp;
  }
}

PlayerSettingListPlayerSettingList $PlayerSettingListPlayerSettingListFromJson(
    Map<String, dynamic> json) {
  final PlayerSettingListPlayerSettingList playerSettingListPlayerSettingList = PlayerSettingListPlayerSettingList();
  final int? settingType = jsonConvert.convert<int>(json['settingType']);
  if (settingType != null) {
    playerSettingListPlayerSettingList.settingType = settingType;
  }
  final int? settingObject = jsonConvert.convert<int>(json['settingObject']);
  if (settingObject != null) {
    playerSettingListPlayerSettingList.settingObject = settingObject;
  }
  final int? deviceType = jsonConvert.convert<int>(json['deviceType']);
  if (deviceType != null) {
    playerSettingListPlayerSettingList.deviceType = deviceType;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    playerSettingListPlayerSettingList.value = value;
  }
  return playerSettingListPlayerSettingList;
}

Map<String, dynamic> $PlayerSettingListPlayerSettingListToJson(
    PlayerSettingListPlayerSettingList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['settingType'] = entity.settingType;
  data['settingObject'] = entity.settingObject;
  data['deviceType'] = entity.deviceType;
  data['value'] = entity.value;
  return data;
}

extension PlayerSettingListPlayerSettingListExtension on PlayerSettingListPlayerSettingList {
  PlayerSettingListPlayerSettingList copyWith({
    int? settingType,
    int? settingObject,
    int? deviceType,
    int? value,
  }) {
    return PlayerSettingListPlayerSettingList()
      ..settingType = settingType ?? this.settingType
      ..settingObject = settingObject ?? this.settingObject
      ..deviceType = deviceType ?? this.deviceType
      ..value = value ?? this.value;
  }
}