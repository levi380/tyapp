import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/query_tournament_score_results_entity.dart';

QueryTournamentScoreResultsEntity $QueryTournamentScoreResultsEntityFromJson(
    Map<String, dynamic> json) {
  final QueryTournamentScoreResultsEntity queryTournamentScoreResultsEntity = QueryTournamentScoreResultsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    queryTournamentScoreResultsEntity.code = code;
  }
  final QueryTournamentScoreResultsData? data = jsonConvert.convert<
      QueryTournamentScoreResultsData>(json['data']);
  if (data != null) {
    queryTournamentScoreResultsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    queryTournamentScoreResultsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    queryTournamentScoreResultsEntity.ts = ts;
  }
  return queryTournamentScoreResultsEntity;
}

Map<String, dynamic> $QueryTournamentScoreResultsEntityToJson(
    QueryTournamentScoreResultsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension QueryTournamentScoreResultsEntityExtension on QueryTournamentScoreResultsEntity {
  QueryTournamentScoreResultsEntity copyWith({
    String? code,
    QueryTournamentScoreResultsData? data,
    String? msg,
    int? ts,
  }) {
    return QueryTournamentScoreResultsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

QueryTournamentScoreResultsData $QueryTournamentScoreResultsDataFromJson(
    Map<String, dynamic> json) {
  final QueryTournamentScoreResultsData queryTournamentScoreResultsData = QueryTournamentScoreResultsData();
  final String? countId = jsonConvert.convert<String>(json['countId']);
  if (countId != null) {
    queryTournamentScoreResultsData.countId = countId;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    queryTournamentScoreResultsData.current = current;
  }
  final dynamic maxLimit = json['maxLimit'];
  if (maxLimit != null) {
    queryTournamentScoreResultsData.maxLimit = maxLimit;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    queryTournamentScoreResultsData.optimizeCountSql = optimizeCountSql;
  }
  final List<dynamic>? orders = (json['orders'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (orders != null) {
    queryTournamentScoreResultsData.orders = orders;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    queryTournamentScoreResultsData.pages = pages;
  }
  final List<
      QueryTournamentScoreResultsDataRecords>? records = (json['records'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<QueryTournamentScoreResultsDataRecords>(
          e) as QueryTournamentScoreResultsDataRecords).toList();
  if (records != null) {
    queryTournamentScoreResultsData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    queryTournamentScoreResultsData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    queryTournamentScoreResultsData.size = size;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    queryTournamentScoreResultsData.total = total;
  }
  return queryTournamentScoreResultsData;
}

Map<String, dynamic> $QueryTournamentScoreResultsDataToJson(
    QueryTournamentScoreResultsData entity) {
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

extension QueryTournamentScoreResultsDataExtension on QueryTournamentScoreResultsData {
  QueryTournamentScoreResultsData copyWith({
    String? countId,
    String? current,
    dynamic maxLimit,
    bool? optimizeCountSql,
    List<dynamic>? orders,
    String? pages,
    List<QueryTournamentScoreResultsDataRecords>? records,
    bool? searchCount,
    String? size,
    String? total,
  }) {
    return QueryTournamentScoreResultsData()
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

QueryTournamentScoreResultsDataRecords $QueryTournamentScoreResultsDataRecordsFromJson(
    Map<String, dynamic> json) {
  final QueryTournamentScoreResultsDataRecords queryTournamentScoreResultsDataRecords = QueryTournamentScoreResultsDataRecords();
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    queryTournamentScoreResultsDataRecords.awayName = awayName;
  }
  final String? awayUrl = jsonConvert.convert<String>(json['awayUrl']);
  if (awayUrl != null) {
    queryTournamentScoreResultsDataRecords.awayUrl = awayUrl;
  }
  final int? batchNo = jsonConvert.convert<int>(json['batchNo']);
  if (batchNo != null) {
    queryTournamentScoreResultsDataRecords.batchNo = batchNo;
  }
  final String? cds = jsonConvert.convert<String>(json['cds']);
  if (cds != null) {
    queryTournamentScoreResultsDataRecords.cds = cds;
  }
  final String? cupMatch = jsonConvert.convert<String>(json['cupMatch']);
  if (cupMatch != null) {
    queryTournamentScoreResultsDataRecords.cupMatch = cupMatch;
  }
  final dynamic displayScoreResult = json['displayScoreResult'];
  if (displayScoreResult != null) {
    queryTournamentScoreResultsDataRecords.displayScoreResult =
        displayScoreResult;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    queryTournamentScoreResultsDataRecords.homeName = homeName;
  }
  final String? homeUrl = jsonConvert.convert<String>(json['homeUrl']);
  if (homeUrl != null) {
    queryTournamentScoreResultsDataRecords.homeUrl = homeUrl;
  }
  final String? iconUrl = jsonConvert.convert<String>(json['iconUrl']);
  if (iconUrl != null) {
    queryTournamentScoreResultsDataRecords.iconUrl = iconUrl;
  }
  final bool? isIcon = jsonConvert.convert<bool>(json['isIcon']);
  if (isIcon != null) {
    queryTournamentScoreResultsDataRecords.isIcon = isIcon;
  }
  final dynamic leagueAsNameCode = json['leagueAsNameCode'];
  if (leagueAsNameCode != null) {
    queryTournamentScoreResultsDataRecords.leagueAsNameCode = leagueAsNameCode;
  }
  final String? legOrder = jsonConvert.convert<String>(json['legOrder']);
  if (legOrder != null) {
    queryTournamentScoreResultsDataRecords.legOrder = legOrder;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    queryTournamentScoreResultsDataRecords.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    queryTournamentScoreResultsDataRecords.matchId = matchId;
  }
  final dynamic matchManageId = json['matchManageId'];
  if (matchManageId != null) {
    queryTournamentScoreResultsDataRecords.matchManageId = matchManageId;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    queryTournamentScoreResultsDataRecords.matchOver = matchOver;
  }
  final int? matchPeriodId = jsonConvert.convert<int>(json['matchPeriodId']);
  if (matchPeriodId != null) {
    queryTournamentScoreResultsDataRecords.matchPeriodId = matchPeriodId;
  }
  final int? matchStatus = jsonConvert.convert<int>(json['matchStatus']);
  if (matchStatus != null) {
    queryTournamentScoreResultsDataRecords.matchStatus = matchStatus;
  }
  final String? matchTime = jsonConvert.convert<String>(json['matchTime']);
  if (matchTime != null) {
    queryTournamentScoreResultsDataRecords.matchTime = matchTime;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    queryTournamentScoreResultsDataRecords.matchType = matchType;
  }
  final dynamic matchesGroupId = json['matchesGroupId'];
  if (matchesGroupId != null) {
    queryTournamentScoreResultsDataRecords.matchesGroupId = matchesGroupId;
  }
  final String? mle = jsonConvert.convert<String>(json['mle']);
  if (mle != null) {
    queryTournamentScoreResultsDataRecords.mle = mle;
  }
  final dynamic nms = json['nms'];
  if (nms != null) {
    queryTournamentScoreResultsDataRecords.nms = nms;
  }
  final String? penaltyScore = jsonConvert.convert<String>(
      json['penaltyScore']);
  if (penaltyScore != null) {
    queryTournamentScoreResultsDataRecords.penaltyScore = penaltyScore;
  }
  final dynamic playBack = json['playBack'];
  if (playBack != null) {
    queryTournamentScoreResultsDataRecords.playBack = playBack;
  }
  final int? realMatchStatus = jsonConvert.convert<int>(
      json['realMatchStatus']);
  if (realMatchStatus != null) {
    queryTournamentScoreResultsDataRecords.realMatchStatus = realMatchStatus;
  }
  final String? sId = jsonConvert.convert<String>(json['sId']);
  if (sId != null) {
    queryTournamentScoreResultsDataRecords.sId = sId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    queryTournamentScoreResultsDataRecords.score = score;
  }
  final String? scoreResult = jsonConvert.convert<String>(json['scoreResult']);
  if (scoreResult != null) {
    queryTournamentScoreResultsDataRecords.scoreResult = scoreResult;
  }
  final String? scoreResult2 = jsonConvert.convert<String>(
      json['scoreResult2']);
  if (scoreResult2 != null) {
    queryTournamentScoreResultsDataRecords.scoreResult2 = scoreResult2;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    queryTournamentScoreResultsDataRecords.sportId = sportId;
  }
  final String? t1FirstWd = jsonConvert.convert<String>(json['t1FirstWd']);
  if (t1FirstWd != null) {
    queryTournamentScoreResultsDataRecords.t1FirstWd = t1FirstWd;
  }
  final String? t2FirstWd = jsonConvert.convert<String>(json['t2FirstWd']);
  if (t2FirstWd != null) {
    queryTournamentScoreResultsDataRecords.t2FirstWd = t2FirstWd;
  }
  final String? teamGroup = jsonConvert.convert<String>(json['teamGroup']);
  if (teamGroup != null) {
    queryTournamentScoreResultsDataRecords.teamGroup = teamGroup;
  }
  final String? teams = jsonConvert.convert<String>(json['teams']);
  if (teams != null) {
    queryTournamentScoreResultsDataRecords.teams = teams;
  }
  final dynamic teamsTop = json['teamsTop'];
  if (teamsTop != null) {
    queryTournamentScoreResultsDataRecords.teamsTop = teamsTop;
  }
  final String? tid = jsonConvert.convert<String>(json['tid']);
  if (tid != null) {
    queryTournamentScoreResultsDataRecords.tid = tid;
  }
  final String? tnameCode = jsonConvert.convert<String>(json['tnameCode']);
  if (tnameCode != null) {
    queryTournamentScoreResultsDataRecords.tnameCode = tnameCode;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    queryTournamentScoreResultsDataRecords.tournamentName = tournamentName;
  }
  final String? tournamentNameCode = jsonConvert.convert<String>(
      json['tournamentNameCode']);
  if (tournamentNameCode != null) {
    queryTournamentScoreResultsDataRecords.tournamentNameCode =
        tournamentNameCode;
  }
  final String? tournamentUrl = jsonConvert.convert<String>(
      json['tournamentUrl']);
  if (tournamentUrl != null) {
    queryTournamentScoreResultsDataRecords.tournamentUrl = tournamentUrl;
  }
  return queryTournamentScoreResultsDataRecords;
}

Map<String, dynamic> $QueryTournamentScoreResultsDataRecordsToJson(
    QueryTournamentScoreResultsDataRecords entity) {
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
  data['nms'] = entity.nms;
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

extension QueryTournamentScoreResultsDataRecordsExtension on QueryTournamentScoreResultsDataRecords {
  QueryTournamentScoreResultsDataRecords copyWith({
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
    dynamic nms,
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
    return QueryTournamentScoreResultsDataRecords()
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
      ..nms = nms ?? this.nms
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