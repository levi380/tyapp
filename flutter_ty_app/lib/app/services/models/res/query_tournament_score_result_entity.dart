import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/query_tournament_score_result_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/query_tournament_score_result_entity.g.dart';

@JsonSerializable()
class QueryTournamentScoreResultEntity {
	late String code;
	late QueryTournamentScoreResultData data;
	late String msg;
	late int ts;

	QueryTournamentScoreResultEntity();

	factory QueryTournamentScoreResultEntity.fromJson(Map<String, dynamic> json) => $QueryTournamentScoreResultEntityFromJson(json);

	Map<String, dynamic> toJson() => $QueryTournamentScoreResultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryTournamentScoreResultData {
	late String countId;
	late String current;
	dynamic maxLimit;
	late bool optimizeCountSql;
	late List<dynamic> orders;
	late String pages;
	late List<QueryTournamentScoreResultDataRecords> records;
	late bool searchCount;
	late String size;
	late String total;

	QueryTournamentScoreResultData();

	factory QueryTournamentScoreResultData.fromJson(Map<String, dynamic> json) => $QueryTournamentScoreResultDataFromJson(json);

	Map<String, dynamic> toJson() => $QueryTournamentScoreResultDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryTournamentScoreResultDataRecords {
	late String awayName;
	late String awayUrl;
	late int batchNo;
	late String cds;
	late String cupMatch;
	dynamic displayScoreResult;
	late String homeName;
	late String homeUrl;
	late String iconUrl;
	late bool isIcon;
	dynamic leagueAsNameCode;
	late String legOrder;
	late String matchDay;
	late String matchId;
	dynamic matchManageId;
	late int matchOver;
	late int matchPeriodId;
	late int matchStatus;
	late String matchTime;
	late int matchType;
	dynamic matchesGroupId;
	late String mle;
	late String penaltyScore;
	dynamic playBack;
	late int realMatchStatus;
	late String sId;
	late String score;
	late String scoreResult;
	late String scoreResult2;
	late String sportId;
	late String t1FirstWd;
	late String t2FirstWd;
	late String teamGroup;
	late String teams;
	dynamic teamsTop;
	late String tid;
	late String tnameCode;
	late String tournamentName;
	late String tournamentNameCode;
	late String tournamentUrl;

	QueryTournamentScoreResultDataRecords();

	factory QueryTournamentScoreResultDataRecords.fromJson(Map<String, dynamic> json) => $QueryTournamentScoreResultDataRecordsFromJson(json);

	Map<String, dynamic> toJson() => $QueryTournamentScoreResultDataRecordsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}