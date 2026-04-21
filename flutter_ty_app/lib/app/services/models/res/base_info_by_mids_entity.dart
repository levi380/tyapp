import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/base_info_by_mids_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/base_info_by_mids_entity.g.dart';

@JsonSerializable()
class BaseInfoByMidsEntity {
	late String code;
	late List<BaseInfoByMidsData> data;
	late String msg;
	late int ts;

	BaseInfoByMidsEntity();

	factory BaseInfoByMidsEntity.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsEntityFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BaseInfoByMidsData {
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
	late List<BaseInfoByMidsDataHps> hps;
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
	late List<BaseInfoByMidsDataHps15Minutes> hps15Minutes;
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
	late int operationHotSortTop;
	late int mms;
	late int mbmty;
	late int regionIdSort;
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
	late String mstrc;

	BaseInfoByMidsData();

	factory BaseInfoByMidsData.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsDataFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BaseInfoByMidsDataHps {
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
	late List<BaseInfoByMidsDataHpsHl> hl;

	BaseInfoByMidsDataHps();

	factory BaseInfoByMidsDataHps.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsDataHpsFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsDataHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BaseInfoByMidsDataHpsHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late List<BaseInfoByMidsDataHpsHlOl> ol;

	BaseInfoByMidsDataHpsHl();

	factory BaseInfoByMidsDataHpsHl.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsDataHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsDataHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BaseInfoByMidsDataHpsHlOl {
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

	BaseInfoByMidsDataHpsHlOl();

	factory BaseInfoByMidsDataHpsHlOl.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsDataHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsDataHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BaseInfoByMidsDataHps15Minutes {
	late String ctsp;
	late int hids;
	late String chpid;
	late List<BaseInfoByMidsDataHps15MinutesHl> hl;
	late String hpn;
	late String mid;
	late int hmm;
	late String hshow;
	late String hpnb;
	late String hSpecial;
	late int hpt;
	late String hsw;
	late String hpid;
	late int hpon;
	late String mct;

	BaseInfoByMidsDataHps15Minutes();

	factory BaseInfoByMidsDataHps15Minutes.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsDataHps15MinutesFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsDataHps15MinutesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BaseInfoByMidsDataHps15MinutesHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late String ad3;
	late String ad5;
	late List<BaseInfoByMidsDataHps15MinutesHlOl> ol;

	BaseInfoByMidsDataHps15MinutesHl();

	factory BaseInfoByMidsDataHps15MinutesHl.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsDataHps15MinutesHlFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsDataHps15MinutesHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BaseInfoByMidsDataHps15MinutesHlOl {
	late String oid;
	late int os;
	late int otd;
	late String ot;
	dynamic dov;
	dynamic doc;
	late int ov;
	dynamic ov2;
	late String onb;
	late String on;
	late String onbl;
	late String cds;
	late String ots;

	BaseInfoByMidsDataHps15MinutesHlOl();

	factory BaseInfoByMidsDataHps15MinutesHlOl.fromJson(Map<String, dynamic> json) => $BaseInfoByMidsDataHps15MinutesHlOlFromJson(json);

	Map<String, dynamic> toJson() => $BaseInfoByMidsDataHps15MinutesHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}