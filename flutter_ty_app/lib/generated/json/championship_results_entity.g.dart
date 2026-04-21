import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/championship_results_entity.dart';

ChampionshipResultsEntity $ChampionshipResultsEntityFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsEntity championshipResultsEntity = ChampionshipResultsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    championshipResultsEntity.code = code;
  }
  final ChampionshipResultsData? data = jsonConvert.convert<
      ChampionshipResultsData>(json['data']);
  if (data != null) {
    championshipResultsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    championshipResultsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    championshipResultsEntity.ts = ts;
  }
  return championshipResultsEntity;
}

Map<String, dynamic> $ChampionshipResultsEntityToJson(
    ChampionshipResultsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension ChampionshipResultsEntityExtension on ChampionshipResultsEntity {
  ChampionshipResultsEntity copyWith({
    String? code,
    ChampionshipResultsData? data,
    String? msg,
    int? ts,
  }) {
    return ChampionshipResultsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

ChampionshipResultsData $ChampionshipResultsDataFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsData championshipResultsData = ChampionshipResultsData();
  final List<ChampionshipResultsDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ChampionshipResultsDataNb>(
          e) as ChampionshipResultsDataNb)
      .toList();
  if (nb != null) {
    championshipResultsData.nb = nb;
  }
  final List<ChampionshipResultsDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ChampionshipResultsDataNt>(
          e) as ChampionshipResultsDataNt)
      .toList();
  if (nt != null) {
    championshipResultsData.nt = nt;
  }
  final List<ChampionshipResultsDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ChampionshipResultsDataNl>(
          e) as ChampionshipResultsDataNl)
      .toList();
  if (nl != null) {
    championshipResultsData.nl = nl;
  }
  return championshipResultsData;
}

Map<String, dynamic> $ChampionshipResultsDataToJson(
    ChampionshipResultsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension ChampionshipResultsDataExtension on ChampionshipResultsData {
  ChampionshipResultsData copyWith({
    List<ChampionshipResultsDataNb>? nb,
    List<ChampionshipResultsDataNt>? nt,
    List<ChampionshipResultsDataNl>? nl,
  }) {
    return ChampionshipResultsData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

ChampionshipResultsDataNb $ChampionshipResultsDataNbFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNb championshipResultsDataNb = ChampionshipResultsDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    championshipResultsDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    championshipResultsDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    championshipResultsDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    championshipResultsDataNb.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    championshipResultsDataNb.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    championshipResultsDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    championshipResultsDataNb.noticeTypeName = noticeTypeName;
  }
  final ChampionshipResultsDataNbOrderInfo? orderInfo = jsonConvert.convert<
      ChampionshipResultsDataNbOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    championshipResultsDataNb.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    championshipResultsDataNb.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    championshipResultsDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    championshipResultsDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    championshipResultsDataNb.title = title;
  }
  return championshipResultsDataNb;
}

Map<String, dynamic> $ChampionshipResultsDataNbToJson(
    ChampionshipResultsDataNb entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['context'] = entity.context;
  data['id'] = entity.id;
  data['isShuf'] = entity.isShuf;
  data['isTop'] = entity.isTop;
  data['matchManageId'] = entity.matchManageId;
  data['noticeType'] = entity.noticeType;
  data['noticeTypeName'] = entity.noticeTypeName;
  data['orderInfo'] = entity.orderInfo.toJson();
  data['searchKey'] = entity.searchKey;
  data['sendTime'] = entity.sendTime;
  data['sendTimeOther'] = entity.sendTimeOther;
  data['title'] = entity.title;
  return data;
}

extension ChampionshipResultsDataNbExtension on ChampionshipResultsDataNb {
  ChampionshipResultsDataNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    ChampionshipResultsDataNbOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return ChampionshipResultsDataNb()
      ..context = context ?? this.context
      ..id = id ?? this.id
      ..isShuf = isShuf ?? this.isShuf
      ..isTop = isTop ?? this.isTop
      ..matchManageId = matchManageId ?? this.matchManageId
      ..noticeType = noticeType ?? this.noticeType
      ..noticeTypeName = noticeTypeName ?? this.noticeTypeName
      ..orderInfo = orderInfo ?? this.orderInfo
      ..searchKey = searchKey ?? this.searchKey
      ..sendTime = sendTime ?? this.sendTime
      ..sendTimeOther = sendTimeOther ?? this.sendTimeOther
      ..title = title ?? this.title;
  }
}

