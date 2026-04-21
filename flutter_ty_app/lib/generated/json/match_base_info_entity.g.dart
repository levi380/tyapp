import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_base_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


MatchBaseInfoEntity $MatchBaseInfoEntityFromJson(Map<String, dynamic> json) {
  final MatchBaseInfoEntity matchBaseInfoEntity = MatchBaseInfoEntity();
  final MatchBaseInfoKySwitch? kySwitch = jsonConvert.convert<
      MatchBaseInfoKySwitch>(json['kySwitch']);
  if (kySwitch != null) {
    matchBaseInfoEntity.kySwitch = kySwitch;
  }
  final List<MatchEntity>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchEntity>(e) as MatchEntity).toList();
  if (list != null) {
    matchBaseInfoEntity.list = list;
  }
  return matchBaseInfoEntity;
}

Map<String, dynamic> $MatchBaseInfoEntityToJson(MatchBaseInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['kySwitch'] = entity.kySwitch.toJson();
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension MatchBaseInfoEntityExtension on MatchBaseInfoEntity {
  MatchBaseInfoEntity copyWith({
    MatchBaseInfoKySwitch? kySwitch,
    List<MatchEntity>? list,
  }) {
    return MatchBaseInfoEntity()
      ..kySwitch = kySwitch ?? this.kySwitch
      ..list = list ?? this.list;
  }
}

MatchBaseInfoKySwitch $MatchBaseInfoKySwitchFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoKySwitch matchBaseInfoKySwitch = MatchBaseInfoKySwitch();
  final int? playType = jsonConvert.convert<int>(json['playType']);
  if (playType != null) {
    matchBaseInfoKySwitch.playType = playType;
  }
  final int? isKy = jsonConvert.convert<int>(json['isKy']);
  if (isKy != null) {
    matchBaseInfoKySwitch.isKy = isKy;
  }
  return matchBaseInfoKySwitch;
}

Map<String, dynamic> $MatchBaseInfoKySwitchToJson(
    MatchBaseInfoKySwitch entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['playType'] = entity.playType;
  data['isKy'] = entity.isKy;
  return data;
}

extension MatchBaseInfoKySwitchExtension on MatchBaseInfoKySwitch {
  MatchBaseInfoKySwitch copyWith({
    int? playType,
    int? isKy,
  }) {
    return MatchBaseInfoKySwitch()
      ..playType = playType ?? this.playType
      ..isKy = isKy ?? this.isKy;
  }
}