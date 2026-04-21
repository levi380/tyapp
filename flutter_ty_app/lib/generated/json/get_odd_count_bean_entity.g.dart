import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_odd_count_bean_entity.dart';

GetOddCountBeanEntity $GetOddCountBeanEntityFromJson(
    Map<String, dynamic> json) {
  final GetOddCountBeanEntity getOddCountBeanEntity = GetOddCountBeanEntity();
  final List<
      GetOddCountBeanStatInfoList>? statInfoList = (json['statInfoList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetOddCountBeanStatInfoList>(
          e) as GetOddCountBeanStatInfoList).toList();
  if (statInfoList != null) {
    getOddCountBeanEntity.statInfoList = statInfoList;
  }
  return getOddCountBeanEntity;
}

Map<String, dynamic> $GetOddCountBeanEntityToJson(
    GetOddCountBeanEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['statInfoList'] = entity.statInfoList?.map((v) => v.toJson()).toList();
  return data;
}

extension GetOddCountBeanEntityExtension on GetOddCountBeanEntity {
  GetOddCountBeanEntity copyWith({
    List<GetOddCountBeanStatInfoList>? statInfoList,
  }) {
    return GetOddCountBeanEntity()
      ..statInfoList = statInfoList ?? this.statInfoList;
  }
}

GetOddCountBeanStatInfoList $GetOddCountBeanStatInfoListFromJson(
    Map<String, dynamic> json) {
  final GetOddCountBeanStatInfoList getOddCountBeanStatInfoList = GetOddCountBeanStatInfoList();
  final int? orderCount = jsonConvert.convert<int>(json['orderCount']);
  if (orderCount != null) {
    getOddCountBeanStatInfoList.orderCount = orderCount;
  }
  final String? playOptionId = jsonConvert.convert<String>(
      json['playOptionId']);
  if (playOptionId != null) {
    getOddCountBeanStatInfoList.playOptionId = playOptionId;
  }
  final String? orderCountAlias = jsonConvert.convert<String>(
      json['orderCountAlias']);
  if (orderCountAlias != null) {
    getOddCountBeanStatInfoList.orderCountAlias = orderCountAlias;
  }
  return getOddCountBeanStatInfoList;
}

Map<String, dynamic> $GetOddCountBeanStatInfoListToJson(
    GetOddCountBeanStatInfoList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderCount'] = entity.orderCount;
  data['playOptionId'] = entity.playOptionId;
  data['orderCountAlias'] = entity.orderCountAlias;
  return data;
}

extension GetOddCountBeanStatInfoListExtension on GetOddCountBeanStatInfoList {
  GetOddCountBeanStatInfoList copyWith({
    int? orderCount,
    String? playOptionId,
    String? orderCountAlias,
  }) {
    return GetOddCountBeanStatInfoList()
      ..orderCount = orderCount ?? this.orderCount
      ..playOptionId = playOptionId ?? this.playOptionId
      ..orderCountAlias = orderCountAlias ?? this.orderCountAlias;
  }
}