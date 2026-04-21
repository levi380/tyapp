import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/front_list_notice_entity.dart';

FrontListNoticeEntity $FrontListNoticeEntityFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeEntity frontListNoticeEntity = FrontListNoticeEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    frontListNoticeEntity.code = code;
  }
  final FrontListNoticeData? data = jsonConvert.convert<FrontListNoticeData>(
      json['data']);
  if (data != null) {
    frontListNoticeEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    frontListNoticeEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    frontListNoticeEntity.ts = ts;
  }
  return frontListNoticeEntity;
}

Map<String, dynamic> $FrontListNoticeEntityToJson(
    FrontListNoticeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension FrontListNoticeEntityExtension on FrontListNoticeEntity {
  FrontListNoticeEntity copyWith({
    String? code,
    FrontListNoticeData? data,
    String? msg,
    int? ts,
  }) {
    return FrontListNoticeEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

FrontListNoticeData $FrontListNoticeDataFromJson(Map<String, dynamic> json) {
  final FrontListNoticeData frontListNoticeData = FrontListNoticeData();
  final List<FrontListNoticeDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListNoticeDataNb>(e) as FrontListNoticeDataNb)
      .toList();
  if (nb != null) {
    frontListNoticeData.nb = nb;
  }
  final List<FrontListNoticeDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListNoticeDataNt>(e) as FrontListNoticeDataNt)
      .toList();
  if (nt != null) {
    frontListNoticeData.nt = nt;
  }
  final List<FrontListNoticeDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListNoticeDataNl>(e) as FrontListNoticeDataNl)
      .toList();
  if (nl != null) {
    frontListNoticeData.nl = nl;
  }
  return frontListNoticeData;
}

Map<String, dynamic> $FrontListNoticeDataToJson(FrontListNoticeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension FrontListNoticeDataExtension on FrontListNoticeData {
  FrontListNoticeData copyWith({
    List<FrontListNoticeDataNb>? nb,
    List<FrontListNoticeDataNt>? nt,
    List<FrontListNoticeDataNl>? nl,
  }) {
    return FrontListNoticeData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

FrontListNoticeDataNb $FrontListNoticeDataNbFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNb frontListNoticeDataNb = FrontListNoticeDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListNoticeDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListNoticeDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListNoticeDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListNoticeDataNb.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    frontListNoticeDataNb.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListNoticeDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListNoticeDataNb.noticeTypeName = noticeTypeName;
  }
  final FrontListNoticeDataNbOrderInfo? orderInfo = jsonConvert.convert<
      FrontListNoticeDataNbOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    frontListNoticeDataNb.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    frontListNoticeDataNb.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListNoticeDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListNoticeDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListNoticeDataNb.title = title;
  }
  return frontListNoticeDataNb;
}

Map<String, dynamic> $FrontListNoticeDataNbToJson(
    FrontListNoticeDataNb entity) {
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

extension FrontListNoticeDataNbExtension on FrontListNoticeDataNb {
  FrontListNoticeDataNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    FrontListNoticeDataNbOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return FrontListNoticeDataNb()
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

FrontListNoticeDataNbOrderInfo $FrontListNoticeDataNbOrderInfoFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNbOrderInfo frontListNoticeDataNbOrderInfo = FrontListNoticeDataNbOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    frontListNoticeDataNbOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    frontListNoticeDataNbOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    frontListNoticeDataNbOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    frontListNoticeDataNbOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    frontListNoticeDataNbOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListNoticeDataNbOrderInfo.marketType = marketType;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    frontListNoticeDataNbOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    frontListNoticeDataNbOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    frontListNoticeDataNbOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    frontListNoticeDataNbOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    frontListNoticeDataNbOrderInfo.seriesType = seriesType;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    frontListNoticeDataNbOrderInfo.odds = odds;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    frontListNoticeDataNbOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    frontListNoticeDataNbOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    frontListNoticeDataNbOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListNoticeDataNbOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    frontListNoticeDataNbOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    frontListNoticeDataNbOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    frontListNoticeDataNbOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    frontListNoticeDataNbOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    frontListNoticeDataNbOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    frontListNoticeDataNbOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    frontListNoticeDataNbOrderInfo.betTime = betTime;
  }
  final List<
      FrontListNoticeDataNbOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FrontListNoticeDataNbOrderInfoDetailList>(
          e) as FrontListNoticeDataNbOrderInfoDetailList).toList();
  if (detailList != null) {
    frontListNoticeDataNbOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    frontListNoticeDataNbOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    frontListNoticeDataNbOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    frontListNoticeDataNbOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    frontListNoticeDataNbOrderInfo.matchIds = matchIds;
  }
  return frontListNoticeDataNbOrderInfo;
}

