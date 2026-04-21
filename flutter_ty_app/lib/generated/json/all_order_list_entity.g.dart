import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/all_order_list_entity.dart';

AllOrderListEntity $AllOrderListEntityFromJson(Map<String, dynamic> json) {
  final AllOrderListEntity allOrderListEntity = AllOrderListEntity();
  final List<AllOrderListList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<AllOrderListList>(e) as AllOrderListList)
      .toList();
  if (list != null) {
    allOrderListEntity.list = list;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    allOrderListEntity.total = total;
  }
  return allOrderListEntity;
}

Map<String, dynamic> $AllOrderListEntityToJson(AllOrderListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  return data;
}

extension AllOrderListEntityExtension on AllOrderListEntity {
  AllOrderListEntity copyWith({
    List<AllOrderListList>? list,
    String? total,
  }) {
    return AllOrderListEntity()
      ..list = list ?? this.list
      ..total = total ?? this.total;
  }
}

AllOrderListList $AllOrderListListFromJson(Map<String, dynamic> json) {
  final AllOrderListList allOrderListList = AllOrderListList();
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    allOrderListList.betAmount = betAmount;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    allOrderListList.betTime = betTime;
  }
  final String? maxWinAmount = jsonConvert.convert<String>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    allOrderListList.maxWinAmount = maxWinAmount;
  }
  final AllOrderListListOrderCashOutInVO? orderCashOutInVO = jsonConvert
      .convert<AllOrderListListOrderCashOutInVO>(json['orderCashOutInVO']);
  if (orderCashOutInVO != null) {
    allOrderListList.orderCashOutInVO = orderCashOutInVO;
  }
  final List<
      AllOrderListListOrderMixExtendVOList>? orderMixExtendVOList = (json['orderMixExtendVOList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<AllOrderListListOrderMixExtendVOList>(
          e) as AllOrderListListOrderMixExtendVOList).toList();
  if (orderMixExtendVOList != null) {
    allOrderListList.orderMixExtendVOList = orderMixExtendVOList;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    allOrderListList.orderNo = orderNo;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    allOrderListList.orderStatus = orderStatus;
  }
  final String? orderType = jsonConvert.convert<String>(json['orderType']);
  if (orderType != null) {
    allOrderListList.orderType = orderType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    allOrderListList.seriesValue = seriesValue;
  }
  return allOrderListList;
}

Map<String, dynamic> $AllOrderListListToJson(AllOrderListList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['betTime'] = entity.betTime;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['orderCashOutInVO'] = entity.orderCashOutInVO?.toJson();
  data['orderMixExtendVOList'] =
      entity.orderMixExtendVOList.map((v) => v.toJson()).toList();
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['orderType'] = entity.orderType;
  data['seriesValue'] = entity.seriesValue;
  return data;
}

extension AllOrderListListExtension on AllOrderListList {
  AllOrderListList copyWith({
    String? betAmount,
    String? betTime,
    String? maxWinAmount,
    AllOrderListListOrderCashOutInVO? orderCashOutInVO,
    List<AllOrderListListOrderMixExtendVOList>? orderMixExtendVOList,
    String? orderNo,
    int? orderStatus,
    String? orderType,
    String? seriesValue,
  }) {
    return AllOrderListList()
      ..betAmount = betAmount ?? this.betAmount
      ..betTime = betTime ?? this.betTime
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..orderCashOutInVO = orderCashOutInVO ?? this.orderCashOutInVO
      ..orderMixExtendVOList = orderMixExtendVOList ?? this.orderMixExtendVOList
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderType = orderType ?? this.orderType
      ..seriesValue = seriesValue ?? this.seriesValue;
  }
}

