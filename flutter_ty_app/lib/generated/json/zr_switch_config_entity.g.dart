import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_switch_config_entity.dart';

ZrSwitchConfigEntity $ZrSwitchConfigEntityFromJson(Map<String, dynamic> json) {
  final ZrSwitchConfigEntity zrSwitchConfigEntity = ZrSwitchConfigEntity();
  final bool? cp = jsonConvert.convert<bool>(json['cp']);
  if (cp != null) {
    zrSwitchConfigEntity.cp = cp;
  }
  final bool? cpH5 = jsonConvert.convert<bool>(json['cpH5']);
  if (cpH5 != null) {
    zrSwitchConfigEntity.cpH5 = cpH5;
  }
  final bool? cpMaintenance = jsonConvert.convert<bool>(json['cpMaintenance']);
  if (cpMaintenance != null) {
    zrSwitchConfigEntity.cpMaintenance = cpMaintenance;
  }
  final bool? cpPc = jsonConvert.convert<bool>(json['cpPc']);
  if (cpPc != null) {
    zrSwitchConfigEntity.cpPc = cpPc;
  }
  final bool? cpSdk = jsonConvert.convert<bool>(json['cpSdk']);
  if (cpSdk != null) {
    zrSwitchConfigEntity.cpSdk = cpSdk;
  }
  final bool? cpSwitch = jsonConvert.convert<bool>(json['cpSwitch']);
  if (cpSwitch != null) {
    zrSwitchConfigEntity.cpSwitch = cpSwitch;
  }
  final bool? zr = jsonConvert.convert<bool>(json['zr']);
  if (zr != null) {
    zrSwitchConfigEntity.zr = zr;
  }
  final bool? zrH5 = jsonConvert.convert<bool>(json['zrH5']);
  if (zrH5 != null) {
    zrSwitchConfigEntity.zrH5 = zrH5;
  }
  final bool? zrMaintenance = jsonConvert.convert<bool>(json['zrMaintenance']);
  if (zrMaintenance != null) {
    zrSwitchConfigEntity.zrMaintenance = zrMaintenance;
  }
  final bool? zrPc = jsonConvert.convert<bool>(json['zrPc']);
  if (zrPc != null) {
    zrSwitchConfigEntity.zrPc = zrPc;
  }
  final bool? zrSdk = jsonConvert.convert<bool>(json['zrSdk']);
  if (zrSdk != null) {
    zrSwitchConfigEntity.zrSdk = zrSdk;
  }
  final bool? zrSwitch = jsonConvert.convert<bool>(json['zrSwitch']);
  if (zrSwitch != null) {
    zrSwitchConfigEntity.zrSwitch = zrSwitch;
  }
  return zrSwitchConfigEntity;
}

Map<String, dynamic> $ZrSwitchConfigEntityToJson(ZrSwitchConfigEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cp'] = entity.cp;
  data['cpH5'] = entity.cpH5;
  data['cpMaintenance'] = entity.cpMaintenance;
  data['cpPc'] = entity.cpPc;
  data['cpSdk'] = entity.cpSdk;
  data['cpSwitch'] = entity.cpSwitch;
  data['zr'] = entity.zr;
  data['zrH5'] = entity.zrH5;
  data['zrMaintenance'] = entity.zrMaintenance;
  data['zrPc'] = entity.zrPc;
  data['zrSdk'] = entity.zrSdk;
  data['zrSwitch'] = entity.zrSwitch;
  return data;
}

extension ZrSwitchConfigEntityExtension on ZrSwitchConfigEntity {
  ZrSwitchConfigEntity copyWith({
    bool? cp,
    bool? cpH5,
    bool? cpMaintenance,
    bool? cpPc,
    bool? cpSdk,
    bool? cpSwitch,
    bool? zr,
    bool? zrH5,
    bool? zrMaintenance,
    bool? zrPc,
    bool? zrSdk,
    bool? zrSwitch,
  }) {
    return ZrSwitchConfigEntity()
      ..cp = cp ?? this.cp
      ..cpH5 = cpH5 ?? this.cpH5
      ..cpMaintenance = cpMaintenance ?? this.cpMaintenance
      ..cpPc = cpPc ?? this.cpPc
      ..cpSdk = cpSdk ?? this.cpSdk
      ..cpSwitch = cpSwitch ?? this.cpSwitch
      ..zr = zr ?? this.zr
      ..zrH5 = zrH5 ?? this.zrH5
      ..zrMaintenance = zrMaintenance ?? this.zrMaintenance
      ..zrPc = zrPc ?? this.zrPc
      ..zrSdk = zrSdk ?? this.zrSdk
      ..zrSwitch = zrSwitch ?? this.zrSwitch;
  }
}