ChampionshipResultsDataNbOrderInfo $ChampionshipResultsDataNbOrderInfoFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNbOrderInfo championshipResultsDataNbOrderInfo = ChampionshipResultsDataNbOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    championshipResultsDataNbOrderInfo.orderType = orderType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    championshipResultsDataNbOrderInfo.matchIds = matchIds;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    championshipResultsDataNbOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    championshipResultsDataNbOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    championshipResultsDataNbOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    championshipResultsDataNbOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    championshipResultsDataNbOrderInfo.marketType = marketType;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    championshipResultsDataNbOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    championshipResultsDataNbOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    championshipResultsDataNbOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    championshipResultsDataNbOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    championshipResultsDataNbOrderInfo.seriesType = seriesType;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    championshipResultsDataNbOrderInfo.odds = odds;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    championshipResultsDataNbOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    championshipResultsDataNbOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    championshipResultsDataNbOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    championshipResultsDataNbOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    championshipResultsDataNbOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    championshipResultsDataNbOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    championshipResultsDataNbOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    championshipResultsDataNbOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    championshipResultsDataNbOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    championshipResultsDataNbOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    championshipResultsDataNbOrderInfo.betTime = betTime;
  }
  final List<
      ChampionshipResultsDataNbOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          ChampionshipResultsDataNbOrderInfoDetailList>(
          e) as ChampionshipResultsDataNbOrderInfoDetailList).toList();
  if (detailList != null) {
    championshipResultsDataNbOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    championshipResultsDataNbOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    championshipResultsDataNbOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    championshipResultsDataNbOrderInfo.settleType = settleType;
  }
  return championshipResultsDataNbOrderInfo;
}

Map<String, dynamic> $ChampionshipResultsDataNbOrderInfoToJson(
    ChampionshipResultsDataNbOrderInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderType'] = entity.orderType;
  data['matchIds'] = entity.matchIds;
  data['langCode'] = entity.langCode;
  data['orderStatus'] = entity.orderStatus;
  data['initPresettleWs'] = entity.initPresettleWs;
  data['orderClass'] = entity.orderClass;
  data['marketType'] = entity.marketType;
  data['modifyTime'] = entity.modifyTime;
  data['orderClassStr'] = entity.orderClassStr;
  data['enablePreSettle'] = entity.enablePreSettle;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['seriesType'] = entity.seriesType;
  data['odds'] = entity.odds;
  data['seriesSum'] = entity.seriesSum;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['beginTime'] = entity.beginTime;
  data['id'] = entity.id;
  data['addition'] = entity.addition;
  data['betTimeStr'] = entity.betTimeStr;
  data['orderNo'] = entity.orderNo;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['preSettleBetAmount'] = entity.preSettleBetAmount;
  data['managerCode'] = entity.managerCode;
  data['betTime'] = entity.betTime;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['maxCashout'] = entity.maxCashout;
  data['seriesValue'] = entity.seriesValue;
  data['settleType'] = entity.settleType;
  return data;
}

