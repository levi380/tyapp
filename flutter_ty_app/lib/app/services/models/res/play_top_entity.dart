import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/play_top_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/play_top_entity.g.dart';

@JsonSerializable()
class PlayTopEntity {
  late String topKey = '';
  late String hton = '';

  PlayTopEntity();

  factory PlayTopEntity.fromJson(Map<String, dynamic> json) =>
      $PlayTopEntityFromJson(json);

  Map<String, dynamic> toJson() => $PlayTopEntityToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayTopEntity &&
          runtimeType == other.runtimeType &&
          topKey == other.topKey;

  @override
  int get hashCode => topKey.hashCode;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
