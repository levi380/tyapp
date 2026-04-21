import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_base_info_by_mids_entity.dart';

MatchBaseInfoByMidsEntity $MatchBaseInfoByMidsEntityFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsEntity matchBaseInfoByMidsEntity = MatchBaseInfoByMidsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchBaseInfoByMidsEntity.code = code;
  }
  final List<MatchBaseInfoByMidsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchBaseInfoByMidsData>(
          e) as MatchBaseInfoByMidsData)
      .toList();
  if (data != null) {
    matchBaseInfoByMidsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchBaseInfoByMidsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchBaseInfoByMidsEntity.ts = ts;
  }
  return matchBaseInfoByMidsEntity;
}

Map<String, dynamic> $MatchBaseInfoByMidsEntityToJson(
    MatchBaseInfoByMidsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchBaseInfoByMidsEntityExtension on MatchBaseInfoByMidsEntity {
  MatchBaseInfoByMidsEntity copyWith({
    String? code,
    List<MatchBaseInfoByMidsData>? data,
    String? msg,
    int? ts,
  }) {
    return MatchBaseInfoByMidsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchBaseInfoByMidsData $MatchBaseInfoByMidsDataFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsData matchBaseInfoByMidsData = MatchBaseInfoByMidsData();
  final String? mcid = jsonConvert.convert<String>(json['mcid']);
  if (mcid != null) {
    matchBaseInfoByMidsData.mcid = mcid;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    matchBaseInfoByMidsData.tnjc = tnjc;
  }
  final bool? cosTCorner = jsonConvert.convert<bool>(json['cosTCorner']);
  if (cosTCorner != null) {
    matchBaseInfoByMidsData.cosTCorner = cosTCorner;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    matchBaseInfoByMidsData.csna = csna;
  }
  final bool? cosTPunish = jsonConvert.convert<bool>(json['cosTPunish']);
  if (cosTPunish != null) {
    matchBaseInfoByMidsData.cosTPunish = cosTPunish;
  }
  final bool? cosOutright = jsonConvert.convert<bool>(json['cosOutright']);
  if (cosOutright != null) {
    matchBaseInfoByMidsData.cosOutright = cosOutright;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    matchBaseInfoByMidsData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    matchBaseInfoByMidsData.gcs = gcs;
  }
  final List<dynamic>? hpsOvertime = (json['hpsOvertime'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOvertime != null) {
    matchBaseInfoByMidsData.hpsOvertime = hpsOvertime;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    matchBaseInfoByMidsData.mgt = mgt;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    matchBaseInfoByMidsData.tlev = tlev;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    matchBaseInfoByMidsData.ctt = ctt;
  }
  final bool? cos5Minutes = jsonConvert.convert<bool>(json['cos5Minutes']);
  if (cos5Minutes != null) {
    matchBaseInfoByMidsData.cos5Minutes = cos5Minutes;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    matchBaseInfoByMidsData.lvs = lvs;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    matchBaseInfoByMidsData.malu = malu;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    matchBaseInfoByMidsData.mprmc = mprmc;
  }
  final bool? cosOvertime = jsonConvert.convert<bool>(json['cosOvertime']);
  if (cosOvertime != null) {
    matchBaseInfoByMidsData.cosOvertime = cosOvertime;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    matchBaseInfoByMidsData.mhn = mhn;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    matchBaseInfoByMidsData.betAmount = betAmount;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchBaseInfoByMidsData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    matchBaseInfoByMidsData.frmhn = frmhn;
  }
  final bool? compose = jsonConvert.convert<bool>(json['compose']);
  if (compose != null) {
    matchBaseInfoByMidsData.compose = compose;
  }
  final bool? cosTBold = jsonConvert.convert<bool>(json['cosTBold']);
  if (cosTBold != null) {
    matchBaseInfoByMidsData.cosTBold = cosTBold;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    matchBaseInfoByMidsData.operationTournamentSort = operationTournamentSort;
  }
  final bool? cos15Minutes = jsonConvert.convert<bool>(json['cos15Minutes']);
  if (cos15Minutes != null) {
    matchBaseInfoByMidsData.cos15Minutes = cos15Minutes;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matchBaseInfoByMidsData.mhs = mhs;
  }
  final List<dynamic>? hps5Minutes = (json['hps5Minutes'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hps5Minutes != null) {
    matchBaseInfoByMidsData.hps5Minutes = hps5Minutes;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchBaseInfoByMidsData.mid = mid;
  }
  final bool? cosBold = jsonConvert.convert<bool>(json['cosBold']);
  if (cosBold != null) {
    matchBaseInfoByMidsData.cosBold = cosBold;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    matchBaseInfoByMidsData.mststi = mststi;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    matchBaseInfoByMidsData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    matchBaseInfoByMidsData.mhlu = mhlu;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    matchBaseInfoByMidsData.mstst = mstst;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    matchBaseInfoByMidsData.man = man;
  }
  final List<dynamic>? hpsTBold = (json['hpsTBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTBold != null) {
    matchBaseInfoByMidsData.hpsTBold = hpsTBold;
  }
  final String? st = jsonConvert.convert<String>(json['st']);
  if (st != null) {
    matchBaseInfoByMidsData.st = st;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matchBaseInfoByMidsData.mat = mat;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    matchBaseInfoByMidsData.mststr = mststr;
  }
  final List<MatchBaseInfoByMidsDataHps>? hps = (json['hps'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchBaseInfoByMidsDataHps>(
          e) as MatchBaseInfoByMidsDataHps)
      .toList();
  if (hps != null) {
    matchBaseInfoByMidsData.hps = hps;
  }
  final List<dynamic>? hpsCompose = (json['hpsCompose'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCompose != null) {
    matchBaseInfoByMidsData.hpsCompose = hpsCompose;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    matchBaseInfoByMidsData.mststs = mststs;
  }
  final String? tc = jsonConvert.convert<String>(json['tc']);
  if (tc != null) {
    matchBaseInfoByMidsData.tc = tc;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    matchBaseInfoByMidsData.tf = tf;
  }
  final int? th = jsonConvert.convert<int>(json['th']);
  if (th != null) {
    matchBaseInfoByMidsData.th = th;
  }
  final bool? cosPromotion = jsonConvert.convert<bool>(json['cosPromotion']);
  if (cosPromotion != null) {
    matchBaseInfoByMidsData.cosPromotion = cosPromotion;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    matchBaseInfoByMidsData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    matchBaseInfoByMidsData.msc = msc;
  }
  final List<dynamic>? hpsPromotion = (json['hpsPromotion'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsPromotion != null) {
    matchBaseInfoByMidsData.hpsPromotion = hpsPromotion;
  }
  final String? tt = jsonConvert.convert<String>(json['tt']);
  if (tt != null) {
    matchBaseInfoByMidsData.tt = tt;
  }
  final List<dynamic>? hpsBold = (json['hpsBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsBold != null) {
    matchBaseInfoByMidsData.hpsBold = hpsBold;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matchBaseInfoByMidsData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    matchBaseInfoByMidsData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    matchBaseInfoByMidsData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    matchBaseInfoByMidsData.mcg = mcg;
  }
  final bool? cosCorner = jsonConvert.convert<bool>(json['cosCorner']);
  if (cosCorner != null) {
    matchBaseInfoByMidsData.cosCorner = cosCorner;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    matchBaseInfoByMidsData.atf = atf;
  }
  final bool? cosPunish = jsonConvert.convert<bool>(json['cosPunish']);
  if (cosPunish != null) {
    matchBaseInfoByMidsData.cosPunish = cosPunish;
  }
  final String? msts = jsonConvert.convert<String>(json['msts']);
  if (msts != null) {
    matchBaseInfoByMidsData.msts = msts;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    matchBaseInfoByMidsData.mc = mc;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    matchBaseInfoByMidsData.mf = mf;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    matchBaseInfoByMidsData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    matchBaseInfoByMidsData.mct = mct;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    matchBaseInfoByMidsData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    matchBaseInfoByMidsData.mo = mo;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    matchBaseInfoByMidsData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    matchBaseInfoByMidsData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matchBaseInfoByMidsData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    matchBaseInfoByMidsData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    matchBaseInfoByMidsData.mle = mle;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    matchBaseInfoByMidsData.sort = sort;
  }
  final String? vf = jsonConvert.convert<String>(json['vf']);
  if (vf != null) {
    matchBaseInfoByMidsData.vf = vf;
  }
  final List<
      MatchBaseInfoByMidsDataHps15Minutes>? hps15Minutes = (json['hps15Minutes'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchBaseInfoByMidsDataHps15Minutes>(
          e) as MatchBaseInfoByMidsDataHps15Minutes).toList();
  if (hps15Minutes != null) {
    matchBaseInfoByMidsData.hps15Minutes = hps15Minutes;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    matchBaseInfoByMidsData.lurl = lurl;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    matchBaseInfoByMidsData.mlet = mlet;
  }
  final bool? cosPenalty = jsonConvert.convert<bool>(json['cosPenalty']);
  if (cosPenalty != null) {
    matchBaseInfoByMidsData.cosPenalty = cosPenalty;
  }
  final List<dynamic>? hpsCorner = (json['hpsCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCorner != null) {
    matchBaseInfoByMidsData.hpsCorner = hpsCorner;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    matchBaseInfoByMidsData.mhid = mhid;
  }
  final List<dynamic>? hpsPunish = (json['hpsPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPunish != null) {
    matchBaseInfoByMidsData.hpsPunish = hpsPunish;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    matchBaseInfoByMidsData.mrmc = mrmc;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matchBaseInfoByMidsData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    matchBaseInfoByMidsData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matchBaseInfoByMidsData.mmp = mmp;
  }
  final int? operationHotSortTop = jsonConvert.convert<int>(
      json['operationHotSortTop']);
  if (operationHotSortTop != null) {
    matchBaseInfoByMidsData.operationHotSortTop = operationHotSortTop;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matchBaseInfoByMidsData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    matchBaseInfoByMidsData.mbmty = mbmty;
  }
  final int? regionIdSort = jsonConvert.convert<int>(json['regionIdSort']);
  if (regionIdSort != null) {
    matchBaseInfoByMidsData.regionIdSort = regionIdSort;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    matchBaseInfoByMidsData.seid = seid;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    matchBaseInfoByMidsData.malut = malut;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    matchBaseInfoByMidsData.frman = frman;
  }
  final String? met = jsonConvert.convert<String>(json['met']);
  if (met != null) {
    matchBaseInfoByMidsData.met = met;
  }
  final List<dynamic>? hpsTPunish = (json['hpsTPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTPunish != null) {
    matchBaseInfoByMidsData.hpsTPunish = hpsTPunish;
  }
  final List<dynamic>? hpsTCorner = (json['hpsTCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTCorner != null) {
    matchBaseInfoByMidsData.hpsTCorner = hpsTCorner;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    matchBaseInfoByMidsData.mng = mng;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    matchBaseInfoByMidsData.mvs = mvs;
  }
  final List<dynamic>? hpsPenalty = (json['hpsPenalty'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPenalty != null) {
    matchBaseInfoByMidsData.hpsPenalty = hpsPenalty;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    matchBaseInfoByMidsData.mearlys = mearlys;
  }
  final bool? hipo = jsonConvert.convert<bool>(json['hipo']);
  if (hipo != null) {
    matchBaseInfoByMidsData.hipo = hipo;
  }
  final String? mfo = jsonConvert.convert<String>(json['mfo']);
  if (mfo != null) {
    matchBaseInfoByMidsData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    matchBaseInfoByMidsData.mft = mft;
  }
  final List<dynamic>? hpsOutright = (json['hpsOutright'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOutright != null) {
    matchBaseInfoByMidsData.hpsOutright = hpsOutright;
  }
  final String? mstrc = jsonConvert.convert<String>(json['mstrc']);
  if (mstrc != null) {
    matchBaseInfoByMidsData.mstrc = mstrc;
  }
  return matchBaseInfoByMidsData;
}

Map<String, dynamic> $MatchBaseInfoByMidsDataToJson(
    MatchBaseInfoByMidsData entity) {
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
  data['mstrc'] = entity.mstrc;
  return data;
}

extension MatchBaseInfoByMidsDataExtension on MatchBaseInfoByMidsData {
  MatchBaseInfoByMidsData copyWith({
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
    List<MatchBaseInfoByMidsDataHps>? hps,
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
    List<MatchBaseInfoByMidsDataHps15Minutes>? hps15Minutes,
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
    String? mfo,
    int? mft,
    List<dynamic>? hpsOutright,
    String? mstrc,
  }) {
    return MatchBaseInfoByMidsData()
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
      ..hpsOutright = hpsOutright ?? this.hpsOutright
      ..mstrc = mstrc ?? this.mstrc;
  }
}

MatchBaseInfoByMidsDataHps $MatchBaseInfoByMidsDataHpsFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsDataHps matchBaseInfoByMidsDataHps = MatchBaseInfoByMidsDataHps();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchBaseInfoByMidsDataHps.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    matchBaseInfoByMidsDataHps.chpid = chpid;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    matchBaseInfoByMidsDataHps.ctsp = ctsp;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchBaseInfoByMidsDataHps.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    matchBaseInfoByMidsDataHps.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    matchBaseInfoByMidsDataHps.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    matchBaseInfoByMidsDataHps.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    matchBaseInfoByMidsDataHps.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    matchBaseInfoByMidsDataHps.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    matchBaseInfoByMidsDataHps.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    matchBaseInfoByMidsDataHps.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    matchBaseInfoByMidsDataHps.hids = hids;
  }
  final List<MatchBaseInfoByMidsDataHpsHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchBaseInfoByMidsDataHpsHl>(
          e) as MatchBaseInfoByMidsDataHpsHl)
      .toList();
  if (hl != null) {
    matchBaseInfoByMidsDataHps.hl = hl;
  }
  return matchBaseInfoByMidsDataHps;
}

Map<String, dynamic> $MatchBaseInfoByMidsDataHpsToJson(
    MatchBaseInfoByMidsDataHps entity) {
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

extension MatchBaseInfoByMidsDataHpsExtension on MatchBaseInfoByMidsDataHps {
  MatchBaseInfoByMidsDataHps copyWith({
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
    List<MatchBaseInfoByMidsDataHpsHl>? hl,
  }) {
    return MatchBaseInfoByMidsDataHps()
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

MatchBaseInfoByMidsDataHpsHl $MatchBaseInfoByMidsDataHpsHlFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsDataHpsHl matchBaseInfoByMidsDataHpsHl = MatchBaseInfoByMidsDataHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchBaseInfoByMidsDataHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchBaseInfoByMidsDataHpsHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    matchBaseInfoByMidsDataHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matchBaseInfoByMidsDataHpsHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    matchBaseInfoByMidsDataHpsHl.hn = hn;
  }
  final List<MatchBaseInfoByMidsDataHpsHlOl>? ol = (json['ol'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchBaseInfoByMidsDataHpsHlOl>(
          e) as MatchBaseInfoByMidsDataHpsHlOl).toList();
  if (ol != null) {
    matchBaseInfoByMidsDataHpsHl.ol = ol;
  }
  return matchBaseInfoByMidsDataHpsHl;
}

Map<String, dynamic> $MatchBaseInfoByMidsDataHpsHlToJson(
    MatchBaseInfoByMidsDataHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension MatchBaseInfoByMidsDataHpsHlExtension on MatchBaseInfoByMidsDataHpsHl {
  MatchBaseInfoByMidsDataHpsHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    List<MatchBaseInfoByMidsDataHpsHlOl>? ol,
  }) {
    return MatchBaseInfoByMidsDataHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ol = ol ?? this.ol;
  }
}

MatchBaseInfoByMidsDataHpsHlOl $MatchBaseInfoByMidsDataHpsHlOlFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsDataHpsHlOl matchBaseInfoByMidsDataHpsHlOl = MatchBaseInfoByMidsDataHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    matchBaseInfoByMidsDataHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    matchBaseInfoByMidsDataHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    matchBaseInfoByMidsDataHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    matchBaseInfoByMidsDataHpsHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    matchBaseInfoByMidsDataHpsHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    matchBaseInfoByMidsDataHpsHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    matchBaseInfoByMidsDataHpsHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    matchBaseInfoByMidsDataHpsHlOl.ov2 = ov2;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    matchBaseInfoByMidsDataHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    matchBaseInfoByMidsDataHpsHlOl.onb = onb;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchBaseInfoByMidsDataHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    matchBaseInfoByMidsDataHpsHlOl.ots = ots;
  }
  return matchBaseInfoByMidsDataHpsHlOl;
}

Map<String, dynamic> $MatchBaseInfoByMidsDataHpsHlOlToJson(
    MatchBaseInfoByMidsDataHpsHlOl entity) {
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

extension MatchBaseInfoByMidsDataHpsHlOlExtension on MatchBaseInfoByMidsDataHpsHlOl {
  MatchBaseInfoByMidsDataHpsHlOl copyWith({
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
    return MatchBaseInfoByMidsDataHpsHlOl()
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

MatchBaseInfoByMidsDataHps15Minutes $MatchBaseInfoByMidsDataHps15MinutesFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsDataHps15Minutes matchBaseInfoByMidsDataHps15Minutes = MatchBaseInfoByMidsDataHps15Minutes();
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    matchBaseInfoByMidsDataHps15Minutes.ctsp = ctsp;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    matchBaseInfoByMidsDataHps15Minutes.hids = hids;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    matchBaseInfoByMidsDataHps15Minutes.chpid = chpid;
  }
  final List<MatchBaseInfoByMidsDataHps15MinutesHl>? hl = (json['hl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchBaseInfoByMidsDataHps15MinutesHl>(
          e) as MatchBaseInfoByMidsDataHps15MinutesHl).toList();
  if (hl != null) {
    matchBaseInfoByMidsDataHps15Minutes.hl = hl;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    matchBaseInfoByMidsDataHps15Minutes.hpn = hpn;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchBaseInfoByMidsDataHps15Minutes.mid = mid;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    matchBaseInfoByMidsDataHps15Minutes.hmm = hmm;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    matchBaseInfoByMidsDataHps15Minutes.hshow = hshow;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    matchBaseInfoByMidsDataHps15Minutes.hpnb = hpnb;
  }
  final String? hSpecial = jsonConvert.convert<String>(json['hSpecial']);
  if (hSpecial != null) {
    matchBaseInfoByMidsDataHps15Minutes.hSpecial = hSpecial;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    matchBaseInfoByMidsDataHps15Minutes.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    matchBaseInfoByMidsDataHps15Minutes.hsw = hsw;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchBaseInfoByMidsDataHps15Minutes.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    matchBaseInfoByMidsDataHps15Minutes.hpon = hpon;
  }
  final String? mct = jsonConvert.convert<String>(json['mct']);
  if (mct != null) {
    matchBaseInfoByMidsDataHps15Minutes.mct = mct;
  }
  return matchBaseInfoByMidsDataHps15Minutes;
}

Map<String, dynamic> $MatchBaseInfoByMidsDataHps15MinutesToJson(
    MatchBaseInfoByMidsDataHps15Minutes entity) {
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

extension MatchBaseInfoByMidsDataHps15MinutesExtension on MatchBaseInfoByMidsDataHps15Minutes {
  MatchBaseInfoByMidsDataHps15Minutes copyWith({
    String? ctsp,
    int? hids,
    String? chpid,
    List<MatchBaseInfoByMidsDataHps15MinutesHl>? hl,
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
    return MatchBaseInfoByMidsDataHps15Minutes()
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

MatchBaseInfoByMidsDataHps15MinutesHl $MatchBaseInfoByMidsDataHps15MinutesHlFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsDataHps15MinutesHl matchBaseInfoByMidsDataHps15MinutesHl = MatchBaseInfoByMidsDataHps15MinutesHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.hn = hn;
  }
  final String? ad3 = jsonConvert.convert<String>(json['ad3']);
  if (ad3 != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.ad3 = ad3;
  }
  final String? ad5 = jsonConvert.convert<String>(json['ad5']);
  if (ad5 != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.ad5 = ad5;
  }
  final List<MatchBaseInfoByMidsDataHps15MinutesHlOl>? ol = (json['ol'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchBaseInfoByMidsDataHps15MinutesHlOl>(
          e) as MatchBaseInfoByMidsDataHps15MinutesHlOl).toList();
  if (ol != null) {
    matchBaseInfoByMidsDataHps15MinutesHl.ol = ol;
  }
  return matchBaseInfoByMidsDataHps15MinutesHl;
}

Map<String, dynamic> $MatchBaseInfoByMidsDataHps15MinutesHlToJson(
    MatchBaseInfoByMidsDataHps15MinutesHl entity) {
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

extension MatchBaseInfoByMidsDataHps15MinutesHlExtension on MatchBaseInfoByMidsDataHps15MinutesHl {
  MatchBaseInfoByMidsDataHps15MinutesHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    String? ad3,
    String? ad5,
    List<MatchBaseInfoByMidsDataHps15MinutesHlOl>? ol,
  }) {
    return MatchBaseInfoByMidsDataHps15MinutesHl()
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

MatchBaseInfoByMidsDataHps15MinutesHlOl $MatchBaseInfoByMidsDataHps15MinutesHlOlFromJson(
    Map<String, dynamic> json) {
  final MatchBaseInfoByMidsDataHps15MinutesHlOl matchBaseInfoByMidsDataHps15MinutesHlOl = MatchBaseInfoByMidsDataHps15MinutesHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.ov2 = ov2;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.onb = onb;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.on = on;
  }
  final String? onbl = jsonConvert.convert<String>(json['onbl']);
  if (onbl != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.onbl = onbl;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    matchBaseInfoByMidsDataHps15MinutesHlOl.ots = ots;
  }
  return matchBaseInfoByMidsDataHps15MinutesHlOl;
}

Map<String, dynamic> $MatchBaseInfoByMidsDataHps15MinutesHlOlToJson(
    MatchBaseInfoByMidsDataHps15MinutesHlOl entity) {
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

extension MatchBaseInfoByMidsDataHps15MinutesHlOlExtension on MatchBaseInfoByMidsDataHps15MinutesHlOl {
  MatchBaseInfoByMidsDataHps15MinutesHlOl copyWith({
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
    return MatchBaseInfoByMidsDataHps15MinutesHlOl()
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