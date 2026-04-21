import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/zr_login_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/zr_login_entity.g.dart';

@JsonSerializable()
class ZrLoginEntity {
  late String url;
  late String token;

  ZrLoginEntity();

  factory ZrLoginEntity.fromJson(Map<String, dynamic> json) => $ZrLoginEntityFromJson(json);

  Map<String, dynamic> toJson() => $ZrLoginEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
