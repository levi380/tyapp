import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_front_list_entity.dart';

GetFrontListEntity $GetFrontListEntityFromJson(Map<String, dynamic> json) {
  final GetFrontListEntity getFrontListEntity = GetFrontListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getFrontListEntity.code = code;
  }
  final GetFrontListData? data = jsonConvert.convert<GetFrontListData>(
      json['data']);
  if (data != null) {
    getFrontListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getFrontListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getFrontListEntity.ts = ts;
  }
  return getFrontListEntity;
}

Map<String, dynamic> $GetFrontListEntityToJson(GetFrontListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetFrontListEntityExtension on GetFrontListEntity {
  GetFrontListEntity copyWith({
    String? code,
    GetFrontListData? data,
    String? msg,
    int? ts,
  }) {
    return GetFrontListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetFrontListData $GetFrontListDataFromJson(Map<String, dynamic> json) {
  final GetFrontListData getFrontListData = GetFrontListData();
  final List<GetFrontListDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFrontListDataNb>(e) as GetFrontListDataNb)
      .toList();
  if (nb != null) {
    getFrontListData.nb = nb;
  }
  final List<GetFrontListDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFrontListDataNt>(e) as GetFrontListDataNt)
      .toList();
  if (nt != null) {
    getFrontListData.nt = nt;
  }
  final List<GetFrontListDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFrontListDataNl>(e) as GetFrontListDataNl)
      .toList();
  if (nl != null) {
    getFrontListData.nl = nl;
  }
  return getFrontListData;
}

