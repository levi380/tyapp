import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_login_entity.dart';

ZrLoginEntity $ZrLoginEntityFromJson(Map<String, dynamic> json) {
  final ZrLoginEntity zrLoginEntity = ZrLoginEntity();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    zrLoginEntity.url = url;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    zrLoginEntity.token = token;
  }
  return zrLoginEntity;
}

Map<String, dynamic> $ZrLoginEntityToJson(ZrLoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['token'] = entity.token;
  return data;
}

extension ZrLoginEntityExtension on ZrLoginEntity {
  ZrLoginEntity copyWith({
    String? url,
    String? token,
  }) {
    return ZrLoginEntity()
      ..url = url ?? this.url
      ..token = token ?? this.token;
  }
}