AllOrderListListOrderMixExtendVOList $AllOrderListListOrderMixExtendVOListFromJson(
    Map<String, dynamic> json) {
  final AllOrderListListOrderMixExtendVOList allOrderListListOrderMixExtendVOList = AllOrderListListOrderMixExtendVOList();
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    allOrderListListOrderMixExtendVOList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    allOrderListListOrderMixExtendVOList.marketValue = marketValue;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    allOrderListListOrderMixExtendVOList.matchInfo = matchInfo;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    allOrderListListOrderMixExtendVOList.matchName = matchName;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    allOrderListListOrderMixExtendVOList.matchType = matchType;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    allOrderListListOrderMixExtendVOList.matchId = matchId;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    allOrderListListOrderMixExtendVOList.playId = playId;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    allOrderListListOrderMixExtendVOList.playOptionsId = playOptionsId;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    allOrderListListOrderMixExtendVOList.odds = odds;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    allOrderListListOrderMixExtendVOList.playName = playName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    allOrderListListOrderMixExtendVOList.playOptions = playOptions;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    allOrderListListOrderMixExtendVOList.scoreBenchmark = scoreBenchmark;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    allOrderListListOrderMixExtendVOList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    allOrderListListOrderMixExtendVOList.sportName = sportName;
  }
  final String? betContent = jsonConvert.convert<String>(json['betContent']);
  if (betContent != null) {
    allOrderListListOrderMixExtendVOList.betContent = betContent;
  }
  final String? ticketName = jsonConvert.convert<String>(json['ticketName']);
  if (ticketName != null) {
    allOrderListListOrderMixExtendVOList.ticketName = ticketName;
  }
  final String? ticketPlanNo = jsonConvert.convert<String>(
      json['ticketPlanNo']);
  if (ticketPlanNo != null) {
    allOrderListListOrderMixExtendVOList.ticketPlanNo = ticketPlanNo;
  }
  final String? startTicketPlanNo = jsonConvert.convert<String>(
      json['startTicketPlanNo']);
  if (startTicketPlanNo != null) {
    allOrderListListOrderMixExtendVOList.startTicketPlanNo = startTicketPlanNo;
  }
  final String? tableName = jsonConvert.convert<String>(json['tableName']);
  if (tableName != null) {
    allOrderListListOrderMixExtendVOList.tableName = tableName;
  }
  final int? totalWinAmount = jsonConvert.convert<int>(json['totalWinAmount']);
  if (totalWinAmount != null) {
    allOrderListListOrderMixExtendVOList.totalWinAmount = totalWinAmount;
  }
  final int? finishPlanNoCount = jsonConvert.convert<int>(
      json['finishPlanNoCount']);
  if (finishPlanNoCount != null) {
    allOrderListListOrderMixExtendVOList.finishPlanNoCount = finishPlanNoCount;
  }
  final int? cancelPlanNoCount = jsonConvert.convert<int>(
      json['cancelPlanNoCount']);
  if (cancelPlanNoCount != null) {
    allOrderListListOrderMixExtendVOList.cancelPlanNoCount = cancelPlanNoCount;
  }
  final double? finishAmount = jsonConvert.convert<double>(
      json['finishAmount']);
  if (finishAmount != null) {
    allOrderListListOrderMixExtendVOList.finishAmount = finishAmount;
  }
  final int? cancelWinAmount = jsonConvert.convert<int>(
      json['cancelWinAmount']);
  if (cancelWinAmount != null) {
    allOrderListListOrderMixExtendVOList.cancelWinAmount = cancelWinAmount;
  }
  final String? playLevel = jsonConvert.convert<String>(json['playLevel']);
  if (playLevel != null) {
    allOrderListListOrderMixExtendVOList.playLevel = playLevel;
  }
  final String? gameName = jsonConvert.convert<String>(json['gameName']);
  if (gameName != null) {
    allOrderListListOrderMixExtendVOList.gameName = gameName;
  }
  final int? winAmountPlanNoCount = jsonConvert.convert<int>(
      json['winAmountPlanNoCount']);
  if (winAmountPlanNoCount != null) {
    allOrderListListOrderMixExtendVOList.winAmountPlanNoCount =
        winAmountPlanNoCount;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    allOrderListListOrderMixExtendVOList.beginTime = beginTime;
  }
  final String? eov = jsonConvert.convert<String>(json['eov']);
  if (eov != null) {
    allOrderListListOrderMixExtendVOList.eov = eov;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    allOrderListListOrderMixExtendVOList.batchNo = batchNo;
  }
  return allOrderListListOrderMixExtendVOList;
}

Map<String, dynamic> $AllOrderListListOrderMixExtendVOListToJson(
    AllOrderListListOrderMixExtendVOList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchInfo'] = entity.matchInfo;
  data['matchName'] = entity.matchName;
  data['matchType'] = entity.matchType;
  data['matchId'] = entity.matchId;
  data['playId'] = entity.playId;
  data['playOptionsId'] = entity.playOptionsId;
  data['odds'] = entity.odds;
  data['playName'] = entity.playName;
  data['playOptions'] = entity.playOptions;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['sportId'] = entity.sportId;
  data['sportName'] = entity.sportName;
  data['betContent'] = entity.betContent;
  data['ticketName'] = entity.ticketName;
  data['ticketPlanNo'] = entity.ticketPlanNo;
  data['startTicketPlanNo'] = entity.startTicketPlanNo;
  data['tableName'] = entity.tableName;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['finishPlanNoCount'] = entity.finishPlanNoCount;
  data['cancelPlanNoCount'] = entity.cancelPlanNoCount;
  data['finishAmount'] = entity.finishAmount;
  data['cancelWinAmount'] = entity.cancelWinAmount;
  data['playLevel'] = entity.playLevel;
  data['gameName'] = entity.gameName;
  data['winAmountPlanNoCount'] = entity.winAmountPlanNoCount;
  data['beginTime'] = entity.beginTime;
  data['eov'] = entity.eov;
  data['batchNo'] = entity.batchNo;
  return data;
}

