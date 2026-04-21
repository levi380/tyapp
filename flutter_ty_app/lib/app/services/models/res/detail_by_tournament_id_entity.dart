import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/detail_by_tournament_id_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/detail_by_tournament_id_entity.g.dart';

@JsonSerializable()
class DetailByTournamentIdEntity {
	late String code;
	late List<DetailByTournamentIdData> data;
	late String msg;
	late int ts;

	DetailByTournamentIdEntity();

	factory DetailByTournamentIdEntity.fromJson(Map<String, dynamic> json) => $DetailByTournamentIdEntityFromJson(json);

	Map<String, dynamic> toJson() => $DetailByTournamentIdEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DetailByTournamentIdData {
	late String mhid;
	late String mid;
	late int mess;
	late String csna;
	late String tid;
	late String vurl;
	late String mst;
	late int mmp;
	late int mms;
	late String varl;
	late List<String> mhlu;
	late bool mf;
	late String mgt;
	late String man;
	late String maid;
	late String frman;
	late int tlev;
	late int mct;
	late String csid;
	late int ms;
	late int mt;
	late List<String> malu;
	late String lurl;
	late String mhn;
	late String frmhn;
	late int mhs;
	late String tn;
	late List<String> msc;

	DetailByTournamentIdData();

	factory DetailByTournamentIdData.fromJson(Map<String, dynamic> json) => $DetailByTournamentIdDataFromJson(json);

	Map<String, dynamic> toJson() => $DetailByTournamentIdDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}