import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/matche_resultl_entity.dart';

MatcheResultlEntity $MatcheResultlEntityFromJson(Map<String, dynamic> json) {
  final MatcheResultlEntity matcheResultlEntity = MatcheResultlEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matcheResultlEntity.code = code;
  }
  final List<MatcheResultlData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MatcheResultlData>(e) as MatcheResultlData)
      .toList();
  if (data != null) {
    matcheResultlEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matcheResultlEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matcheResultlEntity.ts = ts;
  }
  return matcheResultlEntity;
}

Map<String, dynamic> $MatcheResultlEntityToJson(MatcheResultlEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatcheResultlEntityExtension on MatcheResultlEntity {
  MatcheResultlEntity copyWith({
    String? code,
    List<MatcheResultlData>? data,
    String? msg,
    int? ts,
  }) {
    return MatcheResultlEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatcheResultlData $MatcheResultlDataFromJson(Map<String, dynamic> json) {
  final MatcheResultlData matcheResultlData = MatcheResultlData();
  final String? tt = jsonConvert.convert<String>(json['tt']);
  if (tt != null) {
    matcheResultlData.tt = tt;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    matcheResultlData.tnjc = tnjc;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    matcheResultlData.csna = csna;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matcheResultlData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    matcheResultlData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    matcheResultlData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    matcheResultlData.mcg = mcg;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    matcheResultlData.atf = atf;
  }
  final String? mdsc = jsonConvert.convert<String>(json['mdsc']);
  if (mdsc != null) {
    matcheResultlData.mdsc = mdsc;
  }
  final int? nms = jsonConvert.convert<int>(json['nms']);
  if (nms != null) {
    matcheResultlData.nms = nms;
  }
  final String? msts = jsonConvert.convert<String>(json['msts']);
  if (msts != null) {
    matcheResultlData.msts = msts;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    matcheResultlData.gcs = gcs;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    matcheResultlData.mf = mf;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    matcheResultlData.mgt = mgt;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    matcheResultlData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    matcheResultlData.mct = mct;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    matcheResultlData.tlev = tlev;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    matcheResultlData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    matcheResultlData.mo = mo;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    matcheResultlData.ctt = ctt;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    matcheResultlData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    matcheResultlData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matcheResultlData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    matcheResultlData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    matcheResultlData.mle = mle;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    matcheResultlData.lvs = lvs;
  }
  final dynamic sort = json['sort'];
  if (sort != null) {
    matcheResultlData.sort = sort;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    matcheResultlData.malu = malu;
  }
  final String? vf = jsonConvert.convert<String>(json['vf']);
  if (vf != null) {
    matcheResultlData.vf = vf;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    matcheResultlData.lurl = lurl;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    matcheResultlData.mprmc = mprmc;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    matcheResultlData.mhn = mhn;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matcheResultlData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    matcheResultlData.frmhn = frmhn;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    matcheResultlData.operationTournamentSort = operationTournamentSort;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matcheResultlData.mhs = mhs;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    matcheResultlData.mlet = mlet;
  }
  final dynamic tonum = json['tonum'];
  if (tonum != null) {
    matcheResultlData.tonum = tonum;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    matcheResultlData.mhid = mhid;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    matcheResultlData.mrmc = mrmc;
  }
  final bool? playBack = jsonConvert.convert<bool>(json['playBack']);
  if (playBack != null) {
    matcheResultlData.playBack = playBack;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matcheResultlData.mid = mid;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matcheResultlData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    matcheResultlData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matcheResultlData.mmp = mmp;
  }
  final dynamic mststi = json['mststi'];
  if (mststi != null) {
    matcheResultlData.mststi = mststi;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matcheResultlData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    matcheResultlData.mbmty = mbmty;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    matcheResultlData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    matcheResultlData.mhlu = mhlu;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    matcheResultlData.seid = seid;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    matcheResultlData.mstst = mstst;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    matcheResultlData.malut = malut;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    matcheResultlData.man = man;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    matcheResultlData.frman = frman;
  }
  final String? met = jsonConvert.convert<String>(json['met']);
  if (met != null) {
    matcheResultlData.met = met;
  }
  final dynamic st = json['st'];
  if (st != null) {
    matcheResultlData.st = st;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matcheResultlData.mat = mat;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    matcheResultlData.mng = mng;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    matcheResultlData.mststr = mststr;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    matcheResultlData.mvs = mvs;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    matcheResultlData.mststs = mststs;
  }
  final String? tc = jsonConvert.convert<String>(json['tc']);
  if (tc != null) {
    matcheResultlData.tc = tc;
  }
  final int? tournamentSort = jsonConvert.convert<int>(json['tournamentSort']);
  if (tournamentSort != null) {
    matcheResultlData.tournamentSort = tournamentSort;
  }
  final String? sId = jsonConvert.convert<String>(json['sId']);
  if (sId != null) {
    matcheResultlData.sId = sId;
  }
  final dynamic mearlys = json['mearlys'];
  if (mearlys != null) {
    matcheResultlData.mearlys = mearlys;
  }
  final bool? hipo = jsonConvert.convert<bool>(json['hipo']);
  if (hipo != null) {
    matcheResultlData.hipo = hipo;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    matcheResultlData.tf = tf;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    matcheResultlData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    matcheResultlData.mft = mft;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    matcheResultlData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    matcheResultlData.msc = msc;
  }
  return matcheResultlData;
}

Map<String, dynamic> $MatcheResultlDataToJson(MatcheResultlData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tt'] = entity.tt;
  data['tnjc'] = entity.tnjc;
  data['csna'] = entity.csna;
  data['tid'] = entity.tid;
  data['mst'] = entity.mst;
  data['srid'] = entity.srid;
  data['mcg'] = entity.mcg;
  data['atf'] = entity.atf;
  data['mdsc'] = entity.mdsc;
  data['nms'] = entity.nms;
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
  data['tonum'] = entity.tonum;
  data['mhid'] = entity.mhid;
  data['mrmc'] = entity.mrmc;
  data['playBack'] = entity.playBack;
  data['mid'] = entity.mid;
  data['mess'] = entity.mess;
  data['lss'] = entity.lss;
  data['mmp'] = entity.mmp;
  data['mststi'] = entity.mststi;
  data['mms'] = entity.mms;
  data['mbmty'] = entity.mbmty;
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
  data['tournamentSort'] = entity.tournamentSort;
  data['sId'] = entity.sId;
  data['mearlys'] = entity.mearlys;
  data['hipo'] = entity.hipo;
  data['tf'] = entity.tf;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  return data;
}

extension MatcheResultlDataExtension on MatcheResultlData {
  MatcheResultlData copyWith({
    String? tt,
    String? tnjc,
    String? csna,
    String? tid,
    String? mst,
    String? srid,
    int? mcg,
    String? atf,
    String? mdsc,
    int? nms,
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
    dynamic sort,
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
    dynamic tonum,
    String? mhid,
    String? mrmc,
    bool? playBack,
    String? mid,
    int? mess,
    dynamic lss,
    String? mmp,
    dynamic mststi,
    int? mms,
    int? mbmty,
    int? pmms,
    List<String>? mhlu,
    String? seid,
    String? mstst,
    String? malut,
    String? man,
    List<String>? frman,
    String? met,
    dynamic st,
    String? mat,
    int? mng,
    String? mststr,
    int? mvs,
    int? mststs,
    String? tc,
    int? tournamentSort,
    String? sId,
    dynamic mearlys,
    bool? hipo,
    bool? tf,
    dynamic mfo,
    int? mft,
    String? tn,
    List<String>? msc,
  }) {
    return MatcheResultlData()
      ..tt = tt ?? this.tt
      ..tnjc = tnjc ?? this.tnjc
      ..csna = csna ?? this.csna
      ..tid = tid ?? this.tid
      ..mst = mst ?? this.mst
      ..srid = srid ?? this.srid
      ..mcg = mcg ?? this.mcg
      ..atf = atf ?? this.atf
      ..mdsc = mdsc ?? this.mdsc
      ..nms = nms ?? this.nms
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
      ..tonum = tonum ?? this.tonum
      ..mhid = mhid ?? this.mhid
      ..mrmc = mrmc ?? this.mrmc
      ..playBack = playBack ?? this.playBack
      ..mid = mid ?? this.mid
      ..mess = mess ?? this.mess
      ..lss = lss ?? this.lss
      ..mmp = mmp ?? this.mmp
      ..mststi = mststi ?? this.mststi
      ..mms = mms ?? this.mms
      ..mbmty = mbmty ?? this.mbmty
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
      ..tournamentSort = tournamentSort ?? this.tournamentSort
      ..sId = sId ?? this.sId
      ..mearlys = mearlys ?? this.mearlys
      ..hipo = hipo ?? this.hipo
      ..tf = tf ?? this.tf
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc;
  }
}