extension AllOrderListListOrderMixExtendVOListExtension on AllOrderListListOrderMixExtendVOList {
  AllOrderListListOrderMixExtendVOList copyWith({
    String? marketType,
    String? marketValue,
    String? matchInfo,
    String? matchName,
    int? matchType,
    String? matchId,
    int? playId,
    String? playOptionsId,
    String? odds,
    String? playName,
    String? playOptions,
    String? scoreBenchmark,
    int? sportId,
    String? sportName,
    String? betContent,
    String? ticketName,
    String? ticketPlanNo,
    String? startTicketPlanNo,
    String? tableName,
    int? totalWinAmount,
    int? finishPlanNoCount,
    int? cancelPlanNoCount,
    double? finishAmount,
    int? cancelWinAmount,
    String? playLevel,
    String? gameName,
    int? winAmountPlanNoCount,
    String? beginTime,
    String? eov,
    String? batchNo,
  }) {
    return AllOrderListListOrderMixExtendVOList()
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchName = matchName ?? this.matchName
      ..matchType = matchType ?? this.matchType
      ..matchId = matchId ?? this.matchId
      ..playId = playId ?? this.playId
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..odds = odds ?? this.odds
      ..playName = playName ?? this.playName
      ..playOptions = playOptions ?? this.playOptions
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..sportId = sportId ?? this.sportId
      ..sportName = sportName ?? this.sportName
      ..betContent = betContent ?? this.betContent
      ..ticketName = ticketName ?? this.ticketName
      ..ticketPlanNo = ticketPlanNo ?? this.ticketPlanNo
      ..startTicketPlanNo = startTicketPlanNo ?? this.startTicketPlanNo
      ..tableName = tableName ?? this.tableName
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..finishPlanNoCount = finishPlanNoCount ?? this.finishPlanNoCount
      ..cancelPlanNoCount = cancelPlanNoCount ?? this.cancelPlanNoCount
      ..finishAmount = finishAmount ?? this.finishAmount
      ..cancelWinAmount = cancelWinAmount ?? this.cancelWinAmount
      ..playLevel = playLevel ?? this.playLevel
      ..gameName = gameName ?? this.gameName
      ..winAmountPlanNoCount = winAmountPlanNoCount ?? this.winAmountPlanNoCount
      ..beginTime = beginTime ?? this.beginTime
      ..eov = eov ?? this.eov
      ..batchNo = batchNo ?? this.batchNo;
  }
}

AllOrderListListOrderCashOutInVO $AllOrderListListOrderCashOutInVOFromJson(
    Map<String, dynamic> json) {
  final AllOrderListListOrderCashOutInVO allOrderListListOrderCashOutInVO = AllOrderListListOrderCashOutInVO();
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    allOrderListListOrderCashOutInVO.enablePreSettle = enablePreSettle;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    allOrderListListOrderCashOutInVO.initPresettleWs = initPresettleWs;
  }
  final double? maxCashout = jsonConvert.convert<double>(json['maxCashout']);
  if (maxCashout != null) {
    allOrderListListOrderCashOutInVO.maxCashout = maxCashout;
  }
  final double? preBetAmount = jsonConvert.convert<double>(
      json['preBetAmount']);
  if (preBetAmount != null) {
    allOrderListListOrderCashOutInVO.preBetAmount = preBetAmount;
  }
  final String? preOrderNo = jsonConvert.convert<String>(json['preOrderNo']);
  if (preOrderNo != null) {
    allOrderListListOrderCashOutInVO.preOrderNo = preOrderNo;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    allOrderListListOrderCashOutInVO.preSettle = preSettle;
  }
  final double? preSettleBetAmount = jsonConvert.convert<double>(
      json['preSettleBetAmount']);
  if (preSettleBetAmount != null) {
    allOrderListListOrderCashOutInVO.preSettleBetAmount = preSettleBetAmount;
  }
  return allOrderListListOrderCashOutInVO;
}

Map<String, dynamic> $AllOrderListListOrderCashOutInVOToJson(
    AllOrderListListOrderCashOutInVO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enablePreSettle'] = entity.enablePreSettle;
  data['initPresettleWs'] = entity.initPresettleWs;
  data['maxCashout'] = entity.maxCashout;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrderNo'] = entity.preOrderNo;
  data['preSettle'] = entity.preSettle;
  data['preSettleBetAmount'] = entity.preSettleBetAmount;
  return data;
}

extension AllOrderListListOrderCashOutInVOExtension on AllOrderListListOrderCashOutInVO {
  AllOrderListListOrderCashOutInVO copyWith({
    bool? enablePreSettle,
    bool? initPresettleWs,
    double? maxCashout,
    double? preBetAmount,
    String? preOrderNo,
    dynamic preSettle,
    double? preSettleBetAmount,
  }) {
    return AllOrderListListOrderCashOutInVO()
      ..enablePreSettle = enablePreSettle ?? this.enablePreSettle
      ..initPresettleWs = initPresettleWs ?? this.initPresettleWs
      ..maxCashout = maxCashout ?? this.maxCashout
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrderNo = preOrderNo ?? this.preOrderNo
      ..preSettle = preSettle ?? this.preSettle
      ..preSettleBetAmount = preSettleBetAmount ?? this.preSettleBetAmount;
  }
}