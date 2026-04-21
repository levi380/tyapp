import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_info_by_mids_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_info_by_mids_entity.g.dart';

@JsonSerializable()
class GetInfoByMidsEntity {
	late String code;
	late List<GetInfoByMidsData> data;
	late String msg;
	late int ts;

	GetInfoByMidsEntity();

	factory GetInfoByMidsEntity.fromJson(Map<String, dynamic> json) => $GetInfoByMidsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoByMidsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoByMidsData {
	late String mcid;
	late String tnjc;
	late bool cosTCorner;
	late String csna;
	late bool cosTPunish;
	late GetInfoByMidsDataKySwitch kySwitch;
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
	late List<GetInfoByMidsDataHps> hps;
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
	dynamic ecds;
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
	late String mfo;
	late int mft;
	late List<dynamic> hpsOutright;
	late String mstrc;

	GetInfoByMidsData();

	factory GetInfoByMidsData.fromJson(Map<String, dynamic> json) => $GetInfoByMidsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoByMidsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoByMidsDataKySwitch {
	late int playType;
	late String tournamentId;
	late int isKy;

	GetInfoByMidsDataKySwitch();

	factory GetInfoByMidsDataKySwitch.fromJson(Map<String, dynamic> json) => $GetInfoByMidsDataKySwitchFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoByMidsDataKySwitchToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoByMidsDataHps {
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
	late List<GetInfoByMidsDataHpsHl> hl;

	GetInfoByMidsDataHps();

	factory GetInfoByMidsDataHps.fromJson(Map<String, dynamic> json) => $GetInfoByMidsDataHpsFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoByMidsDataHpsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetInfoByMidsDataHpsHl {


	GetInfoByMidsDataHpsHl();

	factory GetInfoByMidsDataHpsHl.fromJson(Map<String, dynamic> json) => $GetInfoByMidsDataHpsHlFromJson(json);

	Map<String, dynamic> toJson() => $GetInfoByMidsDataHpsHlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}