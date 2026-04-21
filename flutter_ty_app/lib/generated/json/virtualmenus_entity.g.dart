import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/mockdata/virtualmenus_entity.dart';

VirtualmenusEntity $VirtualmenusEntityFromJson(Map<String, dynamic> json) {
  final VirtualmenusEntity virtualmenusEntity = VirtualmenusEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    virtualmenusEntity.code = code;
  }
  final List<VirtualmenusData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<VirtualmenusData>(e) as VirtualmenusData)
      .toList();
  if (data != null) {
    virtualmenusEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    virtualmenusEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    virtualmenusEntity.ts = ts;
  }
  return virtualmenusEntity;
}

Map<String, dynamic> $VirtualmenusEntityToJson(VirtualmenusEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension VirtualmenusEntityExtension on VirtualmenusEntity {
  VirtualmenusEntity copyWith({
    String? code,
    List<VirtualmenusData>? data,
    String? msg,
    int? ts,
  }) {
    return VirtualmenusEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

VirtualmenusData $VirtualmenusDataFromJson(Map<String, dynamic> json) {
  final VirtualmenusData virtualmenusData = VirtualmenusData();
  final dynamic count = json['count'];
  if (count != null) {
    virtualmenusData.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    virtualmenusData.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    virtualmenusData.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    virtualmenusData.field3 = field3;
  }
  final String? field4 = jsonConvert.convert<String>(json['field4']);
  if (field4 != null) {
    virtualmenusData.field4 = field4;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    virtualmenusData.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    virtualmenusData.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    virtualmenusData.name = name;
  }
  final List<VirtualmenusDataSubList>? subList = (json['subList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<VirtualmenusDataSubList>(
          e) as VirtualmenusDataSubList).toList();
  if (subList != null) {
    virtualmenusData.subList = subList;
  }
  return virtualmenusData;
}

Map<String, dynamic> $VirtualmenusDataToJson(VirtualmenusData entity) {
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

extension VirtualmenusDataExtension on VirtualmenusData {
  VirtualmenusData copyWith({
    dynamic count,
    String? field1,
    String? field2,
    String? field3,
    String? field4,
    String? menuId,
    dynamic menuType,
    String? name,
    List<VirtualmenusDataSubList>? subList,
  }) {
    return VirtualmenusData()
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

VirtualmenusDataSubList $VirtualmenusDataSubListFromJson(
    Map<String, dynamic> json) {
  final VirtualmenusDataSubList virtualmenusDataSubList = VirtualmenusDataSubList();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    virtualmenusDataSubList.count = count;
  }
  final String? field1 = jsonConvert.convert<String>(json['field1']);
  if (field1 != null) {
    virtualmenusDataSubList.field1 = field1;
  }
  final String? field2 = jsonConvert.convert<String>(json['field2']);
  if (field2 != null) {
    virtualmenusDataSubList.field2 = field2;
  }
  final String? field3 = jsonConvert.convert<String>(json['field3']);
  if (field3 != null) {
    virtualmenusDataSubList.field3 = field3;
  }
  final String? field4 = jsonConvert.convert<String>(json['field4']);
  if (field4 != null) {
    virtualmenusDataSubList.field4 = field4;
  }
  final String? menuId = jsonConvert.convert<String>(json['menuId']);
  if (menuId != null) {
    virtualmenusDataSubList.menuId = menuId;
  }
  final dynamic menuType = json['menuType'];
  if (menuType != null) {
    virtualmenusDataSubList.menuType = menuType;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    virtualmenusDataSubList.name = name;
  }
  final dynamic subList = json['subList'];
  if (subList != null) {
    virtualmenusDataSubList.subList = subList;
  }
  return virtualmenusDataSubList;
}

Map<String, dynamic> $VirtualmenusDataSubListToJson(
    VirtualmenusDataSubList entity) {
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

extension VirtualmenusDataSubListExtension on VirtualmenusDataSubList {
  VirtualmenusDataSubList copyWith({
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
    return VirtualmenusDataSubList()
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