extension ChampionshipResultsDataNbOrderInfoExtension on ChampionshipResultsDataNbOrderInfo {
  ChampionshipResultsDataNbOrderInfo copyWith({
    int? orderType,
    String? matchIds,
    String? langCode,
    String? orderStatus,
    bool? initPresettleWs,
    int? orderClass,
    String? marketType,
    String? modifyTime,
    String? orderClassStr,
    bool? enablePreSettle,
    String? modifyTimeStr,
    String? seriesType,
    String? odds,
    int? seriesSum,
    double? orderAmountTotal,
    String? beginTime,
    String? id,
    int? addition,
    String? betTimeStr,
    String? orderNo,
    double? maxWinAmount,
    double? preSettleBetAmount,
    int? managerCode,
    String? betTime,
    List<ChampionshipResultsDataNbOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
  }) {
    return ChampionshipResultsDataNbOrderInfo()
      ..orderType = orderType ?? this.orderType
      ..matchIds = matchIds ?? this.matchIds
      ..langCode = langCode ?? this.langCode
      ..orderStatus = orderStatus ?? this.orderStatus
      ..initPresettleWs = initPresettleWs ?? this.initPresettleWs
      ..orderClass = orderClass ?? this.orderClass
      ..marketType = marketType ?? this.marketType
      ..modifyTime = modifyTime ?? this.modifyTime
      ..orderClassStr = orderClassStr ?? this.orderClassStr
      ..enablePreSettle = enablePreSettle ?? this.enablePreSettle
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..seriesType = seriesType ?? this.seriesType
      ..odds = odds ?? this.odds
      ..seriesSum = seriesSum ?? this.seriesSum
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..beginTime = beginTime ?? this.beginTime
      ..id = id ?? this.id
      ..addition = addition ?? this.addition
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..orderNo = orderNo ?? this.orderNo
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..preSettleBetAmount = preSettleBetAmount ?? this.preSettleBetAmount
      ..managerCode = managerCode ?? this.managerCode
      ..betTime = betTime ?? this.betTime
      ..detailList = detailList ?? this.detailList
      ..maxCashout = maxCashout ?? this.maxCashout
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleType = settleType ?? this.settleType;
  }
}

ChampionshipResultsDataNbOrderInfoDetailList $ChampionshipResultsDataNbOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNbOrderInfoDetailList championshipResultsDataNbOrderInfoDetailList = ChampionshipResultsDataNbOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    championshipResultsDataNbOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    championshipResultsDataNbOrderInfoDetailList.matchPeriodId = matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    championshipResultsDataNbOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    championshipResultsDataNbOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    championshipResultsDataNbOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    championshipResultsDataNbOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    championshipResultsDataNbOrderInfoDetailList.matchManageType =
        matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    championshipResultsDataNbOrderInfoDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    championshipResultsDataNbOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    championshipResultsDataNbOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    championshipResultsDataNbOrderInfoDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    championshipResultsDataNbOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    championshipResultsDataNbOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    championshipResultsDataNbOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    championshipResultsDataNbOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    championshipResultsDataNbOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    championshipResultsDataNbOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    championshipResultsDataNbOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    championshipResultsDataNbOrderInfoDetailList.matchTestScore =
        matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    championshipResultsDataNbOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    championshipResultsDataNbOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    championshipResultsDataNbOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    championshipResultsDataNbOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    championshipResultsDataNbOrderInfoDetailList.matchProcessId =
        matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    championshipResultsDataNbOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    championshipResultsDataNbOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    championshipResultsDataNbOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    championshipResultsDataNbOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    championshipResultsDataNbOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    championshipResultsDataNbOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    championshipResultsDataNbOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    championshipResultsDataNbOrderInfoDetailList.playId = playId;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    championshipResultsDataNbOrderInfoDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    championshipResultsDataNbOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    championshipResultsDataNbOrderInfoDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    championshipResultsDataNbOrderInfoDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    championshipResultsDataNbOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    championshipResultsDataNbOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    championshipResultsDataNbOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    championshipResultsDataNbOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    championshipResultsDataNbOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    championshipResultsDataNbOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    championshipResultsDataNbOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    championshipResultsDataNbOrderInfoDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    championshipResultsDataNbOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return championshipResultsDataNbOrderInfoDetailList;
}

