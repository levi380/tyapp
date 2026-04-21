import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_notice_front_list_new_entity.dart';

GetNoticeFrontListNewEntity $GetNoticeFrontListNewEntityFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewEntity getNoticeFrontListNewEntity = GetNoticeFrontListNewEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getNoticeFrontListNewEntity.code = code;
  }
  final GetNoticeFrontListNewData? data = jsonConvert.convert<
      GetNoticeFrontListNewData>(json['data']);
  if (data != null) {
    getNoticeFrontListNewEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getNoticeFrontListNewEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getNoticeFrontListNewEntity.ts = ts;
  }
  return getNoticeFrontListNewEntity;
}

Map<String, dynamic> $GetNoticeFrontListNewEntityToJson(
    GetNoticeFrontListNewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetNoticeFrontListNewEntityExtension on GetNoticeFrontListNewEntity {
  GetNoticeFrontListNewEntity copyWith({
    String? code,
    GetNoticeFrontListNewData? data,
    String? msg,
    int? ts,
  }) {
    return GetNoticeFrontListNewEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetNoticeFrontListNewData $GetNoticeFrontListNewDataFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewData getNoticeFrontListNewData = GetNoticeFrontListNewData();
  final List<GetNoticeFrontListNewDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListNewDataNb>(
          e) as GetNoticeFrontListNewDataNb)
      .toList();
  if (nb != null) {
    getNoticeFrontListNewData.nb = nb;
  }
  final List<GetNoticeFrontListNewDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListNewDataNt>(
          e) as GetNoticeFrontListNewDataNt)
      .toList();
  if (nt != null) {
    getNoticeFrontListNewData.nt = nt;
  }
  final List<GetNoticeFrontListNewDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListNewDataNl>(
          e) as GetNoticeFrontListNewDataNl)
      .toList();
  if (nl != null) {
    getNoticeFrontListNewData.nl = nl;
  }
  return getNoticeFrontListNewData;
}

