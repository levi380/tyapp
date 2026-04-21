import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/hps_t_punish_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/hps_t_punish_entity.g.dart';

@JsonSerializable()
class HpsTPunishEntity {
	late String code;
	late HpsTPunishData data;
	late String msg;
	late int ts;

	HpsTPunishEntity();

	factory HpsTPunishEntity.fromJson(Map<String, dynamic> json) => $HpsTPunishEntityFromJson(json);

	Map<String, dynamic> toJson() => $HpsTPunishEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HpsTPunishData {
	late HpsTPunishDataKySwitch kySwitch;
	late List<HpsTPunishDataList> list;

	HpsTPunishData();

	factory HpsTPunishData.fromJson(Map<String, dynamic> json) => $HpsTPunishDataFromJson(json);

	Map<String, dynamic> toJson() => $HpsTPunishDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HpsTPunishDataKySwitch {
	late int playType;
	late int isKy;

	HpsTPunishDataKySwitch();

	factory HpsTPunishDataKySwitch.fromJson(Map<String, dynamic> json) => $HpsTPunishDataKySwitchFromJson(json);

	Map<String, dynamic> toJson() => $HpsTPunishDataKySwitchToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HpsTPunishDataList {
	late String mcid;
	late String tnjc;
	late bool cosTCorner;
	late String csna;
	late bool cosTPunish;
	late bool cosOutright;
	dynamic mdsc;
	late int gcs;
	late List<dynamic> hpsOvertime;
	late String mgt;
	late int tlev;
	late int ctt;
	late bool cos5Minutes;
	late int lvs;
	late List<String> malu;
	late String mprmc;
	late bool cosOvertime;
	late String mhn;
	late String betAmount;
	late String cds;
	late List<String> frmhn;
	late bool compose;
	late bool cosTBold;
	late int operationTournamentSort;
	late bool cos15Minutes;
	late int mhs;
	late List<dynamic> hps5Minutes;
	late String mid;
	late bool cosBold;
	late String mststi;
	late int pmms;
	late List<String> mhlu;
	late String mstst;
	late String man;
	late List<dynamic> hpsTBold;
	late String st;
	late String mat;
	late String mststr;
	late List<HpsTPunishDataListHps> hps;
	late List<dynamic> hpsCompose;
	late int mststs;
	late String tc;
	late bool tf;
	late int th;
	late bool cosPromotion;
	late String tn;
	late List<String> msc;
	late List<dynamic> hpsPromotion;
	late String tt;
	late List<dynamic> hpsBold;
	late String tid;
	late String mst;
	late String srid;
	late int mcg;
	late bool cosCorner;
	late String atf;
	late bool cosPunish;
	late String msts;
	late int mc;
	late bool mf;
	late String maid;
	late int mct;
	late String mhlut;
	late int mo;
	late int mp;
	late String csid;
	late int ms;
	late String cmec;
	late int mle;
	late int sort;
	late String vf;
	late List<dynamic> hps15Minutes;
	late String lurl;
	late String mlet;
	late bool cosPenalty;
	late List<dynamic> hpsCorner;
	late String mhid;
	late List<dynamic> hpsPunish;
	late String mrmc;
	late int mess;
	dynamic lss;
	late String mmp;
	late int mms;
	late int mbmty;
	late int regionIdSort;
	late bool cosBetBuilder;
	late String seid;
	late String malut;
	late List<String> frman;
	late String met;
	late List<dynamic> hpsTPunish;
	late List<dynamic> hpsTCorner;
	late int mng;
	late int mvs;
	late List<dynamic> hpsPenalty;
	late int mearlys;
	late bool hipo;
	late String mfo;
	late int mft;
	late List<dynamic> hpsOutright;

	HpsTPunishDataList();

	factory HpsTPunishDataList.fromJson(Map<String, dynamic> json) => $HpsTPunishDataListFromJson(json);

	Map<String, dynamic> toJson() => $HpsTPunishDataListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HpsTPunishDataListHps {
	late String mid;
	late String chpid;
	late String ctsp;
	late String hpid;
	late int hpon;
	late String hshow;
	late String hpn;
	late String hpnb;
	late int hpt;
	late String hsw;
	late int hmm;
	late int hids;
	late List<HpsTPunishDataListHpsHl> hl;

	HpsTPunishDataListHps();

	factory HpsTPunishDataListHps.fromJson(Map<String, dynamic> json) => $HpsTPunishDataListHpsFromJson(json);

	Map<String, dynamic> toJson() => $HpsTPunishDataListHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HpsTPunishDataListHpsHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late List<HpsTPunishDataListHpsHlOl> ol;

	HpsTPunishDataListHpsHl();

	factory HpsTPunishDataListHpsHl.fromJson(Map<String, dynamic> json) => $HpsTPunishDataListHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $HpsTPunishDataListHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HpsTPunishDataListHpsHlOl {
	late String oid;
	late int os;
	late int otd;
	late String ot;
	dynamic dov;
	dynamic doc;
	late int ov;
	dynamic ov2;
	late String on;
	late String onb;
	late String cds;
	late String ots;

	HpsTPunishDataListHpsHlOl();

	factory HpsTPunishDataListHpsHlOl.fromJson(Map<String, dynamic> json) => $HpsTPunishDataListHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $HpsTPunishDataListHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}