Map<String, dynamic> $ChampionshipResultsDataNbOrderInfoDetailListToJson(
    ChampionshipResultsDataNbOrderInfoDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betResult'] = entity.betResult;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchType'] = entity.matchType;
  data['matchInfo'] = entity.matchInfo;
  data['homeName'] = entity.homeName;
  data['extJson'] = entity.extJson;
  data['matchManageType'] = entity.matchManageType;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eov'] = entity.eov;
  data['marketType'] = entity.marketType;
  data['playOptionName'] = entity.playOptionName;
  data['playOptionsId'] = entity.playOptionsId;
  data['score'] = entity.score;
  data['closingTime'] = entity.closingTime;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentId'] = entity.tournamentId;
  data['oddsValue'] = entity.oddsValue;
  data['beginTime'] = entity.beginTime;
  data['matchTestScore'] = entity.matchTestScore;
  data['tournamentPic'] = entity.tournamentPic;
  data['betNo'] = entity.betNo;
  data['playName'] = entity.playName;
  data['matchOver'] = entity.matchOver;
  data['matchProcessId'] = entity.matchProcessId;
  data['oddFinally'] = entity.oddFinally;
  data['awayName'] = entity.awayName;
  data['betAmount'] = entity.betAmount;
  data['sportName'] = entity.sportName;
  data['childPlayId'] = entity.childPlayId;
  data['cancelType'] = entity.cancelType;
  data['marketId'] = entity.marketId;
  data['playId'] = entity.playId;
  data['orderSettleRemark'] = entity.orderSettleRemark;
  data['matchId'] = entity.matchId;
  data['secondsMatchStart'] = entity.secondsMatchStart;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['matchName'] = entity.matchName;
  data['marketValue'] = entity.marketValue;
  data['betStatus'] = entity.betStatus;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['playOptions'] = entity.playOptions;
  data['sportId'] = entity.sportId;
  data['settleScore'] = entity.settleScore;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['originalMarketValue'] = entity.originalMarketValue;
  return data;
}

extension ChampionshipResultsDataNbOrderInfoDetailListExtension on ChampionshipResultsDataNbOrderInfoDetailList {
  ChampionshipResultsDataNbOrderInfoDetailList copyWith({
    int? betResult,
    String? matchPeriodId,
    int? matchType,
    String? matchInfo,
    String? homeName,
    String? extJson,
    int? matchManageType,
    String? dataSourceCode,
    String? eov,
    String? marketType,
    String? playOptionName,
    String? playOptionsId,
    String? score,
    String? closingTime,
    String? thirdMatchId,
    String? tournamentId,
    double? oddsValue,
    String? beginTime,
    String? matchTestScore,
    String? tournamentPic,
    String? betNo,
    String? playName,
    int? matchOver,
    int? matchProcessId,
    String? oddFinally,
    String? awayName,
    String? betAmount,
    String? sportName,
    String? childPlayId,
    int? cancelType,
    String? marketId,
    int? playId,
    String? orderSettleRemark,
    String? matchId,
    String? secondsMatchStart,
    String? scoreBenchmark,
    String? matchName,
    String? marketValue,
    int? betStatus,
    int? matchVideoTag,
    String? playOptions,
    int? sportId,
    String? settleScore,
    int? tournamentLevel,
    String? originalMarketValue,
  }) {
    return ChampionshipResultsDataNbOrderInfoDetailList()
      ..betResult = betResult ?? this.betResult
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchType = matchType ?? this.matchType
      ..matchInfo = matchInfo ?? this.matchInfo
      ..homeName = homeName ?? this.homeName
      ..extJson = extJson ?? this.extJson
      ..matchManageType = matchManageType ?? this.matchManageType
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eov = eov ?? this.eov
      ..marketType = marketType ?? this.marketType
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..score = score ?? this.score
      ..closingTime = closingTime ?? this.closingTime
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..oddsValue = oddsValue ?? this.oddsValue
      ..beginTime = beginTime ?? this.beginTime
      ..matchTestScore = matchTestScore ?? this.matchTestScore
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..betNo = betNo ?? this.betNo
      ..playName = playName ?? this.playName
      ..matchOver = matchOver ?? this.matchOver
      ..matchProcessId = matchProcessId ?? this.matchProcessId
      ..oddFinally = oddFinally ?? this.oddFinally
      ..awayName = awayName ?? this.awayName
      ..betAmount = betAmount ?? this.betAmount
      ..sportName = sportName ?? this.sportName
      ..childPlayId = childPlayId ?? this.childPlayId
      ..cancelType = cancelType ?? this.cancelType
      ..marketId = marketId ?? this.marketId
      ..playId = playId ?? this.playId
      ..orderSettleRemark = orderSettleRemark ?? this.orderSettleRemark
      ..matchId = matchId ?? this.matchId
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..matchName = matchName ?? this.matchName
      ..marketValue = marketValue ?? this.marketValue
      ..betStatus = betStatus ?? this.betStatus
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..playOptions = playOptions ?? this.playOptions
      ..sportId = sportId ?? this.sportId
      ..settleScore = settleScore ?? this.settleScore
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..originalMarketValue = originalMarketValue ?? this.originalMarketValue;
  }
}

