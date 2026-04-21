import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_user_personalise_new_entity.dart';

GetUserPersonaliseNewEntity $GetUserPersonaliseNewEntityFromJson(
    Map<String, dynamic> json) {
  final GetUserPersonaliseNewEntity getUserPersonaliseNewEntity = GetUserPersonaliseNewEntity();
  final int? uid = jsonConvert.convert<int>(json['uid']);
  if (uid != null) {
    getUserPersonaliseNewEntity.uid = uid;
  }
  final List<
      GetUserPersonaliseNewUserPersonaliseNewList>? userPersonaliseNewList = (json['userPersonaliseNewList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetUserPersonaliseNewUserPersonaliseNewList>(
          e) as GetUserPersonaliseNewUserPersonaliseNewList).toList();
  if (userPersonaliseNewList != null) {
    getUserPersonaliseNewEntity.userPersonaliseNewList = userPersonaliseNewList;
  }
  return getUserPersonaliseNewEntity;
}

Map<String, dynamic> $GetUserPersonaliseNewEntityToJson(
    GetUserPersonaliseNewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['uid'] = entity.uid;
  data['userPersonaliseNewList'] =
      entity.userPersonaliseNewList?.map((v) => v.toJson()).toList();
  return data;
}

extension GetUserPersonaliseNewEntityExtension on GetUserPersonaliseNewEntity {
  GetUserPersonaliseNewEntity copyWith({
    int? uid,
    List<GetUserPersonaliseNewUserPersonaliseNewList>? userPersonaliseNewList,
  }) {
    return GetUserPersonaliseNewEntity()
      ..uid = uid ?? this.uid
      ..userPersonaliseNewList = userPersonaliseNewList ??
          this.userPersonaliseNewList;
  }
}

GetUserPersonaliseNewUserPersonaliseNewList $GetUserPersonaliseNewUserPersonaliseNewListFromJson(
    Map<String, dynamic> json) {
  final GetUserPersonaliseNewUserPersonaliseNewList getUserPersonaliseNewUserPersonaliseNewList = GetUserPersonaliseNewUserPersonaliseNewList();
  final int? uid = jsonConvert.convert<int>(json['uid']);
  if (uid != null) {
    getUserPersonaliseNewUserPersonaliseNewList.uid = uid;
  }
  final String? paramKey = jsonConvert.convert<String>(json['paramKey']);
  if (paramKey != null) {
    getUserPersonaliseNewUserPersonaliseNewList.paramKey = paramKey;
  }
  final String? paramValue = jsonConvert.convert<String>(json['paramValue']);
  if (paramValue != null) {
    getUserPersonaliseNewUserPersonaliseNewList.paramValue = paramValue;
  }
  final String? cp = jsonConvert.convert<String>(json['cp']);
  if (cp != null) {
    getUserPersonaliseNewUserPersonaliseNewList.cp = cp;
  }
  return getUserPersonaliseNewUserPersonaliseNewList;
}

Map<String, dynamic> $GetUserPersonaliseNewUserPersonaliseNewListToJson(
    GetUserPersonaliseNewUserPersonaliseNewList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['uid'] = entity.uid;
  data['paramKey'] = entity.paramKey;
  data['paramValue'] = entity.paramValue;
  data['cp'] = entity.cp;
  return data;
}

extension GetUserPersonaliseNewUserPersonaliseNewListExtension on GetUserPersonaliseNewUserPersonaliseNewList {
  GetUserPersonaliseNewUserPersonaliseNewList copyWith({
    int? uid,
    String? paramKey,
    String? paramValue,
    String? cp,
  }) {
    return GetUserPersonaliseNewUserPersonaliseNewList()
      ..uid = uid ?? this.uid
      ..paramKey = paramKey ?? this.paramKey
      ..paramValue = paramValue ?? this.paramValue
      ..cp = cp ?? this.cp;
  }
}