Map<String, dynamic> $GetNoticeFrontListNewDataToJson(
    GetNoticeFrontListNewData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension GetNoticeFrontListNewDataExtension on GetNoticeFrontListNewData {
  GetNoticeFrontListNewData copyWith({
    List<GetNoticeFrontListNewDataNb>? nb,
    List<GetNoticeFrontListNewDataNt>? nt,
    List<GetNoticeFrontListNewDataNl>? nl,
  }) {
    return GetNoticeFrontListNewData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

GetNoticeFrontListNewDataNb $GetNoticeFrontListNewDataNbFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNb getNoticeFrontListNewDataNb = GetNoticeFrontListNewDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    getNoticeFrontListNewDataNb.context = context;
  }
  final String? context1 = jsonConvert.convert<String>(json['context1']);
  if (context1 != null) {
    getNoticeFrontListNewDataNb.context1 = context1;
  }
  final String? context2 = jsonConvert.convert<String>(json['context2']);
  if (context2 != null) {
    getNoticeFrontListNewDataNb.context2 = context2;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getNoticeFrontListNewDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    getNoticeFrontListNewDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    getNoticeFrontListNewDataNb.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    getNoticeFrontListNewDataNb.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    getNoticeFrontListNewDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    getNoticeFrontListNewDataNb.noticeTypeName = noticeTypeName;
  }
  final GetNoticeFrontListNewDataNbOrderInfo? orderInfo = jsonConvert.convert<
      GetNoticeFrontListNewDataNbOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    getNoticeFrontListNewDataNb.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    getNoticeFrontListNewDataNb.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    getNoticeFrontListNewDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    getNoticeFrontListNewDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getNoticeFrontListNewDataNb.title = title;
  }
  final bool? displayDate = jsonConvert.convert<bool>(json['displayDate']);
  if (displayDate != null) {
    getNoticeFrontListNewDataNb.displayDate = displayDate;
  }
  return getNoticeFrontListNewDataNb;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNbToJson(
    GetNoticeFrontListNewDataNb entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['context'] = entity.context;
  data['context1'] = entity.context1;
  data['context2'] = entity.context2;
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
  data['displayDate'] = entity.displayDate;
  return data;
}

extension GetNoticeFrontListNewDataNbExtension on GetNoticeFrontListNewDataNb {
  GetNoticeFrontListNewDataNb copyWith({
    String? context,
    String? context1,
    String? context2,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    GetNoticeFrontListNewDataNbOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
    bool? displayDate,
  }) {
    return GetNoticeFrontListNewDataNb()
      ..context = context ?? this.context
      ..context1 = context1 ?? this.context1
      ..context2 = context2 ?? this.context2
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
      ..title = title ?? this.title
      ..displayDate = displayDate ?? this.displayDate;
  }
}

GetNoticeFrontListNewDataNbOrderInfo $GetNoticeFrontListNewDataNbOrderInfoFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNbOrderInfo getNoticeFrontListNewDataNbOrderInfo = GetNoticeFrontListNewDataNbOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getNoticeFrontListNewDataNbOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getNoticeFrontListNewDataNbOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getNoticeFrontListNewDataNbOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getNoticeFrontListNewDataNbOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    getNoticeFrontListNewDataNbOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getNoticeFrontListNewDataNbOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getNoticeFrontListNewDataNbOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getNoticeFrontListNewDataNbOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    getNoticeFrontListNewDataNbOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getNoticeFrontListNewDataNbOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getNoticeFrontListNewDataNbOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getNoticeFrontListNewDataNbOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getNoticeFrontListNewDataNbOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getNoticeFrontListNewDataNbOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getNoticeFrontListNewDataNbOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getNoticeFrontListNewDataNbOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getNoticeFrontListNewDataNbOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getNoticeFrontListNewDataNbOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getNoticeFrontListNewDataNbOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getNoticeFrontListNewDataNbOrderInfo.preSettleBetAmount =
        preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getNoticeFrontListNewDataNbOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getNoticeFrontListNewDataNbOrderInfo.betTime = betTime;
  }
  final List<
      GetNoticeFrontListNewDataNbOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetNoticeFrontListNewDataNbOrderInfoDetailList>(
          e) as GetNoticeFrontListNewDataNbOrderInfoDetailList).toList();
  if (detailList != null) {
    getNoticeFrontListNewDataNbOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getNoticeFrontListNewDataNbOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getNoticeFrontListNewDataNbOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getNoticeFrontListNewDataNbOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    getNoticeFrontListNewDataNbOrderInfo.matchIds = matchIds;
  }
  return getNoticeFrontListNewDataNbOrderInfo;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNbOrderInfoToJson(
    GetNoticeFrontListNewDataNbOrderInfo entity) {
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

extension GetNoticeFrontListNewDataNbOrderInfoExtension on GetNoticeFrontListNewDataNbOrderInfo {
  GetNoticeFrontListNewDataNbOrderInfo copyWith({
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
    String? id,
    int? addition,
    String? betTimeStr,
    String? orderNo,
    double? maxWinAmount,
    double? preSettleBetAmount,
    int? managerCode,
    String? betTime,
    List<GetNoticeFrontListNewDataNbOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return GetNoticeFrontListNewDataNbOrderInfo()
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

GetNoticeFrontListNewDataNbOrderInfoDetailList $GetNoticeFrontListNewDataNbOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNbOrderInfoDetailList getNoticeFrontListNewDataNbOrderInfoDetailList = GetNoticeFrontListNewDataNbOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.betResult = betResult;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.extJson = extJson;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.playOptionsId =
        playOptionsId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.beginTime = beginTime;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.playName = playName;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.matchProcessId =
        matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.matchId = matchId;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getNoticeFrontListNewDataNbOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return getNoticeFrontListNewDataNbOrderInfoDetailList;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNbOrderInfoDetailListToJson(
    GetNoticeFrontListNewDataNbOrderInfoDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betResult'] = entity.betResult;
  data['matchType'] = entity.matchType;
  data['matchInfo'] = entity.matchInfo;
  data['homeName'] = entity.homeName;
  data['extJson'] = entity.extJson;
  data['eov'] = entity.eov;
  data['marketType'] = entity.marketType;
  data['playOptionName'] = entity.playOptionName;
  data['playOptionsId'] = entity.playOptionsId;
  data['tournamentId'] = entity.tournamentId;
  data['oddsValue'] = entity.oddsValue;
  data['beginTime'] = entity.beginTime;
  data['betNo'] = entity.betNo;
  data['playName'] = entity.playName;
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

extension GetNoticeFrontListNewDataNbOrderInfoDetailListExtension on GetNoticeFrontListNewDataNbOrderInfoDetailList {
  GetNoticeFrontListNewDataNbOrderInfoDetailList copyWith({
    int? betResult,
    int? matchType,
    String? matchInfo,
    String? homeName,
    String? extJson,
    String? eov,
    String? marketType,
    String? playOptionName,
    String? playOptionsId,
    String? tournamentId,
    double? oddsValue,
    String? beginTime,
    String? betNo,
    String? playName,
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
    return GetNoticeFrontListNewDataNbOrderInfoDetailList()
      ..betResult = betResult ?? this.betResult
      ..matchType = matchType ?? this.matchType
      ..matchInfo = matchInfo ?? this.matchInfo
      ..homeName = homeName ?? this.homeName
      ..extJson = extJson ?? this.extJson
      ..eov = eov ?? this.eov
      ..marketType = marketType ?? this.marketType
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..oddsValue = oddsValue ?? this.oddsValue
      ..beginTime = beginTime ?? this.beginTime
      ..betNo = betNo ?? this.betNo
      ..playName = playName ?? this.playName
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

GetNoticeFrontListNewDataNt $GetNoticeFrontListNewDataNtFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNt getNoticeFrontListNewDataNt = GetNoticeFrontListNewDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    getNoticeFrontListNewDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getNoticeFrontListNewDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    getNoticeFrontListNewDataNt.type = type;
  }
  return getNoticeFrontListNewDataNt;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNtToJson(
    GetNoticeFrontListNewDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension GetNoticeFrontListNewDataNtExtension on GetNoticeFrontListNewDataNt {
  GetNoticeFrontListNewDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return GetNoticeFrontListNewDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

GetNoticeFrontListNewDataNl $GetNoticeFrontListNewDataNlFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNl getNoticeFrontListNewDataNl = GetNoticeFrontListNewDataNl();
  final List<GetNoticeFrontListNewDataNlMtl>? mtl = (json['mtl'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetNoticeFrontListNewDataNlMtl>(
          e) as GetNoticeFrontListNewDataNlMtl).toList();
  if (mtl != null) {
    getNoticeFrontListNewDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    getNoticeFrontListNewDataNl.nen = nen;
  }
  final String? net = jsonConvert.convert<String>(json['net']);
  if (net != null) {
    getNoticeFrontListNewDataNl.net = net;
  }
  return getNoticeFrontListNewDataNl;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNlToJson(
    GetNoticeFrontListNewDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension GetNoticeFrontListNewDataNlExtension on GetNoticeFrontListNewDataNl {
  GetNoticeFrontListNewDataNl copyWith({
    List<GetNoticeFrontListNewDataNlMtl>? mtl,
    String? nen,
    String? net,
  }) {
    return GetNoticeFrontListNewDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

GetNoticeFrontListNewDataNlMtl $GetNoticeFrontListNewDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNlMtl getNoticeFrontListNewDataNlMtl = GetNoticeFrontListNewDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    getNoticeFrontListNewDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getNoticeFrontListNewDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    getNoticeFrontListNewDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    getNoticeFrontListNewDataNlMtl.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    getNoticeFrontListNewDataNlMtl.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    getNoticeFrontListNewDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    getNoticeFrontListNewDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final GetNoticeFrontListNewDataNlMtlOrderInfo? orderInfo = jsonConvert
      .convert<GetNoticeFrontListNewDataNlMtlOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    getNoticeFrontListNewDataNlMtl.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    getNoticeFrontListNewDataNlMtl.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    getNoticeFrontListNewDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    getNoticeFrontListNewDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getNoticeFrontListNewDataNlMtl.title = title;
  }
  final bool? displayDate = jsonConvert.convert<bool>(json['displayDate']);
  if (displayDate != null) {
    getNoticeFrontListNewDataNlMtl.displayDate = displayDate;
  }
  return getNoticeFrontListNewDataNlMtl;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNlMtlToJson(
    GetNoticeFrontListNewDataNlMtl entity) {
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
  data['displayDate'] = entity.displayDate;
  return data;
}

extension GetNoticeFrontListNewDataNlMtlExtension on GetNoticeFrontListNewDataNlMtl {
  GetNoticeFrontListNewDataNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    GetNoticeFrontListNewDataNlMtlOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
    bool? displayDate,
  }) {
    return GetNoticeFrontListNewDataNlMtl()
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
      ..title = title ?? this.title
      ..displayDate = displayDate ?? this.displayDate;
  }
}

GetNoticeFrontListNewDataNlMtlOrderInfo $GetNoticeFrontListNewDataNlMtlOrderInfoFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNlMtlOrderInfo getNoticeFrontListNewDataNlMtlOrderInfo = GetNoticeFrontListNewDataNlMtlOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.preSettleBetAmount =
        preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.betTime = betTime;
  }
  final List<
      GetNoticeFrontListNewDataNlMtlOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetNoticeFrontListNewDataNlMtlOrderInfoDetailList>(
          e) as GetNoticeFrontListNewDataNlMtlOrderInfoDetailList).toList();
  if (detailList != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    getNoticeFrontListNewDataNlMtlOrderInfo.matchIds = matchIds;
  }
  return getNoticeFrontListNewDataNlMtlOrderInfo;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNlMtlOrderInfoToJson(
    GetNoticeFrontListNewDataNlMtlOrderInfo entity) {
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

extension GetNoticeFrontListNewDataNlMtlOrderInfoExtension on GetNoticeFrontListNewDataNlMtlOrderInfo {
  GetNoticeFrontListNewDataNlMtlOrderInfo copyWith({
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
    String? id,
    int? addition,
    String? betTimeStr,
    String? orderNo,
    double? maxWinAmount,
    double? preSettleBetAmount,
    int? managerCode,
    String? betTime,
    List<GetNoticeFrontListNewDataNlMtlOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return GetNoticeFrontListNewDataNlMtlOrderInfo()
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

GetNoticeFrontListNewDataNlMtlOrderInfoDetailList $GetNoticeFrontListNewDataNlMtlOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final GetNoticeFrontListNewDataNlMtlOrderInfoDetailList getNoticeFrontListNewDataNlMtlOrderInfoDetailList = GetNoticeFrontListNewDataNlMtlOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.betResult = betResult;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.extJson = extJson;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.playOptionsId =
        playOptionsId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.tournamentId =
        tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.beginTime = beginTime;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.playName = playName;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.matchProcessId =
        matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.matchId = matchId;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.matchVideoTag =
        matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    getNoticeFrontListNewDataNlMtlOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return getNoticeFrontListNewDataNlMtlOrderInfoDetailList;
}

Map<String, dynamic> $GetNoticeFrontListNewDataNlMtlOrderInfoDetailListToJson(
    GetNoticeFrontListNewDataNlMtlOrderInfoDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betResult'] = entity.betResult;
  data['matchType'] = entity.matchType;
  data['matchInfo'] = entity.matchInfo;
  data['homeName'] = entity.homeName;
  data['extJson'] = entity.extJson;
  data['eov'] = entity.eov;
  data['marketType'] = entity.marketType;
  data['playOptionName'] = entity.playOptionName;
  data['playOptionsId'] = entity.playOptionsId;
  data['tournamentId'] = entity.tournamentId;
  data['oddsValue'] = entity.oddsValue;
  data['beginTime'] = entity.beginTime;
  data['betNo'] = entity.betNo;
  data['playName'] = entity.playName;
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

extension GetNoticeFrontListNewDataNlMtlOrderInfoDetailListExtension on GetNoticeFrontListNewDataNlMtlOrderInfoDetailList {
  GetNoticeFrontListNewDataNlMtlOrderInfoDetailList copyWith({
    int? betResult,
    int? matchType,
    String? matchInfo,
    String? homeName,
    String? extJson,
    String? eov,
    String? marketType,
    String? playOptionName,
    String? playOptionsId,
    String? tournamentId,
    double? oddsValue,
    String? beginTime,
    String? betNo,
    String? playName,
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
    return GetNoticeFrontListNewDataNlMtlOrderInfoDetailList()
      ..betResult = betResult ?? this.betResult
      ..matchType = matchType ?? this.matchType
      ..matchInfo = matchInfo ?? this.matchInfo
      ..homeName = homeName ?? this.homeName
      ..extJson = extJson ?? this.extJson
      ..eov = eov ?? this.eov
      ..marketType = marketType ?? this.marketType
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..tournamentId = tournamentId ?? this.tournamentId
      ..oddsValue = oddsValue ?? this.oddsValue
      ..beginTime = beginTime ?? this.beginTime
      ..betNo = betNo ?? this.betNo
      ..playName = playName ?? this.playName
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