Map<String, dynamic> $FrontListNoticeDataNbOrderInfoToJson(
    FrontListNoticeDataNbOrderInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderType'] = entity.orderType;
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
  data['matchIds'] = entity.matchIds;
  return data;
}

extension FrontListNoticeDataNbOrderInfoExtension on FrontListNoticeDataNbOrderInfo {
  FrontListNoticeDataNbOrderInfo copyWith({
    int? orderType,
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
    List<FrontListNoticeDataNbOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return FrontListNoticeDataNbOrderInfo()
      ..orderType = orderType ?? this.orderType
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
      ..settleType = settleType ?? this.settleType
      ..matchIds = matchIds ?? this.matchIds;
  }
}

FrontListNoticeDataNbOrderInfoDetailList $FrontListNoticeDataNbOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNbOrderInfoDetailList frontListNoticeDataNbOrderInfoDetailList = FrontListNoticeDataNbOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    frontListNoticeDataNbOrderInfoDetailList.betResult = betResult;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    frontListNoticeDataNbOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    frontListNoticeDataNbOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchManageType = matchManageType;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    frontListNoticeDataNbOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListNoticeDataNbOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    frontListNoticeDataNbOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    frontListNoticeDataNbOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    frontListNoticeDataNbOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    frontListNoticeDataNbOrderInfoDetailList.closingTime = closingTime;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    frontListNoticeDataNbOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    frontListNoticeDataNbOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    frontListNoticeDataNbOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchTestScore = matchTestScore;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    frontListNoticeDataNbOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    frontListNoticeDataNbOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchProcessId = matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    frontListNoticeDataNbOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    frontListNoticeDataNbOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    frontListNoticeDataNbOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    frontListNoticeDataNbOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    frontListNoticeDataNbOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    frontListNoticeDataNbOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    frontListNoticeDataNbOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    frontListNoticeDataNbOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchId = matchId;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    frontListNoticeDataNbOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    frontListNoticeDataNbOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    frontListNoticeDataNbOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    frontListNoticeDataNbOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    frontListNoticeDataNbOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    frontListNoticeDataNbOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    frontListNoticeDataNbOrderInfoDetailList.tournamentLevel = tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    frontListNoticeDataNbOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return frontListNoticeDataNbOrderInfoDetailList;
}

