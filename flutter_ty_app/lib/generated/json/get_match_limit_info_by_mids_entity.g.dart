import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_match_limit_info_by_mids_entity.dart';

GetMatchLimitInfoByMidsEntity $GetMatchLimitInfoByMidsEntityFromJson(
    Map<String, dynamic> json) {
  final GetMatchLimitInfoByMidsEntity getMatchLimitInfoByMidsEntity = GetMatchLimitInfoByMidsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getMatchLimitInfoByMidsEntity.code = code;
  }
  final GetMatchLimitInfoByMidsData? data = jsonConvert.convert<
      GetMatchLimitInfoByMidsData>(json['data']);
  if (data != null) {
    getMatchLimitInfoByMidsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getMatchLimitInfoByMidsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getMatchLimitInfoByMidsEntity.ts = ts;
  }
  return getMatchLimitInfoByMidsEntity;
}

Map<String, dynamic> $GetMatchLimitInfoByMidsEntityToJson(
    GetMatchLimitInfoByMidsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetMatchLimitInfoByMidsEntityExtension on GetMatchLimitInfoByMidsEntity {
  GetMatchLimitInfoByMidsEntity copyWith({
    String? code,
    GetMatchLimitInfoByMidsData? data,
    String? msg,
    int? ts,
  }) {
    return GetMatchLimitInfoByMidsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetMatchLimitInfoByMidsData $GetMatchLimitInfoByMidsDataFromJson(
    Map<String, dynamic> json) {
  final GetMatchLimitInfoByMidsData getMatchLimitInfoByMidsData = GetMatchLimitInfoByMidsData();
  final List<GetMatchLimitInfoByMidsDataData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetMatchLimitInfoByMidsDataData>(
          e) as GetMatchLimitInfoByMidsDataData).toList();
  if (data != null) {
    getMatchLimitInfoByMidsData.data = data;
  }
  return getMatchLimitInfoByMidsData;
}

Map<String, dynamic> $GetMatchLimitInfoByMidsDataToJson(
    GetMatchLimitInfoByMidsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension GetMatchLimitInfoByMidsDataExtension on GetMatchLimitInfoByMidsData {
  GetMatchLimitInfoByMidsData copyWith({
    List<GetMatchLimitInfoByMidsDataData>? data,
  }) {
    return GetMatchLimitInfoByMidsData()
      ..data = data ?? this.data;
  }
}

GetMatchLimitInfoByMidsDataData $GetMatchLimitInfoByMidsDataDataFromJson(
    Map<String, dynamic> json) {
  final GetMatchLimitInfoByMidsDataData getMatchLimitInfoByMidsDataData = GetMatchLimitInfoByMidsDataData();
  final List<dynamic>? mpsc = (json['mpsc'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (mpsc != null) {
    getMatchLimitInfoByMidsDataData.mpsc = mpsc;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    getMatchLimitInfoByMidsDataData.ctt = ctt;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    getMatchLimitInfoByMidsDataData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    getMatchLimitInfoByMidsDataData.ms = ms;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    getMatchLimitInfoByMidsDataData.mle = mle;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    getMatchLimitInfoByMidsDataData.mststr = mststr;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    getMatchLimitInfoByMidsDataData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    getMatchLimitInfoByMidsDataData.mess = mess;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    getMatchLimitInfoByMidsDataData.mst = mst;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    getMatchLimitInfoByMidsDataData.mststs = mststs;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    getMatchLimitInfoByMidsDataData.mmp = mmp;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    getMatchLimitInfoByMidsDataData.mststi = mststi;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    getMatchLimitInfoByMidsDataData.cds = cds;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    getMatchLimitInfoByMidsDataData.mhs = mhs;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    getMatchLimitInfoByMidsDataData.mstst = mstst;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    getMatchLimitInfoByMidsDataData.mgt = mgt;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    getMatchLimitInfoByMidsDataData.mlet = mlet;
  }
  return getMatchLimitInfoByMidsDataData;
}

Map<String, dynamic> $GetMatchLimitInfoByMidsDataDataToJson(
    GetMatchLimitInfoByMidsDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mpsc'] = entity.mpsc;
  data['ctt'] = entity.ctt;
  data['csid'] = entity.csid;
  data['ms'] = entity.ms;
  data['mle'] = entity.mle;
  data['mststr'] = entity.mststr;
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['mst'] = entity.mst;
  data['mststs'] = entity.mststs;
  data['mmp'] = entity.mmp;
  data['mststi'] = entity.mststi;
  data['cds'] = entity.cds;
  data['mhs'] = entity.mhs;
  data['mstst'] = entity.mstst;
  data['mgt'] = entity.mgt;
  data['mlet'] = entity.mlet;
  return data;
}

extension GetMatchLimitInfoByMidsDataDataExtension on GetMatchLimitInfoByMidsDataData {
  GetMatchLimitInfoByMidsDataData copyWith({
    List<dynamic>? mpsc,
    int? ctt,
    String? csid,
    int? ms,
    int? mle,
    String? mststr,
    String? mid,
    int? mess,
    String? mst,
    int? mststs,
    String? mmp,
    String? mststi,
    String? cds,
    int? mhs,
    String? mstst,
    String? mgt,
    String? mlet,
  }) {
    return GetMatchLimitInfoByMidsDataData()
      ..mpsc = mpsc ?? this.mpsc
      ..ctt = ctt ?? this.ctt
      ..csid = csid ?? this.csid
      ..ms = ms ?? this.ms
      ..mle = mle ?? this.mle
      ..mststr = mststr ?? this.mststr
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..mst = mst ?? this.mst
      ..mststs = mststs ?? this.mststs
      ..mmp = mmp ?? this.mmp
      ..mststi = mststi ?? this.mststi
      ..cds = cds ?? this.cds
      ..mhs = mhs ?? this.mhs
      ..mstst = mstst ?? this.mstst
      ..mgt = mgt ?? this.mgt
      ..mlet = mlet ?? this.mlet;
  }
}