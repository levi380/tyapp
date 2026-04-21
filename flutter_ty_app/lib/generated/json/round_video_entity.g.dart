import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/round_video_entity.dart';

RoundVideoEntity $RoundVideoEntityFromJson(Map<String, dynamic> json) {
  final RoundVideoEntity roundVideoEntity = RoundVideoEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    roundVideoEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    roundVideoEntity.message = message;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    roundVideoEntity.code = code;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    roundVideoEntity.serverTime = serverTime;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    roundVideoEntity.msg = msg;
  }
  final List<RoundVideoData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<RoundVideoData>(e) as RoundVideoData)
      .toList();
  if (data != null) {
    roundVideoEntity.data = data;
  }
  return roundVideoEntity;
}

Map<String, dynamic> $RoundVideoEntityToJson(RoundVideoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['code'] = entity.code;
  data['serverTime'] = entity.serverTime;
  data['msg'] = entity.msg;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension RoundVideoEntityExtension on RoundVideoEntity {
  RoundVideoEntity copyWith({
    bool? status,
    String? message,
    String? code,
    int? serverTime,
    String? msg,
    List<RoundVideoData>? data,
  }) {
    return RoundVideoEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..code = code ?? this.code
      ..serverTime = serverTime ?? this.serverTime
      ..msg = msg ?? this.msg
      ..data = data ?? this.data;
  }
}

RoundVideoData $RoundVideoDataFromJson(Map<String, dynamic> json) {
  final RoundVideoData roundVideoData = RoundVideoData();
  final String? roundNo = jsonConvert.convert<String>(json['roundNo']);
  if (roundNo != null) {
    roundVideoData.roundNo = roundNo;
  }
  final String? videoPath = jsonConvert.convert<String>(json['videoPath']);
  if (videoPath != null) {
    roundVideoData.videoPath = videoPath;
  }
  return roundVideoData;
}

Map<String, dynamic> $RoundVideoDataToJson(RoundVideoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['roundNo'] = entity.roundNo;
  data['videoPath'] = entity.videoPath;
  return data;
}

extension RoundVideoDataExtension on RoundVideoData {
  RoundVideoData copyWith({
    String? roundNo,
    String? videoPath,
  }) {
    return RoundVideoData()
      ..roundNo = roundNo ?? this.roundNo
      ..videoPath = videoPath ?? this.videoPath;
  }
}