Map<String, dynamic> $FrontListNoticeDataNbOrderInfoDetailListToJson(
    FrontListNoticeDataNbOrderInfoDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betResult'] = entity.betResult;
  data['matchType'] = entity.matchType;
  data['matchInfo'] = entity.matchInfo;
  data['homeName'] = entity.homeName;
  data['extJson'] = entity.extJson;
  data['matchManageType'] = entity.matchManageType;
  data['eov'] = entity.eov;
  data['marketType'] = entity.marketType;
  data['playOptionName'] = entity.playOptionName;
  data['playOptionsId'] = entity.playOptionsId;
  data['score'] = entity.score;
  data['closingTime'] = entity.closingTime;
  data['tournamentId'] = entity.tournamentId;
  data['oddsValue'] = entity.oddsValue;
  data['beginTime'] = entity.beginTime;
  data['matchTestScore'] = entity.matchTestScore;
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

extension FrontListNoticeDataNbOrderInfoDetailListExtension on FrontListNoticeDataNbOrderInfoDetailList {
  FrontListNoticeDataNbOrderInfoDetailList copyWith({
    int? betResult,
    int? matchType,
    String? matchInfo,
    String? homeName,
    String? extJson,
    int? matchManageType,
    String? eov,
    String? marketType,
    String? playOptionName,
    String? playOptionsId,
    String? score,
    String? closingTime,
    String? tournamentId,
    double? oddsValue,
    String? beginTime,
    String? matchTestScore,
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
    return FrontListNoticeDataNbOrderInfoDetailList()
      ..betResult = betResult ?? this.betResult
      ..matchType = matchType ?? this.matchType
      ..matchInfo = matchInfo ?? this.matchInfo
      ..homeName = homeName ?? this.homeName
      ..extJson = extJson ?? this.extJson
      ..matchManageType = matchManageType ?? this.matchManageType
      ..eov = eov ?? this.eov
      ..marketType = marketType ?? this.marketType
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..score = score ?? this.score
      ..closingTime = closingTime ?? this.closingTime
      ..tournamentId = tournamentId ?? this.tournamentId
      ..oddsValue = oddsValue ?? this.oddsValue
      ..beginTime = beginTime ?? this.beginTime
      ..matchTestScore = matchTestScore ?? this.matchTestScore
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

FrontListNoticeDataNt $FrontListNoticeDataNtFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNt frontListNoticeDataNt = FrontListNoticeDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    frontListNoticeDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    frontListNoticeDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    frontListNoticeDataNt.type = type;
  }
  return frontListNoticeDataNt;
}

Map<String, dynamic> $FrontListNoticeDataNtToJson(
    FrontListNoticeDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension FrontListNoticeDataNtExtension on FrontListNoticeDataNt {
  FrontListNoticeDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return FrontListNoticeDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

FrontListNoticeDataNl $FrontListNoticeDataNlFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNl frontListNoticeDataNl = FrontListNoticeDataNl();
  final List<FrontListNoticeDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FrontListNoticeDataNlMtl>(
          e) as FrontListNoticeDataNlMtl)
      .toList();
  if (mtl != null) {
    frontListNoticeDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    frontListNoticeDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    frontListNoticeDataNl.net = net;
  }
  return frontListNoticeDataNl;
}

Map<String, dynamic> $FrontListNoticeDataNlToJson(
    FrontListNoticeDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension FrontListNoticeDataNlExtension on FrontListNoticeDataNl {
  FrontListNoticeDataNl copyWith({
    List<FrontListNoticeDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return FrontListNoticeDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

FrontListNoticeDataNlMtl $FrontListNoticeDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNlMtl frontListNoticeDataNlMtl = FrontListNoticeDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    frontListNoticeDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListNoticeDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    frontListNoticeDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    frontListNoticeDataNlMtl.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    frontListNoticeDataNlMtl.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    frontListNoticeDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    frontListNoticeDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final FrontListNoticeDataNlMtlOrderInfo? orderInfo = jsonConvert.convert<
      FrontListNoticeDataNlMtlOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    frontListNoticeDataNlMtl.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    frontListNoticeDataNlMtl.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    frontListNoticeDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    frontListNoticeDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    frontListNoticeDataNlMtl.title = title;
  }
  return frontListNoticeDataNlMtl;
}

Map<String, dynamic> $FrontListNoticeDataNlMtlToJson(
    FrontListNoticeDataNlMtl entity) {
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

extension FrontListNoticeDataNlMtlExtension on FrontListNoticeDataNlMtl {
  FrontListNoticeDataNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    FrontListNoticeDataNlMtlOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return FrontListNoticeDataNlMtl()
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

FrontListNoticeDataNlMtlOrderInfo $FrontListNoticeDataNlMtlOrderInfoFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNlMtlOrderInfo frontListNoticeDataNlMtlOrderInfo = FrontListNoticeDataNlMtlOrderInfo();
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    frontListNoticeDataNlMtlOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    frontListNoticeDataNlMtlOrderInfo.orderStatus = orderStatus;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    frontListNoticeDataNlMtlOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListNoticeDataNlMtlOrderInfo.marketType = marketType;
  }
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    frontListNoticeDataNlMtlOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    frontListNoticeDataNlMtlOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    frontListNoticeDataNlMtlOrderInfo.orderClassStr = orderClassStr;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    frontListNoticeDataNlMtlOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    frontListNoticeDataNlMtlOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    frontListNoticeDataNlMtlOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    frontListNoticeDataNlMtlOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    frontListNoticeDataNlMtlOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    frontListNoticeDataNlMtlOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    frontListNoticeDataNlMtlOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    frontListNoticeDataNlMtlOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    frontListNoticeDataNlMtlOrderInfo.maxWinAmount = maxWinAmount;
  }
  final int? preOrderStatus = jsonConvert.convert<int>(json['preOrderStatus']);
  if (preOrderStatus != null) {
    frontListNoticeDataNlMtlOrderInfo.preOrderStatus = preOrderStatus;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    frontListNoticeDataNlMtlOrderInfo.betTime = betTime;
  }
  final List<
      FrontListNoticeDataNlMtlOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FrontListNoticeDataNlMtlOrderInfoDetailList>(
          e) as FrontListNoticeDataNlMtlOrderInfoDetailList).toList();
  if (detailList != null) {
    frontListNoticeDataNlMtlOrderInfo.detailList = detailList;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    frontListNoticeDataNlMtlOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    frontListNoticeDataNlMtlOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    frontListNoticeDataNlMtlOrderInfo.matchIds = matchIds;
  }
  return frontListNoticeDataNlMtlOrderInfo;
}

Map<String, dynamic> $FrontListNoticeDataNlMtlOrderInfoToJson(
    FrontListNoticeDataNlMtlOrderInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['langCode'] = entity.langCode;
  data['orderStatus'] = entity.orderStatus;
  data['orderClass'] = entity.orderClass;
  data['marketType'] = entity.marketType;
  data['preBetAmount'] = entity.preBetAmount;
  data['modifyTime'] = entity.modifyTime;
  data['orderClassStr'] = entity.orderClassStr;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['seriesType'] = entity.seriesType;
  data['seriesSum'] = entity.seriesSum;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['id'] = entity.id;
  data['addition'] = entity.addition;
  data['betTimeStr'] = entity.betTimeStr;
  data['orderNo'] = entity.orderNo;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['betTime'] = entity.betTime;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['seriesValue'] = entity.seriesValue;
  data['settleType'] = entity.settleType;
  data['matchIds'] = entity.matchIds;
  return data;
}

extension FrontListNoticeDataNlMtlOrderInfoExtension on FrontListNoticeDataNlMtlOrderInfo {
  FrontListNoticeDataNlMtlOrderInfo copyWith({
    String? langCode,
    String? orderStatus,
    int? orderClass,
    String? marketType,
    double? preBetAmount,
    String? modifyTime,
    String? orderClassStr,
    String? modifyTimeStr,
    String? seriesType,
    int? seriesSum,
    double? orderAmountTotal,
    String? id,
    int? addition,
    String? betTimeStr,
    String? orderNo,
    double? maxWinAmount,
    int? preOrderStatus,
    String? betTime,
    List<FrontListNoticeDataNlMtlOrderInfoDetailList>? detailList,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return FrontListNoticeDataNlMtlOrderInfo()
      ..langCode = langCode ?? this.langCode
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderClass = orderClass ?? this.orderClass
      ..marketType = marketType ?? this.marketType
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..orderClassStr = orderClassStr ?? this.orderClassStr
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..seriesType = seriesType ?? this.seriesType
      ..seriesSum = seriesSum ?? this.seriesSum
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..id = id ?? this.id
      ..addition = addition ?? this.addition
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..orderNo = orderNo ?? this.orderNo
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..betTime = betTime ?? this.betTime
      ..detailList = detailList ?? this.detailList
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleType = settleType ?? this.settleType
      ..matchIds = matchIds ?? this.matchIds;
  }
}

FrontListNoticeDataNlMtlOrderInfoDetailList $FrontListNoticeDataNlMtlOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final FrontListNoticeDataNlMtlOrderInfoDetailList frontListNoticeDataNlMtlOrderInfoDetailList = FrontListNoticeDataNlMtlOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.betResult = betResult;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.homeName = homeName;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.beginTime = beginTime;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.playName = playName;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.sportName = sportName;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.matchId = matchId;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.scoreBenchmark = scoreBenchmark;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.settleScore = settleScore;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    frontListNoticeDataNlMtlOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return frontListNoticeDataNlMtlOrderInfoDetailList;
}

Map<String, dynamic> $FrontListNoticeDataNlMtlOrderInfoDetailListToJson(
    FrontListNoticeDataNlMtlOrderInfoDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betResult'] = entity.betResult;
  data['matchType'] = entity.matchType;
  data['matchInfo'] = entity.matchInfo;
  data['homeName'] = entity.homeName;
  data['eov'] = entity.eov;
  data['marketType'] = entity.marketType;
  data['playOptionName'] = entity.playOptionName;
  data['playOptionsId'] = entity.playOptionsId;
  data['tournamentId'] = entity.tournamentId;
  data['oddsValue'] = entity.oddsValue;
  data['beginTime'] = entity.beginTime;
  data['tournamentPic'] = entity.tournamentPic;
  data['betNo'] = entity.betNo;
  data['playName'] = entity.playName;
  data['oddFinally'] = entity.oddFinally;
  data['awayName'] = entity.awayName;
  data['betAmount'] = entity.betAmount;
  data['sportName'] = entity.sportName;
  data['cancelType'] = entity.cancelType;
  data['marketId'] = entity.marketId;
  data['playId'] = entity.playId;
  data['matchId'] = entity.matchId;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['matchName'] = entity.matchName;
  data['marketValue'] = entity.marketValue;
  data['betStatus'] = entity.betStatus;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['playOptions'] = entity.playOptions;
  data['sportId'] = entity.sportId;
  data['settleScore'] = entity.settleScore;
  data['originalMarketValue'] = entity.originalMarketValue;
  return data;
}

extension FrontListNoticeDataNlMtlOrderInfoDetailListExtension on FrontListNoticeDataNlMtlOrderInfoDetailList {
  FrontListNoticeDataNlMtlOrderInfoDetailList copyWith({
    int? betResult,
    int? matchType,
    String? matchInfo,
    String? homeName,
    String? eov,
    String? marketType,
    String? playOptionName,
    String? playOptionsId,
    String? tournamentId,
    double? oddsValue,
    String? beginTime,
    String? tournamentPic,
    String? betNo,
    String? playName,
    String? oddFinally,
    String? awayName,
    String? betAmount,
    String? sportName,
    int? cancelType,
    String? marketId,
    int? playId,
    String? matchId,
    String? scoreBenchmark,
    String? matchName,
    String? marketValue,
    int? betStatus,
    int? matchVideoTag,
    String? playOptions,
    int? sportId,
    String? settleScore,
    String? originalMarketValue,
  }) {
    return FrontListNoticeDataNlMtlOrderInfoDetailList()
      ..betResult = betResult ?? this.betResult
      ..matchType = matchType ?? this.matchType
      ..matchInfo = matchInfo ?? this.matchInfo
      ..homeName = homeName ?? this.homeName
      ..eov = eov ?? this.eov
      ..marketType = marketType ?? this.marketType
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..oddsValue = oddsValue ?? this.oddsValue
      ..beginTime = beginTime ?? this.beginTime
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..betNo = betNo ?? this.betNo
      ..playName = playName ?? this.playName
      ..oddFinally = oddFinally ?? this.oddFinally
      ..awayName = awayName ?? this.awayName
      ..betAmount = betAmount ?? this.betAmount
      ..sportName = sportName ?? this.sportName
      ..cancelType = cancelType ?? this.cancelType
      ..marketId = marketId ?? this.marketId
      ..playId = playId ?? this.playId
      ..matchId = matchId ?? this.matchId
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..matchName = matchName ?? this.matchName
      ..marketValue = marketValue ?? this.marketValue
      ..betStatus = betStatus ?? this.betStatus
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..playOptions = playOptions ?? this.playOptions
      ..sportId = sportId ?? this.sportId
      ..settleScore = settleScore ?? this.settleScore
      ..originalMarketValue = originalMarketValue ?? this.originalMarketValue;
  }
}