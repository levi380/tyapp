import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_info_mids_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/match_info_mids_entity.g.dart';

@JsonSerializable()
class MatchInfoMidsEntity {
	late String code;
	late List<MatchInfoMidsData> data;
	late String msg;
	late int ts;

	MatchInfoMidsEntity();

	factory MatchInfoMidsEntity.fromJson(Map<String, dynamic> json) => $MatchInfoMidsEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsData {
	late String mcid;
	late String tnjc;
	late bool cosTCorner;
	late String csna;
	late bool cosTPunish;
	late MatchInfoMidsDataKySwitch kySwitch;
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
	dynamic st;
	late String mat;
	late String mststr;
	late List<MatchInfoMidsDataHps> hps;
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
	late String ecds;
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
	late List<MatchInfoMidsDataHps15Minutes> hps15Minutes;
	late String lurl;
	late bool cosOvertimeIng;
	late String mlet;
	late bool cosPenalty;
	late List<MatchInfoMidsDataHpsCorner> hpsCorner;
	late String mhid;
	late List<dynamic> hpsPunish;
	dynamic legOrder;
	late String mrmc;
	late int mess;
	dynamic lss;
	late String mmp;
	late int operationHotSortTop;
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
	dynamic mfo;
	late int mft;
	late List<dynamic> hpsOutright;

	MatchInfoMidsData();

	factory MatchInfoMidsData.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataKySwitch {
	late int playType;
	late int isKy;

	MatchInfoMidsDataKySwitch();

	factory MatchInfoMidsDataKySwitch.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataKySwitchFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataKySwitchToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHps {
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
	late List<MatchInfoMidsDataHpsHl> hl;

	MatchInfoMidsDataHps();

	factory MatchInfoMidsDataHps.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHpsFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHpsHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late List<MatchInfoMidsDataHpsHlOl> ol;

	MatchInfoMidsDataHpsHl();

	factory MatchInfoMidsDataHpsHl.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHpsHlOl {
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

	MatchInfoMidsDataHpsHlOl();

	factory MatchInfoMidsDataHpsHlOl.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHps15Minutes {
	late String ctsp;
	late int hids;
	late String chpid;
	late List<MatchInfoMidsDataHps15MinutesHl> hl;
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

	MatchInfoMidsDataHps15Minutes();

	factory MatchInfoMidsDataHps15Minutes.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHps15MinutesFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHps15MinutesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHps15MinutesHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late String ad3;
	late String ad5;
	late List<MatchInfoMidsDataHps15MinutesHlOl> ol;

	MatchInfoMidsDataHps15MinutesHl();

	factory MatchInfoMidsDataHps15MinutesHl.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHps15MinutesHlFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHps15MinutesHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHps15MinutesHlOl {
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

	MatchInfoMidsDataHps15MinutesHlOl();

	factory MatchInfoMidsDataHps15MinutesHlOl.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHps15MinutesHlOlFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHps15MinutesHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHpsCorner {
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
	late List<MatchInfoMidsDataHpsCornerHl> hl;

	MatchInfoMidsDataHpsCorner();

	factory MatchInfoMidsDataHpsCorner.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHpsCornerFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHpsCornerToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchInfoMidsDataHpsCornerHl {


	MatchInfoMidsDataHpsCornerHl();

	factory MatchInfoMidsDataHpsCornerHl.fromJson(Map<String, dynamic> json) => $MatchInfoMidsDataHpsCornerHlFromJson(json);

	Map<String, dynamic> toJson() => $MatchInfoMidsDataHpsCornerHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}