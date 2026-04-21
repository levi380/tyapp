import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/fireworks_activity_entity.dart';

FireworksActivityEntity $FireworksActivityEntityFromJson(
    Map<String, dynamic> json) {
  final FireworksActivityEntity fireworksActivityEntity = FireworksActivityEntity();
  final int? activityStatus = jsonConvert.convert<int>(json['activityStatus']);
  if (activityStatus != null) {
    fireworksActivityEntity.activityStatus = activityStatus;
  }
  final String? activityTitle = jsonConvert.convert<String>(
      json['activityTitle']);
  if (activityTitle != null) {
    fireworksActivityEntity.activityTitle = activityTitle;
  }
  final int? activityType = jsonConvert.convert<int>(json['activityType']);
  if (activityType != null) {
    fireworksActivityEntity.activityType = activityType;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    fireworksActivityEntity.beginTime = beginTime;
  }
  final dynamic codeList = json['codeList'];
  if (codeList != null) {
    fireworksActivityEntity.codeList = codeList;
  }
  final String? createBy = jsonConvert.convert<String>(json['createBy']);
  if (createBy != null) {
    fireworksActivityEntity.createBy = createBy;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    fireworksActivityEntity.createTime = createTime;
  }
  final String? deviceType = jsonConvert.convert<String>(json['deviceType']);
  if (deviceType != null) {
    fireworksActivityEntity.deviceType = deviceType;
  }
  final dynamic deviceTypeList = json['deviceTypeList'];
  if (deviceTypeList != null) {
    fireworksActivityEntity.deviceTypeList = deviceTypeList;
  }
  final String? endTime = jsonConvert.convert<String>(json['endTime']);
  if (endTime != null) {
    fireworksActivityEntity.endTime = endTime;
  }
  final int? fireworksType = jsonConvert.convert<int>(json['fireworksType']);
  if (fireworksType != null) {
    fireworksActivityEntity.fireworksType = fireworksType;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    fireworksActivityEntity.id = id;
  }
  final List<
      FireworksActivityLanguageReqList>? languageVOList = (json['languageVOList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FireworksActivityLanguageReqList>(
          e) as FireworksActivityLanguageReqList).toList();
  if (languageVOList != null) {
    fireworksActivityEntity.languageVOList = languageVOList;
  }
  final String? logo = jsonConvert.convert<String>(json['logo']);
  if (logo != null) {
    fireworksActivityEntity.logo = logo;
  }
  final String? merchantCode = jsonConvert.convert<String>(
      json['merchantCode']);
  if (merchantCode != null) {
    fireworksActivityEntity.merchantCode = merchantCode;
  }
  final int? playType = jsonConvert.convert<int>(json['playType']);
  if (playType != null) {
    fireworksActivityEntity.playType = playType;
  }
  final String? updateBy = jsonConvert.convert<String>(json['updateBy']);
  if (updateBy != null) {
    fireworksActivityEntity.updateBy = updateBy;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    fireworksActivityEntity.updateTime = updateTime;
  }
  return fireworksActivityEntity;
}

Map<String, dynamic> $FireworksActivityEntityToJson(
    FireworksActivityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['activityStatus'] = entity.activityStatus;
  data['activityTitle'] = entity.activityTitle;
  data['activityType'] = entity.activityType;
  data['beginTime'] = entity.beginTime;
  data['codeList'] = entity.codeList;
  data['createBy'] = entity.createBy;
  data['createTime'] = entity.createTime;
  data['deviceType'] = entity.deviceType;
  data['deviceTypeList'] = entity.deviceTypeList;
  data['endTime'] = entity.endTime;
  data['fireworksType'] = entity.fireworksType;
  data['id'] = entity.id;
  data['languageVOList'] =
      entity.languageVOList.map((v) => v.toJson()).toList();
  data['logo'] = entity.logo;
  data['merchantCode'] = entity.merchantCode;
  data['playType'] = entity.playType;
  data['updateBy'] = entity.updateBy;
  data['updateTime'] = entity.updateTime;
  return data;
}

extension FireworksActivityEntityExtension on FireworksActivityEntity {
  FireworksActivityEntity copyWith({
    int? activityStatus,
    String? activityTitle,
    int? activityType,
    String? beginTime,
    dynamic codeList,
    String? createBy,
    String? createTime,
    String? deviceType,
    dynamic deviceTypeList,
    String? endTime,
    int? fireworksType,
    String? id,
    List<FireworksActivityLanguageReqList>? languageVOList,
    String? logo,
    String? merchantCode,
    int? playType,
    String? updateBy,
    String? updateTime,
  }) {
    return FireworksActivityEntity()
      ..activityStatus = activityStatus ?? this.activityStatus
      ..activityTitle = activityTitle ?? this.activityTitle
      ..activityType = activityType ?? this.activityType
      ..beginTime = beginTime ?? this.beginTime
      ..codeList = codeList ?? this.codeList
      ..createBy = createBy ?? this.createBy
      ..createTime = createTime ?? this.createTime
      ..deviceType = deviceType ?? this.deviceType
      ..deviceTypeList = deviceTypeList ?? this.deviceTypeList
      ..endTime = endTime ?? this.endTime
      ..fireworksType = fireworksType ?? this.fireworksType
      ..id = id ?? this.id
      ..languageVOList = languageVOList ?? this.languageVOList
      ..logo = logo ?? this.logo
      ..merchantCode = merchantCode ?? this.merchantCode
      ..playType = playType ?? this.playType
      ..updateBy = updateBy ?? this.updateBy
      ..updateTime = updateTime ?? this.updateTime;
  }
}

FireworksActivityLanguageReqList $FireworksActivityLanguageReqListFromJson(
    Map<String, dynamic> json) {
  final FireworksActivityLanguageReqList fireworksActivityLanguageReqList = FireworksActivityLanguageReqList();
  final String? languageType = jsonConvert.convert<String>(
      json['languageType']);
  if (languageType != null) {
    fireworksActivityLanguageReqList.languageType = languageType;
  }
  final String? copyDesc = jsonConvert.convert<String>(json['copyDesc']);
  if (copyDesc != null) {
    fireworksActivityLanguageReqList.copyDesc = copyDesc;
  }
  return fireworksActivityLanguageReqList;
}

Map<String, dynamic> $FireworksActivityLanguageReqListToJson(
    FireworksActivityLanguageReqList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['languageType'] = entity.languageType;
  data['copyDesc'] = entity.copyDesc;
  return data;
}

extension FireworksActivityLanguageReqListExtension on FireworksActivityLanguageReqList {
  FireworksActivityLanguageReqList copyWith({
    String? languageType,
    String? copyDesc,
  }) {
    return FireworksActivityLanguageReqList()
      ..languageType = languageType ?? this.languageType
      ..copyDesc = copyDesc ?? this.copyDesc;
  }
}