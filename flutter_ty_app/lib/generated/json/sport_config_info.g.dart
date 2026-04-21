import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';



SportConfigInfo $SportConfigInfoFromJson(Map<String, dynamic> json) {
  final SportConfigInfo sportConfigInfo = SportConfigInfo();
  final int? ct = jsonConvert.convert<int>(json['ct']);
  if (ct != null) {
    sportConfigInfo.ct = ct;
  }
  final String? eid = jsonConvert.convert<String>(json['eid']);
  if (eid != null) {
    sportConfigInfo.eid = eid;
  }
  final int? hl = jsonConvert.convert<int>(json['hl']);
  if (hl != null) {
    sportConfigInfo.hl = hl;
  }
  final String? mi = jsonConvert.convert<String>(json['mi']);
  if (mi != null) {
    sportConfigInfo.mi = mi;
  }
  final String? pId = jsonConvert.convert<String>(json['pId']);
  if (pId != null) {
    sportConfigInfo.pId = pId;
  }
  final List<SportConfigInfo>? sl = (json['sl'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<SportConfigInfo>(e) as SportConfigInfo)
      .toList();
  if (sl != null) {
    sportConfigInfo.sl = sl;
  }
  final int? st = jsonConvert.convert<int>(json['st']);
  if (st != null) {
    sportConfigInfo.st = st;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    sportConfigInfo.tid = tid;
  }
  return sportConfigInfo;
}

Map<String, dynamic> $SportConfigInfoToJson(SportConfigInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ct'] = entity.ct;
  data['eid'] = entity.eid;
  data['hl'] = entity.hl;
  data['mi'] = entity.mi;
  data['pId'] = entity.pId;
  data['sl'] = entity.sl?.map((v) => v.toJson()).toList();
  data['st'] = entity.st;
  data['tid'] = entity.tid;
  return data;
}

extension SportConfigInfoExtension on SportConfigInfo {
  SportConfigInfo copyWith({
    int? ct,
    String? eid,
    int? hl,
    String? mi,
    String? pId,
    List<SportConfigInfo>? sl,
    int? st,
    String? tid,
  }) {
    return SportConfigInfo()
      ..ct = ct ?? this.ct
      ..eid = eid ?? this.eid
      ..hl = hl ?? this.hl
      ..mi = mi ?? this.mi
      ..pId = pId ?? this.pId
      ..sl = sl ?? this.sl
      ..st = st ?? this.st
      ..tid = tid ?? this.tid;
  }
}