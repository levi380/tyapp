import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_mobile_outright_display_matchs_entity.dart';

GetMobileOutrightDisplayMatchsEntity $GetMobileOutrightDisplayMatchsEntityFromJson(
    Map<String, dynamic> json) {
  final GetMobileOutrightDisplayMatchsEntity getMobileOutrightDisplayMatchsEntity = GetMobileOutrightDisplayMatchsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getMobileOutrightDisplayMatchsEntity.code = code;
  }
  final dynamic data = json['data'];
  if (data != null) {
    getMobileOutrightDisplayMatchsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getMobileOutrightDisplayMatchsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getMobileOutrightDisplayMatchsEntity.ts = ts;
  }
  return getMobileOutrightDisplayMatchsEntity;
}

Map<String, dynamic> $GetMobileOutrightDisplayMatchsEntityToJson(
    GetMobileOutrightDisplayMatchsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetMobileOutrightDisplayMatchsEntityExtension on GetMobileOutrightDisplayMatchsEntity {
  GetMobileOutrightDisplayMatchsEntity copyWith({
    String? code,
    dynamic data,
    String? msg,
    int? ts,
  }) {
    return GetMobileOutrightDisplayMatchsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}