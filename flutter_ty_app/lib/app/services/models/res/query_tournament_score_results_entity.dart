import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/query_tournament_score_results_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/query_tournament_score_results_entity.g.dart';

@JsonSerializable()
class QueryTournamentScoreResultsEntity {
	late String code;
	late QueryTournamentScoreResultsData data;
	late String msg;
	late int ts;

	QueryTournamentScoreResultsEntity();

	factory QueryTournamentScoreResultsEntity.fromJson(Map<String, dynamic> json) => $QueryTournamentScoreResultsEntityFromJson(json);

	Map<String, dynamic> toJson() => $QueryTournamentScoreResultsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryTournamentScoreResultsData {
	late String countId;
	late String current;
	dynamic maxLimit;
	late bool optimizeCountSql;
	late List<dynamic> orders;
	late String pages;
	late List<QueryTournamentScoreResultsDataRecords> records;
	late bool searchCount;
	late String size;
	late String total;

	QueryTournamentScoreResultsData();

	factory QueryTournamentScoreResultsData.fromJson(Map<String, dynamic> json) => $QueryTournamentScoreResultsDataFromJson(json);

	Map<String, dynamic> toJson() => $QueryTournamentScoreResultsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QueryTournamentScoreResultsDataRecords {
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
	dynamic nms;
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

	QueryTournamentScoreResultsDataRecords();

	factory QueryTournamentScoreResultsDataRecords.fromJson(Map<String, dynamic> json) => $QueryTournamentScoreResultsDataRecordsFromJson(json);

	Map<String, dynamic> toJson() => $QueryTournamentScoreResultsDataRecordsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}