ChampionshipResultsDataNt $ChampionshipResultsDataNtFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNt championshipResultsDataNt = ChampionshipResultsDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    championshipResultsDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    championshipResultsDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    championshipResultsDataNt.type = type;
  }
  return championshipResultsDataNt;
}

Map<String, dynamic> $ChampionshipResultsDataNtToJson(
    ChampionshipResultsDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension ChampionshipResultsDataNtExtension on ChampionshipResultsDataNt {
  ChampionshipResultsDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return ChampionshipResultsDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

ChampionshipResultsDataNl $ChampionshipResultsDataNlFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNl championshipResultsDataNl = ChampionshipResultsDataNl();
  final List<ChampionshipResultsDataNlMtl>? mtl = (json['mtl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ChampionshipResultsDataNlMtl>(
          e) as ChampionshipResultsDataNlMtl).toList();
  if (mtl != null) {
    championshipResultsDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    championshipResultsDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    championshipResultsDataNl.net = net;
  }
  return championshipResultsDataNl;
}

Map<String, dynamic> $ChampionshipResultsDataNlToJson(
    ChampionshipResultsDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension ChampionshipResultsDataNlExtension on ChampionshipResultsDataNl {
  ChampionshipResultsDataNl copyWith({
    List<ChampionshipResultsDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return ChampionshipResultsDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

ChampionshipResultsDataNlMtl $ChampionshipResultsDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNlMtl championshipResultsDataNlMtl = ChampionshipResultsDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    championshipResultsDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    championshipResultsDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    championshipResultsDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    championshipResultsDataNlMtl.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    championshipResultsDataNlMtl.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    championshipResultsDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    championshipResultsDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final ChampionshipResultsDataNlMtlOrderInfo? orderInfo = jsonConvert.convert<
      ChampionshipResultsDataNlMtlOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    championshipResultsDataNlMtl.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    championshipResultsDataNlMtl.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    championshipResultsDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    championshipResultsDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    championshipResultsDataNlMtl.title = title;
  }
  return championshipResultsDataNlMtl;
}

Map<String, dynamic> $ChampionshipResultsDataNlMtlToJson(
    ChampionshipResultsDataNlMtl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['context'] = entity.context;
  data['id'] = entity.id;
  data['isShuf'] = entity.isShuf;
  data['isTop'] = entity.isTop;
  data['matchManageId'] = entity.matchManageId;
  data['noticeType'] = entity.noticeType;
  data['noticeTypeName'] = entity.noticeTypeName;
  data['orderInfo'] = entity.orderInfo.toJson();
  data['searchKey'] = entity.searchKey;
  data['sendTime'] = entity.sendTime;
  data['sendTimeOther'] = entity.sendTimeOther;
  data['title'] = entity.title;
  return data;
}

extension ChampionshipResultsDataNlMtlExtension on ChampionshipResultsDataNlMtl {
  ChampionshipResultsDataNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    ChampionshipResultsDataNlMtlOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return ChampionshipResultsDataNlMtl()
      ..context = context ?? this.context
      ..id = id ?? this.id
      ..isShuf = isShuf ?? this.isShuf
      ..isTop = isTop ?? this.isTop
      ..matchManageId = matchManageId ?? this.matchManageId
      ..noticeType = noticeType ?? this.noticeType
      ..noticeTypeName = noticeTypeName ?? this.noticeTypeName
      ..orderInfo = orderInfo ?? this.orderInfo
      ..searchKey = searchKey ?? this.searchKey
      ..sendTime = sendTime ?? this.sendTime
      ..sendTimeOther = sendTimeOther ?? this.sendTimeOther
      ..title = title ?? this.title;
  }
}

ChampionshipResultsDataNlMtlOrderInfo $ChampionshipResultsDataNlMtlOrderInfoFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNlMtlOrderInfo championshipResultsDataNlMtlOrderInfo = ChampionshipResultsDataNlMtlOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    championshipResultsDataNlMtlOrderInfo.orderType = orderType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    championshipResultsDataNlMtlOrderInfo.matchIds = matchIds;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    championshipResultsDataNlMtlOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    championshipResultsDataNlMtlOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    championshipResultsDataNlMtlOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    championshipResultsDataNlMtlOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    championshipResultsDataNlMtlOrderInfo.marketType = marketType;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    championshipResultsDataNlMtlOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    championshipResultsDataNlMtlOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    championshipResultsDataNlMtlOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    championshipResultsDataNlMtlOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    championshipResultsDataNlMtlOrderInfo.seriesType = seriesType;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    championshipResultsDataNlMtlOrderInfo.odds = odds;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    championshipResultsDataNlMtlOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    championshipResultsDataNlMtlOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    championshipResultsDataNlMtlOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    championshipResultsDataNlMtlOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    championshipResultsDataNlMtlOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    championshipResultsDataNlMtlOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    championshipResultsDataNlMtlOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    championshipResultsDataNlMtlOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    championshipResultsDataNlMtlOrderInfo.preSettleBetAmount =
        preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    championshipResultsDataNlMtlOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    championshipResultsDataNlMtlOrderInfo.betTime = betTime;
  }
  final List<
      ChampionshipResultsDataNlMtlOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          ChampionshipResultsDataNlMtlOrderInfoDetailList>(
          e) as ChampionshipResultsDataNlMtlOrderInfoDetailList).toList();
  if (detailList != null) {
    championshipResultsDataNlMtlOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    championshipResultsDataNlMtlOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    championshipResultsDataNlMtlOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    championshipResultsDataNlMtlOrderInfo.settleType = settleType;
  }
  return championshipResultsDataNlMtlOrderInfo;
}

