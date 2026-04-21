import 'dart:collection';
import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/sport_config_info.g.dart';

@JsonSerializable()
class SportConfigInfo {
  int? ct;
  String? eid;
  int? hl;
  late String mi = '';
  late String pId = '';
  List<SportConfigInfo>? sl;
  int? st;
  String? tid ;

  @JSONField(serialize: false, deserialize: false)
  final LinkedHashMap<String, SportConfigInfo> _slMap = LinkedHashMap();

  SportConfigInfo();

  LinkedHashMap<String, SportConfigInfo> get slMap {
    if (_slMap.isEmpty && sl != null) {
      for (var item in sl!) {
        _slMap[item.mi] = item;
      }
    }
    return _slMap;
  }

  factory SportConfigInfo.fromJson(Map<String, dynamic> json) =>
      $SportConfigInfoFromJson(json);

  Map<String, dynamic> toJson() => $SportConfigInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
