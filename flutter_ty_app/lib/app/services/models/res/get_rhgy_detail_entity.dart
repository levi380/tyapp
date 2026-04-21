import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_rhgy_detail_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_rhgy_detail_entity.g.dart';

@JsonSerializable()
class GetRhgyDetailEntity {
	late String code;
	late GetRhgyDetailData data;
	late String msg;
	late int ts;

	GetRhgyDetailEntity();

	factory GetRhgyDetailEntity.fromJson(Map<String, dynamic> json) => $GetRhgyDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetRhgyDetailData {
	late String tt;
	late String tnjc;
	late int mss;
	late String csna;
	late String tid;
	late String mst;
	late String srid;
	late int mcg;
	late String atf;
	dynamic mdsc;
	late int mks;
	late String msts;
	late int gcs;
	late bool mf;
	late String mgt;
	late String maid;
	late int mct;
	late int tlev;
	late String mhlut;
	late int mo;
	late int ctt;
	late int mp;
	late String csid;
	late int ms;
	late String cmec;
	late int mle;
	late int lvs;
	late int sort;
	late List<String> malu;
	late String vf;
	late String lurl;
	late String mprmc;
	late String mhn;
	late String cds;
	late List<String> frmhn;
	late int operationTournamentSort;
	late int mhs;
	late String mlet;
	late int mds;
	late String mhid;
	late String mrmc;
	late String mid;
	late int mess;
	dynamic lss;
	late String mmp;
	late String mststi;
	late int mms;
	late int mbmty;
	late int mis;
	late int pmms;
	late List<String> mhlu;
	late String seid;
	late String mstst;
	late String malut;
	late String man;
	late List<String> frman;
	late String met;
	late String st;
	late String mat;
	late int mng;
	late String mststr;
	late int mvs;
	late int mststs;
	late String tc;
	late int mearlys;
	late bool hipo;
	dynamic mfo;
	late int mft;
	late String tn;
	late List<String> msc;

	GetRhgyDetailData();

	factory GetRhgyDetailData.fromJson(Map<String, dynamic> json) => $GetRhgyDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $GetRhgyDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}