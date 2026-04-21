import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/front_fight_p_b_bean_entity_electronic_football_entity.dart';

FrontFightPBBeanEntityElectronicFootballEntity $FrontFightPBBeanEntityElectronicFootballEntityFromJson(
    Map<String, dynamic> json) {
  final FrontFightPBBeanEntityElectronicFootballEntity frontFightPBBeanEntityElectronicFootballEntity = FrontFightPBBeanEntityElectronicFootballEntity();
  final String? away = jsonConvert.convert<String>(json['away']);
  if (away != null) {
    frontFightPBBeanEntityElectronicFootballEntity.away = away;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    frontFightPBBeanEntityElectronicFootballEntity.awayName = awayName;
  }
  final String? home = jsonConvert.convert<String>(json['home']);
  if (home != null) {
    frontFightPBBeanEntityElectronicFootballEntity.home = home;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    frontFightPBBeanEntityElectronicFootballEntity.homeName = homeName;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    frontFightPBBeanEntityElectronicFootballEntity.mid = mid;
  }
  final int? t1 = jsonConvert.convert<int>(json['t1']);
  if (t1 != null) {
    frontFightPBBeanEntityElectronicFootballEntity.t1 = t1;
  }
  final int? t2 = jsonConvert.convert<int>(json['t2']);
  if (t2 != null) {
    frontFightPBBeanEntityElectronicFootballEntity.t2 = t2;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    frontFightPBBeanEntityElectronicFootballEntity.time = time;
  }
  final String? thirdId = jsonConvert.convert<String>(json['thirdId']);
  if (thirdId != null) {
    frontFightPBBeanEntityElectronicFootballEntity.thirdId = thirdId;
  }
  return frontFightPBBeanEntityElectronicFootballEntity;
}

Map<String, dynamic> $FrontFightPBBeanEntityElectronicFootballEntityToJson(
    FrontFightPBBeanEntityElectronicFootballEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['away'] = entity.away;
  data['awayName'] = entity.awayName;
  data['home'] = entity.home;
  data['homeName'] = entity.homeName;
  data['mid'] = entity.mid;
  data['t1'] = entity.t1;
  data['t2'] = entity.t2;
  data['time'] = entity.time;
  data['thirdId'] = entity.thirdId;
  return data;
}

extension FrontFightPBBeanEntityElectronicFootballEntityExtension on FrontFightPBBeanEntityElectronicFootballEntity {
  FrontFightPBBeanEntityElectronicFootballEntity copyWith({
    String? away,
    String? awayName,
    String? home,
    String? homeName,
    String? mid,
    int? t1,
    int? t2,
    String? time,
    String? thirdId,
  }) {
    return FrontFightPBBeanEntityElectronicFootballEntity()
      ..away = away ?? this.away
      ..awayName = awayName ?? this.awayName
      ..home = home ?? this.home
      ..homeName = homeName ?? this.homeName
      ..mid = mid ?? this.mid
      ..t1 = t1 ?? this.t1
      ..t2 = t2 ?? this.t2
      ..time = time ?? this.time
      ..thirdId = thirdId ?? this.thirdId;
  }
}