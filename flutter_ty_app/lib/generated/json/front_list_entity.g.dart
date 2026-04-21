import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/front_list_entity.dart';

FrontListEntity $FrontListEntityFromJson(Map<String, dynamic> json) {
  final FrontListEntity frontListEntity = FrontListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    frontListEntity.code = code;
  }
  final FrontListData? data = jsonConvert.convert<FrontListData>(json['data']);
  if (data != null) {
    frontListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    frontListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    frontListEntity.ts = ts;
  }
  return frontListEntity;
}

Map<String, dynamic> $FrontListEntityToJson(FrontListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension FrontListEntityExtension on FrontListEntity {
  FrontListEntity copyWith({
    String? code,
    FrontListData? data,
    String? msg,
    int? ts,
  }) {
    return FrontListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

FrontListData $FrontListDataFromJson(Map<String, dynamic> json) {
  final FrontListData frontListData = FrontListData();
  final List<FrontListDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<FrontListDataNb>(e) as FrontListDataNb)
      .toList();
  if (nb != null) {
    frontListData.nb = nb;
  }
  final List<FrontListDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<FrontListDataNt>(e) as FrontListDataNt)
      .toList();
  if (nt != null) {
    frontListData.nt = nt;
  }
  final List<FrontListDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<FrontListDataNl>(e) as FrontListDataNl)
      .toList();
  if (nl != null) {
    frontListData.nl = nl;
  }
  return frontListData;
}

