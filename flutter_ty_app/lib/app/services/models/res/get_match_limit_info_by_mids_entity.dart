import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_match_limit_info_by_mids_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_match_limit_info_by_mids_entity.g.dart';

@JsonSerializable()
class GetMatchLimitInfoByMidsEntity {
	late String code;
	late GetMatchLimitInfoByMidsData data;
	late String msg;
	late int ts;

	GetMatchLimitInfoByMidsEntity();

	factory GetMatchLimitInfoByMidsEntity.fromJson(Map<String, dynamic> json) => $GetMatchLimitInfoByMidsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchLimitInfoByMidsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchLimitInfoByMidsData {
	late List<GetMatchLimitInfoByMidsDataData> data;

	GetMatchLimitInfoByMidsData();

	factory GetMatchLimitInfoByMidsData.fromJson(Map<String, dynamic> json) => $GetMatchLimitInfoByMidsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchLimitInfoByMidsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMatchLimitInfoByMidsDataData {
  late List<dynamic> mpsc = [];
  late int ctt;
	late String csid;
	late int ms;
	late int mle;
	late String mststr;
	late String mid;
	late int mess;
	late String mst;
	late int mststs;
	late String mmp;
	late String mststi;
	late String cds;
	late int mhs;
	late String mstst;
	late String mgt;
	late String mlet;

	GetMatchLimitInfoByMidsDataData();

	factory GetMatchLimitInfoByMidsDataData.fromJson(Map<String, dynamic> json) => $GetMatchLimitInfoByMidsDataDataFromJson(json);

	Map<String, dynamic> toJson() => $GetMatchLimitInfoByMidsDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}