import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_match_base_info_by_midsl_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_match_base_info_by_midsl_entity.g.dart';

@JsonSerializable()
class GetMatchBaseInfoByMidslEntity {
	late String code;
	late List<GetMatchBaseInfoByMidslData> data;
	late String msg;
	late int ts;

	GetMatchBaseInfoByMidslEntity();

	factory GetMatchBaseInfoByMidslEntity.fromJson(Map<String, dynamic> json) => $GetMatchBaseInfoByMidslEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchBaseInfoByMidslEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchBaseInfoByMidslData {
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
	late List<GetMatchBaseInfoByMidslDataHps> hps;
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
	late List<GetMatchBaseInfoByMidslDataHpsCorner> hpsCorner;
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
	dynamic mfo;
	late int mft;
	late List<dynamic> hpsOutright;

	GetMatchBaseInfoByMidslData();

	factory GetMatchBaseInfoByMidslData.fromJson(Map<String, dynamic> json) => $GetMatchBaseInfoByMidslDataFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchBaseInfoByMidslDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchBaseInfoByMidslDataHps {
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
	late List<GetMatchBaseInfoByMidslDataHpsHl> hl;

	GetMatchBaseInfoByMidslDataHps();

	factory GetMatchBaseInfoByMidslDataHps.fromJson(Map<String, dynamic> json) => $GetMatchBaseInfoByMidslDataHpsFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchBaseInfoByMidslDataHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchBaseInfoByMidslDataHpsHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late List<GetMatchBaseInfoByMidslDataHpsHlOl> ol;

	GetMatchBaseInfoByMidslDataHpsHl();

	factory GetMatchBaseInfoByMidslDataHpsHl.fromJson(Map<String, dynamic> json) => $GetMatchBaseInfoByMidslDataHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchBaseInfoByMidslDataHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchBaseInfoByMidslDataHpsHlOl {
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

	GetMatchBaseInfoByMidslDataHpsHlOl();

	factory GetMatchBaseInfoByMidslDataHpsHlOl.fromJson(Map<String, dynamic> json) => $GetMatchBaseInfoByMidslDataHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchBaseInfoByMidslDataHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchBaseInfoByMidslDataHpsCorner {
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
	late List<GetMatchBaseInfoByMidslDataHpsCornerHl> hl;

	GetMatchBaseInfoByMidslDataHpsCorner();

	factory GetMatchBaseInfoByMidslDataHpsCorner.fromJson(Map<String, dynamic> json) => $GetMatchBaseInfoByMidslDataHpsCornerFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchBaseInfoByMidslDataHpsCornerToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchBaseInfoByMidslDataHpsCornerHl {


	GetMatchBaseInfoByMidslDataHpsCornerHl();

	factory GetMatchBaseInfoByMidslDataHpsCornerHl.fromJson(Map<String, dynamic> json) => $GetMatchBaseInfoByMidslDataHpsCornerHlFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchBaseInfoByMidslDataHpsCornerHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}