Map<String, dynamic> $ChampionshipResultsDataNlMtlOrderInfoToJson(
    ChampionshipResultsDataNlMtlOrderInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderType'] = entity.orderType;
  data['matchIds'] = entity.matchIds;
  data['langCode'] = entity.langCode;
  data['orderStatus'] = entity.orderStatus;
  data['initPresettleWs'] = entity.initPresettleWs;
  data['orderClass'] = entity.orderClass;
  data['marketType'] = entity.marketType;
  data['modifyTime'] = entity.modifyTime;
  data['orderClassStr'] = entity.orderClassStr;
  data['enablePreSettle'] = entity.enablePreSettle;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['seriesType'] = entity.seriesType;
  data['odds'] = entity.odds;
  data['seriesSum'] = entity.seriesSum;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['beginTime'] = entity.beginTime;
  data['id'] = entity.id;
  data['addition'] = entity.addition;
  data['betTimeStr'] = entity.betTimeStr;
  data['orderNo'] = entity.orderNo;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['preSettleBetAmount'] = entity.preSettleBetAmount;
  data['managerCode'] = entity.managerCode;
  data['betTime'] = entity.betTime;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['maxCashout'] = entity.maxCashout;
  data['seriesValue'] = entity.seriesValue;
  data['settleType'] = entity.settleType;
  return data;
}

