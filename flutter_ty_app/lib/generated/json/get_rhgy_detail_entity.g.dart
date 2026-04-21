import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_rhgy_detail_entity.dart';

GetRhgyDetailEntity $GetRhgyDetailEntityFromJson(Map<String, dynamic> json) {
  final GetRhgyDetailEntity getRhgyDetailEntity = GetRhgyDetailEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getRhgyDetailEntity.code = code;
  }
  final GetRhgyDetailData? data = jsonConvert.convert<GetRhgyDetailData>(
      json['data']);
  if (data != null) {
    getRhgyDetailEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getRhgyDetailEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getRhgyDetailEntity.ts = ts;
  }
  return getRhgyDetailEntity;
}

Map<String, dynamic> $GetRhgyDetailEntityToJson(GetRhgyDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetRhgyDetailEntityExtension on GetRhgyDetailEntity {
  GetRhgyDetailEntity copyWith({
    String? code,
    GetRhgyDetailData? data,
    String? msg,
    int? ts,
  }) {
    return GetRhgyDetailEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetRhgyDetailData $GetRhgyDetailDataFromJson(Map<String, dynamic> json) {
  final GetRhgyDetailData getRhgyDetailData = GetRhgyDetailData();
  final String? tt = jsonConvert.convert<String>(json['tt']);
  if (tt != null) {
    getRhgyDetailData.tt = tt;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    getRhgyDetailData.tnjc = tnjc;
  }
  final int? mss = jsonConvert.convert<int>(json['mss']);
  if (mss != null) {
    getRhgyDetailData.mss = mss;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    getRhgyDetailData.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    getRhgyDetailData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    getRhgyDetailData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    getRhgyDetailData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    getRhgyDetailData.mcg = mcg;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    getRhgyDetailData.atf = atf;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    getRhgyDetailData.mdsc = mdsc;
  }
  final int? mks = jsonConvert.convert<int>(json['mks']);
  if (mks != null) {
    getRhgyDetailData.mks = mks;
  }
  final String? msts = jsonConvert.convert<String>(json['msts']);
  if (msts != null) {
    getRhgyDetailData.msts = msts;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    getRhgyDetailData.gcs = gcs;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    getRhgyDetailData.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    getRhgyDetailData.mgt = mgt;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    getRhgyDetailData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    getRhgyDetailData.mct = mct;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    getRhgyDetailData.tlev = tlev;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    getRhgyDetailData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    getRhgyDetailData.mo = mo;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    getRhgyDetailData.ctt = ctt;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    getRhgyDetailData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    getRhgyDetailData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    getRhgyDetailData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    getRhgyDetailData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    getRhgyDetailData.mle = mle;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    getRhgyDetailData.lvs = lvs;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    getRhgyDetailData.sort = sort;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    getRhgyDetailData.malu = malu;
  }
  final String? vf = jsonConvert.convert<String>(json['vf']);
  if (vf != null) {
    getRhgyDetailData.vf = vf;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    getRhgyDetailData.lurl = lurl;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    getRhgyDetailData.mprmc = mprmc;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    getRhgyDetailData.mhn = mhn;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    getRhgyDetailData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    getRhgyDetailData.frmhn = frmhn;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    getRhgyDetailData.operationTournamentSort = operationTournamentSort;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    getRhgyDetailData.mhs = mhs;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    getRhgyDetailData.mlet = mlet;
  }
  final int? mds = jsonConvert.convert<int>(json['mds']);
  if (mds != null) {
    getRhgyDetailData.mds = mds;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    getRhgyDetailData.mhid = mhid;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    getRhgyDetailData.mrmc = mrmc;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    getRhgyDetailData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    getRhgyDetailData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    getRhgyDetailData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    getRhgyDetailData.mmp = mmp;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    getRhgyDetailData.mststi = mststi;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    getRhgyDetailData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    getRhgyDetailData.mbmty = mbmty;
  }
  final int? mis = jsonConvert.convert<int>(json['mis']);
  if (mis != null) {
    getRhgyDetailData.mis = mis;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    getRhgyDetailData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    getRhgyDetailData.mhlu = mhlu;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    getRhgyDetailData.seid = seid;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    getRhgyDetailData.mstst = mstst;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    getRhgyDetailData.malut = malut;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    getRhgyDetailData.man = man;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    getRhgyDetailData.frman = frman;
  }
  final String? met = jsonConvert.convert<String>(json['met']);
  if (met != null) {
    getRhgyDetailData.met = met;
  }
  final String? st = jsonConvert.convert<String>(json['st']);
  if (st != null) {
    getRhgyDetailData.st = st;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    getRhgyDetailData.mat = mat;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    getRhgyDetailData.mng = mng;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    getRhgyDetailData.mststr = mststr;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    getRhgyDetailData.mvs = mvs;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    getRhgyDetailData.mststs = mststs;
  }
  final String? tc = jsonConvert.convert<String>(json['tc']);
  if (tc != null) {
    getRhgyDetailData.tc = tc;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    getRhgyDetailData.mearlys = mearlys;
  }
  final bool? hipo = jsonConvert.convert<bool>(json['hipo']);
  if (hipo != null) {
    getRhgyDetailData.hipo = hipo;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    getRhgyDetailData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    getRhgyDetailData.mft = mft;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    getRhgyDetailData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    getRhgyDetailData.msc = msc;
  }
  return getRhgyDetailData;
}

Map<String, dynamic> $GetRhgyDetailDataToJson(GetRhgyDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tt'] = entity.tt;
  data['tnjc'] = entity.tnjc;
  data['mss'] = entity.mss;
  data['csna'] = entity.csna;
  data['tid'] = entity.tid;
  data['mst'] = entity.mst;
  data['srid'] = entity.srid;
  data['mcg'] = entity.mcg;
  data['atf'] = entity.atf;
  data['mdsc'] = entity.mdsc;
  data['mks'] = entity.mks;
  data['msts'] = entity.msts;
  data['gcs'] = entity.gcs;
  data['mf'] = entity.mf;
  data['mgt'] = entity.mgt;
  data['maid'] = entity.maid;
  data['mct'] = entity.mct;
  data['tlev'] = entity.tlev;
  data['mhlut'] = entity.mhlut;
  data['mo'] = entity.mo;
  data['ctt'] = entity.ctt;
  data['mp'] = entity.mp;
  data['csid'] = entity.csid;
  data['ms'] = entity.ms;
  data['cmec'] = entity.cmec;
  data['mle'] = entity.mle;
  data['lvs'] = entity.lvs;
  data['sort'] = entity.sort;
  data['malu'] = entity.malu;
  data['vf'] = entity.vf;
  data['lurl'] = entity.lurl;
  data['mprmc'] = entity.mprmc;
  data['mhn'] = entity.mhn;
  data['cds'] = entity.cds;
  data['frmhn'] = entity.frmhn;
  data['operationTournamentSort'] = entity.operationTournamentSort;
  data['mhs'] = entity.mhs;
  data['mlet'] = entity.mlet;
  data['mds'] = entity.mds;
  data['mhid'] = entity.mhid;
  data['mrmc'] = entity.mrmc;
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['lss'] = entity.lss;
  data['mmp'] = entity.mmp;
  data['mststi'] = entity.mststi;
  data['mms'] = entity.mms;
  data['mbmty'] = entity.mbmty;
  data['mis'] = entity.mis;
  data['pmms'] = entity.pmms;
  data['mhlu'] = entity.mhlu;
  data['seid'] = entity.seid;
  data['mstst'] = entity.mstst;
  data['malut'] = entity.malut;
  data['man'] = entity.man;
  data['frman'] = entity.frman;
  data['met'] = entity.met;
  data['st'] = entity.st;
  data['mat'] = entity.mat;
  data['mng'] = entity.mng;
  data['mststr'] = entity.mststr;
  data['mvs'] = entity.mvs;
  data['mststs'] = entity.mststs;
  data['tc'] = entity.tc;
  data['mearlys'] = entity.mearlys;
  data['hipo'] = entity.hipo;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension GetRhgyDetailDataExtension on GetRhgyDetailData {
  GetRhgyDetailData copyWith({
    String? tt,
    String? tnjc,
    int? mss,
    String? csna,
    String? tid,
    String? mst,
    String? srid,
    int? mcg,
    String? atf,
    dynamic mdsc,
    int? mks,
    String? msts,
    int? gcs,
    bool? mf,
    String? mgt,
    String? maid,
    int? mct,
    int? tlev,
    String? mhlut,
    int? mo,
    int? ctt,
    int? mp,
    String? csid,
    int? ms,
    String? cmec,
    int? mle,
    int? lvs,
    int? sort,
    List<String>? malu,
    String? vf,
    String? lurl,
    String? mprmc,
    String? mhn,
    String? cds,
    List<String>? frmhn,
    int? operationTournamentSort,
    int? mhs,
    String? mlet,
    int? mds,
    String? mhid,
    String? mrmc,
    String? mid,
    int? mess,
    dynamic lss,
    String? mmp,
    String? mststi,
    int? mms,
    int? mbmty,
    int? mis,
    int? pmms,
    List<String>? mhlu,
    String? seid,
    String? mstst,
    String? malut,
    String? man,
    List<String>? frman,
    String? met,
    String? st,
    String? mat,
    int? mng,
    String? mststr,
    int? mvs,
    int? mststs,
    String? tc,
    int? mearlys,
    bool? hipo,
    dynamic mfo,
    int? mft,
    String? tn,
    List<String>? msc,
  }) {
    return GetRhgyDetailData()
      ..tt = tt ?? this.tt
      ..tnjc = tnjc ?? this.tnjc
      ..mss = mss ?? this.mss
      ..csna = csna ?? this.csna
      ..tid = tid ?? this.tid
      ..mst = mst ?? this.mst
      ..srid = srid ?? this.srid
      ..mcg = mcg ?? this.mcg
      ..atf = atf ?? this.atf
      ..mdsc = mdsc ?? this.mdsc
      ..mks = mks ?? this.mks
      ..msts = msts ?? this.msts
      ..gcs = gcs ?? this.gcs
      ..mf = mf ?? this.mf
      ..mgt = mgt ?? this.mgt
      ..maid = maid ?? this.maid
      ..mct = mct ?? this.mct
      ..tlev = tlev ?? this.tlev
      ..mhlut = mhlut ?? this.mhlut
      ..mo = mo ?? this.mo
      ..ctt = ctt ?? this.ctt
      ..mp = mp ?? this.mp
      ..csid = csid ?? this.csid
      ..ms = ms ?? this.ms
      ..cmec = cmec ?? this.cmec
      ..mle = mle ?? this.mle
      ..lvs = lvs ?? this.lvs
      ..sort = sort ?? this.sort
      ..malu = malu ?? this.malu
      ..vf = vf ?? this.vf
      ..lurl = lurl ?? this.lurl
      ..mprmc = mprmc ?? this.mprmc
      ..mhn = mhn ?? this.mhn
      ..cds = cds ?? this.cds
      ..frmhn = frmhn ?? this.frmhn
      ..operationTournamentSort = operationTournamentSort ??
          this.operationTournamentSort
      ..mhs = mhs ?? this.mhs
      ..mlet = mlet ?? this.mlet
      ..mds = mds ?? this.mds
      ..mhid = mhid ?? this.mhid
      ..mrmc = mrmc ?? this.mrmc
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..lss = lss ?? this.lss
      ..mmp = mmp ?? this.mmp
      ..mststi = mststi ?? this.mststi
      ..mms = mms ?? this.mms
      ..mbmty = mbmty ?? this.mbmty
      ..mis = mis ?? this.mis
      ..pmms = pmms ?? this.pmms
      ..mhlu = mhlu ?? this.mhlu
      ..seid = seid ?? this.seid
      ..mstst = mstst ?? this.mstst
      ..malut = malut ?? this.malut
      ..man = man ?? this.man
      ..frman = frman ?? this.frman
      ..met = met ?? this.met
      ..st = st ?? this.st
      ..mat = mat ?? this.mat
      ..mng = mng ?? this.mng
      ..mststr = mststr ?? this.mststr
      ..mvs = mvs ?? this.mvs
      ..mststs = mststs ?? this.mststs
      ..tc = tc ?? this.tc
      ..mearlys = mearlys ?? this.mearlys
      ..hipo = hipo ?? this.hipo
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc;
  }
}