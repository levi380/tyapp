import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/cos_outright_entity.dart';

CosOutrightEntity $CosOutrightEntityFromJson(Map<String, dynamic> json) {
  final CosOutrightEntity cosOutrightEntity = CosOutrightEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    cosOutrightEntity.code = code;
  }
  final List<CosOutrightData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CosOutrightData>(e) as CosOutrightData)
      .toList();
  if (data != null) {
    cosOutrightEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    cosOutrightEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    cosOutrightEntity.ts = ts;
  }
  return cosOutrightEntity;
}

Map<String, dynamic> $CosOutrightEntityToJson(CosOutrightEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension CosOutrightEntityExtension on CosOutrightEntity {
  CosOutrightEntity copyWith({
    String? code,
    List<CosOutrightData>? data,
    String? msg,
    int? ts,
  }) {
    return CosOutrightEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

CosOutrightData $CosOutrightDataFromJson(Map<String, dynamic> json) {
  final CosOutrightData cosOutrightData = CosOutrightData();
  final String? mcid = jsonConvert.convert<String>(json['mcid']);
  if (mcid != null) {
    cosOutrightData.mcid = mcid;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    cosOutrightData.tnjc = tnjc;
  }
  final bool? cosTCorner = jsonConvert.convert<bool>(json['cosTCorner']);
  if (cosTCorner != null) {
    cosOutrightData.cosTCorner = cosTCorner;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    cosOutrightData.csna = csna;
  }
  final bool? cosTPunish = jsonConvert.convert<bool>(json['cosTPunish']);
  if (cosTPunish != null) {
    cosOutrightData.cosTPunish = cosTPunish;
  }
  final bool? cosOutright = jsonConvert.convert<bool>(json['cosOutright']);
  if (cosOutright != null) {
    cosOutrightData.cosOutright = cosOutright;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    cosOutrightData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    cosOutrightData.gcs = gcs;
  }
  final List<dynamic>? hpsOvertime = (json['hpsOvertime'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOvertime != null) {
    cosOutrightData.hpsOvertime = hpsOvertime;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    cosOutrightData.mgt = mgt;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    cosOutrightData.tlev = tlev;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    cosOutrightData.ctt = ctt;
  }
  final bool? cos5Minutes = jsonConvert.convert<bool>(json['cos5Minutes']);
  if (cos5Minutes != null) {
    cosOutrightData.cos5Minutes = cos5Minutes;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    cosOutrightData.lvs = lvs;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    cosOutrightData.malu = malu;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    cosOutrightData.mprmc = mprmc;
  }
  final bool? cosOvertime = jsonConvert.convert<bool>(json['cosOvertime']);
  if (cosOvertime != null) {
    cosOutrightData.cosOvertime = cosOvertime;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    cosOutrightData.mhn = mhn;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    cosOutrightData.betAmount = betAmount;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    cosOutrightData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    cosOutrightData.frmhn = frmhn;
  }
  final bool? compose = jsonConvert.convert<bool>(json['compose']);
  if (compose != null) {
    cosOutrightData.compose = compose;
  }
  final bool? cosTBold = jsonConvert.convert<bool>(json['cosTBold']);
  if (cosTBold != null) {
    cosOutrightData.cosTBold = cosTBold;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    cosOutrightData.operationTournamentSort = operationTournamentSort;
  }
  final bool? cos15Minutes = jsonConvert.convert<bool>(json['cos15Minutes']);
  if (cos15Minutes != null) {
    cosOutrightData.cos15Minutes = cos15Minutes;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    cosOutrightData.mhs = mhs;
  }
  final List<dynamic>? hps5Minutes = (json['hps5Minutes'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hps5Minutes != null) {
    cosOutrightData.hps5Minutes = hps5Minutes;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    cosOutrightData.mid = mid;
  }
  final bool? cosBold = jsonConvert.convert<bool>(json['cosBold']);
  if (cosBold != null) {
    cosOutrightData.cosBold = cosBold;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    cosOutrightData.mststi = mststi;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    cosOutrightData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    cosOutrightData.mhlu = mhlu;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    cosOutrightData.mstst = mstst;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    cosOutrightData.man = man;
  }
  final List<dynamic>? hpsTBold = (json['hpsTBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTBold != null) {
    cosOutrightData.hpsTBold = hpsTBold;
  }
  final String? st = jsonConvert.convert<String>(json['st']);
  if (st != null) {
    cosOutrightData.st = st;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    cosOutrightData.mat = mat;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    cosOutrightData.mststr = mststr;
  }
  final List<CosOutrightDataHps>? hps = (json['hps'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CosOutrightDataHps>(e) as CosOutrightDataHps)
      .toList();
  if (hps != null) {
    cosOutrightData.hps = hps;
  }
  final List<dynamic>? hpsCompose = (json['hpsCompose'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCompose != null) {
    cosOutrightData.hpsCompose = hpsCompose;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    cosOutrightData.mststs = mststs;
  }
  final String? tc = jsonConvert.convert<String>(json['tc']);
  if (tc != null) {
    cosOutrightData.tc = tc;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    cosOutrightData.tf = tf;
  }
  final int? th = jsonConvert.convert<int>(json['th']);
  if (th != null) {
    cosOutrightData.th = th;
  }
  final bool? cosPromotion = jsonConvert.convert<bool>(json['cosPromotion']);
  if (cosPromotion != null) {
    cosOutrightData.cosPromotion = cosPromotion;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    cosOutrightData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    cosOutrightData.msc = msc;
  }
  final List<dynamic>? hpsPromotion = (json['hpsPromotion'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsPromotion != null) {
    cosOutrightData.hpsPromotion = hpsPromotion;
  }
  final String? tt = jsonConvert.convert<String>(json['tt']);
  if (tt != null) {
    cosOutrightData.tt = tt;
  }
  final List<dynamic>? hpsBold = (json['hpsBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsBold != null) {
    cosOutrightData.hpsBold = hpsBold;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    cosOutrightData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    cosOutrightData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    cosOutrightData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    cosOutrightData.mcg = mcg;
  }
  final bool? cosCorner = jsonConvert.convert<bool>(json['cosCorner']);
  if (cosCorner != null) {
    cosOutrightData.cosCorner = cosCorner;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    cosOutrightData.atf = atf;
  }
  final bool? cosPunish = jsonConvert.convert<bool>(json['cosPunish']);
  if (cosPunish != null) {
    cosOutrightData.cosPunish = cosPunish;
  }
  final String? msts = jsonConvert.convert<String>(json['msts']);
  if (msts != null) {
    cosOutrightData.msts = msts;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    cosOutrightData.mc = mc;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    cosOutrightData.mf = mf;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    cosOutrightData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    cosOutrightData.mct = mct;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    cosOutrightData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    cosOutrightData.mo = mo;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    cosOutrightData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    cosOutrightData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    cosOutrightData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    cosOutrightData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    cosOutrightData.mle = mle;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    cosOutrightData.sort = sort;
  }
  final String? vf = jsonConvert.convert<String>(json['vf']);
  if (vf != null) {
    cosOutrightData.vf = vf;
  }
  final List<
      CosOutrightDataHps15Minutes>? hps15Minutes = (json['hps15Minutes'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CosOutrightDataHps15Minutes>(
          e) as CosOutrightDataHps15Minutes).toList();
  if (hps15Minutes != null) {
    cosOutrightData.hps15Minutes = hps15Minutes;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    cosOutrightData.lurl = lurl;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    cosOutrightData.mlet = mlet;
  }
  final bool? cosPenalty = jsonConvert.convert<bool>(json['cosPenalty']);
  if (cosPenalty != null) {
    cosOutrightData.cosPenalty = cosPenalty;
  }
  final List<dynamic>? hpsCorner = (json['hpsCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCorner != null) {
    cosOutrightData.hpsCorner = hpsCorner;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    cosOutrightData.mhid = mhid;
  }
  final List<dynamic>? hpsPunish = (json['hpsPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPunish != null) {
    cosOutrightData.hpsPunish = hpsPunish;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    cosOutrightData.mrmc = mrmc;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    cosOutrightData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    cosOutrightData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    cosOutrightData.mmp = mmp;
  }
  final int? operationHotSortTop = jsonConvert.convert<int>(
      json['operationHotSortTop']);
  if (operationHotSortTop != null) {
    cosOutrightData.operationHotSortTop = operationHotSortTop;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    cosOutrightData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    cosOutrightData.mbmty = mbmty;
  }
  final int? regionIdSort = jsonConvert.convert<int>(json['regionIdSort']);
  if (regionIdSort != null) {
    cosOutrightData.regionIdSort = regionIdSort;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    cosOutrightData.seid = seid;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    cosOutrightData.malut = malut;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    cosOutrightData.frman = frman;
  }
  final String? met = jsonConvert.convert<String>(json['met']);
  if (met != null) {
    cosOutrightData.met = met;
  }
  final List<dynamic>? hpsTPunish = (json['hpsTPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTPunish != null) {
    cosOutrightData.hpsTPunish = hpsTPunish;
  }
  final List<dynamic>? hpsTCorner = (json['hpsTCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTCorner != null) {
    cosOutrightData.hpsTCorner = hpsTCorner;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    cosOutrightData.mng = mng;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    cosOutrightData.mvs = mvs;
  }
  final List<dynamic>? hpsPenalty = (json['hpsPenalty'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPenalty != null) {
    cosOutrightData.hpsPenalty = hpsPenalty;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    cosOutrightData.mearlys = mearlys;
  }
  final bool? hipo = jsonConvert.convert<bool>(json['hipo']);
  if (hipo != null) {
    cosOutrightData.hipo = hipo;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    cosOutrightData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    cosOutrightData.mft = mft;
  }
  final List<dynamic>? hpsOutright = (json['hpsOutright'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOutright != null) {
    cosOutrightData.hpsOutright = hpsOutright;
  }
  return cosOutrightData;
}

Map<String, dynamic> $CosOutrightDataToJson(CosOutrightData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mcid'] = entity.mcid;
  data['tnjc'] = entity.tnjc;
  data['cosTCorner'] = entity.cosTCorner;
  data['csna'] = entity.csna;
  data['cosTPunish'] = entity.cosTPunish;
  data['cosOutright'] = entity.cosOutright;
  data['mdsc'] = entity.mdsc;
  data['gcs'] = entity.gcs;
  data['hpsOvertime'] = entity.hpsOvertime;
  data['mgt'] = entity.mgt;
  data['tlev'] = entity.tlev;
  data['ctt'] = entity.ctt;
  data['cos5Minutes'] = entity.cos5Minutes;
  data['lvs'] = entity.lvs;
  data['malu'] = entity.malu;
  data['mprmc'] = entity.mprmc;
  data['cosOvertime'] = entity.cosOvertime;
  data['mhn'] = entity.mhn;
  data['betAmount'] = entity.betAmount;
  data['cds'] = entity.cds;
  data['frmhn'] = entity.frmhn;
  data['compose'] = entity.compose;
  data['cosTBold'] = entity.cosTBold;
  data['operationTournamentSort'] = entity.operationTournamentSort;
  data['cos15Minutes'] = entity.cos15Minutes;
  data['mhs'] = entity.mhs;
  data['hps5Minutes'] = entity.hps5Minutes;
  data['mid'] = entity.mid;
  data['cosBold'] = entity.cosBold;
  data['mststi'] = entity.mststi;
  data['pmms'] = entity.pmms;
  data['mhlu'] = entity.mhlu;
  data['mstst'] = entity.mstst;
  data['man'] = entity.man;
  data['hpsTBold'] = entity.hpsTBold;
  data['st'] = entity.st;
  data['mat'] = entity.mat;
  data['mststr'] = entity.mststr;
  data['hps'] = entity.hps.map((v) => v.toJson()).toList();
  data['hpsCompose'] = entity.hpsCompose;
  data['mststs'] = entity.mststs;
  data['tc'] = entity.tc;
  data['tf'] = entity.tf;
  data['th'] = entity.th;
  data['cosPromotion'] = entity.cosPromotion;
  data['tn'] = entity.tn;
  data['msc'] = entity.msc;
  data['hpsPromotion'] = entity.hpsPromotion;
  data['tt'] = entity.tt;
  data['hpsBold'] = entity.hpsBold;
  data['tid'] = entity.tid;
  data['mst'] = entity.mst;
  data['srid'] = entity.srid;
  data['mcg'] = entity.mcg;
  data['cosCorner'] = entity.cosCorner;
  data['atf'] = entity.atf;
  data['cosPunish'] = entity.cosPunish;
  data['msts'] = entity.msts;
  data['mc'] = entity.mc;
  data['mf'] = entity.mf;
  data['maid'] = entity.maid;
  data['mct'] = entity.mct;
  data['mhlut'] = entity.mhlut;
  data['mo'] = entity.mo;
  data['mp'] = entity.mp;
  data['csid'] = entity.csid;
  data['ms'] = entity.ms;
  data['cmec'] = entity.cmec;
  data['mle'] = entity.mle;
  data['sort'] = entity.sort;
  data['vf'] = entity.vf;
  data['hps15Minutes'] = entity.hps15Minutes.map((v) => v.toJson()).toList();
  data['lurl'] = entity.lurl;
  data['mlet'] = entity.mlet;
  data['cosPenalty'] = entity.cosPenalty;
  data['hpsCorner'] = entity.hpsCorner;
  data['mhid'] = entity.mhid;
  data['hpsPunish'] = entity.hpsPunish;
  data['mrmc'] = entity.mrmc;
  data['mess'] = entity.mess;
  data['lss'] = entity.lss;
  data['mmp'] = entity.mmp;
  data['operationHotSortTop'] = entity.operationHotSortTop;
  data['mms'] = entity.mms;
  data['mbmty'] = entity.mbmty;
  data['regionIdSort'] = entity.regionIdSort;
  data['seid'] = entity.seid;
  data['malut'] = entity.malut;
  data['frman'] = entity.frman;
  data['met'] = entity.met;
  data['hpsTPunish'] = entity.hpsTPunish;
  data['hpsTCorner'] = entity.hpsTCorner;
  data['mng'] = entity.mng;
  data['mvs'] = entity.mvs;
  data['hpsPenalty'] = entity.hpsPenalty;
  data['mearlys'] = entity.mearlys;
  data['hipo'] = entity.hipo;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['hpsOutright'] = entity.hpsOutright;
  return data;
}

extension CosOutrightDataExtension on CosOutrightData {
  CosOutrightData copyWith({
    String? mcid,
    String? tnjc,
    bool? cosTCorner,
    String? csna,
    bool? cosTPunish,
    bool? cosOutright,
    dynamic mdsc,
    int? gcs,
    List<dynamic>? hpsOvertime,
    String? mgt,
    int? tlev,
    int? ctt,
    bool? cos5Minutes,
    int? lvs,
    List<String>? malu,
    String? mprmc,
    bool? cosOvertime,
    String? mhn,
    String? betAmount,
    String? cds,
    List<String>? frmhn,
    bool? compose,
    bool? cosTBold,
    int? operationTournamentSort,
    bool? cos15Minutes,
    int? mhs,
    List<dynamic>? hps5Minutes,
    String? mid,
    bool? cosBold,
    String? mststi,
    int? pmms,
    List<String>? mhlu,
    String? mstst,
    String? man,
    List<dynamic>? hpsTBold,
    String? st,
    String? mat,
    String? mststr,
    List<CosOutrightDataHps>? hps,
    List<dynamic>? hpsCompose,
    int? mststs,
    String? tc,
    bool? tf,
    int? th,
    bool? cosPromotion,
    String? tn,
    List<String>? msc,
    List<dynamic>? hpsPromotion,
    String? tt,
    List<dynamic>? hpsBold,
    String? tid,
    String? mst,
    String? srid,
    int? mcg,
    bool? cosCorner,
    String? atf,
    bool? cosPunish,
    String? msts,
    int? mc,
    bool? mf,
    String? maid,
    int? mct,
    String? mhlut,
    int? mo,
    int? mp,
    String? csid,
    int? ms,
    String? cmec,
    int? mle,
    int? sort,
    String? vf,
    List<CosOutrightDataHps15Minutes>? hps15Minutes,
    String? lurl,
    String? mlet,
    bool? cosPenalty,
    List<dynamic>? hpsCorner,
    String? mhid,
    List<dynamic>? hpsPunish,
    String? mrmc,
    int? mess,
    dynamic lss,
    String? mmp,
    int? operationHotSortTop,
    int? mms,
    int? mbmty,
    int? regionIdSort,
    String? seid,
    String? malut,
    List<String>? frman,
    String? met,
    List<dynamic>? hpsTPunish,
    List<dynamic>? hpsTCorner,
    int? mng,
    int? mvs,
    List<dynamic>? hpsPenalty,
    int? mearlys,
    bool? hipo,
    dynamic mfo,
    int? mft,
    List<dynamic>? hpsOutright,
  }) {
    return CosOutrightData()
      ..mcid = mcid ?? this.mcid
      ..tnjc = tnjc ?? this.tnjc
      ..cosTCorner = cosTCorner ?? this.cosTCorner
      ..csna = csna ?? this.csna
      ..cosTPunish = cosTPunish ?? this.cosTPunish
      ..cosOutright = cosOutright ?? this.cosOutright
      ..mdsc = mdsc ?? this.mdsc
      ..gcs = gcs ?? this.gcs
      ..hpsOvertime = hpsOvertime ?? this.hpsOvertime
      ..mgt = mgt ?? this.mgt
      ..tlev = tlev ?? this.tlev
      ..ctt = ctt ?? this.ctt
      ..cos5Minutes = cos5Minutes ?? this.cos5Minutes
      ..lvs = lvs ?? this.lvs
      ..malu = malu ?? this.malu
      ..mprmc = mprmc ?? this.mprmc
      ..cosOvertime = cosOvertime ?? this.cosOvertime
      ..mhn = mhn ?? this.mhn
      ..betAmount = betAmount ?? this.betAmount
      ..cds = cds ?? this.cds
      ..frmhn = frmhn ?? this.frmhn
      ..compose = compose ?? this.compose
      ..cosTBold = cosTBold ?? this.cosTBold
      ..operationTournamentSort = operationTournamentSort ??
          this.operationTournamentSort
      ..cos15Minutes = cos15Minutes ?? this.cos15Minutes
      ..mhs = mhs ?? this.mhs
      ..hps5Minutes = hps5Minutes ?? this.hps5Minutes
      ..mid = mid ?? this.mid
      ..cosBold = cosBold ?? this.cosBold
      ..mststi = mststi ?? this.mststi
      ..pmms = pmms ?? this.pmms
      ..mhlu = mhlu ?? this.mhlu
      ..mstst = mstst ?? this.mstst
      ..man = man ?? this.man
      ..hpsTBold = hpsTBold ?? this.hpsTBold
      ..st = st ?? this.st
      ..mat = mat ?? this.mat
      ..mststr = mststr ?? this.mststr
      ..hps = hps ?? this.hps
      ..hpsCompose = hpsCompose ?? this.hpsCompose
      ..mststs = mststs ?? this.mststs
      ..tc = tc ?? this.tc
      ..tf = tf ?? this.tf
      ..th = th ?? this.th
      ..cosPromotion = cosPromotion ?? this.cosPromotion
      ..tn = tn ?? this.tn
      ..msc = msc ?? this.msc
      ..hpsPromotion = hpsPromotion ?? this.hpsPromotion
      ..tt = tt ?? this.tt
      ..hpsBold = hpsBold ?? this.hpsBold
      ..tid = tid ?? this.tid
      ..mst = mst ?? this.mst
      ..srid = srid ?? this.srid
      ..mcg = mcg ?? this.mcg
      ..cosCorner = cosCorner ?? this.cosCorner
      ..atf = atf ?? this.atf
      ..cosPunish = cosPunish ?? this.cosPunish
      ..msts = msts ?? this.msts
      ..mc = mc ?? this.mc
      ..mf = mf ?? this.mf
      ..maid = maid ?? this.maid
      ..mct = mct ?? this.mct
      ..mhlut = mhlut ?? this.mhlut
      ..mo = mo ?? this.mo
      ..mp = mp ?? this.mp
      ..csid = csid ?? this.csid
      ..ms = ms ?? this.ms
      ..cmec = cmec ?? this.cmec
      ..mle = mle ?? this.mle
      ..sort = sort ?? this.sort
      ..vf = vf ?? this.vf
      ..hps15Minutes = hps15Minutes ?? this.hps15Minutes
      ..lurl = lurl ?? this.lurl
      ..mlet = mlet ?? this.mlet
      ..cosPenalty = cosPenalty ?? this.cosPenalty
      ..hpsCorner = hpsCorner ?? this.hpsCorner
      ..mhid = mhid ?? this.mhid
      ..hpsPunish = hpsPunish ?? this.hpsPunish
      ..mrmc = mrmc ?? this.mrmc
      ..mess = mess ?? this.mess
      ..lss = lss ?? this.lss
      ..mmp = mmp ?? this.mmp
      ..operationHotSortTop = operationHotSortTop ?? this.operationHotSortTop
      ..mms = mms ?? this.mms
      ..mbmty = mbmty ?? this.mbmty
      ..regionIdSort = regionIdSort ?? this.regionIdSort
      ..seid = seid ?? this.seid
      ..malut = malut ?? this.malut
      ..frman = frman ?? this.frman
      ..met = met ?? this.met
      ..hpsTPunish = hpsTPunish ?? this.hpsTPunish
      ..hpsTCorner = hpsTCorner ?? this.hpsTCorner
      ..mng = mng ?? this.mng
      ..mvs = mvs ?? this.mvs
      ..hpsPenalty = hpsPenalty ?? this.hpsPenalty
      ..mearlys = mearlys ?? this.mearlys
      ..hipo = hipo ?? this.hipo
      ..mfo = mfo ?? this.mfo
      ..mft = mft ?? this.mft
      ..hpsOutright = hpsOutright ?? this.hpsOutright;
  }
}

CosOutrightDataHps $CosOutrightDataHpsFromJson(Map<String, dynamic> json) {
  final CosOutrightDataHps cosOutrightDataHps = CosOutrightDataHps();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    cosOutrightDataHps.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    cosOutrightDataHps.chpid = chpid;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    cosOutrightDataHps.ctsp = ctsp;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    cosOutrightDataHps.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    cosOutrightDataHps.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    cosOutrightDataHps.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    cosOutrightDataHps.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    cosOutrightDataHps.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    cosOutrightDataHps.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    cosOutrightDataHps.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    cosOutrightDataHps.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    cosOutrightDataHps.hids = hids;
  }
  final List<CosOutrightDataHpsHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CosOutrightDataHpsHl>(e) as CosOutrightDataHpsHl)
      .toList();
  if (hl != null) {
    cosOutrightDataHps.hl = hl;
  }
  return cosOutrightDataHps;
}

Map<String, dynamic> $CosOutrightDataHpsToJson(CosOutrightDataHps entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mid'] = entity.mid;
  data['chpid'] = entity.chpid;
  data['ctsp'] = entity.ctsp;
  data['hpid'] = entity.hpid;
  data['hpon'] = entity.hpon;
  data['hshow'] = entity.hshow;
  data['hpn'] = entity.hpn;
  data['hpnb'] = entity.hpnb;
  data['hpt'] = entity.hpt;
  data['hsw'] = entity.hsw;
  data['hmm'] = entity.hmm;
  data['hids'] = entity.hids;
  data['hl'] = entity.hl.map((v) => v.toJson()).toList();
  return data;
}

extension CosOutrightDataHpsExtension on CosOutrightDataHps {
  CosOutrightDataHps copyWith({
    String? mid,
    String? chpid,
    String? ctsp,
    String? hpid,
    int? hpon,
    String? hshow,
    String? hpn,
    String? hpnb,
    int? hpt,
    String? hsw,
    int? hmm,
    int? hids,
    List<CosOutrightDataHpsHl>? hl,
  }) {
    return CosOutrightDataHps()
      ..mid = mid ?? this.mid
      ..chpid = chpid ?? this.chpid
      ..ctsp = ctsp ?? this.ctsp
      ..hpid = hpid ?? this.hpid
      ..hpon = hpon ?? this.hpon
      ..hshow = hshow ?? this.hshow
      ..hpn = hpn ?? this.hpn
      ..hpnb = hpnb ?? this.hpnb
      ..hpt = hpt ?? this.hpt
      ..hsw = hsw ?? this.hsw
      ..hmm = hmm ?? this.hmm
      ..hids = hids ?? this.hids
      ..hl = hl ?? this.hl;
  }
}

CosOutrightDataHpsHl $CosOutrightDataHpsHlFromJson(Map<String, dynamic> json) {
  final CosOutrightDataHpsHl cosOutrightDataHpsHl = CosOutrightDataHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    cosOutrightDataHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    cosOutrightDataHpsHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    cosOutrightDataHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    cosOutrightDataHpsHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    cosOutrightDataHpsHl.hn = hn;
  }
  final List<CosOutrightDataHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CosOutrightDataHpsHlOl>(e) as CosOutrightDataHpsHlOl)
      .toList();
  if (ol != null) {
    cosOutrightDataHpsHl.ol = ol;
  }
  return cosOutrightDataHpsHl;
}

Map<String, dynamic> $CosOutrightDataHpsHlToJson(CosOutrightDataHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension CosOutrightDataHpsHlExtension on CosOutrightDataHpsHl {
  CosOutrightDataHpsHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    List<CosOutrightDataHpsHlOl>? ol,
  }) {
    return CosOutrightDataHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ol = ol ?? this.ol;
  }
}

CosOutrightDataHpsHlOl $CosOutrightDataHpsHlOlFromJson(
    Map<String, dynamic> json) {
  final CosOutrightDataHpsHlOl cosOutrightDataHpsHlOl = CosOutrightDataHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    cosOutrightDataHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    cosOutrightDataHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    cosOutrightDataHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    cosOutrightDataHpsHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    cosOutrightDataHpsHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    cosOutrightDataHpsHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    cosOutrightDataHpsHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    cosOutrightDataHpsHlOl.ov2 = ov2;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    cosOutrightDataHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    cosOutrightDataHpsHlOl.onb = onb;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    cosOutrightDataHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    cosOutrightDataHpsHlOl.ots = ots;
  }
  return cosOutrightDataHpsHlOl;
}

Map<String, dynamic> $CosOutrightDataHpsHlOlToJson(
    CosOutrightDataHpsHlOl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['oid'] = entity.oid;
  data['os'] = entity.os;
  data['otd'] = entity.otd;
  data['ot'] = entity.ot;
  data['dov'] = entity.dov;
  data['doc'] = entity.doc;
  data['ov'] = entity.ov;
  data['ov2'] = entity.ov2;
  data['on'] = entity.on;
  data['onb'] = entity.onb;
  data['cds'] = entity.cds;
  data['ots'] = entity.ots;
  return data;
}

extension CosOutrightDataHpsHlOlExtension on CosOutrightDataHpsHlOl {
  CosOutrightDataHpsHlOl copyWith({
    String? oid,
    int? os,
    int? otd,
    String? ot,
    dynamic dov,
    dynamic doc,
    int? ov,
    dynamic ov2,
    String? on,
    String? onb,
    String? cds,
    String? ots,
  }) {
    return CosOutrightDataHpsHlOl()
      ..oid = oid ?? this.oid
      ..os = os ?? this.os
      ..otd = otd ?? this.otd
      ..ot = ot ?? this.ot
      ..dov = dov ?? this.dov
      ..doc = doc ?? this.doc
      ..ov = ov ?? this.ov
      ..ov2 = ov2 ?? this.ov2
      ..on = on ?? this.on
      ..onb = onb ?? this.onb
      ..cds = cds ?? this.cds
      ..ots = ots ?? this.ots;
  }
}

CosOutrightDataHps15Minutes $CosOutrightDataHps15MinutesFromJson(
    Map<String, dynamic> json) {
  final CosOutrightDataHps15Minutes cosOutrightDataHps15Minutes = CosOutrightDataHps15Minutes();
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    cosOutrightDataHps15Minutes.ctsp = ctsp;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    cosOutrightDataHps15Minutes.hids = hids;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    cosOutrightDataHps15Minutes.chpid = chpid;
  }
  final List<CosOutrightDataHps15MinutesHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CosOutrightDataHps15MinutesHl>(
          e) as CosOutrightDataHps15MinutesHl)
      .toList();
  if (hl != null) {
    cosOutrightDataHps15Minutes.hl = hl;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    cosOutrightDataHps15Minutes.hpn = hpn;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    cosOutrightDataHps15Minutes.mid = mid;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    cosOutrightDataHps15Minutes.hmm = hmm;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    cosOutrightDataHps15Minutes.hshow = hshow;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    cosOutrightDataHps15Minutes.hpnb = hpnb;
  }
  final String? hSpecial = jsonConvert.convert<String>(json['hSpecial']);
  if (hSpecial != null) {
    cosOutrightDataHps15Minutes.hSpecial = hSpecial;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    cosOutrightDataHps15Minutes.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    cosOutrightDataHps15Minutes.hsw = hsw;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    cosOutrightDataHps15Minutes.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    cosOutrightDataHps15Minutes.hpon = hpon;
  }
  final String? mct = jsonConvert.convert<String>(json['mct']);
  if (mct != null) {
    cosOutrightDataHps15Minutes.mct = mct;
  }
  return cosOutrightDataHps15Minutes;
}

Map<String, dynamic> $CosOutrightDataHps15MinutesToJson(
    CosOutrightDataHps15Minutes entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ctsp'] = entity.ctsp;
  data['hids'] = entity.hids;
  data['chpid'] = entity.chpid;
  data['hl'] = entity.hl.map((v) => v.toJson()).toList();
  data['hpn'] = entity.hpn;
  data['mid'] = entity.mid;
  data['hmm'] = entity.hmm;
  data['hshow'] = entity.hshow;
  data['hpnb'] = entity.hpnb;
  data['hSpecial'] = entity.hSpecial;
  data['hpt'] = entity.hpt;
  data['hsw'] = entity.hsw;
  data['hpid'] = entity.hpid;
  data['hpon'] = entity.hpon;
  data['mct'] = entity.mct;
  return data;
}

extension CosOutrightDataHps15MinutesExtension on CosOutrightDataHps15Minutes {
  CosOutrightDataHps15Minutes copyWith({
    String? ctsp,
    int? hids,
    String? chpid,
    List<CosOutrightDataHps15MinutesHl>? hl,
    String? hpn,
    String? mid,
    int? hmm,
    String? hshow,
    String? hpnb,
    String? hSpecial,
    int? hpt,
    String? hsw,
    String? hpid,
    int? hpon,
    String? mct,
  }) {
    return CosOutrightDataHps15Minutes()
      ..ctsp = ctsp ?? this.ctsp
      ..hids = hids ?? this.hids
      ..chpid = chpid ?? this.chpid
      ..hl = hl ?? this.hl
      ..hpn = hpn ?? this.hpn
      ..mid = mid ?? this.mid
      ..hmm = hmm ?? this.hmm
      ..hshow = hshow ?? this.hshow
      ..hpnb = hpnb ?? this.hpnb
      ..hSpecial = hSpecial ?? this.hSpecial
      ..hpt = hpt ?? this.hpt
      ..hsw = hsw ?? this.hsw
      ..hpid = hpid ?? this.hpid
      ..hpon = hpon ?? this.hpon
      ..mct = mct ?? this.mct;
  }
}

CosOutrightDataHps15MinutesHl $CosOutrightDataHps15MinutesHlFromJson(
    Map<String, dynamic> json) {
  final CosOutrightDataHps15MinutesHl cosOutrightDataHps15MinutesHl = CosOutrightDataHps15MinutesHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    cosOutrightDataHps15MinutesHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    cosOutrightDataHps15MinutesHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    cosOutrightDataHps15MinutesHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    cosOutrightDataHps15MinutesHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    cosOutrightDataHps15MinutesHl.hn = hn;
  }
  final String? ad3 = jsonConvert.convert<String>(json['ad3']);
  if (ad3 != null) {
    cosOutrightDataHps15MinutesHl.ad3 = ad3;
  }
  final String? ad5 = jsonConvert.convert<String>(json['ad5']);
  if (ad5 != null) {
    cosOutrightDataHps15MinutesHl.ad5 = ad5;
  }
  final List<CosOutrightDataHps15MinutesHlOl>? ol = (json['ol'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CosOutrightDataHps15MinutesHlOl>(
          e) as CosOutrightDataHps15MinutesHlOl).toList();
  if (ol != null) {
    cosOutrightDataHps15MinutesHl.ol = ol;
  }
  return cosOutrightDataHps15MinutesHl;
}

Map<String, dynamic> $CosOutrightDataHps15MinutesHlToJson(
    CosOutrightDataHps15MinutesHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ad3'] = entity.ad3;
  data['ad5'] = entity.ad5;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension CosOutrightDataHps15MinutesHlExtension on CosOutrightDataHps15MinutesHl {
  CosOutrightDataHps15MinutesHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    String? ad3,
    String? ad5,
    List<CosOutrightDataHps15MinutesHlOl>? ol,
  }) {
    return CosOutrightDataHps15MinutesHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ad3 = ad3 ?? this.ad3
      ..ad5 = ad5 ?? this.ad5
      ..ol = ol ?? this.ol;
  }
}

CosOutrightDataHps15MinutesHlOl $CosOutrightDataHps15MinutesHlOlFromJson(
    Map<String, dynamic> json) {
  final CosOutrightDataHps15MinutesHlOl cosOutrightDataHps15MinutesHlOl = CosOutrightDataHps15MinutesHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    cosOutrightDataHps15MinutesHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    cosOutrightDataHps15MinutesHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    cosOutrightDataHps15MinutesHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    cosOutrightDataHps15MinutesHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    cosOutrightDataHps15MinutesHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    cosOutrightDataHps15MinutesHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    cosOutrightDataHps15MinutesHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    cosOutrightDataHps15MinutesHlOl.ov2 = ov2;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    cosOutrightDataHps15MinutesHlOl.onb = onb;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    cosOutrightDataHps15MinutesHlOl.on = on;
  }
  final String? onbl = jsonConvert.convert<String>(json['onbl']);
  if (onbl != null) {
    cosOutrightDataHps15MinutesHlOl.onbl = onbl;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    cosOutrightDataHps15MinutesHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    cosOutrightDataHps15MinutesHlOl.ots = ots;
  }
  return cosOutrightDataHps15MinutesHlOl;
}

Map<String, dynamic> $CosOutrightDataHps15MinutesHlOlToJson(
    CosOutrightDataHps15MinutesHlOl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['oid'] = entity.oid;
  data['os'] = entity.os;
  data['otd'] = entity.otd;
  data['ot'] = entity.ot;
  data['dov'] = entity.dov;
  data['doc'] = entity.doc;
  data['ov'] = entity.ov;
  data['ov2'] = entity.ov2;
  data['onb'] = entity.onb;
  data['on'] = entity.on;
  data['onbl'] = entity.onbl;
  data['cds'] = entity.cds;
  data['ots'] = entity.ots;
  return data;
}

extension CosOutrightDataHps15MinutesHlOlExtension on CosOutrightDataHps15MinutesHlOl {
  CosOutrightDataHps15MinutesHlOl copyWith({
    String? oid,
    int? os,
    int? otd,
    String? ot,
    dynamic dov,
    dynamic doc,
    int? ov,
    dynamic ov2,
    String? onb,
    String? on,
    String? onbl,
    String? cds,
    String? ots,
  }) {
    return CosOutrightDataHps15MinutesHlOl()
      ..oid = oid ?? this.oid
      ..os = os ?? this.os
      ..otd = otd ?? this.otd
      ..ot = ot ?? this.ot
      ..dov = dov ?? this.dov
      ..doc = doc ?? this.doc
      ..ov = ov ?? this.ov
      ..ov2 = ov2 ?? this.ov2
      ..onb = onb ?? this.onb
      ..on = on ?? this.on
      ..onbl = onbl ?? this.onbl
      ..cds = cds ?? this.cds
      ..ots = ots ?? this.ots;
  }
}