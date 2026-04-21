import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_menus_entity.dart';

VrMenusEntity $VrMenusEntityFromJson(Map<String, dynamic> json) {
  final VrMenusEntity vrMenusEntity = VrMenusEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    vrMenusEntity.code = code;
  }
  final List<VrMenusData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<VrMenusData>(e) as VrMenusData).toList();
  if (data != null) {
    vrMenusEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    vrMenusEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    vrMenusEntity.ts = ts;
  }
  return vrMenusEntity;
}

Map<String, dynamic> $VrMenusEntityToJson(VrMenusEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension VrMenusEntityExtension on VrMenusEntity {
  VrMenusEntity copyWith({
    String? code,
    List<VrMenusData>? data,
    String? msg,
    int? ts,
  }) {
    return VrMenusEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

VrMenusData $VrMenusDataFromJson(Map<String, dynamic> json) {
  final VrMenusData vrMenusData = VrMenusData();
  final dynamic count = json['count'];
  if (count != null) {
    vrMenusData.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    vrMenusData.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    vrMenusData.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    vrMenusData.field3 = field3;
  }
  final String? field4 = jsonConvert.convert<String>(json['field4']);
  if (field4 != null) {
    vrMenusData.field4 = field4;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    vrMenusData.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    vrMenusData.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    vrMenusData.name = name;
  }
  final List<VrMenusDataSubList>? subList = (json['subList'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<VrMenusDataSubList>(e) as VrMenusDataSubList)
      .toList();
  if (subList != null) {
    vrMenusData.subList = subList;
  }
  return vrMenusData;
}

Map<String, dynamic> $VrMenusDataToJson(VrMenusData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['field1'] = entity.field1;
  data['field2'] = entity.field2;
  data['field3'] = entity.field3;
  data['field4'] = entity.field4;
  data['menuId'] = entity.menuId;
  data['menuType'] = entity.menuType;
  data['name'] = entity.name;
  data['subList'] = entity.subList.map((v) => v.toJson()).toList();
  return data;
}

extension VrMenusDataExtension on VrMenusData {
  VrMenusData copyWith({
    dynamic count,
    String? field1,
    String? field2,
    String? field3,
    String? field4,
    String? menuId,
    dynamic menuType,
    String? name,
    List<VrMenusDataSubList>? subList,
  }) {
    return VrMenusData()
      ..count = count ?? this.count
      ..field1 = field1 ?? this.field1
      ..field2 = field2 ?? this.field2
      ..field3 = field3 ?? this.field3
      ..field4 = field4 ?? this.field4
      ..menuId = menuId ?? this.menuId
      ..menuType = menuType ?? this.menuType
      ..name = name ?? this.name
      ..subList = subList ?? this.subList;
  }
}

VrMenusDataSubList $VrMenusDataSubListFromJson(Map<String, dynamic> json) {
  final VrMenusDataSubList vrMenusDataSubList = VrMenusDataSubList();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    vrMenusDataSubList.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    vrMenusDataSubList.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    vrMenusDataSubList.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    vrMenusDataSubList.field3 = field3;
  }
  final String? field4 = jsonConvert.convert<String>(json['field4']);
  if (field4 != null) {
    vrMenusDataSubList.field4 = field4;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    vrMenusDataSubList.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    vrMenusDataSubList.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    vrMenusDataSubList.name = name;
  }
  final dynamic subList = json['subList'];
  if (subList != null) {
    vrMenusDataSubList.subList = subList;
  }
  return vrMenusDataSubList;
}

Map<String, dynamic> $VrMenusDataSubListToJson(VrMenusDataSubList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['field1'] = entity.field1;
  data['field2'] = entity.field2;
  data['field3'] = entity.field3;
  data['field4'] = entity.field4;
  data['menuId'] = entity.menuId;
  data['menuType'] = entity.menuType;
  data['name'] = entity.name;
  data['subList'] = entity.subList;
  return data;
}

extension VrMenusDataSubListExtension on VrMenusDataSubList {
  VrMenusDataSubList copyWith({
    int? count,
    String? field1,
    String? field2,
    String? field3,
    String? field4,
    String? menuId,
    dynamic menuType,
    String? name,
    dynamic subList,
  }) {
    return VrMenusDataSubList()
      ..count = count ?? this.count
      ..field1 = field1 ?? this.field1
      ..field2 = field2 ?? this.field2
      ..field3 = field3 ?? this.field3
      ..field4 = field4 ?? this.field4
      ..menuId = menuId ?? this.menuId
      ..menuType = menuType ?? this.menuType
      ..name = name ?? this.name
      ..subList = subList ?? this.subList;
  }
}