extension ChampionshipResultsDataNlMtlOrderInfoExtension on ChampionshipResultsDataNlMtlOrderInfo {
  ChampionshipResultsDataNlMtlOrderInfo copyWith({
    int? orderType,
    String? matchIds,
    String? langCode,
    String? orderStatus,
    bool? initPresettleWs,
    int? orderClass,
    String? marketType,
    String? modifyTime,
    String? orderClassStr,
    bool? enablePreSettle,
    String? modifyTimeStr,
    String? seriesType,
    String? odds,
    int? seriesSum,
    double? orderAmountTotal,
    String? beginTime,
    String? id,
    int? addition,
    String? betTimeStr,
    String? orderNo,
    double? maxWinAmount,
    double? preSettleBetAmount,
    int? managerCode,
    String? betTime,
    List<ChampionshipResultsDataNlMtlOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
  }) {
    return ChampionshipResultsDataNlMtlOrderInfo()
      ..orderType = orderType ?? this.orderType
      ..matchIds = matchIds ?? this.matchIds
      ..langCode = langCode ?? this.langCode
      ..orderStatus = orderStatus ?? this.orderStatus
      ..initPresettleWs = initPresettleWs ?? this.initPresettleWs
      ..orderClass = orderClass ?? this.orderClass
      ..marketType = marketType ?? this.marketType
      ..modifyTime = modifyTime ?? this.modifyTime
      ..orderClassStr = orderClassStr ?? this.orderClassStr
      ..enablePreSettle = enablePreSettle ?? this.enablePreSettle
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..seriesType = seriesType ?? this.seriesType
      ..odds = odds ?? this.odds
      ..seriesSum = seriesSum ?? this.seriesSum
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..beginTime = beginTime ?? this.beginTime
      ..id = id ?? this.id
      ..addition = addition ?? this.addition
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..orderNo = orderNo ?? this.orderNo
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..preSettleBetAmount = preSettleBetAmount ?? this.preSettleBetAmount
      ..managerCode = managerCode ?? this.managerCode
      ..betTime = betTime ?? this.betTime
      ..detailList = detailList ?? this.detailList
      ..maxCashout = maxCashout ?? this.maxCashout
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleType = settleType ?? this.settleType;
  }
}

ChampionshipResultsDataNlMtlOrderInfoDetailList $ChampionshipResultsDataNlMtlOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final ChampionshipResultsDataNlMtlOrderInfoDetailList championshipResultsDataNlMtlOrderInfoDetailList = ChampionshipResultsDataNlMtlOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchPeriodId =
        matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchManageType =
        matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.dataSourceCode =
        dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.playOptionsId =
        playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchTestScore =
        matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.tournamentPic =
        tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchProcessId =
        matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.playId = playId;
  }
  final String? orderSettleRemark = jsonConvert.convert<String>(
      json['orderSettleRemark']);
  if (orderSettleRemark != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.orderSettleRemark =
        orderSettleRemark;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    championshipResultsDataNlMtlOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return championshipResultsDataNlMtlOrderInfoDetailList;
}

Map<String, dynamic> $ChampionshipResultsDataNlMtlOrderInfoDetailListToJson(
    ChampionshipResultsDataNlMtlOrderInfoDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betResult'] = entity.betResult;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchType'] = entity.matchType;
  data['matchInfo'] = entity.matchInfo;
  data['homeName'] = entity.homeName;
  data['extJson'] = entity.extJson;
  data['matchManageType'] = entity.matchManageType;
  data['dataSourceCode'] = entity.dataSourceCode;
  data['eov'] = entity.eov;
  data['marketType'] = entity.marketType;
  data['playOptionName'] = entity.playOptionName;
  data['playOptionsId'] = entity.playOptionsId;
  data['score'] = entity.score;
  data['closingTime'] = entity.closingTime;
  data['thirdMatchId'] = entity.thirdMatchId;
  data['tournamentId'] = entity.tournamentId;
  data['oddsValue'] = entity.oddsValue;
  data['beginTime'] = entity.beginTime;
  data['matchTestScore'] = entity.matchTestScore;
  data['tournamentPic'] = entity.tournamentPic;
  data['betNo'] = entity.betNo;
  data['playName'] = entity.playName;
  data['matchOver'] = entity.matchOver;
  data['matchProcessId'] = entity.matchProcessId;
  data['oddFinally'] = entity.oddFinally;
  data['awayName'] = entity.awayName;
  data['betAmount'] = entity.betAmount;
  data['sportName'] = entity.sportName;
  data['childPlayId'] = entity.childPlayId;
  data['cancelType'] = entity.cancelType;
  data['marketId'] = entity.marketId;
  data['playId'] = entity.playId;
  data['orderSettleRemark'] = entity.orderSettleRemark;
  data['matchId'] = entity.matchId;
  data['secondsMatchStart'] = entity.secondsMatchStart;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['matchName'] = entity.matchName;
  data['marketValue'] = entity.marketValue;
  data['betStatus'] = entity.betStatus;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['playOptions'] = entity.playOptions;
  data['sportId'] = entity.sportId;
  data['settleScore'] = entity.settleScore;
  data['tournamentLevel'] = entity.tournamentLevel;
  data['originalMarketValue'] = entity.originalMarketValue;
  return data;
}

