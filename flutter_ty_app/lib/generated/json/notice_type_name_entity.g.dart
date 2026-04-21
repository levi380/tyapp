import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_type_name_entity.dart';

NoticeTypeNameEntity $NoticeTypeNameEntityFromJson(Map<String, dynamic> json) {
  final NoticeTypeNameEntity noticeTypeNameEntity = NoticeTypeNameEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    noticeTypeNameEntity.code = code;
  }
  final NoticeTypeNameData? data = jsonConvert.convert<NoticeTypeNameData>(
      json['data']);
  if (data != null) {
    noticeTypeNameEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    noticeTypeNameEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    noticeTypeNameEntity.ts = ts;
  }
  return noticeTypeNameEntity;
}

Map<String, dynamic> $NoticeTypeNameEntityToJson(NoticeTypeNameEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension NoticeTypeNameEntityExtension on NoticeTypeNameEntity {
  NoticeTypeNameEntity copyWith({
    String? code,
    NoticeTypeNameData? data,
    String? msg,
    int? ts,
  }) {
    return NoticeTypeNameEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

NoticeTypeNameData $NoticeTypeNameDataFromJson(Map<String, dynamic> json) {
  final NoticeTypeNameData noticeTypeNameData = NoticeTypeNameData();
  final List<NoticeTypeNameDataNb>? nb = (json['nb'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeTypeNameDataNb>(e) as NoticeTypeNameDataNb)
      .toList();
  if (nb != null) {
    noticeTypeNameData.nb = nb;
  }
  final List<NoticeTypeNameDataNt>? nt = (json['nt'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeTypeNameDataNt>(e) as NoticeTypeNameDataNt)
      .toList();
  if (nt != null) {
    noticeTypeNameData.nt = nt;
  }
  final List<NoticeTypeNameDataNl>? nl = (json['nl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeTypeNameDataNl>(e) as NoticeTypeNameDataNl)
      .toList();
  if (nl != null) {
    noticeTypeNameData.nl = nl;
  }
  return noticeTypeNameData;
}

Map<String, dynamic> $NoticeTypeNameDataToJson(NoticeTypeNameData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nb'] = entity.nb.map((v) => v.toJson()).toList();
  data['nt'] = entity.nt.map((v) => v.toJson()).toList();
  data['nl'] = entity.nl.map((v) => v.toJson()).toList();
  return data;
}

extension NoticeTypeNameDataExtension on NoticeTypeNameData {
  NoticeTypeNameData copyWith({
    List<NoticeTypeNameDataNb>? nb,
    List<NoticeTypeNameDataNt>? nt,
    List<NoticeTypeNameDataNl>? nl,
  }) {
    return NoticeTypeNameData()
      ..nb = nb ?? this.nb
      ..nt = nt ?? this.nt
      ..nl = nl ?? this.nl;
  }
}

NoticeTypeNameDataNb $NoticeTypeNameDataNbFromJson(Map<String, dynamic> json) {
  final NoticeTypeNameDataNb noticeTypeNameDataNb = NoticeTypeNameDataNb();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeTypeNameDataNb.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeTypeNameDataNb.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeTypeNameDataNb.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeTypeNameDataNb.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    noticeTypeNameDataNb.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeTypeNameDataNb.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeTypeNameDataNb.noticeTypeName = noticeTypeName;
  }
  final NoticeTypeNameDataNbOrderInfo? orderInfo = jsonConvert.convert<
      NoticeTypeNameDataNbOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    noticeTypeNameDataNb.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    noticeTypeNameDataNb.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeTypeNameDataNb.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeTypeNameDataNb.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeTypeNameDataNb.title = title;
  }
  return noticeTypeNameDataNb;
}

Map<String, dynamic> $NoticeTypeNameDataNbToJson(NoticeTypeNameDataNb entity) {
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

extension NoticeTypeNameDataNbExtension on NoticeTypeNameDataNb {
  NoticeTypeNameDataNb copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    NoticeTypeNameDataNbOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return NoticeTypeNameDataNb()
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

NoticeTypeNameDataNbOrderInfo $NoticeTypeNameDataNbOrderInfoFromJson(
    Map<String, dynamic> json) {
  final NoticeTypeNameDataNbOrderInfo noticeTypeNameDataNbOrderInfo = NoticeTypeNameDataNbOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    noticeTypeNameDataNbOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    noticeTypeNameDataNbOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    noticeTypeNameDataNbOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    noticeTypeNameDataNbOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    noticeTypeNameDataNbOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    noticeTypeNameDataNbOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    noticeTypeNameDataNbOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    noticeTypeNameDataNbOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    noticeTypeNameDataNbOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    noticeTypeNameDataNbOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    noticeTypeNameDataNbOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    noticeTypeNameDataNbOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    noticeTypeNameDataNbOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    noticeTypeNameDataNbOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    noticeTypeNameDataNbOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeTypeNameDataNbOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    noticeTypeNameDataNbOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    noticeTypeNameDataNbOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    noticeTypeNameDataNbOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    noticeTypeNameDataNbOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    noticeTypeNameDataNbOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    noticeTypeNameDataNbOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    noticeTypeNameDataNbOrderInfo.betTime = betTime;
  }
  final List<
      NoticeTypeNameDataNbOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeTypeNameDataNbOrderInfoDetailList>(
          e) as NoticeTypeNameDataNbOrderInfoDetailList).toList();
  if (detailList != null) {
    noticeTypeNameDataNbOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    noticeTypeNameDataNbOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    noticeTypeNameDataNbOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    noticeTypeNameDataNbOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    noticeTypeNameDataNbOrderInfo.matchIds = matchIds;
  }
  return noticeTypeNameDataNbOrderInfo;
}

Map<String, dynamic> $NoticeTypeNameDataNbOrderInfoToJson(
    NoticeTypeNameDataNbOrderInfo entity) {
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

extension NoticeTypeNameDataNbOrderInfoExtension on NoticeTypeNameDataNbOrderInfo {
  NoticeTypeNameDataNbOrderInfo copyWith({
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
    List<NoticeTypeNameDataNbOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return NoticeTypeNameDataNbOrderInfo()
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

NoticeTypeNameDataNbOrderInfoDetailList $NoticeTypeNameDataNbOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final NoticeTypeNameDataNbOrderInfoDetailList noticeTypeNameDataNbOrderInfoDetailList = NoticeTypeNameDataNbOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    noticeTypeNameDataNbOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchPeriodId = matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    noticeTypeNameDataNbOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    noticeTypeNameDataNbOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchManageType = matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    noticeTypeNameDataNbOrderInfoDetailList.dataSourceCode = dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    noticeTypeNameDataNbOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    noticeTypeNameDataNbOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    noticeTypeNameDataNbOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    noticeTypeNameDataNbOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    noticeTypeNameDataNbOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    noticeTypeNameDataNbOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    noticeTypeNameDataNbOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchTestScore = matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    noticeTypeNameDataNbOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    noticeTypeNameDataNbOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    noticeTypeNameDataNbOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchProcessId = matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    noticeTypeNameDataNbOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    noticeTypeNameDataNbOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    noticeTypeNameDataNbOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    noticeTypeNameDataNbOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    noticeTypeNameDataNbOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    noticeTypeNameDataNbOrderInfoDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    noticeTypeNameDataNbOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    noticeTypeNameDataNbOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    noticeTypeNameDataNbOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    noticeTypeNameDataNbOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    noticeTypeNameDataNbOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    noticeTypeNameDataNbOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    noticeTypeNameDataNbOrderInfoDetailList.tournamentLevel = tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    noticeTypeNameDataNbOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return noticeTypeNameDataNbOrderInfoDetailList;
}

Map<String, dynamic> $NoticeTypeNameDataNbOrderInfoDetailListToJson(
    NoticeTypeNameDataNbOrderInfoDetailList entity) {
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

extension NoticeTypeNameDataNbOrderInfoDetailListExtension on NoticeTypeNameDataNbOrderInfoDetailList {
  NoticeTypeNameDataNbOrderInfoDetailList copyWith({
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
    return NoticeTypeNameDataNbOrderInfoDetailList()
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

NoticeTypeNameDataNt $NoticeTypeNameDataNtFromJson(Map<String, dynamic> json) {
  final NoticeTypeNameDataNt noticeTypeNameDataNt = NoticeTypeNameDataNt();
  final String? enType = jsonConvert.convert<String>(json['enType']);
  if (enType != null) {
    noticeTypeNameDataNt.enType = enType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    noticeTypeNameDataNt.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    noticeTypeNameDataNt.type = type;
  }
  return noticeTypeNameDataNt;
}

Map<String, dynamic> $NoticeTypeNameDataNtToJson(NoticeTypeNameDataNt entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enType'] = entity.enType;
  data['id'] = entity.id;
  data['type'] = entity.type;
  return data;
}

extension NoticeTypeNameDataNtExtension on NoticeTypeNameDataNt {
  NoticeTypeNameDataNt copyWith({
    String? enType,
    int? id,
    String? type,
  }) {
    return NoticeTypeNameDataNt()
      ..enType = enType ?? this.enType
      ..id = id ?? this.id
      ..type = type ?? this.type;
  }
}

NoticeTypeNameDataNl $NoticeTypeNameDataNlFromJson(Map<String, dynamic> json) {
  final NoticeTypeNameDataNl noticeTypeNameDataNl = NoticeTypeNameDataNl();
  final List<NoticeTypeNameDataNlMtl>? mtl = (json['mtl'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<NoticeTypeNameDataNlMtl>(
          e) as NoticeTypeNameDataNlMtl)
      .toList();
  if (mtl != null) {
    noticeTypeNameDataNl.mtl = mtl;
  }
  final String? nen = jsonConvert.convert<String>(json['nen']);
  if (nen != null) {
    noticeTypeNameDataNl.nen = nen;
  }
  final int? net = jsonConvert.convert<int>(json['net']);
  if (net != null) {
    noticeTypeNameDataNl.net = net;
  }
  return noticeTypeNameDataNl;
}

Map<String, dynamic> $NoticeTypeNameDataNlToJson(NoticeTypeNameDataNl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mtl'] = entity.mtl.map((v) => v.toJson()).toList();
  data['nen'] = entity.nen;
  data['net'] = entity.net;
  return data;
}

extension NoticeTypeNameDataNlExtension on NoticeTypeNameDataNl {
  NoticeTypeNameDataNl copyWith({
    List<NoticeTypeNameDataNlMtl>? mtl,
    String? nen,
    int? net,
  }) {
    return NoticeTypeNameDataNl()
      ..mtl = mtl ?? this.mtl
      ..nen = nen ?? this.nen
      ..net = net ?? this.net;
  }
}

NoticeTypeNameDataNlMtl $NoticeTypeNameDataNlMtlFromJson(
    Map<String, dynamic> json) {
  final NoticeTypeNameDataNlMtl noticeTypeNameDataNlMtl = NoticeTypeNameDataNlMtl();
  final String? context = jsonConvert.convert<String>(json['context']);
  if (context != null) {
    noticeTypeNameDataNlMtl.context = context;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeTypeNameDataNlMtl.id = id;
  }
  final int? isShuf = jsonConvert.convert<int>(json['isShuf']);
  if (isShuf != null) {
    noticeTypeNameDataNlMtl.isShuf = isShuf;
  }
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    noticeTypeNameDataNlMtl.isTop = isTop;
  }
  final String? matchManageId = jsonConvert.convert<String>(
      json['matchManageId']);
  if (matchManageId != null) {
    noticeTypeNameDataNlMtl.matchManageId = matchManageId;
  }
  final int? noticeType = jsonConvert.convert<int>(json['noticeType']);
  if (noticeType != null) {
    noticeTypeNameDataNlMtl.noticeType = noticeType;
  }
  final String? noticeTypeName = jsonConvert.convert<String>(
      json['noticeTypeName']);
  if (noticeTypeName != null) {
    noticeTypeNameDataNlMtl.noticeTypeName = noticeTypeName;
  }
  final NoticeTypeNameDataNlMtlOrderInfo? orderInfo = jsonConvert.convert<
      NoticeTypeNameDataNlMtlOrderInfo>(json['orderInfo']);
  if (orderInfo != null) {
    noticeTypeNameDataNlMtl.orderInfo = orderInfo;
  }
  final String? searchKey = jsonConvert.convert<String>(json['searchKey']);
  if (searchKey != null) {
    noticeTypeNameDataNlMtl.searchKey = searchKey;
  }
  final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
  if (sendTime != null) {
    noticeTypeNameDataNlMtl.sendTime = sendTime;
  }
  final String? sendTimeOther = jsonConvert.convert<String>(
      json['sendTimeOther']);
  if (sendTimeOther != null) {
    noticeTypeNameDataNlMtl.sendTimeOther = sendTimeOther;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    noticeTypeNameDataNlMtl.title = title;
  }
  return noticeTypeNameDataNlMtl;
}

Map<String, dynamic> $NoticeTypeNameDataNlMtlToJson(
    NoticeTypeNameDataNlMtl entity) {
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

extension NoticeTypeNameDataNlMtlExtension on NoticeTypeNameDataNlMtl {
  NoticeTypeNameDataNlMtl copyWith({
    String? context,
    String? id,
    int? isShuf,
    int? isTop,
    String? matchManageId,
    int? noticeType,
    String? noticeTypeName,
    NoticeTypeNameDataNlMtlOrderInfo? orderInfo,
    String? searchKey,
    String? sendTime,
    String? sendTimeOther,
    String? title,
  }) {
    return NoticeTypeNameDataNlMtl()
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

NoticeTypeNameDataNlMtlOrderInfo $NoticeTypeNameDataNlMtlOrderInfoFromJson(
    Map<String, dynamic> json) {
  final NoticeTypeNameDataNlMtlOrderInfo noticeTypeNameDataNlMtlOrderInfo = NoticeTypeNameDataNlMtlOrderInfo();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    noticeTypeNameDataNlMtlOrderInfo.orderType = orderType;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    noticeTypeNameDataNlMtlOrderInfo.langCode = langCode;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    noticeTypeNameDataNlMtlOrderInfo.orderStatus = orderStatus;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    noticeTypeNameDataNlMtlOrderInfo.initPresettleWs = initPresettleWs;
  }
  final int? orderClass = jsonConvert.convert<int>(json['orderClass']);
  if (orderClass != null) {
    noticeTypeNameDataNlMtlOrderInfo.orderClass = orderClass;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    noticeTypeNameDataNlMtlOrderInfo.marketType = marketType;
  }
  final int? preBetAmount = jsonConvert.convert<int>(json['preBetAmount']);
  if (preBetAmount != null) {
    noticeTypeNameDataNlMtlOrderInfo.preBetAmount = preBetAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    noticeTypeNameDataNlMtlOrderInfo.modifyTime = modifyTime;
  }
  final String? orderClassStr = jsonConvert.convert<String>(
      json['orderClassStr']);
  if (orderClassStr != null) {
    noticeTypeNameDataNlMtlOrderInfo.orderClassStr = orderClassStr;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    noticeTypeNameDataNlMtlOrderInfo.enablePreSettle = enablePreSettle;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    noticeTypeNameDataNlMtlOrderInfo.modifyTimeStr = modifyTimeStr;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    noticeTypeNameDataNlMtlOrderInfo.seriesType = seriesType;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    noticeTypeNameDataNlMtlOrderInfo.seriesSum = seriesSum;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    noticeTypeNameDataNlMtlOrderInfo.orderAmountTotal = orderAmountTotal;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    noticeTypeNameDataNlMtlOrderInfo.beginTime = beginTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    noticeTypeNameDataNlMtlOrderInfo.id = id;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    noticeTypeNameDataNlMtlOrderInfo.addition = addition;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    noticeTypeNameDataNlMtlOrderInfo.betTimeStr = betTimeStr;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    noticeTypeNameDataNlMtlOrderInfo.orderNo = orderNo;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    noticeTypeNameDataNlMtlOrderInfo.maxWinAmount = maxWinAmount;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    noticeTypeNameDataNlMtlOrderInfo.preSettleBetAmount = preSettleBetAmount;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    noticeTypeNameDataNlMtlOrderInfo.managerCode = managerCode;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    noticeTypeNameDataNlMtlOrderInfo.betTime = betTime;
  }
  final List<
      NoticeTypeNameDataNlMtlOrderInfoDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<NoticeTypeNameDataNlMtlOrderInfoDetailList>(
          e) as NoticeTypeNameDataNlMtlOrderInfoDetailList).toList();
  if (detailList != null) {
    noticeTypeNameDataNlMtlOrderInfo.detailList = detailList;
  }
  final int? maxCashout = jsonConvert.convert<int>(json['maxCashout']);
  if (maxCashout != null) {
    noticeTypeNameDataNlMtlOrderInfo.maxCashout = maxCashout;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    noticeTypeNameDataNlMtlOrderInfo.seriesValue = seriesValue;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    noticeTypeNameDataNlMtlOrderInfo.settleType = settleType;
  }
  final String? matchIds = jsonConvert.convert<String>(json['matchIds']);
  if (matchIds != null) {
    noticeTypeNameDataNlMtlOrderInfo.matchIds = matchIds;
  }
  return noticeTypeNameDataNlMtlOrderInfo;
}

Map<String, dynamic> $NoticeTypeNameDataNlMtlOrderInfoToJson(
    NoticeTypeNameDataNlMtlOrderInfo entity) {
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

extension NoticeTypeNameDataNlMtlOrderInfoExtension on NoticeTypeNameDataNlMtlOrderInfo {
  NoticeTypeNameDataNlMtlOrderInfo copyWith({
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
    List<NoticeTypeNameDataNlMtlOrderInfoDetailList>? detailList,
    int? maxCashout,
    String? seriesValue,
    int? settleType,
    String? matchIds,
  }) {
    return NoticeTypeNameDataNlMtlOrderInfo()
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

NoticeTypeNameDataNlMtlOrderInfoDetailList $NoticeTypeNameDataNlMtlOrderInfoDetailListFromJson(
    Map<String, dynamic> json) {
  final NoticeTypeNameDataNlMtlOrderInfoDetailList noticeTypeNameDataNlMtlOrderInfoDetailList = NoticeTypeNameDataNlMtlOrderInfoDetailList();
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.betResult = betResult;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchPeriodId = matchPeriodId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchType = matchType;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchInfo = matchInfo;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.homeName = homeName;
  }
  final String? extJson = jsonConvert.convert<String>(json['extJson']);
  if (extJson != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.extJson = extJson;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchManageType =
        matchManageType;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.dataSourceCode = dataSourceCode;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.eov = eov;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.marketType = marketType;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.playOptionName = playOptionName;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.playOptionsId = playOptionsId;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.score = score;
  }
  final String? closingTime = jsonConvert.convert<String>(json['closingTime']);
  if (closingTime != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.closingTime = closingTime;
  }
  final String? thirdMatchId = jsonConvert.convert<String>(
      json['thirdMatchId']);
  if (thirdMatchId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.thirdMatchId = thirdMatchId;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.tournamentId = tournamentId;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.oddsValue = oddsValue;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.beginTime = beginTime;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchTestScore = matchTestScore;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.tournamentPic = tournamentPic;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.betNo = betNo;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.playName = playName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchOver = matchOver;
  }
  final int? matchProcessId = jsonConvert.convert<int>(json['matchProcessId']);
  if (matchProcessId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchProcessId = matchProcessId;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.oddFinally = oddFinally;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.awayName = awayName;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.betAmount = betAmount;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.sportName = sportName;
  }
  final String? childPlayId = jsonConvert.convert<String>(json['childPlayId']);
  if (childPlayId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.childPlayId = childPlayId;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.cancelType = cancelType;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.marketId = marketId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.playId = playId;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchId = matchId;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchName = matchName;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.marketValue = marketValue;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.betStatus = betStatus;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.matchVideoTag = matchVideoTag;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.playOptions = playOptions;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.sportId = sportId;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.settleScore = settleScore;
  }
  final int? tournamentLevel = jsonConvert.convert<int>(
      json['tournamentLevel']);
  if (tournamentLevel != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.tournamentLevel =
        tournamentLevel;
  }
  final String? originalMarketValue = jsonConvert.convert<String>(
      json['originalMarketValue']);
  if (originalMarketValue != null) {
    noticeTypeNameDataNlMtlOrderInfoDetailList.originalMarketValue =
        originalMarketValue;
  }
  return noticeTypeNameDataNlMtlOrderInfoDetailList;
}

Map<String, dynamic> $NoticeTypeNameDataNlMtlOrderInfoDetailListToJson(
    NoticeTypeNameDataNlMtlOrderInfoDetailList entity) {
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

extension NoticeTypeNameDataNlMtlOrderInfoDetailListExtension on NoticeTypeNameDataNlMtlOrderInfoDetailList {
  NoticeTypeNameDataNlMtlOrderInfoDetailList copyWith({
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
    return NoticeTypeNameDataNlMtlOrderInfoDetailList()
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