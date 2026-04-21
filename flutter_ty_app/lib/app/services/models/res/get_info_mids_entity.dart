import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_info_mids_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_info_mids_entity.g.dart';

@JsonSerializable()
class GetInfoMidsEntity {
	late String code;
	late List<GetInfoMidsData> data;
	late String msg;
	late int ts;

	GetInfoMidsEntity();

	factory GetInfoMidsEntity.fromJson(Map<String, dynamic> json) => $GetInfoMidsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsData {
	late String mcid;
	late String tnjc;
	late bool cosTCorner;
	late String csna;
	late bool cosTPunish;
	late GetInfoMidsDataKySwitch kySwitch;
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
	late List<GetInfoMidsDataHps> hps;
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
	late List<dynamic> hps15Minutes;
	late String lurl;
	late bool cosOvertimeIng;
	late String mlet;
	late bool cosPenalty;
	late List<dynamic> hpsCorner;
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
	late List<GetInfoMidsDataHpsPenalty> hpsPenalty;
	late int mearlys;
	late bool hipo;
	late String mfo;
	late int mft;
	late List<dynamic> hpsOutright;

	GetInfoMidsData();

	factory GetInfoMidsData.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsDataKySwitch {
	late int playType;
	late String tournamentId;
	late int isKy;

	GetInfoMidsDataKySwitch();

	factory GetInfoMidsDataKySwitch.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataKySwitchFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataKySwitchToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsDataHps {
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
	late List<GetInfoMidsDataHpsHl> hl;

	GetInfoMidsDataHps();

	factory GetInfoMidsDataHps.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataHpsFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsDataHpsHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late List<GetInfoMidsDataHpsHlOl> ol;

	GetInfoMidsDataHpsHl();

	factory GetInfoMidsDataHpsHl.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsDataHpsHlOl {
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

	GetInfoMidsDataHpsHlOl();

	factory GetInfoMidsDataHpsHlOl.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataHpsHlOlFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataHpsHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsDataHpsPenalty {
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
	late List<GetInfoMidsDataHpsPenaltyHl> hl;

	GetInfoMidsDataHpsPenalty();

	factory GetInfoMidsDataHpsPenalty.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataHpsPenaltyFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataHpsPenaltyToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsDataHpsPenaltyHl {
	late String hid;
	late int hs;
	dynamic hv;
	late int hmt;
	dynamic hn;
	late List<GetInfoMidsDataHpsPenaltyHlOl> ol;

	GetInfoMidsDataHpsPenaltyHl();

	factory GetInfoMidsDataHpsPenaltyHl.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataHpsPenaltyHlFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataHpsPenaltyHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoMidsDataHpsPenaltyHlOl {
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

	GetInfoMidsDataHpsPenaltyHlOl();

	factory GetInfoMidsDataHpsPenaltyHlOl.fromJson(Map<String, dynamic> json) => $GetInfoMidsDataHpsPenaltyHlOlFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoMidsDataHpsPenaltyHlOlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}