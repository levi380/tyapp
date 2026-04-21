import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/play_top_entity.dart';

PlayTopEntity $PlayTopEntityFromJson(Map<String, dynamic> json) {
  final PlayTopEntity playTopEntity = PlayTopEntity();
  final String? topKey = jsonConvert.convert<String>(json['topKey']);
  if (topKey != null) {
    playTopEntity.topKey = topKey;
  }
  final String? hton = jsonConvert.convert<String>(json['hton']);
  if (hton != null) {
    playTopEntity.hton = hton;
  }
  return playTopEntity;
}

Map<String, dynamic> $PlayTopEntityToJson(PlayTopEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['topKey'] = entity.topKey;
  data['hton'] = entity.hton;
  return data;
}

extension PlayTopEntityExtension on PlayTopEntity {
  PlayTopEntity copyWith({
    String? topKey,
    String? hton,
  }) {
    return PlayTopEntity()
      ..topKey = topKey ?? this.topKey
      ..hton = hton ?? this.hton;
  }
}