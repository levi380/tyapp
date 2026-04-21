import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/pin_info_entity.dart';

PinInfoEntity $PinInfoEntityFromJson(Map<String, dynamic> json) {
  final PinInfoEntity pinInfoEntity = PinInfoEntity();
  final List<String>? tIds = (json['tIds'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (tIds != null) {
    pinInfoEntity.tIds = tIds;
  }
  final List<String>? mIds = (json['mIds'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mIds != null) {
    pinInfoEntity.mIds = mIds;
  }
  final List<String>? cMids = (json['cMids'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (cMids != null) {
    pinInfoEntity.cMids = cMids;
  }
  return pinInfoEntity;
}

Map<String, dynamic> $PinInfoEntityToJson(PinInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tIds'] = entity.tIds;
  data['mIds'] = entity.mIds;
  data['cMids'] = entity.cMids;
  return data;
}

extension PinInfoEntityExtension on PinInfoEntity {
  PinInfoEntity copyWith({
    List<String>? tIds,
    List<String>? mIds,
    List<String>? cMids,
  }) {
    return PinInfoEntity()
      ..tIds = tIds ?? this.tIds
      ..mIds = mIds ?? this.mIds
      ..cMids = cMids ?? this.cMids;
  }
}