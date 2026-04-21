import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/virtual_menus_entity.dart';

VirtualMenusEntity $VirtualMenusEntityFromJson(Map<String, dynamic> json) {
  final VirtualMenusEntity virtualMenusEntity = VirtualMenusEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    virtualMenusEntity.code = code;
  }
  final List<VirtualMenusData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<VirtualMenusData>(e) as VirtualMenusData)
      .toList();
  if (data != null) {
    virtualMenusEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    virtualMenusEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    virtualMenusEntity.ts = ts;
  }
  return virtualMenusEntity;
}

Map<String, dynamic> $VirtualMenusEntityToJson(VirtualMenusEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension VirtualMenusEntityExtension on VirtualMenusEntity {
  VirtualMenusEntity copyWith({
    String? code,
    List<VirtualMenusData>? data,
    String? msg,
    int? ts,
  }) {
    return VirtualMenusEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

VirtualMenusData $VirtualMenusDataFromJson(Map<String, dynamic> json) {
  final VirtualMenusData virtualMenusData = VirtualMenusData();
  final dynamic count = json['count'];
  if (count != null) {
    virtualMenusData.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    virtualMenusData.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    virtualMenusData.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    virtualMenusData.field3 = field3;
  }
  final String? field4 = jsonConvert.convert<String>(json['field4']);
  if (field4 != null) {
    virtualMenusData.field4 = field4;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    virtualMenusData.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    virtualMenusData.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    virtualMenusData.name = name;
  }
  final List<VirtualMenusDataSubList>? subList = (json['subList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<VirtualMenusDataSubList>(
          e) as VirtualMenusDataSubList).toList();
  if (subList != null) {
    virtualMenusData.subList = subList;
  }
  return virtualMenusData;
}

Map<String, dynamic> $VirtualMenusDataToJson(VirtualMenusData entity) {
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

extension VirtualMenusDataExtension on VirtualMenusData {
  VirtualMenusData copyWith({
    dynamic count,
    String? field1,
    String? field2,
    String? field3,
    String? field4,
    String? menuId,
    dynamic menuType,
    String? name,
    List<VirtualMenusDataSubList>? subList,
  }) {
    return VirtualMenusData()
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

VirtualMenusDataSubList $VirtualMenusDataSubListFromJson(
    Map<String, dynamic> json) {
  final VirtualMenusDataSubList virtualMenusDataSubList = VirtualMenusDataSubList();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    virtualMenusDataSubList.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    virtualMenusDataSubList.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    virtualMenusDataSubList.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    virtualMenusDataSubList.field3 = field3;
  }
  final String? field4 = jsonConvert.convert<String>(json['field4']);
  if (field4 != null) {
    virtualMenusDataSubList.field4 = field4;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    virtualMenusDataSubList.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    virtualMenusDataSubList.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    virtualMenusDataSubList.name = name;
  }
  final dynamic subList = json['subList'];
  if (subList != null) {
    virtualMenusDataSubList.subList = subList;
  }
  return virtualMenusDataSubList;
}

Map<String, dynamic> $VirtualMenusDataSubListToJson(
    VirtualMenusDataSubList entity) {
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

extension VirtualMenusDataSubListExtension on VirtualMenusDataSubList {
  VirtualMenusDataSubList copyWith({
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
    return VirtualMenusDataSubList()
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