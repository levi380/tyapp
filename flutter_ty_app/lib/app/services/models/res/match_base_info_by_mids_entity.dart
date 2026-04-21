import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_base_info_by_mids_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/match_base_info_by_mids_entity.g.dart';

@JsonSerializable()
class MatchBaseInfoByMidsEntity {
	late String code;
	late List<MatchBaseInfoByMidsData> data;
	late String msg;
	late int ts;

	MatchBaseInfoByMidsEntity();

	factory MatchBaseInfoByMidsEntity.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoByMidsData {
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
	late List<MatchBaseInfoByMidsDataHps> hps;
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
	late List<MatchBaseInfoByMidsDataHps15Minutes> hps15Minutes;
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

	MatchBaseInfoByMidsData();

	factory MatchBaseInfoByMidsData.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoByMidsDataHps {
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
	late List<MatchBaseInfoByMidsDataHpsHl> hl;

	MatchBaseInfoByMidsDataHps();

	factory MatchBaseInfoByMidsDataHps.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsDataHpsFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsDataHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoByMidsDataHpsHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late List<MatchBaseInfoByMidsDataHpsHlOl> ol;

	MatchBaseInfoByMidsDataHpsHl();

	factory MatchBaseInfoByMidsDataHpsHl.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsDataHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsDataHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoByMidsDataHpsHlOl {
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

	MatchBaseInfoByMidsDataHpsHlOl();

	factory MatchBaseInfoByMidsDataHpsHlOl.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsDataHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsDataHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoByMidsDataHps15Minutes {
	late String ctsp;
	late int hids;
	late String chpid;
	late List<MatchBaseInfoByMidsDataHps15MinutesHl> hl;
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

	MatchBaseInfoByMidsDataHps15Minutes();

	factory MatchBaseInfoByMidsDataHps15Minutes.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsDataHps15MinutesFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsDataHps15MinutesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoByMidsDataHps15MinutesHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late String ad3;
	late String ad5;
	late List<MatchBaseInfoByMidsDataHps15MinutesHlOl> ol;

	MatchBaseInfoByMidsDataHps15MinutesHl();

	factory MatchBaseInfoByMidsDataHps15MinutesHl.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsDataHps15MinutesHlFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsDataHps15MinutesHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchBaseInfoByMidsDataHps15MinutesHlOl {
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

	MatchBaseInfoByMidsDataHps15MinutesHlOl();

	factory MatchBaseInfoByMidsDataHps15MinutesHlOl.fromJson(Map<String, dynamic> json) => $MatchBaseInfoByMidsDataHps15MinutesHlOlFromJson(json);

	Map<String, dynamic> toJson() => $MatchBaseInfoByMidsDataHps15MinutesHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}