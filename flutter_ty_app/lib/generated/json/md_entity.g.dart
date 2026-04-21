import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/md_entity.dart';

MdEntity $MdEntityFromJson(Map<String, dynamic> json) {
  final MdEntity mdEntity = MdEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    mdEntity.code = code;
  }
  final dynamic data = json['data'];
  if (data != null) {
    mdEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    mdEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    mdEntity.ts = ts;
  }
  return mdEntity;
}

Map<String, dynamic> $MdEntityToJson(MdEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data;
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MdEntityExtension on MdEntity {
  MdEntity copyWith({
    String? code,
    dynamic data,
    String? msg,
    int? ts,
  }) {
    return MdEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}