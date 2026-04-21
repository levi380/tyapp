import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/query_tournament_score_result_entity.dart';

QueryTournamentScoreResultEntity $QueryTournamentScoreResultEntityFromJson(
    Map<String, dynamic> json) {
  final QueryTournamentScoreResultEntity queryTournamentScoreResultEntity = QueryTournamentScoreResultEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    queryTournamentScoreResultEntity.code = code;
  }
  final QueryTournamentScoreResultData? data = jsonConvert.convert<
      QueryTournamentScoreResultData>(json['data']);
  if (data != null) {
    queryTournamentScoreResultEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    queryTournamentScoreResultEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    queryTournamentScoreResultEntity.ts = ts;
  }
  return queryTournamentScoreResultEntity;
}

Map<String, dynamic> $QueryTournamentScoreResultEntityToJson(
    QueryTournamentScoreResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension QueryTournamentScoreResultEntityExtension on QueryTournamentScoreResultEntity {
  QueryTournamentScoreResultEntity copyWith({
    String? code,
    QueryTournamentScoreResultData? data,
    String? msg,
    int? ts,
  }) {
    return QueryTournamentScoreResultEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

QueryTournamentScoreResultData $QueryTournamentScoreResultDataFromJson(
    Map<String, dynamic> json) {
  final QueryTournamentScoreResultData queryTournamentScoreResultData = QueryTournamentScoreResultData();
  final String? countId = jsonConvert.convert<String>(json['countId']);
  if (countId != null) {
    queryTournamentScoreResultData.countId = countId;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    queryTournamentScoreResultData.current = current;
  }
  final dynamic maxLimit = json['maxLimit'];
  if (maxLimit != null) {
    queryTournamentScoreResultData.maxLimit = maxLimit;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    queryTournamentScoreResultData.optimizeCountSql = optimizeCountSql;
  }
  final List<dynamic>? orders = (json['orders'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (orders != null) {
    queryTournamentScoreResultData.orders = orders;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    queryTournamentScoreResultData.pages = pages;
  }
  final List<
      QueryTournamentScoreResultDataRecords>? records = (json['records'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QueryTournamentScoreResultDataRecords>(
          e) as QueryTournamentScoreResultDataRecords).toList();
  if (records != null) {
    queryTournamentScoreResultData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    queryTournamentScoreResultData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    queryTournamentScoreResultData.size = size;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    queryTournamentScoreResultData.total = total;
  }
  return queryTournamentScoreResultData;
}

Map<String, dynamic> $QueryTournamentScoreResultDataToJson(
    QueryTournamentScoreResultData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['countId'] = entity.countId;
  data['current'] = entity.current;
  data['maxLimit'] = entity.maxLimit;
  data['optimizeCountSql'] = entity.optimizeCountSql;
  data['orders'] = entity.orders;
  data['pages'] = entity.pages;
  data['records'] = entity.records.map((v) => v.toJson()).toList();
  data['searchCount'] = entity.searchCount;
  data['size'] = entity.size;
  data['total'] = entity.total;
  return data;
}

extension QueryTournamentScoreResultDataExtension on QueryTournamentScoreResultData {
  QueryTournamentScoreResultData copyWith({
    String? countId,
    String? current,
    dynamic maxLimit,
    bool? optimizeCountSql,
    List<dynamic>? orders,
    String? pages,
    List<QueryTournamentScoreResultDataRecords>? records,
    bool? searchCount,
    String? size,
    String? total,
  }) {
    return QueryTournamentScoreResultData()
      ..countId = countId ?? this.countId
      ..current = current ?? this.current
      ..maxLimit = maxLimit ?? this.maxLimit
      ..optimizeCountSql = optimizeCountSql ?? this.optimizeCountSql
      ..orders = orders ?? this.orders
      ..pages = pages ?? this.pages
      ..records = records ?? this.records
      ..searchCount = searchCount ?? this.searchCount
      ..size = size ?? this.size
      ..total = total ?? this.total;
  }
}

QueryTournamentScoreResultDataRecords $QueryTournamentScoreResultDataRecordsFromJson(
    Map<String, dynamic> json) {
  final QueryTournamentScoreResultDataRecords queryTournamentScoreResultDataRecords = QueryTournamentScoreResultDataRecords();
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    queryTournamentScoreResultDataRecords.awayName = awayName;
  }
  final String? awayUrl = jsonConvert.convert<String>(json['awayUrl']);
  if (awayUrl != null) {
    queryTournamentScoreResultDataRecords.awayUrl = awayUrl;
  }
  final int? batchNo = jsonConvert.convert<int>(json['batchNo']);
  if (batchNo != null) {
    queryTournamentScoreResultDataRecords.batchNo = batchNo;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    queryTournamentScoreResultDataRecords.cds = cds;
  }
  final String? cupMatch = jsonConvert.convert<String>(json['cupMatch']);
  if (cupMatch != null) {
    queryTournamentScoreResultDataRecords.cupMatch = cupMatch;
  }
  final dynamic displayScoreResult = json['displayScoreResult'];
  if (displayScoreResult != null) {
    queryTournamentScoreResultDataRecords.displayScoreResult =
        displayScoreResult;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    queryTournamentScoreResultDataRecords.homeName = homeName;
  }
  final String? homeUrl = jsonConvert.convert<String>(json['homeUrl']);
  if (homeUrl != null) {
    queryTournamentScoreResultDataRecords.homeUrl = homeUrl;
  }
  final String? iconUrl = jsonConvert.convert<String>(json['iconUrl']);
  if (iconUrl != null) {
    queryTournamentScoreResultDataRecords.iconUrl = iconUrl;
  }
  final bool? isIcon = jsonConvert.convert<bool>(json['isIcon']);
  if (isIcon != null) {
    queryTournamentScoreResultDataRecords.isIcon = isIcon;
  }
  final dynamic leagueAsNameCode = json['leagueAsNameCode'];
  if (leagueAsNameCode != null) {
    queryTournamentScoreResultDataRecords.leagueAsNameCode = leagueAsNameCode;
  }
  final String? legOrder = jsonConvert.convert<String>(json['legOrder']);
  if (legOrder != null) {
    queryTournamentScoreResultDataRecords.legOrder = legOrder;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    queryTournamentScoreResultDataRecords.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    queryTournamentScoreResultDataRecords.matchId = matchId;
  }
  final dynamic matchManageId = json['matchManageId'];
  if (matchManageId != null) {
    queryTournamentScoreResultDataRecords.matchManageId = matchManageId;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    queryTournamentScoreResultDataRecords.matchOver = matchOver;
  }
  final int? matchPeriodId = jsonConvert.convert<int>(json['matchPeriodId']);
  if (matchPeriodId != null) {
    queryTournamentScoreResultDataRecords.matchPeriodId = matchPeriodId;
  }
  final int? matchStatus = jsonConvert.convert<int>(json['matchStatus']);
  if (matchStatus != null) {
    queryTournamentScoreResultDataRecords.matchStatus = matchStatus;
  }
  final String? matchTime = jsonConvert.convert<String>(json['matchTime']);
  if (matchTime != null) {
    queryTournamentScoreResultDataRecords.matchTime = matchTime;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    queryTournamentScoreResultDataRecords.matchType = matchType;
  }
  final dynamic matchesGroupId = json['matchesGroupId'];
  if (matchesGroupId != null) {
    queryTournamentScoreResultDataRecords.matchesGroupId = matchesGroupId;
  }
  final String? mle = jsonConvert.convert<String>(json['mle']);
  if (mle != null) {
    queryTournamentScoreResultDataRecords.mle = mle;
  }
  final String? penaltyScore = jsonConvert.convert<String>(
      json['penaltyScore']);
  if (penaltyScore != null) {
    queryTournamentScoreResultDataRecords.penaltyScore = penaltyScore;
  }
  final dynamic playBack = json['playBack'];
  if (playBack != null) {
    queryTournamentScoreResultDataRecords.playBack = playBack;
  }
  final int? realMatchStatus = jsonConvert.convert<int>(
      json['realMatchStatus']);
  if (realMatchStatus != null) {
    queryTournamentScoreResultDataRecords.realMatchStatus = realMatchStatus;
  }
  final String? sId = jsonConvert.convert<String>(json['sId']);
  if (sId != null) {
    queryTournamentScoreResultDataRecords.sId = sId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    queryTournamentScoreResultDataRecords.score = score;
  }
  final String? scoreResult = jsonConvert.convert<String>(json['scoreResult']);
  if (scoreResult != null) {
    queryTournamentScoreResultDataRecords.scoreResult = scoreResult;
  }
  final String? scoreResult2 = jsonConvert.convert<String>(
      json['scoreResult2']);
  if (scoreResult2 != null) {
    queryTournamentScoreResultDataRecords.scoreResult2 = scoreResult2;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    queryTournamentScoreResultDataRecords.sportId = sportId;
  }
  final String? t1FirstWd = jsonConvert.convert<String>(json['t1FirstWd']);
  if (t1FirstWd != null) {
    queryTournamentScoreResultDataRecords.t1FirstWd = t1FirstWd;
  }
  final String? t2FirstWd = jsonConvert.convert<String>(json['t2FirstWd']);
  if (t2FirstWd != null) {
    queryTournamentScoreResultDataRecords.t2FirstWd = t2FirstWd;
  }
  final String? teamGroup = jsonConvert.convert<String>(json['teamGroup']);
  if (teamGroup != null) {
    queryTournamentScoreResultDataRecords.teamGroup = teamGroup;
  }
  final String? teams = jsonConvert.convert<String>(json['teams']);
  if (teams != null) {
    queryTournamentScoreResultDataRecords.teams = teams;
  }
  final dynamic teamsTop = json['teamsTop'];
  if (teamsTop != null) {
    queryTournamentScoreResultDataRecords.teamsTop = teamsTop;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    queryTournamentScoreResultDataRecords.tid = tid;
  }
  final String? tnameCode = jsonConvert.convert<String>(json['tnameCode']);
  if (tnameCode != null) {
    queryTournamentScoreResultDataRecords.tnameCode = tnameCode;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    queryTournamentScoreResultDataRecords.tournamentName = tournamentName;
  }
  final String? tournamentNameCode = jsonConvert.convert<String>(
      json['tournamentNameCode']);
  if (tournamentNameCode != null) {
    queryTournamentScoreResultDataRecords.tournamentNameCode =
        tournamentNameCode;
  }
  final String? tournamentUrl = jsonConvert.convert<String>(
      json['tournamentUrl']);
  if (tournamentUrl != null) {
    queryTournamentScoreResultDataRecords.tournamentUrl = tournamentUrl;
  }
  return queryTournamentScoreResultDataRecords;
}

Map<String, dynamic> $QueryTournamentScoreResultDataRecordsToJson(
    QueryTournamentScoreResultDataRecords entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayName'] = entity.awayName;
  data['awayUrl'] = entity.awayUrl;
  data['batchNo'] = entity.batchNo;
  data['cds'] = entity.cds;
  data['cupMatch'] = entity.cupMatch;
  data['displayScoreResult'] = entity.displayScoreResult;
  data['homeName'] = entity.homeName;
  data['homeUrl'] = entity.homeUrl;
  data['iconUrl'] = entity.iconUrl;
  data['isIcon'] = entity.isIcon;
  data['leagueAsNameCode'] = entity.leagueAsNameCode;
  data['legOrder'] = entity.legOrder;
  data['matchDay'] = entity.matchDay;
  data['matchId'] = entity.matchId;
  data['matchManageId'] = entity.matchManageId;
  data['matchOver'] = entity.matchOver;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchStatus'] = entity.matchStatus;
  data['matchTime'] = entity.matchTime;
  data['matchType'] = entity.matchType;
  data['matchesGroupId'] = entity.matchesGroupId;
  data['mle'] = entity.mle;
  data['penaltyScore'] = entity.penaltyScore;
  data['playBack'] = entity.playBack;
  data['realMatchStatus'] = entity.realMatchStatus;
  data['sId'] = entity.sId;
  data['score'] = entity.score;
  data['scoreResult'] = entity.scoreResult;
  data['scoreResult2'] = entity.scoreResult2;
  data['sportId'] = entity.sportId;
  data['t1FirstWd'] = entity.t1FirstWd;
  data['t2FirstWd'] = entity.t2FirstWd;
  data['teamGroup'] = entity.teamGroup;
  data['teams'] = entity.teams;
  data['teamsTop'] = entity.teamsTop;
  data['tid'] = entity.tid;
  data['tnameCode'] = entity.tnameCode;
  data['tournamentName'] = entity.tournamentName;
  data['tournamentNameCode'] = entity.tournamentNameCode;
  data['tournamentUrl'] = entity.tournamentUrl;
  return data;
}

extension QueryTournamentScoreResultDataRecordsExtension on QueryTournamentScoreResultDataRecords {
  QueryTournamentScoreResultDataRecords copyWith({
    String? awayName,
    String? awayUrl,
    int? batchNo,
    String? cds,
    String? cupMatch,
    dynamic displayScoreResult,
    String? homeName,
    String? homeUrl,
    String? iconUrl,
    bool? isIcon,
    dynamic leagueAsNameCode,
    String? legOrder,
    String? matchDay,
    String? matchId,
    dynamic matchManageId,
    int? matchOver,
    int? matchPeriodId,
    int? matchStatus,
    String? matchTime,
    int? matchType,
    dynamic matchesGroupId,
    String? mle,
    String? penaltyScore,
    dynamic playBack,
    int? realMatchStatus,
    String? sId,
    String? score,
    String? scoreResult,
    String? scoreResult2,
    String? sportId,
    String? t1FirstWd,
    String? t2FirstWd,
    String? teamGroup,
    String? teams,
    dynamic teamsTop,
    String? tid,
    String? tnameCode,
    String? tournamentName,
    String? tournamentNameCode,
    String? tournamentUrl,
  }) {
    return QueryTournamentScoreResultDataRecords()
      ..awayName = awayName ?? this.awayName
      ..awayUrl = awayUrl ?? this.awayUrl
      ..batchNo = batchNo ?? this.batchNo
      ..cds = cds ?? this.cds
      ..cupMatch = cupMatch ?? this.cupMatch
      ..displayScoreResult = displayScoreResult ?? this.displayScoreResult
      ..homeName = homeName ?? this.homeName
      ..homeUrl = homeUrl ?? this.homeUrl
      ..iconUrl = iconUrl ?? this.iconUrl
      ..isIcon = isIcon ?? this.isIcon
      ..leagueAsNameCode = leagueAsNameCode ?? this.leagueAsNameCode
      ..legOrder = legOrder ?? this.legOrder
      ..matchDay = matchDay ?? this.matchDay
      ..matchId = matchId ?? this.matchId
      ..matchManageId = matchManageId ?? this.matchManageId
      ..matchOver = matchOver ?? this.matchOver
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchStatus = matchStatus ?? this.matchStatus
      ..matchTime = matchTime ?? this.matchTime
      ..matchType = matchType ?? this.matchType
      ..matchesGroupId = matchesGroupId ?? this.matchesGroupId
      ..mle = mle ?? this.mle
      ..penaltyScore = penaltyScore ?? this.penaltyScore
      ..playBack = playBack ?? this.playBack
      ..realMatchStatus = realMatchStatus ?? this.realMatchStatus
      ..sId = sId ?? this.sId
      ..score = score ?? this.score
      ..scoreResult = scoreResult ?? this.scoreResult
      ..scoreResult2 = scoreResult2 ?? this.scoreResult2
      ..sportId = sportId ?? this.sportId
      ..t1FirstWd = t1FirstWd ?? this.t1FirstWd
      ..t2FirstWd = t2FirstWd ?? this.t2FirstWd
      ..teamGroup = teamGroup ?? this.teamGroup
      ..teams = teams ?? this.teams
      ..teamsTop = teamsTop ?? this.teamsTop
      ..tid = tid ?? this.tid
      ..tnameCode = tnameCode ?? this.tnameCode
      ..tournamentName = tournamentName ?? this.tournamentName
      ..tournamentNameCode = tournamentNameCode ?? this.tournamentNameCode
      ..tournamentUrl = tournamentUrl ?? this.tournamentUrl;
  }
}