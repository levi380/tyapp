import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/detail_by_tournament_id_entity.dart';

DetailByTournamentIdEntity $DetailByTournamentIdEntityFromJson(
    Map<String, dynamic> json) {
  final DetailByTournamentIdEntity detailByTournamentIdEntity = DetailByTournamentIdEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    detailByTournamentIdEntity.code = code;
  }
  final List<DetailByTournamentIdData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<DetailByTournamentIdData>(
          e) as DetailByTournamentIdData)
      .toList();
  if (data != null) {
    detailByTournamentIdEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    detailByTournamentIdEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    detailByTournamentIdEntity.ts = ts;
  }
  return detailByTournamentIdEntity;
}

Map<String, dynamic> $DetailByTournamentIdEntityToJson(
    DetailByTournamentIdEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension DetailByTournamentIdEntityExtension on DetailByTournamentIdEntity {
  DetailByTournamentIdEntity copyWith({
    String? code,
    List<DetailByTournamentIdData>? data,
    String? msg,
    int? ts,
  }) {
    return DetailByTournamentIdEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

DetailByTournamentIdData $DetailByTournamentIdDataFromJson(
    Map<String, dynamic> json) {
  final DetailByTournamentIdData detailByTournamentIdData = DetailByTournamentIdData();
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    detailByTournamentIdData.mhid = mhid;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    detailByTournamentIdData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    detailByTournamentIdData.mess = mess;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    detailByTournamentIdData.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    detailByTournamentIdData.tid = tid;
  }
  final String? vurl = jsonConvert.convert<String>(json['vurl']);
  if (vurl != null) {
    detailByTournamentIdData.vurl = vurl;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    detailByTournamentIdData.mst = mst;
  }
  final int? mmp = jsonConvert.convert<int>(json['mmp']);
  if (mmp != null) {
    detailByTournamentIdData.mmp = mmp;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    detailByTournamentIdData.mms = mms;
  }
  final String? varl = jsonConvert.convert<String>(json['varl']);
  if (varl != null) {
    detailByTournamentIdData.varl = varl;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    detailByTournamentIdData.mhlu = mhlu;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    detailByTournamentIdData.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    detailByTournamentIdData.mgt = mgt;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    detailByTournamentIdData.man = man;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    detailByTournamentIdData.maid = maid;
  }
  final String? frman = jsonConvert.convert<String>(json['frman']);
  if (frman != null) {
    detailByTournamentIdData.frman = frman;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    detailByTournamentIdData.tlev = tlev;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    detailByTournamentIdData.mct = mct;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    detailByTournamentIdData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    detailByTournamentIdData.ms = ms;
  }
  final int? mt = jsonConvert.convert<int>(json['mt']);
  if (mt != null) {
    detailByTournamentIdData.mt = mt;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    detailByTournamentIdData.malu = malu;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    detailByTournamentIdData.lurl = lurl;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    detailByTournamentIdData.mhn = mhn;
  }
  final String? frmhn = jsonConvert.convert<String>(json['frmhn']);
  if (frmhn != null) {
    detailByTournamentIdData.frmhn = frmhn;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    detailByTournamentIdData.mhs = mhs;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    detailByTournamentIdData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    detailByTournamentIdData.msc = msc;
  }
  return detailByTournamentIdData;
}

Map<String, dynamic> $DetailByTournamentIdDataToJson(
    DetailByTournamentIdData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mhid'] = entity.mhid;
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['csna'] = entity.csna;
  data['tid'] = entity.tid;
  data['vurl'] = entity.vurl;
  data['mst'] = entity.mst;
  data['mmp'] = entity.mmp;
  data['mms'] = entity.mms;
  data['varl'] = entity.varl;
  data['mhlu'] = entity.mhlu;
  data['mf'] = entity.mf;
  data['mgt'] = entity.mgt;
  data['man'] = entity.man;
  data['maid'] = entity.maid;
  data['frman'] = entity.frman;
  data['tlev'] = entity.tlev;
  data['mct'] = entity.mct;
  data['csid'] = entity.csid;
  data['ms'] = entity.ms;
  data['mt'] = entity.mt;
  data['malu'] = entity.malu;
  data['lurl'] = entity.lurl;
  data['mhn'] = entity.mhn;
  data['frmhn'] = entity.frmhn;
  data['mhs'] = entity.mhs;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension DetailByTournamentIdDataExtension on DetailByTournamentIdData {
  DetailByTournamentIdData copyWith({
    String? mhid,
    String? mid,
    int? mess,
    String? csna,
    String? tid,
    String? vurl,
    String? mst,
    int? mmp,
    int? mms,
    String? varl,
    List<String>? mhlu,
    bool? mf,
    String? mgt,
    String? man,
    String? maid,
    String? frman,
    int? tlev,
    int? mct,
    String? csid,
    int? ms,
    int? mt,
    List<String>? malu,
    String? lurl,
    String? mhn,
    String? frmhn,
    int? mhs,
    String? tn,
    List<String>? msc,
  }) {
    return DetailByTournamentIdData()
      ..mhid = mhid ?? this.mhid
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..csna = csna ?? this.csna
      ..tid = tid ?? this.tid
      ..vurl = vurl ?? this.vurl
      ..mst = mst ?? this.mst
      ..mmp = mmp ?? this.mmp
      ..mms = mms ?? this.mms
      ..varl = varl ?? this.varl
      ..mhlu = mhlu ?? this.mhlu
      ..mf = mf ?? this.mf
      ..mgt = mgt ?? this.mgt
      ..man = man ?? this.man
      ..maid = maid ?? this.maid
      ..frman = frman ?? this.frman
      ..tlev = tlev ?? this.tlev
      ..mct = mct ?? this.mct
      ..csid = csid ?? this.csid
      ..ms = ms ?? this.ms
      ..mt = mt ?? this.mt
      ..malu = malu ?? this.malu
      ..lurl = lurl ?? this.lurl
      ..mhn = mhn ?? this.mhn
      ..frmhn = frmhn ?? this.frmhn
      ..mhs = mhs ?? this.mhs
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc;
  }
}