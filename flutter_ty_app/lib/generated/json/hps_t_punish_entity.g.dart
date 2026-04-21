import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/mockdata/hps_t_punish_entity.dart';

HpsTPunishEntity $HpsTPunishEntityFromJson(Map<String, dynamic> json) {
  final HpsTPunishEntity hpsTPunishEntity = HpsTPunishEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    hpsTPunishEntity.code = code;
  }
  final HpsTPunishData? data = jsonConvert.convert<HpsTPunishData>(
      json['data']);
  if (data != null) {
    hpsTPunishEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    hpsTPunishEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    hpsTPunishEntity.ts = ts;
  }
  return hpsTPunishEntity;
}

Map<String, dynamic> $HpsTPunishEntityToJson(HpsTPunishEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension HpsTPunishEntityExtension on HpsTPunishEntity {
  HpsTPunishEntity copyWith({
    String? code,
    HpsTPunishData? data,
    String? msg,
    int? ts,
  }) {
    return HpsTPunishEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

HpsTPunishData $HpsTPunishDataFromJson(Map<String, dynamic> json) {
  final HpsTPunishData hpsTPunishData = HpsTPunishData();
  final HpsTPunishDataKySwitch? kySwitch = jsonConvert.convert<
      HpsTPunishDataKySwitch>(json['kySwitch']);
  if (kySwitch != null) {
    hpsTPunishData.kySwitch = kySwitch;
  }
  final List<HpsTPunishDataList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<HpsTPunishDataList>(e) as HpsTPunishDataList)
      .toList();
  if (list != null) {
    hpsTPunishData.list = list;
  }
  return hpsTPunishData;
}

Map<String, dynamic> $HpsTPunishDataToJson(HpsTPunishData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['kySwitch'] = entity.kySwitch.toJson();
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension HpsTPunishDataExtension on HpsTPunishData {
  HpsTPunishData copyWith({
    HpsTPunishDataKySwitch? kySwitch,
    List<HpsTPunishDataList>? list,
  }) {
    return HpsTPunishData()
      ..kySwitch = kySwitch ?? this.kySwitch
      ..list = list ?? this.list;
  }
}

HpsTPunishDataKySwitch $HpsTPunishDataKySwitchFromJson(
    Map<String, dynamic> json) {
  final HpsTPunishDataKySwitch hpsTPunishDataKySwitch = HpsTPunishDataKySwitch();
  final int? playType = jsonConvert.convert<int>(json['playType']);
  if (playType != null) {
    hpsTPunishDataKySwitch.playType = playType;
  }
  final int? isKy = jsonConvert.convert<int>(json['isKy']);
  if (isKy != null) {
    hpsTPunishDataKySwitch.isKy = isKy;
  }
  return hpsTPunishDataKySwitch;
}

Map<String, dynamic> $HpsTPunishDataKySwitchToJson(
    HpsTPunishDataKySwitch entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['playType'] = entity.playType;
  data['isKy'] = entity.isKy;
  return data;
}

extension HpsTPunishDataKySwitchExtension on HpsTPunishDataKySwitch {
  HpsTPunishDataKySwitch copyWith({
    int? playType,
    int? isKy,
  }) {
    return HpsTPunishDataKySwitch()
      ..playType = playType ?? this.playType
      ..isKy = isKy ?? this.isKy;
  }
}

HpsTPunishDataList $HpsTPunishDataListFromJson(Map<String, dynamic> json) {
  final HpsTPunishDataList hpsTPunishDataList = HpsTPunishDataList();
  final String? mcid = jsonConvert.convert<String>(json['mcid']);
  if (mcid != null) {
    hpsTPunishDataList.mcid = mcid;
  }
  final String? tnjc = jsonConvert.convert<String>(json['tnjc']);
  if (tnjc != null) {
    hpsTPunishDataList.tnjc = tnjc;
  }
  final bool? cosTCorner = jsonConvert.convert<bool>(json['cosTCorner']);
  if (cosTCorner != null) {
    hpsTPunishDataList.cosTCorner = cosTCorner;
  }
  final String? csna = jsonConvert.convert<String>(json['csna']);
  if (csna != null) {
    hpsTPunishDataList.csna = csna;
  }
  final bool? cosTPunish = jsonConvert.convert<bool>(json['cosTPunish']);
  if (cosTPunish != null) {
    hpsTPunishDataList.cosTPunish = cosTPunish;
  }
  final bool? cosOutright = jsonConvert.convert<bool>(json['cosOutright']);
  if (cosOutright != null) {
    hpsTPunishDataList.cosOutright = cosOutright;
  }
  final dynamic mdsc = json['mdsc'];
  if (mdsc != null) {
    hpsTPunishDataList.mdsc = mdsc;
  }
  final int? gcs = jsonConvert.convert<int>(json['gcs']);
  if (gcs != null) {
    hpsTPunishDataList.gcs = gcs;
  }
  final List<dynamic>? hpsOvertime = (json['hpsOvertime'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOvertime != null) {
    hpsTPunishDataList.hpsOvertime = hpsOvertime;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    hpsTPunishDataList.mgt = mgt;
  }
  final int? tlev = jsonConvert.convert<int>(json['tlev']);
  if (tlev != null) {
    hpsTPunishDataList.tlev = tlev;
  }
  final int? ctt = jsonConvert.convert<int>(json['ctt']);
  if (ctt != null) {
    hpsTPunishDataList.ctt = ctt;
  }
  final bool? cos5Minutes = jsonConvert.convert<bool>(json['cos5Minutes']);
  if (cos5Minutes != null) {
    hpsTPunishDataList.cos5Minutes = cos5Minutes;
  }
  final int? lvs = jsonConvert.convert<int>(json['lvs']);
  if (lvs != null) {
    hpsTPunishDataList.lvs = lvs;
  }
  final List<String>? malu = (json['malu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (malu != null) {
    hpsTPunishDataList.malu = malu;
  }
  final String? mprmc = jsonConvert.convert<String>(json['mprmc']);
  if (mprmc != null) {
    hpsTPunishDataList.mprmc = mprmc;
  }
  final bool? cosOvertime = jsonConvert.convert<bool>(json['cosOvertime']);
  if (cosOvertime != null) {
    hpsTPunishDataList.cosOvertime = cosOvertime;
  }
  final String? mhn = jsonConvert.convert<String>(json['mhn']);
  if (mhn != null) {
    hpsTPunishDataList.mhn = mhn;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    hpsTPunishDataList.betAmount = betAmount;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    hpsTPunishDataList.cds = cds;
  }
  final List<String>? frmhn = (json['frmhn'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frmhn != null) {
    hpsTPunishDataList.frmhn = frmhn;
  }
  final bool? compose = jsonConvert.convert<bool>(json['compose']);
  if (compose != null) {
    hpsTPunishDataList.compose = compose;
  }
  final bool? cosTBold = jsonConvert.convert<bool>(json['cosTBold']);
  if (cosTBold != null) {
    hpsTPunishDataList.cosTBold = cosTBold;
  }
  final int? operationTournamentSort = jsonConvert.convert<int>(
      json['operationTournamentSort']);
  if (operationTournamentSort != null) {
    hpsTPunishDataList.operationTournamentSort = operationTournamentSort;
  }
  final bool? cos15Minutes = jsonConvert.convert<bool>(json['cos15Minutes']);
  if (cos15Minutes != null) {
    hpsTPunishDataList.cos15Minutes = cos15Minutes;
  }
  final int? mhs = jsonConvert.convert<int>(json['mhs']);
  if (mhs != null) {
    hpsTPunishDataList.mhs = mhs;
  }
  final List<dynamic>? hps5Minutes = (json['hps5Minutes'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hps5Minutes != null) {
    hpsTPunishDataList.hps5Minutes = hps5Minutes;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    hpsTPunishDataList.mid = mid;
  }
  final bool? cosBold = jsonConvert.convert<bool>(json['cosBold']);
  if (cosBold != null) {
    hpsTPunishDataList.cosBold = cosBold;
  }
  final String? mststi = jsonConvert.convert<String>(json['mststi']);
  if (mststi != null) {
    hpsTPunishDataList.mststi = mststi;
  }
  final int? pmms = jsonConvert.convert<int>(json['pmms']);
  if (pmms != null) {
    hpsTPunishDataList.pmms = pmms;
  }
  final List<String>? mhlu = (json['mhlu'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (mhlu != null) {
    hpsTPunishDataList.mhlu = mhlu;
  }
  final String? mstst = jsonConvert.convert<String>(json['mstst']);
  if (mstst != null) {
    hpsTPunishDataList.mstst = mstst;
  }
  final String? man = jsonConvert.convert<String>(json['man']);
  if (man != null) {
    hpsTPunishDataList.man = man;
  }
  final List<dynamic>? hpsTBold = (json['hpsTBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTBold != null) {
    hpsTPunishDataList.hpsTBold = hpsTBold;
  }
  final String? st = jsonConvert.convert<String>(json['st']);
  if (st != null) {
    hpsTPunishDataList.st = st;
  }
  final String? mat = jsonConvert.convert<String>(json['mat']);
  if (mat != null) {
    hpsTPunishDataList.mat = mat;
  }
  final String? mststr = jsonConvert.convert<String>(json['mststr']);
  if (mststr != null) {
    hpsTPunishDataList.mststr = mststr;
  }
  final List<HpsTPunishDataListHps>? hps = (json['hps'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<HpsTPunishDataListHps>(e) as HpsTPunishDataListHps)
      .toList();
  if (hps != null) {
    hpsTPunishDataList.hps = hps;
  }
  final List<dynamic>? hpsCompose = (json['hpsCompose'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCompose != null) {
    hpsTPunishDataList.hpsCompose = hpsCompose;
  }
  final int? mststs = jsonConvert.convert<int>(json['mststs']);
  if (mststs != null) {
    hpsTPunishDataList.mststs = mststs;
  }
  final String? tc = jsonConvert.convert<String>(json['tc']);
  if (tc != null) {
    hpsTPunishDataList.tc = tc;
  }
  final bool? tf = jsonConvert.convert<bool>(json['tf']);
  if (tf != null) {
    hpsTPunishDataList.tf = tf;
  }
  final int? th = jsonConvert.convert<int>(json['th']);
  if (th != null) {
    hpsTPunishDataList.th = th;
  }
  final bool? cosPromotion = jsonConvert.convert<bool>(json['cosPromotion']);
  if (cosPromotion != null) {
    hpsTPunishDataList.cosPromotion = cosPromotion;
  }
  final String? tn = jsonConvert.convert<String>(json['tn']);
  if (tn != null) {
    hpsTPunishDataList.tn = tn;
  }
  final List<String>? msc = (json['msc'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (msc != null) {
    hpsTPunishDataList.msc = msc;
  }
  final List<dynamic>? hpsPromotion = (json['hpsPromotion'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsPromotion != null) {
    hpsTPunishDataList.hpsPromotion = hpsPromotion;
  }
  final String? tt = jsonConvert.convert<String>(json['tt']);
  if (tt != null) {
    hpsTPunishDataList.tt = tt;
  }
  final List<dynamic>? hpsBold = (json['hpsBold'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsBold != null) {
    hpsTPunishDataList.hpsBold = hpsBold;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    hpsTPunishDataList.tid = tid;
  }
  final String? mst = jsonConvert.convert<String>(json['mst']);
  if (mst != null) {
    hpsTPunishDataList.mst = mst;
  }
  final String? srid = jsonConvert.convert<String>(json['srid']);
  if (srid != null) {
    hpsTPunishDataList.srid = srid;
  }
  final int? mcg = jsonConvert.convert<int>(json['mcg']);
  if (mcg != null) {
    hpsTPunishDataList.mcg = mcg;
  }
  final bool? cosCorner = jsonConvert.convert<bool>(json['cosCorner']);
  if (cosCorner != null) {
    hpsTPunishDataList.cosCorner = cosCorner;
  }
  final String? atf = jsonConvert.convert<String>(json['atf']);
  if (atf != null) {
    hpsTPunishDataList.atf = atf;
  }
  final bool? cosPunish = jsonConvert.convert<bool>(json['cosPunish']);
  if (cosPunish != null) {
    hpsTPunishDataList.cosPunish = cosPunish;
  }
  final String? msts = jsonConvert.convert<String>(json['msts']);
  if (msts != null) {
    hpsTPunishDataList.msts = msts;
  }
  final int? mc = jsonConvert.convert<int>(json['mc']);
  if (mc != null) {
    hpsTPunishDataList.mc = mc;
  }
  final bool? mf = jsonConvert.convert<bool>(json['mf']);
  if (mf != null) {
    hpsTPunishDataList.mf = mf;
  }
  final String? maid = jsonConvert.convert<String>(json['maid']);
  if (maid != null) {
    hpsTPunishDataList.maid = maid;
  }
  final int? mct = jsonConvert.convert<int>(json['mct']);
  if (mct != null) {
    hpsTPunishDataList.mct = mct;
  }
  final String? mhlut = jsonConvert.convert<String>(json['mhlut']);
  if (mhlut != null) {
    hpsTPunishDataList.mhlut = mhlut;
  }
  final int? mo = jsonConvert.convert<int>(json['mo']);
  if (mo != null) {
    hpsTPunishDataList.mo = mo;
  }
  final int? mp = jsonConvert.convert<int>(json['mp']);
  if (mp != null) {
    hpsTPunishDataList.mp = mp;
  }
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    hpsTPunishDataList.csid = csid;
  }
  final int? ms = jsonConvert.convert<int>(json['ms']);
  if (ms != null) {
    hpsTPunishDataList.ms = ms;
  }
  final String? cmec = jsonConvert.convert<String>(json['cmec']);
  if (cmec != null) {
    hpsTPunishDataList.cmec = cmec;
  }
  final int? mle = jsonConvert.convert<int>(json['mle']);
  if (mle != null) {
    hpsTPunishDataList.mle = mle;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    hpsTPunishDataList.sort = sort;
  }
  final String? vf = jsonConvert.convert<String>(json['vf']);
  if (vf != null) {
    hpsTPunishDataList.vf = vf;
  }
  final List<dynamic>? hps15Minutes = (json['hps15Minutes'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hps15Minutes != null) {
    hpsTPunishDataList.hps15Minutes = hps15Minutes;
  }
  final String? lurl = jsonConvert.convert<String>(json['lurl']);
  if (lurl != null) {
    hpsTPunishDataList.lurl = lurl;
  }
  final String? mlet = jsonConvert.convert<String>(json['mlet']);
  if (mlet != null) {
    hpsTPunishDataList.mlet = mlet;
  }
  final bool? cosPenalty = jsonConvert.convert<bool>(json['cosPenalty']);
  if (cosPenalty != null) {
    hpsTPunishDataList.cosPenalty = cosPenalty;
  }
  final List<dynamic>? hpsCorner = (json['hpsCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsCorner != null) {
    hpsTPunishDataList.hpsCorner = hpsCorner;
  }
  final String? mhid = jsonConvert.convert<String>(json['mhid']);
  if (mhid != null) {
    hpsTPunishDataList.mhid = mhid;
  }
  final List<dynamic>? hpsPunish = (json['hpsPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPunish != null) {
    hpsTPunishDataList.hpsPunish = hpsPunish;
  }
  final String? mrmc = jsonConvert.convert<String>(json['mrmc']);
  if (mrmc != null) {
    hpsTPunishDataList.mrmc = mrmc;
  }
  final int? mess = jsonConvert.convert<int>(json['mess']);
  if (mess != null) {
    hpsTPunishDataList.mess = mess;
  }
  final dynamic lss = json['lss'];
  if (lss != null) {
    hpsTPunishDataList.lss = lss;
  }
  final String? mmp = jsonConvert.convert<String>(json['mmp']);
  if (mmp != null) {
    hpsTPunishDataList.mmp = mmp;
  }
  final int? mms = jsonConvert.convert<int>(json['mms']);
  if (mms != null) {
    hpsTPunishDataList.mms = mms;
  }
  final int? mbmty = jsonConvert.convert<int>(json['mbmty']);
  if (mbmty != null) {
    hpsTPunishDataList.mbmty = mbmty;
  }
  final int? regionIdSort = jsonConvert.convert<int>(json['regionIdSort']);
  if (regionIdSort != null) {
    hpsTPunishDataList.regionIdSort = regionIdSort;
  }
  final bool? cosBetBuilder = jsonConvert.convert<bool>(json['cosBetBuilder']);
  if (cosBetBuilder != null) {
    hpsTPunishDataList.cosBetBuilder = cosBetBuilder;
  }
  final String? seid = jsonConvert.convert<String>(json['seid']);
  if (seid != null) {
    hpsTPunishDataList.seid = seid;
  }
  final String? malut = jsonConvert.convert<String>(json['malut']);
  if (malut != null) {
    hpsTPunishDataList.malut = malut;
  }
  final List<String>? frman = (json['frman'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (frman != null) {
    hpsTPunishDataList.frman = frman;
  }
  final String? met = jsonConvert.convert<String>(json['met']);
  if (met != null) {
    hpsTPunishDataList.met = met;
  }
  final List<dynamic>? hpsTPunish = (json['hpsTPunish'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTPunish != null) {
    hpsTPunishDataList.hpsTPunish = hpsTPunish;
  }
  final List<dynamic>? hpsTCorner = (json['hpsTCorner'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsTCorner != null) {
    hpsTPunishDataList.hpsTCorner = hpsTCorner;
  }
  final int? mng = jsonConvert.convert<int>(json['mng']);
  if (mng != null) {
    hpsTPunishDataList.mng = mng;
  }
  final int? mvs = jsonConvert.convert<int>(json['mvs']);
  if (mvs != null) {
    hpsTPunishDataList.mvs = mvs;
  }
  final List<dynamic>? hpsPenalty = (json['hpsPenalty'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (hpsPenalty != null) {
    hpsTPunishDataList.hpsPenalty = hpsPenalty;
  }
  final int? mearlys = jsonConvert.convert<int>(json['mearlys']);
  if (mearlys != null) {
    hpsTPunishDataList.mearlys = mearlys;
  }
  final bool? hipo = jsonConvert.convert<bool>(json['hipo']);
  if (hipo != null) {
    hpsTPunishDataList.hipo = hipo;
  }
  final String? mfo = jsonConvert.convert<String>(json['mfo']);
  if (mfo != null) {
    hpsTPunishDataList.mfo = mfo;
  }
  final int? mft = jsonConvert.convert<int>(json['mft']);
  if (mft != null) {
    hpsTPunishDataList.mft = mft;
  }
  final List<dynamic>? hpsOutright = (json['hpsOutright'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (hpsOutright != null) {
    hpsTPunishDataList.hpsOutright = hpsOutright;
  }
  return hpsTPunishDataList;
}

Map<String, dynamic> $HpsTPunishDataListToJson(HpsTPunishDataList entity) {
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
  data['hps15Minutes'] = entity.hps15Minutes;
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

extension HpsTPunishDataListExtension on HpsTPunishDataList {
  HpsTPunishDataList copyWith({
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
    List<HpsTPunishDataListHps>? hps,
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
    List<dynamic>? hps15Minutes,
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
    String? mfo,
    int? mft,
    List<dynamic>? hpsOutright,
  }) {
    return HpsTPunishDataList()
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

HpsTPunishDataListHps $HpsTPunishDataListHpsFromJson(
    Map<String, dynamic> json) {
  final HpsTPunishDataListHps hpsTPunishDataListHps = HpsTPunishDataListHps();
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    hpsTPunishDataListHps.mid = mid;
  }
  final String? chpid = jsonConvert.convert<String>(json['chpid']);
  if (chpid != null) {
    hpsTPunishDataListHps.chpid = chpid;
  }
  final String? ctsp = jsonConvert.convert<String>(json['ctsp']);
  if (ctsp != null) {
    hpsTPunishDataListHps.ctsp = ctsp;
  }
  final String? hpid = jsonConvert.convert<String>(json['hpid']);
  if (hpid != null) {
    hpsTPunishDataListHps.hpid = hpid;
  }
  final int? hpon = jsonConvert.convert<int>(json['hpon']);
  if (hpon != null) {
    hpsTPunishDataListHps.hpon = hpon;
  }
  final String? hshow = jsonConvert.convert<String>(json['hshow']);
  if (hshow != null) {
    hpsTPunishDataListHps.hshow = hshow;
  }
  final String? hpn = jsonConvert.convert<String>(json['hpn']);
  if (hpn != null) {
    hpsTPunishDataListHps.hpn = hpn;
  }
  final String? hpnb = jsonConvert.convert<String>(json['hpnb']);
  if (hpnb != null) {
    hpsTPunishDataListHps.hpnb = hpnb;
  }
  final int? hpt = jsonConvert.convert<int>(json['hpt']);
  if (hpt != null) {
    hpsTPunishDataListHps.hpt = hpt;
  }
  final String? hsw = jsonConvert.convert<String>(json['hsw']);
  if (hsw != null) {
    hpsTPunishDataListHps.hsw = hsw;
  }
  final int? hmm = jsonConvert.convert<int>(json['hmm']);
  if (hmm != null) {
    hpsTPunishDataListHps.hmm = hmm;
  }
  final int? hids = jsonConvert.convert<int>(json['hids']);
  if (hids != null) {
    hpsTPunishDataListHps.hids = hids;
  }
  final List<HpsTPunishDataListHpsHl>? hl = (json['hl'] as List<dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<HpsTPunishDataListHpsHl>(
          e) as HpsTPunishDataListHpsHl).toList();
  if (hl != null) {
    hpsTPunishDataListHps.hl = hl;
  }
  return hpsTPunishDataListHps;
}

Map<String, dynamic> $HpsTPunishDataListHpsToJson(
    HpsTPunishDataListHps entity) {
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

extension HpsTPunishDataListHpsExtension on HpsTPunishDataListHps {
  HpsTPunishDataListHps copyWith({
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
    List<HpsTPunishDataListHpsHl>? hl,
  }) {
    return HpsTPunishDataListHps()
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

HpsTPunishDataListHpsHl $HpsTPunishDataListHpsHlFromJson(
    Map<String, dynamic> json) {
  final HpsTPunishDataListHpsHl hpsTPunishDataListHpsHl = HpsTPunishDataListHpsHl();
  final String? hid = jsonConvert.convert<String>(json['hid']);
  if (hid != null) {
    hpsTPunishDataListHpsHl.hid = hid;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    hpsTPunishDataListHpsHl.hs = hs;
  }
  final dynamic hv = json['hv'];
  if (hv != null) {
    hpsTPunishDataListHpsHl.hv = hv;
  }
  final int? hmt = jsonConvert.convert<int>(json['hmt']);
  if (hmt != null) {
    hpsTPunishDataListHpsHl.hmt = hmt;
  }
  final dynamic hn = json['hn'];
  if (hn != null) {
    hpsTPunishDataListHpsHl.hn = hn;
  }
  final List<HpsTPunishDataListHpsHlOl>? ol = (json['ol'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<HpsTPunishDataListHpsHlOl>(
          e) as HpsTPunishDataListHpsHlOl)
      .toList();
  if (ol != null) {
    hpsTPunishDataListHpsHl.ol = ol;
  }
  return hpsTPunishDataListHpsHl;
}

Map<String, dynamic> $HpsTPunishDataListHpsHlToJson(
    HpsTPunishDataListHpsHl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hid'] = entity.hid;
  data['hs'] = entity.hs;
  data['hv'] = entity.hv;
  data['hmt'] = entity.hmt;
  data['hn'] = entity.hn;
  data['ol'] = entity.ol.map((v) => v.toJson()).toList();
  return data;
}

extension HpsTPunishDataListHpsHlExtension on HpsTPunishDataListHpsHl {
  HpsTPunishDataListHpsHl copyWith({
    String? hid,
    int? hs,
    dynamic hv,
    int? hmt,
    dynamic hn,
    List<HpsTPunishDataListHpsHlOl>? ol,
  }) {
    return HpsTPunishDataListHpsHl()
      ..hid = hid ?? this.hid
      ..hs = hs ?? this.hs
      ..hv = hv ?? this.hv
      ..hmt = hmt ?? this.hmt
      ..hn = hn ?? this.hn
      ..ol = ol ?? this.ol;
  }
}

HpsTPunishDataListHpsHlOl $HpsTPunishDataListHpsHlOlFromJson(
    Map<String, dynamic> json) {
  final HpsTPunishDataListHpsHlOl hpsTPunishDataListHpsHlOl = HpsTPunishDataListHpsHlOl();
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    hpsTPunishDataListHpsHlOl.oid = oid;
  }
  final int? os = jsonConvert.convert<int>(json['os']);
  if (os != null) {
    hpsTPunishDataListHpsHlOl.os = os;
  }
  final int? otd = jsonConvert.convert<int>(json['otd']);
  if (otd != null) {
    hpsTPunishDataListHpsHlOl.otd = otd;
  }
  final String? ot = jsonConvert.convert<String>(json['ot']);
  if (ot != null) {
    hpsTPunishDataListHpsHlOl.ot = ot;
  }
  final dynamic dov = json['dov'];
  if (dov != null) {
    hpsTPunishDataListHpsHlOl.dov = dov;
  }
  final dynamic doc = json['doc'];
  if (doc != null) {
    hpsTPunishDataListHpsHlOl.doc = doc;
  }
  final int? ov = jsonConvert.convert<int>(json['ov']);
  if (ov != null) {
    hpsTPunishDataListHpsHlOl.ov = ov;
  }
  final dynamic ov2 = json['ov2'];
  if (ov2 != null) {
    hpsTPunishDataListHpsHlOl.ov2 = ov2;
  }
  final String? on = jsonConvert.convert<String>(json['on']);
  if (on != null) {
    hpsTPunishDataListHpsHlOl.on = on;
  }
  final String? onb = jsonConvert.convert<String>(json['onb']);
  if (onb != null) {
    hpsTPunishDataListHpsHlOl.onb = onb;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    hpsTPunishDataListHpsHlOl.cds = cds;
  }
  final String? ots = jsonConvert.convert<String>(json['ots']);
  if (ots != null) {
    hpsTPunishDataListHpsHlOl.ots = ots;
  }
  return hpsTPunishDataListHpsHlOl;
}

Map<String, dynamic> $HpsTPunishDataListHpsHlOlToJson(
    HpsTPunishDataListHpsHlOl entity) {
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

extension HpsTPunishDataListHpsHlOlExtension on HpsTPunishDataListHpsHlOl {
  HpsTPunishDataListHpsHlOl copyWith({
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
    return HpsTPunishDataListHpsHlOl()
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