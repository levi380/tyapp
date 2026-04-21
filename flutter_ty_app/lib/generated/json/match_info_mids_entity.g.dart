import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_info_mids_entity.dart';

MatchInfoMidsEntity $MatchInfoMidsEntityFromJson(Map<String, dynamic> json) {
  final MatchInfoMidsEntity matchInfoMidsEntity = MatchInfoMidsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchInfoMidsEntity.code = code;
  }
  final List<MatchInfoMidsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MatchInfoMidsData>(e) as MatchInfoMidsData)
      .toList();
  if (data != null) {
    matchInfoMidsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchInfoMidsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchInfoMidsEntity.ts = ts;
  }
  return matchInfoMidsEntity;
}

Map<String, dynamic> $MatchInfoMidsEntityToJson(MatchInfoMidsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchInfoMidsEntityExtension on MatchInfoMidsEntity {
  MatchInfoMidsEntity copyWith({
    String? code,
    List<MatchInfoMidsData>? data,
    String? msg,
    int? ts,
  }) {
    return MatchInfoMidsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchInfoMidsData $MatchInfoMidsDataFromJson(Map<String, dynamic> json) {
  final MatchInfoMidsData matchInfoMidsData = MatchInfoMidsData();
  final String? mcid = jsonConvert.convert<String>(json['mcid']);
  if (mcid != null) {
    matchInfoMidsData.mcid = mcid;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    matchInfoMidsData.tnjc = tnjc;
  }
  final bool? cosTCorner = jsonConvert.convert<bool>(json['cosTCorner']);
  if (cosTCorner != null) {
    matchInfoMidsData.cosTCorner = cosTCorner;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    matchInfoMidsData.csna = csna;
  }
  final bool? cosTPunish = jsonConvert.convert<bool>(json['cosTPunish']);
  if (cosTPunish != null) {
    matchInfoMidsData.cosTPunish = cosTPunish;
  }
  final MatchInfoMidsDataKySwitch? kySwitch = jsonConvert.convert<
      MatchInfoMidsDataKySwitch>(json['kySwitch']);
  if (kySwitch != null) {
    matchInfoMidsData.kySwitch = kySwitch;
  }
  final bool? cosOutright = jsonConvert.convert<bool>(json['cosOutright']);
  if (cosOutright != null) {
    matchInfoMidsData.cosOutright = cosOutright;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    matchInfoMidsData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    matchInfoMidsData.gcs = gcs;
  }
  final List<dynamic>? hpsOvertime = (json['hpsOvertime'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOvertime != null) {
    matchInfoMidsData.hpsOvertime = hpsOvertime;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    matchInfoMidsData.mgt = mgt;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    matchInfoMidsData.tlev = tlev;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    matchInfoMidsData.ctt = ctt;
  }
  final bool? cos5Minutes = jsonConvert.convert<bool>(json['cos5Minutes']);
  if (cos5Minutes != null) {
    matchInfoMidsData.cos5Minutes = cos5Minutes;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    matchInfoMidsData.lvs = lvs;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    matchInfoMidsData.malu = malu;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    matchInfoMidsData.mprmc = mprmc;
  }
  final bool? cosOvertime = jsonConvert.convert<bool>(json['cosOvertime']);
  if (cosOvertime != null) {
    matchInfoMidsData.cosOvertime = cosOvertime;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    matchInfoMidsData.mhn = mhn;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    matchInfoMidsData.betAmount = betAmount;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchInfoMidsData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    matchInfoMidsData.frmhn = frmhn;
  }
  final bool? compose = jsonConvert.convert<bool>(json['compose']);
  if (compose != null) {
    matchInfoMidsData.compose = compose;
  }
  final bool? cosTBold = jsonConvert.convert<bool>(json['cosTBold']);
  if (cosTBold != null) {
    matchInfoMidsData.cosTBold = cosTBold;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    matchInfoMidsData.operationTournamentSort = operationTournamentSort;
  }
  final bool? cos15Minutes = jsonConvert.convert<bool>(json['cos15Minutes']);
  if (cos15Minutes != null) {
    matchInfoMidsData.cos15Minutes = cos15Minutes;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    matchInfoMidsData.mhs = mhs;
  }
  final List<dynamic>? hps5Minutes = (json['hps5Minutes'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hps5Minutes != null) {
    matchInfoMidsData.hps5Minutes = hps5Minutes;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchInfoMidsData.mid = mid;
  }
  final bool? cosBold = jsonConvert.convert<bool>(json['cosBold']);
  if (cosBold != null) {
    matchInfoMidsData.cosBold = cosBold;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    matchInfoMidsData.mststi = mststi;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    matchInfoMidsData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    matchInfoMidsData.mhlu = mhlu;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    matchInfoMidsData.mstst = mstst;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    matchInfoMidsData.man = man;
  }
  final List<dynamic>? hpsTBold = (json['hpsTBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTBold != null) {
    matchInfoMidsData.hpsTBold = hpsTBold;
  }
  final dynamic st = json['st'];
  if (st != null) {
    matchInfoMidsData.st = st;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    matchInfoMidsData.mat = mat;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    matchInfoMidsData.mststr = mststr;
  }
  final List<MatchInfoMidsDataHps>? hps = (json['hps'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHps>(e) as MatchInfoMidsDataHps)
      .toList();
  if (hps != null) {
    matchInfoMidsData.hps = hps;
  }
  final List<dynamic>? hpsCompose = (json['hpsCompose'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCompose != null) {
    matchInfoMidsData.hpsCompose = hpsCompose;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    matchInfoMidsData.mststs = mststs;
  }
  final String? tc = jsonConvert.convert<String>(json['tc']);
  if (tc != null) {
    matchInfoMidsData.tc = tc;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    matchInfoMidsData.tf = tf;
  }
  final int? th = jsonConvert.convert<int>(json['th']);
  if (th != null) {
    matchInfoMidsData.th = th;
  }
  final bool? cosPromotion = jsonConvert.convert<bool>(json['cosPromotion']);
  if (cosPromotion != null) {
    matchInfoMidsData.cosPromotion = cosPromotion;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    matchInfoMidsData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    matchInfoMidsData.msc = msc;
  }
  final List<dynamic>? hpsPromotion = (json['hpsPromotion'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsPromotion != null) {
    matchInfoMidsData.hpsPromotion = hpsPromotion;
  }
  final String? tt = jsonConvert.convert<String>(json['tt']);
  if (tt != null) {
    matchInfoMidsData.tt = tt;
  }
  final String? ecds = jsonConvert.convert<String>(json['ecds']);
  if (ecds != null) {
    matchInfoMidsData.ecds = ecds;
  }
  final List<dynamic>? hpsBold = (json['hpsBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsBold != null) {
    matchInfoMidsData.hpsBold = hpsBold;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    matchInfoMidsData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    matchInfoMidsData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    matchInfoMidsData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    matchInfoMidsData.mcg = mcg;
  }
  final bool? cosCorner = jsonConvert.convert<bool>(json['cosCorner']);
  if (cosCorner != null) {
    matchInfoMidsData.cosCorner = cosCorner;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    matchInfoMidsData.atf = atf;
  }
  final bool? cosPunish = jsonConvert.convert<bool>(json['cosPunish']);
  if (cosPunish != null) {
    matchInfoMidsData.cosPunish = cosPunish;
  }
  final String? msts = jsonConvert.convert<String>(json['msts']);
  if (msts != null) {
    matchInfoMidsData.msts = msts;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    matchInfoMidsData.mc = mc;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    matchInfoMidsData.mf = mf;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    matchInfoMidsData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    matchInfoMidsData.mct = mct;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    matchInfoMidsData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    matchInfoMidsData.mo = mo;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    matchInfoMidsData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    matchInfoMidsData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    matchInfoMidsData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    matchInfoMidsData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    matchInfoMidsData.mle = mle;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    matchInfoMidsData.sort = sort;
  }
  final String? vf = jsonConvert.convert<String>(json['vf']);
  if (vf != null) {
    matchInfoMidsData.vf = vf;
  }
  final List<
      MatchInfoMidsDataHps15Minutes>? hps15Minutes = (json['hps15Minutes'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHps15Minutes>(
          e) as MatchInfoMidsDataHps15Minutes).toList();
  if (hps15Minutes != null) {
    matchInfoMidsData.hps15Minutes = hps15Minutes;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    matchInfoMidsData.lurl = lurl;
  }
  final bool? cosOvertimeIng = jsonConvert.convert<bool>(
      json['cosOvertimeIng']);
  if (cosOvertimeIng != null) {
    matchInfoMidsData.cosOvertimeIng = cosOvertimeIng;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    matchInfoMidsData.mlet = mlet;
  }
  final bool? cosPenalty = jsonConvert.convert<bool>(json['cosPenalty']);
  if (cosPenalty != null) {
    matchInfoMidsData.cosPenalty = cosPenalty;
  }
  final List<
      MatchInfoMidsDataHpsCorner>? hpsCorner = (json['hpsCorner'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHpsCorner>(
          e) as MatchInfoMidsDataHpsCorner).toList();
  if (hpsCorner != null) {
    matchInfoMidsData.hpsCorner = hpsCorner;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    matchInfoMidsData.mhid = mhid;
  }
  final List<dynamic>? hpsPunish = (json['hpsPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPunish != null) {
    matchInfoMidsData.hpsPunish = hpsPunish;
  }
  final dynamic legOrder = json['legOrder'];
  if (legOrder != null) {
    matchInfoMidsData.legOrder = legOrder;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    matchInfoMidsData.mrmc = mrmc;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    matchInfoMidsData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    matchInfoMidsData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    matchInfoMidsData.mmp = mmp;
  }
  final int? operationHotSortTop = jsonConvert.convert<int>(
      json['operationHotSortTop']);
  if (operationHotSortTop != null) {
    matchInfoMidsData.operationHotSortTop = operationHotSortTop;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    matchInfoMidsData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    matchInfoMidsData.mbmty = mbmty;
  }
  final int? regionIdSort = jsonConvert.convert<int>(json['regionIdSort']);
  if (regionIdSort != null) {
    matchInfoMidsData.regionIdSort = regionIdSort;
  }
  final bool? cosBetBuilder = jsonConvert.convert<bool>(json['cosBetBuilder']);
  if (cosBetBuilder != null) {
    matchInfoMidsData.cosBetBuilder = cosBetBuilder;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    matchInfoMidsData.seid = seid;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    matchInfoMidsData.malut = malut;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    matchInfoMidsData.frman = frman;
  }
  final String? met = jsonConvert.convert<String>(json['met']);
  if (met != null) {
    matchInfoMidsData.met = met;
  }
  final List<dynamic>? hpsTPunish = (json['hpsTPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTPunish != null) {
    matchInfoMidsData.hpsTPunish = hpsTPunish;
  }
  final List<dynamic>? hpsTCorner = (json['hpsTCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTCorner != null) {
    matchInfoMidsData.hpsTCorner = hpsTCorner;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    matchInfoMidsData.mng = mng;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    matchInfoMidsData.mvs = mvs;
  }
  final List<dynamic>? hpsPenalty = (json['hpsPenalty'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPenalty != null) {
    matchInfoMidsData.hpsPenalty = hpsPenalty;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    matchInfoMidsData.mearlys = mearlys;
  }
  final bool? hipo = jsonConvert.convert<bool>(json['hipo']);
  if (hipo != null) {
    matchInfoMidsData.hipo = hipo;
  }
  final dynamic mfo = json['mfo'];
  if (mfo != null) {
    matchInfoMidsData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    matchInfoMidsData.mft = mft;
  }
  final List<dynamic>? hpsOutright = (json['hpsOutright'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOutright != null) {
    matchInfoMidsData.hpsOutright = hpsOutright;
  }
  return matchInfoMidsData;
}

Map<String, dynamic> $MatchInfoMidsDataToJson(MatchInfoMidsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mcid'] = entity.mcid;
  data['tnjc'] = entity.tnjc;
  data['cosTCorner'] = entity.cosTCorner;
  data['csna'] = entity.csna;
  data['cosTPunish'] = entity.cosTPunish;
  data['kySwitch'] = entity.kySwitch.toJson();
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
  data['ecds'] = entity.ecds;
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
  data['cosOvertimeIng'] = entity.cosOvertimeIng;
  data['mlet'] = entity.mlet;
  data['cosPenalty'] = entity.cosPenalty;
  data['hpsCorner'] = entity.hpsCorner.map((v) => v.toJson()).toList();
  data['mhid'] = entity.mhid;
  data['hpsPunish'] = entity.hpsPunish;
  data['legOrder'] = entity.legOrder;
  data['mrmc'] = entity.mrmc;
  data['mess'] = entity.mess;
  data['lss'] = entity.lss;
  data['mmp'] = entity.mmp;
  data['operationHotSortTop'] = entity.operationHotSortTop;
  data['mms'] = entity.mms;
  data['mbmty'] = entity.mbmty;
  data['regionIdSort'] = entity.regionIdSort;
  data['cosBetBuilder'] = entity.cosBetBuilder;
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

extension MatchInfoMidsDataExtension on MatchInfoMidsData {
  MatchInfoMidsData copyWith({
    String? mcid,
    String? tnjc,
    bool? cosTCorner,
    String? csna,
    bool? cosTPunish,
    MatchInfoMidsDataKySwitch? kySwitch,
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
    dynamic st,
    String? mat,
    String? mststr,
    List<MatchInfoMidsDataHps>? hps,
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
    String? ecds,
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
    List<MatchInfoMidsDataHps15Minutes>? hps15Minutes,
    String? lurl,
    bool? cosOvertimeIng,
    String? mlet,
    bool? cosPenalty,
    List<MatchInfoMidsDataHpsCorner>? hpsCorner,
    String? mhid,
    List<dynamic>? hpsPunish,
    dynamic legOrder,
    String? mrmc,
    int? mess,
    dynamic lss,
    String? mmp,
    int? operationHotSortTop,
    int? mms,
    int? mbmty,
    int? regionIdSort,
    bool? cosBetBuilder,
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
    return MatchInfoMidsData()
      ..mcid = mcid ?? this.mcid
      ..tnjc = tnjc ?? this.tnjc
      ..cosTCorner = cosTCorner ?? this.cosTCorner
      ..csna = csna ?? this.csna
      ..cosTPunish = cosTPunish ?? this.cosTPunish
      ..kySwitch = kySwitch ?? this.kySwitch
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
      ..ecds = ecds ?? this.ecds
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
      ..cosOvertimeIng = cosOvertimeIng ?? this.cosOvertimeIng
      ..mlet = mlet ?? this.mlet
      ..cosPenalty = cosPenalty ?? this.cosPenalty
      ..hpsCorner = hpsCorner ?? this.hpsCorner
      ..mhid = mhid ?? this.mhid
      ..hpsPunish = hpsPunish ?? this.hpsPunish
      ..legOrder = legOrder ?? this.legOrder
      ..mrmc = mrmc ?? this.mrmc
      ..mess = mess ?? this.mess
      ..lss = lss ?? this.lss
      ..mmp = mmp ?? this.mmp
      ..operationHotSortTop = operationHotSortTop ?? this.operationHotSortTop
      ..mms = mms ?? this.mms
      ..mbmty = mbmty ?? this.mbmty
      ..regionIdSort = regionIdSort ?? this.regionIdSort
      ..cosBetBuilder = cosBetBuilder ?? this.cosBetBuilder
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

MatchInfoMidsDataKySwitch $MatchInfoMidsDataKySwitchFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataKySwitch matchInfoMidsDataKySwitch = MatchInfoMidsDataKySwitch();
  final int? playType = jsonConvert.convert<int>(json['playType']);
  if (playType != null) {
    matchInfoMidsDataKySwitch.playType = playType;
  }
  final int? isKy = jsonConvert.convert<int>(json['isKy']);
  if (isKy != null) {
    matchInfoMidsDataKySwitch.isKy = isKy;
  }
  return matchInfoMidsDataKySwitch;
}

Map<String, dynamic> $MatchInfoMidsDataKySwitchToJson(
    MatchInfoMidsDataKySwitch entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['playType'] = entity.playType;
  data['isKy'] = entity.isKy;
  return data;
}

extension MatchInfoMidsDataKySwitchExtension on MatchInfoMidsDataKySwitch {
  MatchInfoMidsDataKySwitch copyWith({
    int? playType,
    int? isKy,
  }) {
    return MatchInfoMidsDataKySwitch()
      ..playType = playType ?? this.playType
      ..isKy = isKy ?? this.isKy;
  }
}

MatchInfoMidsDataHps $MatchInfoMidsDataHpsFromJson(Map<String, dynamic> json) {
  final MatchInfoMidsDataHps matchInfoMidsDataHps = MatchInfoMidsDataHps();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchInfoMidsDataHps.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    matchInfoMidsDataHps.chpid = chpid;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    matchInfoMidsDataHps.ctsp = ctsp;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchInfoMidsDataHps.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    matchInfoMidsDataHps.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    matchInfoMidsDataHps.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    matchInfoMidsDataHps.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    matchInfoMidsDataHps.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    matchInfoMidsDataHps.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    matchInfoMidsDataHps.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    matchInfoMidsDataHps.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    matchInfoMidsDataHps.hids = hids;
  }
  final List<MatchInfoMidsDataHpsHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHpsHl>(e) as MatchInfoMidsDataHpsHl)
      .toList();
  if (hl != null) {
    matchInfoMidsDataHps.hl = hl;
  }
  return matchInfoMidsDataHps;
}

Map<String, dynamic> $MatchInfoMidsDataHpsToJson(MatchInfoMidsDataHps entity) {
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

extension MatchInfoMidsDataHpsExtension on MatchInfoMidsDataHps {
  MatchInfoMidsDataHps copyWith({
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
    List<MatchInfoMidsDataHpsHl>? hl,
  }) {
    return MatchInfoMidsDataHps()
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

MatchInfoMidsDataHpsHl $MatchInfoMidsDataHpsHlFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataHpsHl matchInfoMidsDataHpsHl = MatchInfoMidsDataHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchInfoMidsDataHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchInfoMidsDataHpsHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    matchInfoMidsDataHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matchInfoMidsDataHpsHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    matchInfoMidsDataHpsHl.hn = hn;
  }
  final List<MatchInfoMidsDataHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHpsHlOl>(
          e) as MatchInfoMidsDataHpsHlOl)
      .toList();
  if (ol != null) {
    matchInfoMidsDataHpsHl.ol = ol;
  }
  return matchInfoMidsDataHpsHl;
}

Map<String, dynamic> $MatchInfoMidsDataHpsHlToJson(
    MatchInfoMidsDataHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension MatchInfoMidsDataHpsHlExtension on MatchInfoMidsDataHpsHl {
  MatchInfoMidsDataHpsHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    List<MatchInfoMidsDataHpsHlOl>? ol,
  }) {
    return MatchInfoMidsDataHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ol = ol ?? this.ol;
  }
}

MatchInfoMidsDataHpsHlOl $MatchInfoMidsDataHpsHlOlFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataHpsHlOl matchInfoMidsDataHpsHlOl = MatchInfoMidsDataHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    matchInfoMidsDataHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    matchInfoMidsDataHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    matchInfoMidsDataHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    matchInfoMidsDataHpsHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    matchInfoMidsDataHpsHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    matchInfoMidsDataHpsHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    matchInfoMidsDataHpsHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    matchInfoMidsDataHpsHlOl.ov2 = ov2;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    matchInfoMidsDataHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    matchInfoMidsDataHpsHlOl.onb = onb;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchInfoMidsDataHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    matchInfoMidsDataHpsHlOl.ots = ots;
  }
  return matchInfoMidsDataHpsHlOl;
}

Map<String, dynamic> $MatchInfoMidsDataHpsHlOlToJson(
    MatchInfoMidsDataHpsHlOl entity) {
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

extension MatchInfoMidsDataHpsHlOlExtension on MatchInfoMidsDataHpsHlOl {
  MatchInfoMidsDataHpsHlOl copyWith({
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
    return MatchInfoMidsDataHpsHlOl()
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

MatchInfoMidsDataHps15Minutes $MatchInfoMidsDataHps15MinutesFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataHps15Minutes matchInfoMidsDataHps15Minutes = MatchInfoMidsDataHps15Minutes();
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    matchInfoMidsDataHps15Minutes.ctsp = ctsp;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    matchInfoMidsDataHps15Minutes.hids = hids;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    matchInfoMidsDataHps15Minutes.chpid = chpid;
  }
  final List<MatchInfoMidsDataHps15MinutesHl>? hl = (json['hl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHps15MinutesHl>(
          e) as MatchInfoMidsDataHps15MinutesHl).toList();
  if (hl != null) {
    matchInfoMidsDataHps15Minutes.hl = hl;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    matchInfoMidsDataHps15Minutes.hpn = hpn;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchInfoMidsDataHps15Minutes.mid = mid;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    matchInfoMidsDataHps15Minutes.hmm = hmm;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    matchInfoMidsDataHps15Minutes.hshow = hshow;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    matchInfoMidsDataHps15Minutes.hpnb = hpnb;
  }
  final String? hSpecial = jsonConvert.convert<String>(json['hSpecial']);
  if (hSpecial != null) {
    matchInfoMidsDataHps15Minutes.hSpecial = hSpecial;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    matchInfoMidsDataHps15Minutes.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    matchInfoMidsDataHps15Minutes.hsw = hsw;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchInfoMidsDataHps15Minutes.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    matchInfoMidsDataHps15Minutes.hpon = hpon;
  }
  final String? mct = jsonConvert.convert<String>(json['mct']);
  if (mct != null) {
    matchInfoMidsDataHps15Minutes.mct = mct;
  }
  return matchInfoMidsDataHps15Minutes;
}

Map<String, dynamic> $MatchInfoMidsDataHps15MinutesToJson(
    MatchInfoMidsDataHps15Minutes entity) {
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

extension MatchInfoMidsDataHps15MinutesExtension on MatchInfoMidsDataHps15Minutes {
  MatchInfoMidsDataHps15Minutes copyWith({
    String? ctsp,
    int? hids,
    String? chpid,
    List<MatchInfoMidsDataHps15MinutesHl>? hl,
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
    return MatchInfoMidsDataHps15Minutes()
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

MatchInfoMidsDataHps15MinutesHl $MatchInfoMidsDataHps15MinutesHlFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataHps15MinutesHl matchInfoMidsDataHps15MinutesHl = MatchInfoMidsDataHps15MinutesHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    matchInfoMidsDataHps15MinutesHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    matchInfoMidsDataHps15MinutesHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    matchInfoMidsDataHps15MinutesHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    matchInfoMidsDataHps15MinutesHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    matchInfoMidsDataHps15MinutesHl.hn = hn;
  }
  final String? ad3 = jsonConvert.convert<String>(json['ad3']);
  if (ad3 != null) {
    matchInfoMidsDataHps15MinutesHl.ad3 = ad3;
  }
  final String? ad5 = jsonConvert.convert<String>(json['ad5']);
  if (ad5 != null) {
    matchInfoMidsDataHps15MinutesHl.ad5 = ad5;
  }
  final List<MatchInfoMidsDataHps15MinutesHlOl>? ol = (json['ol'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHps15MinutesHlOl>(
          e) as MatchInfoMidsDataHps15MinutesHlOl).toList();
  if (ol != null) {
    matchInfoMidsDataHps15MinutesHl.ol = ol;
  }
  return matchInfoMidsDataHps15MinutesHl;
}

Map<String, dynamic> $MatchInfoMidsDataHps15MinutesHlToJson(
    MatchInfoMidsDataHps15MinutesHl entity) {
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

extension MatchInfoMidsDataHps15MinutesHlExtension on MatchInfoMidsDataHps15MinutesHl {
  MatchInfoMidsDataHps15MinutesHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    String? ad3,
    String? ad5,
    List<MatchInfoMidsDataHps15MinutesHlOl>? ol,
  }) {
    return MatchInfoMidsDataHps15MinutesHl()
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

MatchInfoMidsDataHps15MinutesHlOl $MatchInfoMidsDataHps15MinutesHlOlFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataHps15MinutesHlOl matchInfoMidsDataHps15MinutesHlOl = MatchInfoMidsDataHps15MinutesHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    matchInfoMidsDataHps15MinutesHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    matchInfoMidsDataHps15MinutesHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    matchInfoMidsDataHps15MinutesHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    matchInfoMidsDataHps15MinutesHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    matchInfoMidsDataHps15MinutesHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    matchInfoMidsDataHps15MinutesHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    matchInfoMidsDataHps15MinutesHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    matchInfoMidsDataHps15MinutesHlOl.ov2 = ov2;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    matchInfoMidsDataHps15MinutesHlOl.onb = onb;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    matchInfoMidsDataHps15MinutesHlOl.on = on;
  }
  final String? onbl = jsonConvert.convert<String>(json['onbl']);
  if (onbl != null) {
    matchInfoMidsDataHps15MinutesHlOl.onbl = onbl;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    matchInfoMidsDataHps15MinutesHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    matchInfoMidsDataHps15MinutesHlOl.ots = ots;
  }
  return matchInfoMidsDataHps15MinutesHlOl;
}

Map<String, dynamic> $MatchInfoMidsDataHps15MinutesHlOlToJson(
    MatchInfoMidsDataHps15MinutesHlOl entity) {
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

extension MatchInfoMidsDataHps15MinutesHlOlExtension on MatchInfoMidsDataHps15MinutesHlOl {
  MatchInfoMidsDataHps15MinutesHlOl copyWith({
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
    return MatchInfoMidsDataHps15MinutesHlOl()
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

MatchInfoMidsDataHpsCorner $MatchInfoMidsDataHpsCornerFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataHpsCorner matchInfoMidsDataHpsCorner = MatchInfoMidsDataHpsCorner();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    matchInfoMidsDataHpsCorner.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    matchInfoMidsDataHpsCorner.chpid = chpid;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    matchInfoMidsDataHpsCorner.ctsp = ctsp;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    matchInfoMidsDataHpsCorner.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    matchInfoMidsDataHpsCorner.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    matchInfoMidsDataHpsCorner.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    matchInfoMidsDataHpsCorner.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    matchInfoMidsDataHpsCorner.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    matchInfoMidsDataHpsCorner.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    matchInfoMidsDataHpsCorner.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    matchInfoMidsDataHpsCorner.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    matchInfoMidsDataHpsCorner.hids = hids;
  }
  final List<MatchInfoMidsDataHpsCornerHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchInfoMidsDataHpsCornerHl>(
          e) as MatchInfoMidsDataHpsCornerHl)
      .toList();
  if (hl != null) {
    matchInfoMidsDataHpsCorner.hl = hl;
  }
  return matchInfoMidsDataHpsCorner;
}

Map<String, dynamic> $MatchInfoMidsDataHpsCornerToJson(
    MatchInfoMidsDataHpsCorner entity) {
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

extension MatchInfoMidsDataHpsCornerExtension on MatchInfoMidsDataHpsCorner {
  MatchInfoMidsDataHpsCorner copyWith({
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
    List<MatchInfoMidsDataHpsCornerHl>? hl,
  }) {
    return MatchInfoMidsDataHpsCorner()
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

MatchInfoMidsDataHpsCornerHl $MatchInfoMidsDataHpsCornerHlFromJson(
    Map<String, dynamic> json) {
  final MatchInfoMidsDataHpsCornerHl matchInfoMidsDataHpsCornerHl = MatchInfoMidsDataHpsCornerHl();
  return matchInfoMidsDataHpsCornerHl;
}

Map<String, dynamic> $MatchInfoMidsDataHpsCornerHlToJson(
    MatchInfoMidsDataHpsCornerHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension MatchInfoMidsDataHpsCornerHlExtension on MatchInfoMidsDataHpsCornerHl {
}