extension ChampionshipResultsDataNlMtlOrderInfoDetailListExtension on ChampionshipResultsDataNlMtlOrderInfoDetailList {
  ChampionshipResultsDataNlMtlOrderInfoDetailList copyWith({
    int? betResult,
    String? matchPeriodId,
    int? matchType,
    String? matchInfo,
    String? homeName,
    String? extJson,
    int? matchManageType,
    String? dataSourceCode,
    String? eov,
    String? marketType,
    String? playOptionName,
    String? playOptionsId,
    String? score,
    String? closingTime,
    String? thirdMatchId,
    String? tournamentId,
    double? oddsValue,
    String? beginTime,
    String? matchTestScore,
    String? tournamentPic,
    String? betNo,
    String? playName,
    int? matchOver,
    int? matchProcessId,
    String? oddFinally,
    String? awayName,
    String? betAmount,
    String? sportName,
    String? childPlayId,
    int? cancelType,
    String? marketId,
    int? playId,
    String? orderSettleRemark,
    String? matchId,
    String? secondsMatchStart,
    String? scoreBenchmark,
    String? matchName,
    String? marketValue,
    int? betStatus,
    int? matchVideoTag,
    String? playOptions,
    int? sportId,
    String? settleScore,
    int? tournamentLevel,
    String? originalMarketValue,
  }) {
    return ChampionshipResultsDataNlMtlOrderInfoDetailList()
      ..betResult = betResult ?? this.betResult
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchType = matchType ?? this.matchType
      ..matchInfo = matchInfo ?? this.matchInfo
      ..homeName = homeName ?? this.homeName
      ..extJson = extJson ?? this.extJson
      ..matchManageType = matchManageType ?? this.matchManageType
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..eov = eov ?? this.eov
      ..marketType = marketType ?? this.marketType
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..score = score ?? this.score
      ..closingTime = closingTime ?? this.closingTime
      ..thirdMatchId = thirdMatchId ?? this.thirdMatchId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..oddsValue = oddsValue ?? this.oddsValue
      ..beginTime = beginTime ?? this.beginTime
      ..matchTestScore = matchTestScore ?? this.matchTestScore
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..betNo = betNo ?? this.betNo
      ..playName = playName ?? this.playName
      ..matchOver = matchOver ?? this.matchOver
      ..matchProcessId = matchProcessId ?? this.matchProcessId
      ..oddFinally = oddFinally ?? this.oddFinally
      ..awayName = awayName ?? this.awayName
      ..betAmount = betAmount ?? this.betAmount
      ..sportName = sportName ?? this.sportName
      ..childPlayId = childPlayId ?? this.childPlayId
      ..cancelType = cancelType ?? this.cancelType
      ..marketId = marketId ?? this.marketId
      ..playId = playId ?? this.playId
      ..orderSettleRemark = orderSettleRemark ?? this.orderSettleRemark
      ..matchId = matchId ?? this.matchId
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..matchName = matchName ?? this.matchName
      ..marketValue = marketValue ?? this.marketValue
      ..betStatus = betStatus ?? this.betStatus
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..playOptions = playOptions ?? this.playOptions
      ..sportId = sportId ?? this.sportId
      ..settleScore = settleScore ?? this.settleScore
      ..tournamentLevel = tournamentLevel ?? this.tournamentLevel
      ..originalMarketValue = originalMarketValue ?? this.originalMarketValue;
  }
}