Map<String, dynamic> $FrontListDataToJson(FrontListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension FrontListDataExtension on FrontListData {
  FrontListData copyWith({
    List<FrontListDataNb>? nb,
    List<FrontListDataNt>? nt,
    List<FrontListDataNl>? nl,
  }) {
    return FrontListData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

FrontListDataNb $FrontListDataNbFromJson(Map<String, dynamic> json) {
  final FrontListDataNb frontListDataNb = FrontListDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListDataNb.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    frontListDataNb.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListDataNb.noticeTypeName = noticeTypeName;
  }
  final FrontListDataNbOrderInfo? orderInfo = jsonConvert.convert<
      FrontListDataNbOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    frontListDataNb.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    frontListDataNb.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListDataNb.title = title;
  }
  return frontListDataNb;
}

Map<String, dynamic> $FrontListDataNbToJson(FrontListDataNb entity) {
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

extension FrontListDataNbExtension on FrontListDataNb {
  FrontListDataNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    FrontListDataNbOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return FrontListDataNb()
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

FrontListDataNbOrderInfo $FrontListDataNbOrderInfoFromJson(
    Map<String, dynamic> json) {
  final FrontListDataNbOrderInfo frontListDataNbOrderInfo = FrontListDataNbOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    frontListDataNbOrderInfo.orderType = orderType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    frontListDataNbOrderInfo.matchIds = matchIds;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    frontListDataNbOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    frontListDataNbOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    frontListDataNbOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    frontListDataNbOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListDataNbOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    frontListDataNbOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    frontListDataNbOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    frontListDataNbOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    frontListDataNbOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    frontListDataNbOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    frontListDataNbOrderInfo.seriesType = seriesType;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    frontListDataNbOrderInfo.odds = odds;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    frontListDataNbOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    frontListDataNbOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    frontListDataNbOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListDataNbOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    frontListDataNbOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    frontListDataNbOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    frontListDataNbOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    frontListDataNbOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    frontListDataNbOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    frontListDataNbOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    frontListDataNbOrderInfo.betTime = betTime;
  }
  final List<
      FrontListDataNbOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FrontListDataNbOrderInfoDetailList>(
          e) as FrontListDataNbOrderInfoDetailList).toList();
  if (detailList != null) {
    frontListDataNbOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    frontListDataNbOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    frontListDataNbOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    frontListDataNbOrderInfo.settleType = settleType;
  }
  return frontListDataNbOrderInfo;
}

Map<String, dynamic> $FrontListDataNbOrderInfoToJson(
    FrontListDataNbOrderInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderType'] = entity.orderType;
  data['matchIds'] = entity.matchIds;
  data['langCode'] = entity.langCode;
  data['orderStatus'] = entity.orderStatus;
  data['initPresettleWs'] = entity.initPresettleWs;
  data['orderClass'] = entity.orderClass;
  data['marketType'] = entity.marketType;
  data['preBetAmount'] = entity.preBetAmount;
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

extension FrontListDataNbOrderInfoExtension on FrontListDataNbOrderInfo {
  FrontListDataNbOrderInfo copyWith({
    int? orderType,
    String? matchIds,
    String? langCode,
    String? orderStatus,
    bool? initPresettleWs,
    int? orderClass,
    String? marketType,
    int? preBetAmount,
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
    List<FrontListDataNbOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
  }) {
    return FrontListDataNbOrderInfo()
      ..orderType = orderType ?? this.orderType
      ..matchIds = matchIds ?? this.matchIds
      ..langCode = langCode ?? this.langCode
      ..orderStatus = orderStatus ?? this.orderStatus
      ..initPresettleWs = initPresettleWs ?? this.initPresettleWs
      ..orderClass = orderClass ?? this.orderClass
      ..marketType = marketType ?? this.marketType
      ..preBetAmount = preBetAmount ?? this.preBetAmount
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

FrontListDataNbOrderInfoDetailList $FrontListDataNbOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final FrontListDataNbOrderInfoDetailList frontListDataNbOrderInfoDetailList = FrontListDataNbOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    frontListDataNbOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    frontListDataNbOrderInfoDetailList.matchPeriodId = matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    frontListDataNbOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    frontListDataNbOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    frontListDataNbOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    frontListDataNbOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    frontListDataNbOrderInfoDetailList.matchManageType = matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    frontListDataNbOrderInfoDetailList.dataSourceCode = dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    frontListDataNbOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListDataNbOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    frontListDataNbOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    frontListDataNbOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    frontListDataNbOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    frontListDataNbOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    frontListDataNbOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    frontListDataNbOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    frontListDataNbOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    frontListDataNbOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    frontListDataNbOrderInfoDetailList.matchTestScore = matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    frontListDataNbOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    frontListDataNbOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    frontListDataNbOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    frontListDataNbOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    frontListDataNbOrderInfoDetailList.matchProcessId = matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    frontListDataNbOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    frontListDataNbOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    frontListDataNbOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    frontListDataNbOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    frontListDataNbOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    frontListDataNbOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    frontListDataNbOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    frontListDataNbOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    frontListDataNbOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    frontListDataNbOrderInfoDetailList.secondsMatchStart = secondsMatchStart;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    frontListDataNbOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    frontListDataNbOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    frontListDataNbOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    frontListDataNbOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    frontListDataNbOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    frontListDataNbOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    frontListDataNbOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    frontListDataNbOrderInfoDetailList.tournamentLevel = tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    frontListDataNbOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return frontListDataNbOrderInfoDetailList;
}

Map<String, dynamic> $FrontListDataNbOrderInfoDetailListToJson(
    FrontListDataNbOrderInfoDetailList entity) {
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
  data['matchId'] = entity.matchId;
  data['secondsMatchStart'] = entity.secondsMatchStart;
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

extension FrontListDataNbOrderInfoDetailListExtension on FrontListDataNbOrderInfoDetailList {
  FrontListDataNbOrderInfoDetailList copyWith({
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
    String? matchId,
    String? secondsMatchStart,
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
    return FrontListDataNbOrderInfoDetailList()
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
      ..matchId = matchId ?? this.matchId
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
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

FrontListDataNt $FrontListDataNtFromJson(Map<String, dynamic> json) {
  final FrontListDataNt frontListDataNt = FrontListDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    frontListDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    frontListDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    frontListDataNt.type = type;
  }
  return frontListDataNt;
}

Map<String, dynamic> $FrontListDataNtToJson(FrontListDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension FrontListDataNtExtension on FrontListDataNt {
  FrontListDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return FrontListDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

FrontListDataNl $FrontListDataNlFromJson(Map<String, dynamic> json) {
  final FrontListDataNl frontListDataNl = FrontListDataNl();
  final List<FrontListDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListDataNlMtl>(e) as FrontListDataNlMtl)
      .toList();
  if (mtl != null) {
    frontListDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    frontListDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    frontListDataNl.net = net;
  }
  return frontListDataNl;
}

Map<String, dynamic> $FrontListDataNlToJson(FrontListDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension FrontListDataNlExtension on FrontListDataNl {
  FrontListDataNl copyWith({
    List<FrontListDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return FrontListDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

FrontListDataNlMtl $FrontListDataNlMtlFromJson(Map<String, dynamic> json) {
  final FrontListDataNlMtl frontListDataNlMtl = FrontListDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListDataNlMtl.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    frontListDataNlMtl.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final FrontListDataNlMtlOrderInfo? orderInfo = jsonConvert.convert<
      FrontListDataNlMtlOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    frontListDataNlMtl.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    frontListDataNlMtl.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListDataNlMtl.title = title;
  }
  return frontListDataNlMtl;
}

Map<String, dynamic> $FrontListDataNlMtlToJson(FrontListDataNlMtl entity) {
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

extension FrontListDataNlMtlExtension on FrontListDataNlMtl {
  FrontListDataNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    FrontListDataNlMtlOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return FrontListDataNlMtl()
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

FrontListDataNlMtlOrderInfo $FrontListDataNlMtlOrderInfoFromJson(
    Map<String, dynamic> json) {
  final FrontListDataNlMtlOrderInfo frontListDataNlMtlOrderInfo = FrontListDataNlMtlOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    frontListDataNlMtlOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    frontListDataNlMtlOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    frontListDataNlMtlOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    frontListDataNlMtlOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    frontListDataNlMtlOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListDataNlMtlOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    frontListDataNlMtlOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    frontListDataNlMtlOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    frontListDataNlMtlOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    frontListDataNlMtlOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    frontListDataNlMtlOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    frontListDataNlMtlOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    frontListDataNlMtlOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    frontListDataNlMtlOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    frontListDataNlMtlOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListDataNlMtlOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    frontListDataNlMtlOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    frontListDataNlMtlOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    frontListDataNlMtlOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    frontListDataNlMtlOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    frontListDataNlMtlOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    frontListDataNlMtlOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    frontListDataNlMtlOrderInfo.betTime = betTime;
  }
  final List<
      FrontListDataNlMtlOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FrontListDataNlMtlOrderInfoDetailList>(
          e) as FrontListDataNlMtlOrderInfoDetailList).toList();
  if (detailList != null) {
    frontListDataNlMtlOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    frontListDataNlMtlOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    frontListDataNlMtlOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    frontListDataNlMtlOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    frontListDataNlMtlOrderInfo.matchIds = matchIds;
  }
  return frontListDataNlMtlOrderInfo;
}

Map<String, dynamic> $FrontListDataNlMtlOrderInfoToJson(
    FrontListDataNlMtlOrderInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderType'] = entity.orderType;
  data['langCode'] = entity.langCode;
  data['orderStatus'] = entity.orderStatus;
  data['initPresettleWs'] = entity.initPresettleWs;
  data['orderClass'] = entity.orderClass;
  data['marketType'] = entity.marketType;
  data['preBetAmount'] = entity.preBetAmount;
  data['modifyTime'] = entity.modifyTime;
  data['orderClassStr'] = entity.orderClassStr;
  data['enablePreSettle'] = entity.enablePreSettle;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['seriesType'] = entity.seriesType;
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
  data['matchIds'] = entity.matchIds;
  return data;
}

extension FrontListDataNlMtlOrderInfoExtension on FrontListDataNlMtlOrderInfo {
  FrontListDataNlMtlOrderInfo copyWith({
    int? orderType,
    String? langCode,
    String? orderStatus,
    bool? initPresettleWs,
    int? orderClass,
    String? marketType,
    int? preBetAmount,
    String? modifyTime,
    String? orderClassStr,
    bool? enablePreSettle,
    String? modifyTimeStr,
    String? seriesType,
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
    List<FrontListDataNlMtlOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return FrontListDataNlMtlOrderInfo()
      ..orderType = orderType ?? this.orderType
      ..langCode = langCode ?? this.langCode
      ..orderStatus = orderStatus ?? this.orderStatus
      ..initPresettleWs = initPresettleWs ?? this.initPresettleWs
      ..orderClass = orderClass ?? this.orderClass
      ..marketType = marketType ?? this.marketType
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..orderClassStr = orderClassStr ?? this.orderClassStr
      ..enablePreSettle = enablePreSettle ?? this.enablePreSettle
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..seriesType = seriesType ?? this.seriesType
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
      ..settleType = settleType ?? this.settleType
      ..matchIds = matchIds ?? this.matchIds;
  }
}

FrontListDataNlMtlOrderInfoDetailList $FrontListDataNlMtlOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final FrontListDataNlMtlOrderInfoDetailList frontListDataNlMtlOrderInfoDetailList = FrontListDataNlMtlOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    frontListDataNlMtlOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    frontListDataNlMtlOrderInfoDetailList.matchPeriodId = matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    frontListDataNlMtlOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    frontListDataNlMtlOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    frontListDataNlMtlOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    frontListDataNlMtlOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    frontListDataNlMtlOrderInfoDetailList.matchManageType = matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    frontListDataNlMtlOrderInfoDetailList.dataSourceCode = dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    frontListDataNlMtlOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListDataNlMtlOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    frontListDataNlMtlOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    frontListDataNlMtlOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    frontListDataNlMtlOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    frontListDataNlMtlOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    frontListDataNlMtlOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    frontListDataNlMtlOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    frontListDataNlMtlOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    frontListDataNlMtlOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    frontListDataNlMtlOrderInfoDetailList.matchTestScore = matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    frontListDataNlMtlOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    frontListDataNlMtlOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    frontListDataNlMtlOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    frontListDataNlMtlOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    frontListDataNlMtlOrderInfoDetailList.matchProcessId = matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    frontListDataNlMtlOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    frontListDataNlMtlOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    frontListDataNlMtlOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    frontListDataNlMtlOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    frontListDataNlMtlOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    frontListDataNlMtlOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    frontListDataNlMtlOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    frontListDataNlMtlOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    frontListDataNlMtlOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    frontListDataNlMtlOrderInfoDetailList.secondsMatchStart = secondsMatchStart;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    frontListDataNlMtlOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    frontListDataNlMtlOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    frontListDataNlMtlOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    frontListDataNlMtlOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    frontListDataNlMtlOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    frontListDataNlMtlOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    frontListDataNlMtlOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    frontListDataNlMtlOrderInfoDetailList.tournamentLevel = tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    frontListDataNlMtlOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return frontListDataNlMtlOrderInfoDetailList;
}

Map<String, dynamic> $FrontListDataNlMtlOrderInfoDetailListToJson(
    FrontListDataNlMtlOrderInfoDetailList entity) {
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
  data['matchId'] = entity.matchId;
  data['secondsMatchStart'] = entity.secondsMatchStart;
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

extension FrontListDataNlMtlOrderInfoDetailListExtension on FrontListDataNlMtlOrderInfoDetailList {
  FrontListDataNlMtlOrderInfoDetailList copyWith({
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
    String? matchId,
    String? secondsMatchStart,
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
    return FrontListDataNlMtlOrderInfoDetailList()
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
      ..matchId = matchId ?? this.matchId
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
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