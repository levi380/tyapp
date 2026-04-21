import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_info_mids_entity.dart';

GetInfoMidsEntity $GetInfoMidsEntityFromJson(Map<String, dynamic> json) {
  final GetInfoMidsEntity getInfoMidsEntity = GetInfoMidsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getInfoMidsEntity.code = code;
  }
  final List<GetInfoMidsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetInfoMidsData>(e) as GetInfoMidsData)
      .toList();
  if (data != null) {
    getInfoMidsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getInfoMidsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getInfoMidsEntity.ts = ts;
  }
  return getInfoMidsEntity;
}

Map<String, dynamic> $GetInfoMidsEntityToJson(GetInfoMidsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetInfoMidsEntityExtension on GetInfoMidsEntity {
  GetInfoMidsEntity copyWith({
    String? code,
    List<GetInfoMidsData>? data,
    String? msg,
    int? ts,
  }) {
    return GetInfoMidsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetInfoMidsData $GetInfoMidsDataFromJson(Map<String, dynamic> json) {
  final GetInfoMidsData getInfoMidsData = GetInfoMidsData();
  final String? mcid = jsonConvert.convert<String>(json['mcid']);
  if (mcid != null) {
    getInfoMidsData.mcid = mcid;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    getInfoMidsData.tnjc = tnjc;
  }
  final bool? cosTCorner = jsonConvert.convert<bool>(json['cosTCorner']);
  if (cosTCorner != null) {
    getInfoMidsData.cosTCorner = cosTCorner;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    getInfoMidsData.csna = csna;
  }
  final bool? cosTPunish = jsonConvert.convert<bool>(json['cosTPunish']);
  if (cosTPunish != null) {
    getInfoMidsData.cosTPunish = cosTPunish;
  }
  final GetInfoMidsDataKySwitch? kySwitch = jsonConvert.convert<
      GetInfoMidsDataKySwitch>(json['kySwitch']);
  if (kySwitch != null) {
    getInfoMidsData.kySwitch = kySwitch;
  }
  final bool? cosOutright = jsonConvert.convert<bool>(json['cosOutright']);
  if (cosOutright != null) {
    getInfoMidsData.cosOutright = cosOutright;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    getInfoMidsData.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    getInfoMidsData.gcs = gcs;
  }
  final List<dynamic>? hpsOvertime = (json['hpsOvertime'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOvertime != null) {
    getInfoMidsData.hpsOvertime = hpsOvertime;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    getInfoMidsData.mgt = mgt;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    getInfoMidsData.tlev = tlev;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    getInfoMidsData.ctt = ctt;
  }
  final bool? cos5Minutes = jsonConvert.convert<bool>(json['cos5Minutes']);
  if (cos5Minutes != null) {
    getInfoMidsData.cos5Minutes = cos5Minutes;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    getInfoMidsData.lvs = lvs;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    getInfoMidsData.malu = malu;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    getInfoMidsData.mprmc = mprmc;
  }
  final bool? cosOvertime = jsonConvert.convert<bool>(json['cosOvertime']);
  if (cosOvertime != null) {
    getInfoMidsData.cosOvertime = cosOvertime;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    getInfoMidsData.mhn = mhn;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getInfoMidsData.betAmount = betAmount;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    getInfoMidsData.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    getInfoMidsData.frmhn = frmhn;
  }
  final bool? compose = jsonConvert.convert<bool>(json['compose']);
  if (compose != null) {
    getInfoMidsData.compose = compose;
  }
  final bool? cosTBold = jsonConvert.convert<bool>(json['cosTBold']);
  if (cosTBold != null) {
    getInfoMidsData.cosTBold = cosTBold;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    getInfoMidsData.operationTournamentSort = operationTournamentSort;
  }
  final bool? cos15Minutes = jsonConvert.convert<bool>(json['cos15Minutes']);
  if (cos15Minutes != null) {
    getInfoMidsData.cos15Minutes = cos15Minutes;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    getInfoMidsData.mhs = mhs;
  }
  final List<dynamic>? hps5Minutes = (json['hps5Minutes'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hps5Minutes != null) {
    getInfoMidsData.hps5Minutes = hps5Minutes;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    getInfoMidsData.mid = mid;
  }
  final bool? cosBold = jsonConvert.convert<bool>(json['cosBold']);
  if (cosBold != null) {
    getInfoMidsData.cosBold = cosBold;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    getInfoMidsData.mststi = mststi;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    getInfoMidsData.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    getInfoMidsData.mhlu = mhlu;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    getInfoMidsData.mstst = mstst;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    getInfoMidsData.man = man;
  }
  final List<dynamic>? hpsTBold = (json['hpsTBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTBold != null) {
    getInfoMidsData.hpsTBold = hpsTBold;
  }
  final dynamic st = json['st'];
  if (st != null) {
    getInfoMidsData.st = st;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    getInfoMidsData.mat = mat;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    getInfoMidsData.mststr = mststr;
  }
  final List<GetInfoMidsDataHps>? hps = (json['hps'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetInfoMidsDataHps>(e) as GetInfoMidsDataHps)
      .toList();
  if (hps != null) {
    getInfoMidsData.hps = hps;
  }
  final List<dynamic>? hpsCompose = (json['hpsCompose'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCompose != null) {
    getInfoMidsData.hpsCompose = hpsCompose;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    getInfoMidsData.mststs = mststs;
  }
  final String? tc = jsonConvert.convert<String>(json['tc']);
  if (tc != null) {
    getInfoMidsData.tc = tc;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    getInfoMidsData.tf = tf;
  }
  final int? th = jsonConvert.convert<int>(json['th']);
  if (th != null) {
    getInfoMidsData.th = th;
  }
  final bool? cosPromotion = jsonConvert.convert<bool>(json['cosPromotion']);
  if (cosPromotion != null) {
    getInfoMidsData.cosPromotion = cosPromotion;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    getInfoMidsData.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    getInfoMidsData.msc = msc;
  }
  final List<dynamic>? hpsPromotion = (json['hpsPromotion'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsPromotion != null) {
    getInfoMidsData.hpsPromotion = hpsPromotion;
  }
  final String? tt = jsonConvert.convert<String>(json['tt']);
  if (tt != null) {
    getInfoMidsData.tt = tt;
  }
  final String? ecds = jsonConvert.convert<String>(json['ecds']);
  if (ecds != null) {
    getInfoMidsData.ecds = ecds;
  }
  final List<dynamic>? hpsBold = (json['hpsBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsBold != null) {
    getInfoMidsData.hpsBold = hpsBold;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    getInfoMidsData.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    getInfoMidsData.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    getInfoMidsData.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    getInfoMidsData.mcg = mcg;
  }
  final bool? cosCorner = jsonConvert.convert<bool>(json['cosCorner']);
  if (cosCorner != null) {
    getInfoMidsData.cosCorner = cosCorner;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    getInfoMidsData.atf = atf;
  }
  final bool? cosPunish = jsonConvert.convert<bool>(json['cosPunish']);
  if (cosPunish != null) {
    getInfoMidsData.cosPunish = cosPunish;
  }
  final String? msts = jsonConvert.convert<String>(json['msts']);
  if (msts != null) {
    getInfoMidsData.msts = msts;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    getInfoMidsData.mc = mc;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    getInfoMidsData.mf = mf;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    getInfoMidsData.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    getInfoMidsData.mct = mct;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    getInfoMidsData.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    getInfoMidsData.mo = mo;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    getInfoMidsData.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    getInfoMidsData.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    getInfoMidsData.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    getInfoMidsData.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    getInfoMidsData.mle = mle;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    getInfoMidsData.sort = sort;
  }
  final String? vf = jsonConvert.convert<String>(json['vf']);
  if (vf != null) {
    getInfoMidsData.vf = vf;
  }
  final List<dynamic>? hps15Minutes = (json['hps15Minutes'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hps15Minutes != null) {
    getInfoMidsData.hps15Minutes = hps15Minutes;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    getInfoMidsData.lurl = lurl;
  }
  final bool? cosOvertimeIng = jsonConvert.convert<bool>(
      json['cosOvertimeIng']);
  if (cosOvertimeIng != null) {
    getInfoMidsData.cosOvertimeIng = cosOvertimeIng;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    getInfoMidsData.mlet = mlet;
  }
  final bool? cosPenalty = jsonConvert.convert<bool>(json['cosPenalty']);
  if (cosPenalty != null) {
    getInfoMidsData.cosPenalty = cosPenalty;
  }
  final List<dynamic>? hpsCorner = (json['hpsCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCorner != null) {
    getInfoMidsData.hpsCorner = hpsCorner;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    getInfoMidsData.mhid = mhid;
  }
  final List<dynamic>? hpsPunish = (json['hpsPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPunish != null) {
    getInfoMidsData.hpsPunish = hpsPunish;
  }
  final dynamic legOrder = json['legOrder'];
  if (legOrder != null) {
    getInfoMidsData.legOrder = legOrder;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    getInfoMidsData.mrmc = mrmc;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    getInfoMidsData.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    getInfoMidsData.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    getInfoMidsData.mmp = mmp;
  }
  final int? operationHotSortTop = jsonConvert.convert<int>(
      json['operationHotSortTop']);
  if (operationHotSortTop != null) {
    getInfoMidsData.operationHotSortTop = operationHotSortTop;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    getInfoMidsData.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    getInfoMidsData.mbmty = mbmty;
  }
  final int? regionIdSort = jsonConvert.convert<int>(json['regionIdSort']);
  if (regionIdSort != null) {
    getInfoMidsData.regionIdSort = regionIdSort;
  }
  final bool? cosBetBuilder = jsonConvert.convert<bool>(json['cosBetBuilder']);
  if (cosBetBuilder != null) {
    getInfoMidsData.cosBetBuilder = cosBetBuilder;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    getInfoMidsData.seid = seid;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    getInfoMidsData.malut = malut;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    getInfoMidsData.frman = frman;
  }
  final String? met = jsonConvert.convert<String>(json['met']);
  if (met != null) {
    getInfoMidsData.met = met;
  }
  final List<dynamic>? hpsTPunish = (json['hpsTPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTPunish != null) {
    getInfoMidsData.hpsTPunish = hpsTPunish;
  }
  final List<dynamic>? hpsTCorner = (json['hpsTCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTCorner != null) {
    getInfoMidsData.hpsTCorner = hpsTCorner;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    getInfoMidsData.mng = mng;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    getInfoMidsData.mvs = mvs;
  }
  final List<
      GetInfoMidsDataHpsPenalty>? hpsPenalty = (json['hpsPenalty'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetInfoMidsDataHpsPenalty>(
          e) as GetInfoMidsDataHpsPenalty).toList();
  if (hpsPenalty != null) {
    getInfoMidsData.hpsPenalty = hpsPenalty;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    getInfoMidsData.mearlys = mearlys;
  }
  final bool? hipo = jsonConvert.convert<bool>(json['hipo']);
  if (hipo != null) {
    getInfoMidsData.hipo = hipo;
  }
  final String? mfo = jsonConvert.convert<String>(json['mfo']);
  if (mfo != null) {
    getInfoMidsData.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    getInfoMidsData.mft = mft;
  }
  final List<dynamic>? hpsOutright = (json['hpsOutright'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOutright != null) {
    getInfoMidsData.hpsOutright = hpsOutright;
  }
  return getInfoMidsData;
}

Map<String, dynamic> $GetInfoMidsDataToJson(GetInfoMidsData entity) {
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
  data['hps15Minutes'] = entity.hps15Minutes;
  data['lurl'] = entity.lurl;
  data['cosOvertimeIng'] = entity.cosOvertimeIng;
  data['mlet'] = entity.mlet;
  data['cosPenalty'] = entity.cosPenalty;
  data['hpsCorner'] = entity.hpsCorner;
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
  data['hpsPenalty'] = entity.hpsPenalty.map((v) => v.toJson()).toList();
  data['mearlys'] = entity.mearlys;
  data['hipo'] = entity.hipo;
  data['mfo'] = entity.mfo;
  data['mft'] = entity.mft;
  data['hpsOutright'] = entity.hpsOutright;
  return data;
}

extension GetInfoMidsDataExtension on GetInfoMidsData {
  GetInfoMidsData copyWith({
    String? mcid,
    String? tnjc,
    bool? cosTCorner,
    String? csna,
    bool? cosTPunish,
    GetInfoMidsDataKySwitch? kySwitch,
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
    List<GetInfoMidsDataHps>? hps,
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
    List<dynamic>? hps15Minutes,
    String? lurl,
    bool? cosOvertimeIng,
    String? mlet,
    bool? cosPenalty,
    List<dynamic>? hpsCorner,
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
    List<GetInfoMidsDataHpsPenalty>? hpsPenalty,
    int? mearlys,
    bool? hipo,
    String? mfo,
    int? mft,
    List<dynamic>? hpsOutright,
  }) {
    return GetInfoMidsData()
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

GetInfoMidsDataKySwitch $GetInfoMidsDataKySwitchFromJson(
    Map<String, dynamic> json) {
  final GetInfoMidsDataKySwitch getInfoMidsDataKySwitch = GetInfoMidsDataKySwitch();
  final int? playType = jsonConvert.convert<int>(json['playType']);
  if (playType != null) {
    getInfoMidsDataKySwitch.playType = playType;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getInfoMidsDataKySwitch.tournamentId = tournamentId;
  }
  final int? isKy = jsonConvert.convert<int>(json['isKy']);
  if (isKy != null) {
    getInfoMidsDataKySwitch.isKy = isKy;
  }
  return getInfoMidsDataKySwitch;
}

Map<String, dynamic> $GetInfoMidsDataKySwitchToJson(
    GetInfoMidsDataKySwitch entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['playType'] = entity.playType;
  data['tournamentId'] = entity.tournamentId;
  data['isKy'] = entity.isKy;
  return data;
}

extension GetInfoMidsDataKySwitchExtension on GetInfoMidsDataKySwitch {
  GetInfoMidsDataKySwitch copyWith({
    int? playType,
    String? tournamentId,
    int? isKy,
  }) {
    return GetInfoMidsDataKySwitch()
      ..playType = playType ?? this.playType
      ..tournamentId = tournamentId ?? this.tournamentId
      ..isKy = isKy ?? this.isKy;
  }
}

GetInfoMidsDataHps $GetInfoMidsDataHpsFromJson(Map<String, dynamic> json) {
  final GetInfoMidsDataHps getInfoMidsDataHps = GetInfoMidsDataHps();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    getInfoMidsDataHps.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    getInfoMidsDataHps.chpid = chpid;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    getInfoMidsDataHps.ctsp = ctsp;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    getInfoMidsDataHps.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    getInfoMidsDataHps.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    getInfoMidsDataHps.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    getInfoMidsDataHps.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    getInfoMidsDataHps.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    getInfoMidsDataHps.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    getInfoMidsDataHps.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    getInfoMidsDataHps.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    getInfoMidsDataHps.hids = hids;
  }
  final List<GetInfoMidsDataHpsHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetInfoMidsDataHpsHl>(e) as GetInfoMidsDataHpsHl)
      .toList();
  if (hl != null) {
    getInfoMidsDataHps.hl = hl;
  }
  return getInfoMidsDataHps;
}

Map<String, dynamic> $GetInfoMidsDataHpsToJson(GetInfoMidsDataHps entity) {
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

extension GetInfoMidsDataHpsExtension on GetInfoMidsDataHps {
  GetInfoMidsDataHps copyWith({
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
    List<GetInfoMidsDataHpsHl>? hl,
  }) {
    return GetInfoMidsDataHps()
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

GetInfoMidsDataHpsHl $GetInfoMidsDataHpsHlFromJson(Map<String, dynamic> json) {
  final GetInfoMidsDataHpsHl getInfoMidsDataHpsHl = GetInfoMidsDataHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    getInfoMidsDataHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    getInfoMidsDataHpsHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    getInfoMidsDataHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    getInfoMidsDataHpsHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    getInfoMidsDataHpsHl.hn = hn;
  }
  final List<GetInfoMidsDataHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetInfoMidsDataHpsHlOl>(e) as GetInfoMidsDataHpsHlOl)
      .toList();
  if (ol != null) {
    getInfoMidsDataHpsHl.ol = ol;
  }
  return getInfoMidsDataHpsHl;
}

Map<String, dynamic> $GetInfoMidsDataHpsHlToJson(GetInfoMidsDataHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension GetInfoMidsDataHpsHlExtension on GetInfoMidsDataHpsHl {
  GetInfoMidsDataHpsHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    List<GetInfoMidsDataHpsHlOl>? ol,
  }) {
    return GetInfoMidsDataHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ol = ol ?? this.ol;
  }
}

GetInfoMidsDataHpsHlOl $GetInfoMidsDataHpsHlOlFromJson(
    Map<String, dynamic> json) {
  final GetInfoMidsDataHpsHlOl getInfoMidsDataHpsHlOl = GetInfoMidsDataHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    getInfoMidsDataHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    getInfoMidsDataHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    getInfoMidsDataHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    getInfoMidsDataHpsHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    getInfoMidsDataHpsHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    getInfoMidsDataHpsHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    getInfoMidsDataHpsHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    getInfoMidsDataHpsHlOl.ov2 = ov2;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    getInfoMidsDataHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    getInfoMidsDataHpsHlOl.onb = onb;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    getInfoMidsDataHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    getInfoMidsDataHpsHlOl.ots = ots;
  }
  return getInfoMidsDataHpsHlOl;
}

Map<String, dynamic> $GetInfoMidsDataHpsHlOlToJson(
    GetInfoMidsDataHpsHlOl entity) {
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

extension GetInfoMidsDataHpsHlOlExtension on GetInfoMidsDataHpsHlOl {
  GetInfoMidsDataHpsHlOl copyWith({
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
    return GetInfoMidsDataHpsHlOl()
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

GetInfoMidsDataHpsPenalty $GetInfoMidsDataHpsPenaltyFromJson(
    Map<String, dynamic> json) {
  final GetInfoMidsDataHpsPenalty getInfoMidsDataHpsPenalty = GetInfoMidsDataHpsPenalty();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    getInfoMidsDataHpsPenalty.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    getInfoMidsDataHpsPenalty.chpid = chpid;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    getInfoMidsDataHpsPenalty.ctsp = ctsp;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    getInfoMidsDataHpsPenalty.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    getInfoMidsDataHpsPenalty.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    getInfoMidsDataHpsPenalty.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    getInfoMidsDataHpsPenalty.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    getInfoMidsDataHpsPenalty.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    getInfoMidsDataHpsPenalty.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    getInfoMidsDataHpsPenalty.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    getInfoMidsDataHpsPenalty.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    getInfoMidsDataHpsPenalty.hids = hids;
  }
  final List<GetInfoMidsDataHpsPenaltyHl>? hl = (json['hl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetInfoMidsDataHpsPenaltyHl>(
          e) as GetInfoMidsDataHpsPenaltyHl)
      .toList();
  if (hl != null) {
    getInfoMidsDataHpsPenalty.hl = hl;
  }
  return getInfoMidsDataHpsPenalty;
}

Map<String, dynamic> $GetInfoMidsDataHpsPenaltyToJson(
    GetInfoMidsDataHpsPenalty entity) {
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

extension GetInfoMidsDataHpsPenaltyExtension on GetInfoMidsDataHpsPenalty {
  GetInfoMidsDataHpsPenalty copyWith({
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
    List<GetInfoMidsDataHpsPenaltyHl>? hl,
  }) {
    return GetInfoMidsDataHpsPenalty()
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

GetInfoMidsDataHpsPenaltyHl $GetInfoMidsDataHpsPenaltyHlFromJson(
    Map<String, dynamic> json) {
  final GetInfoMidsDataHpsPenaltyHl getInfoMidsDataHpsPenaltyHl = GetInfoMidsDataHpsPenaltyHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    getInfoMidsDataHpsPenaltyHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    getInfoMidsDataHpsPenaltyHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    getInfoMidsDataHpsPenaltyHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    getInfoMidsDataHpsPenaltyHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    getInfoMidsDataHpsPenaltyHl.hn = hn;
  }
  final List<GetInfoMidsDataHpsPenaltyHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetInfoMidsDataHpsPenaltyHlOl>(
          e) as GetInfoMidsDataHpsPenaltyHlOl)
      .toList();
  if (ol != null) {
    getInfoMidsDataHpsPenaltyHl.ol = ol;
  }
  return getInfoMidsDataHpsPenaltyHl;
}

Map<String, dynamic> $GetInfoMidsDataHpsPenaltyHlToJson(
    GetInfoMidsDataHpsPenaltyHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension GetInfoMidsDataHpsPenaltyHlExtension on GetInfoMidsDataHpsPenaltyHl {
  GetInfoMidsDataHpsPenaltyHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    List<GetInfoMidsDataHpsPenaltyHlOl>? ol,
  }) {
    return GetInfoMidsDataHpsPenaltyHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ol = ol ?? this.ol;
  }
}

GetInfoMidsDataHpsPenaltyHlOl $GetInfoMidsDataHpsPenaltyHlOlFromJson(
    Map<String, dynamic> json) {
  final GetInfoMidsDataHpsPenaltyHlOl getInfoMidsDataHpsPenaltyHlOl = GetInfoMidsDataHpsPenaltyHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    getInfoMidsDataHpsPenaltyHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    getInfoMidsDataHpsPenaltyHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    getInfoMidsDataHpsPenaltyHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    getInfoMidsDataHpsPenaltyHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    getInfoMidsDataHpsPenaltyHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    getInfoMidsDataHpsPenaltyHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    getInfoMidsDataHpsPenaltyHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    getInfoMidsDataHpsPenaltyHlOl.ov2 = ov2;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    getInfoMidsDataHpsPenaltyHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    getInfoMidsDataHpsPenaltyHlOl.onb = onb;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    getInfoMidsDataHpsPenaltyHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    getInfoMidsDataHpsPenaltyHlOl.ots = ots;
  }
  return getInfoMidsDataHpsPenaltyHlOl;
}

Map<String, dynamic> $GetInfoMidsDataHpsPenaltyHlOlToJson(
    GetInfoMidsDataHpsPenaltyHlOl entity) {
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

extension GetInfoMidsDataHpsPenaltyHlOlExtension on GetInfoMidsDataHpsPenaltyHlOl {
  GetInfoMidsDataHpsPenaltyHlOl copyWith({
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
    return GetInfoMidsDataHpsPenaltyHlOl()
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