Map<String, dynamic> $GetFrontListDataToJson(GetFrontListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension GetFrontListDataExtension on GetFrontListData {
  GetFrontListData copyWith({
    List<GetFrontListDataNb>? nb,
    List<GetFrontListDataNt>? nt,
    List<GetFrontListDataNl>? nl,
  }) {
    return GetFrontListData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

GetFrontListDataNb $GetFrontListDataNbFromJson(Map<String, dynamic> json) {
  final GetFrontListDataNb getFrontListDataNb = GetFrontListDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    getFrontListDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFrontListDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    getFrontListDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    getFrontListDataNb.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    getFrontListDataNb.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    getFrontListDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    getFrontListDataNb.noticeTypeName = noticeTypeName;
  }
  final GetFrontListDataNbOrderInfo? orderInfo = jsonConvert.convert<
      GetFrontListDataNbOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    getFrontListDataNb.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    getFrontListDataNb.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    getFrontListDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    getFrontListDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getFrontListDataNb.title = title;
  }
  return getFrontListDataNb;
}

Map<String, dynamic> $GetFrontListDataNbToJson(GetFrontListDataNb entity) {
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

extension GetFrontListDataNbExtension on GetFrontListDataNb {
  GetFrontListDataNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    GetFrontListDataNbOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return GetFrontListDataNb()
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

GetFrontListDataNbOrderInfo $GetFrontListDataNbOrderInfoFromJson(
    Map<String, dynamic> json) {
  final GetFrontListDataNbOrderInfo getFrontListDataNbOrderInfo = GetFrontListDataNbOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getFrontListDataNbOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getFrontListDataNbOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getFrontListDataNbOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getFrontListDataNbOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    getFrontListDataNbOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getFrontListDataNbOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getFrontListDataNbOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getFrontListDataNbOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    getFrontListDataNbOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getFrontListDataNbOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getFrontListDataNbOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getFrontListDataNbOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getFrontListDataNbOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getFrontListDataNbOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getFrontListDataNbOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFrontListDataNbOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getFrontListDataNbOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getFrontListDataNbOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getFrontListDataNbOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getFrontListDataNbOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getFrontListDataNbOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getFrontListDataNbOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getFrontListDataNbOrderInfo.betTime = betTime;
  }
  final List<
      GetFrontListDataNbOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFrontListDataNbOrderInfoDetailList>(
          e) as GetFrontListDataNbOrderInfoDetailList).toList();
  if (detailList != null) {
    getFrontListDataNbOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getFrontListDataNbOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getFrontListDataNbOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getFrontListDataNbOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    getFrontListDataNbOrderInfo.matchIds = matchIds;
  }
  return getFrontListDataNbOrderInfo;
}

Map<String, dynamic> $GetFrontListDataNbOrderInfoToJson(
    GetFrontListDataNbOrderInfo entity) {
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

extension GetFrontListDataNbOrderInfoExtension on GetFrontListDataNbOrderInfo {
  GetFrontListDataNbOrderInfo copyWith({
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
    List<GetFrontListDataNbOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return GetFrontListDataNbOrderInfo()
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

GetFrontListDataNbOrderInfoDetailList $GetFrontListDataNbOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final GetFrontListDataNbOrderInfoDetailList getFrontListDataNbOrderInfoDetailList = GetFrontListDataNbOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getFrontListDataNbOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getFrontListDataNbOrderInfoDetailList.matchPeriodId = matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getFrontListDataNbOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getFrontListDataNbOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getFrontListDataNbOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getFrontListDataNbOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getFrontListDataNbOrderInfoDetailList.matchManageType = matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getFrontListDataNbOrderInfoDetailList.dataSourceCode = dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getFrontListDataNbOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getFrontListDataNbOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getFrontListDataNbOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getFrontListDataNbOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getFrontListDataNbOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getFrontListDataNbOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getFrontListDataNbOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFrontListDataNbOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getFrontListDataNbOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getFrontListDataNbOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getFrontListDataNbOrderInfoDetailList.matchTestScore = matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getFrontListDataNbOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getFrontListDataNbOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getFrontListDataNbOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getFrontListDataNbOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getFrontListDataNbOrderInfoDetailList.matchProcessId = matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getFrontListDataNbOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getFrontListDataNbOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getFrontListDataNbOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getFrontListDataNbOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getFrontListDataNbOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getFrontListDataNbOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getFrontListDataNbOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getFrontListDataNbOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getFrontListDataNbOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getFrontListDataNbOrderInfoDetailList.secondsMatchStart = secondsMatchStart;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getFrontListDataNbOrderInfoDetailList.scoreBenchmark = scoreBenchmark;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getFrontListDataNbOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getFrontListDataNbOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getFrontListDataNbOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getFrontListDataNbOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getFrontListDataNbOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getFrontListDataNbOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getFrontListDataNbOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFrontListDataNbOrderInfoDetailList.tournamentLevel = tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getFrontListDataNbOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return getFrontListDataNbOrderInfoDetailList;
}

Map<String, dynamic> $GetFrontListDataNbOrderInfoDetailListToJson(
    GetFrontListDataNbOrderInfoDetailList entity) {
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

extension GetFrontListDataNbOrderInfoDetailListExtension on GetFrontListDataNbOrderInfoDetailList {
  GetFrontListDataNbOrderInfoDetailList copyWith({
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
    return GetFrontListDataNbOrderInfoDetailList()
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

GetFrontListDataNt $GetFrontListDataNtFromJson(Map<String, dynamic> json) {
  final GetFrontListDataNt getFrontListDataNt = GetFrontListDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    getFrontListDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getFrontListDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    getFrontListDataNt.type = type;
  }
  return getFrontListDataNt;
}

Map<String, dynamic> $GetFrontListDataNtToJson(GetFrontListDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension GetFrontListDataNtExtension on GetFrontListDataNt {
  GetFrontListDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return GetFrontListDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

GetFrontListDataNl $GetFrontListDataNlFromJson(Map<String, dynamic> json) {
  final GetFrontListDataNl getFrontListDataNl = GetFrontListDataNl();
  final List<GetFrontListDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetFrontListDataNlMtl>(e) as GetFrontListDataNlMtl)
      .toList();
  if (mtl != null) {
    getFrontListDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    getFrontListDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    getFrontListDataNl.net = net;
  }
  return getFrontListDataNl;
}

Map<String, dynamic> $GetFrontListDataNlToJson(GetFrontListDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension GetFrontListDataNlExtension on GetFrontListDataNl {
  GetFrontListDataNl copyWith({
    List<GetFrontListDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return GetFrontListDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

GetFrontListDataNlMtl $GetFrontListDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final GetFrontListDataNlMtl getFrontListDataNlMtl = GetFrontListDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    getFrontListDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFrontListDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    getFrontListDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    getFrontListDataNlMtl.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    getFrontListDataNlMtl.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    getFrontListDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    getFrontListDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final GetFrontListDataNlMtlOrderInfo? orderInfo = jsonConvert.convert<
      GetFrontListDataNlMtlOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    getFrontListDataNlMtl.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    getFrontListDataNlMtl.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    getFrontListDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    getFrontListDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getFrontListDataNlMtl.title = title;
  }
  return getFrontListDataNlMtl;
}

Map<String, dynamic> $GetFrontListDataNlMtlToJson(
    GetFrontListDataNlMtl entity) {
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

extension GetFrontListDataNlMtlExtension on GetFrontListDataNlMtl {
  GetFrontListDataNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    GetFrontListDataNlMtlOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return GetFrontListDataNlMtl()
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

GetFrontListDataNlMtlOrderInfo $GetFrontListDataNlMtlOrderInfoFromJson(
    Map<String, dynamic> json) {
  final GetFrontListDataNlMtlOrderInfo getFrontListDataNlMtlOrderInfo = GetFrontListDataNlMtlOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getFrontListDataNlMtlOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getFrontListDataNlMtlOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getFrontListDataNlMtlOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getFrontListDataNlMtlOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    getFrontListDataNlMtlOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getFrontListDataNlMtlOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getFrontListDataNlMtlOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getFrontListDataNlMtlOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    getFrontListDataNlMtlOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getFrontListDataNlMtlOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getFrontListDataNlMtlOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getFrontListDataNlMtlOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getFrontListDataNlMtlOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getFrontListDataNlMtlOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getFrontListDataNlMtlOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getFrontListDataNlMtlOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getFrontListDataNlMtlOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getFrontListDataNlMtlOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getFrontListDataNlMtlOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getFrontListDataNlMtlOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getFrontListDataNlMtlOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getFrontListDataNlMtlOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getFrontListDataNlMtlOrderInfo.betTime = betTime;
  }
  final List<
      GetFrontListDataNlMtlOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetFrontListDataNlMtlOrderInfoDetailList>(
          e) as GetFrontListDataNlMtlOrderInfoDetailList).toList();
  if (detailList != null) {
    getFrontListDataNlMtlOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getFrontListDataNlMtlOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getFrontListDataNlMtlOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getFrontListDataNlMtlOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    getFrontListDataNlMtlOrderInfo.matchIds = matchIds;
  }
  return getFrontListDataNlMtlOrderInfo;
}

Map<String, dynamic> $GetFrontListDataNlMtlOrderInfoToJson(
    GetFrontListDataNlMtlOrderInfo entity) {
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

extension GetFrontListDataNlMtlOrderInfoExtension on GetFrontListDataNlMtlOrderInfo {
  GetFrontListDataNlMtlOrderInfo copyWith({
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
    List<GetFrontListDataNlMtlOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return GetFrontListDataNlMtlOrderInfo()
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

GetFrontListDataNlMtlOrderInfoDetailList $GetFrontListDataNlMtlOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final GetFrontListDataNlMtlOrderInfoDetailList getFrontListDataNlMtlOrderInfoDetailList = GetFrontListDataNlMtlOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getFrontListDataNlMtlOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchPeriodId = matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getFrontListDataNlMtlOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getFrontListDataNlMtlOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchManageType = matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getFrontListDataNlMtlOrderInfoDetailList.dataSourceCode = dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getFrontListDataNlMtlOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getFrontListDataNlMtlOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getFrontListDataNlMtlOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getFrontListDataNlMtlOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    getFrontListDataNlMtlOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getFrontListDataNlMtlOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getFrontListDataNlMtlOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchTestScore = matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getFrontListDataNlMtlOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getFrontListDataNlMtlOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getFrontListDataNlMtlOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchProcessId = matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getFrontListDataNlMtlOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getFrontListDataNlMtlOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getFrontListDataNlMtlOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getFrontListDataNlMtlOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getFrontListDataNlMtlOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getFrontListDataNlMtlOrderInfoDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getFrontListDataNlMtlOrderInfoDetailList.scoreBenchmark = scoreBenchmark;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getFrontListDataNlMtlOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getFrontListDataNlMtlOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getFrontListDataNlMtlOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getFrontListDataNlMtlOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getFrontListDataNlMtlOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getFrontListDataNlMtlOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getFrontListDataNlMtlOrderInfoDetailList.tournamentLevel = tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getFrontListDataNlMtlOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return getFrontListDataNlMtlOrderInfoDetailList;
}

Map<String, dynamic> $GetFrontListDataNlMtlOrderInfoDetailListToJson(
    GetFrontListDataNlMtlOrderInfoDetailList entity) {
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

extension GetFrontListDataNlMtlOrderInfoDetailListExtension on GetFrontListDataNlMtlOrderInfoDetailList {
  GetFrontListDataNlMtlOrderInfoDetailList copyWith({
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
    return GetFrontListDataNlMtlOrderInfoDetailList()
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