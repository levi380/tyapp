import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_cp_list_entry_entity.dart';

GetOrderCpListEntryEntity $GetOrderCpListEntryEntityFromJson(
    Map<String, dynamic> json) {
  final GetOrderCpListEntryEntity getOrderCpListEntryEntity = GetOrderCpListEntryEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    getOrderCpListEntryEntity.total = total;
  }
  final double? totalBetAmount = jsonConvert.convert<double>(
      json['totalBetAmount']);
  if (totalBetAmount != null) {
    getOrderCpListEntryEntity.totalBetAmount = totalBetAmount;
  }
  final double? totalValidBetAmount = jsonConvert.convert<double>(
      json['totalValidBetAmount']);
  if (totalValidBetAmount != null) {
    getOrderCpListEntryEntity.totalValidBetAmount = totalValidBetAmount;
  }
  final double? totalWinAmount = jsonConvert.convert<double>(
      json['totalWinAmount']);
  if (totalWinAmount != null) {
    getOrderCpListEntryEntity.totalWinAmount = totalWinAmount;
  }
  final double? totalCanWinAmount = jsonConvert.convert<double>(
      json['totalCanWinAmount']);
  if (totalCanWinAmount != null) {
    getOrderCpListEntryEntity.totalCanWinAmount = totalCanWinAmount;
  }
  final List<GetOrderCpListEntryList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetOrderCpListEntryList>(
          e) as GetOrderCpListEntryList)
      .toList();
  if (list != null) {
    getOrderCpListEntryEntity.list = list;
  }
  return getOrderCpListEntryEntity;
}

Map<String, dynamic> $GetOrderCpListEntryEntityToJson(
    GetOrderCpListEntryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalBetAmount'] = entity.totalBetAmount;
  data['totalValidBetAmount'] = entity.totalValidBetAmount;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['totalCanWinAmount'] = entity.totalCanWinAmount;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension GetOrderCpListEntryEntityExtension on GetOrderCpListEntryEntity {
  GetOrderCpListEntryEntity copyWith({
    int? total,
    double? totalBetAmount,
    double? totalValidBetAmount,
    double? totalWinAmount,
    double? totalCanWinAmount,
    List<GetOrderCpListEntryList>? list,
  }) {
    return GetOrderCpListEntryEntity()
      ..total = total ?? this.total
      ..totalBetAmount = totalBetAmount ?? this.totalBetAmount
      ..totalValidBetAmount = totalValidBetAmount ?? this.totalValidBetAmount
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..totalCanWinAmount = totalCanWinAmount ?? this.totalCanWinAmount
      ..list = list ?? this.list;
  }
}

GetOrderCpListEntryList $GetOrderCpListEntryListFromJson(
    Map<String, dynamic> json) {
  final GetOrderCpListEntryList getOrderCpListEntryList = GetOrderCpListEntryList();
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    getOrderCpListEntryList.uid = uid;
  }
  final String? orderId = jsonConvert.convert<String>(json['orderId']);
  if (orderId != null) {
    getOrderCpListEntryList.orderId = orderId;
  }
  final String? playId = jsonConvert.convert<String>(json['playId']);
  if (playId != null) {
    getOrderCpListEntryList.playId = playId;
  }
  final String? playItemId = jsonConvert.convert<String>(json['playItemId']);
  if (playItemId != null) {
    getOrderCpListEntryList.playItemId = playItemId;
  }
  final int? ticketId = jsonConvert.convert<int>(json['ticketId']);
  if (ticketId != null) {
    getOrderCpListEntryList.ticketId = ticketId;
  }
  final String? playLevelId = jsonConvert.convert<String>(json['playLevelId']);
  if (playLevelId != null) {
    getOrderCpListEntryList.playLevelId = playLevelId;
  }
  final String? ticketPlanNo = jsonConvert.convert<String>(
      json['ticketPlanNo']);
  if (ticketPlanNo != null) {
    getOrderCpListEntryList.ticketPlanNo = ticketPlanNo;
  }
  final String? memberId = jsonConvert.convert<String>(json['memberId']);
  if (memberId != null) {
    getOrderCpListEntryList.memberId = memberId;
  }
  final double? betMoney = jsonConvert.convert<double>(json['betMoney']);
  if (betMoney != null) {
    getOrderCpListEntryList.betMoney = betMoney;
  }
  final int? validBetMoney = jsonConvert.convert<int>(json['validBetMoney']);
  if (validBetMoney != null) {
    getOrderCpListEntryList.validBetMoney = validBetMoney;
  }
  final String? betNum = jsonConvert.convert<String>(json['betNum']);
  if (betNum != null) {
    getOrderCpListEntryList.betNum = betNum;
  }
  final int? seriesId = jsonConvert.convert<int>(json['seriesId']);
  if (seriesId != null) {
    getOrderCpListEntryList.seriesId = seriesId;
  }
  final String? seriesName = jsonConvert.convert<String>(json['seriesName']);
  if (seriesName != null) {
    getOrderCpListEntryList.seriesName = seriesName;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getOrderCpListEntryList.betTime = betTime;
  }
  final int? betNums = jsonConvert.convert<int>(json['betNums']);
  if (betNums != null) {
    getOrderCpListEntryList.betNums = betNums;
  }
  final int? betMultiple = jsonConvert.convert<int>(json['betMultiple']);
  if (betMultiple != null) {
    getOrderCpListEntryList.betMultiple = betMultiple;
  }
  final dynamic betPointId = json['betPointId'];
  if (betPointId != null) {
    getOrderCpListEntryList.betPointId = betPointId;
  }
  final double? betModel = jsonConvert.convert<double>(json['betModel']);
  if (betModel != null) {
    getOrderCpListEntryList.betModel = betModel;
  }
  final double? betRebate = jsonConvert.convert<double>(json['betRebate']);
  if (betRebate != null) {
    getOrderCpListEntryList.betRebate = betRebate;
  }
  final String? betPrize = jsonConvert.convert<String>(json['betPrize']);
  if (betPrize != null) {
    getOrderCpListEntryList.betPrize = betPrize;
  }
  final String? odd = jsonConvert.convert<String>(json['odd']);
  if (odd != null) {
    getOrderCpListEntryList.odd = odd;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getOrderCpListEntryList.betStatus = betStatus;
  }
  final bool? cancelStatus = jsonConvert.convert<bool>(json['cancelStatus']);
  if (cancelStatus != null) {
    getOrderCpListEntryList.cancelStatus = cancelStatus;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getOrderCpListEntryList.cancelType = cancelType;
  }
  final int? riskStatus = jsonConvert.convert<int>(json['riskStatus']);
  if (riskStatus != null) {
    getOrderCpListEntryList.riskStatus = riskStatus;
  }
  final String? riskUnlockBy = jsonConvert.convert<String>(
      json['riskUnlockBy']);
  if (riskUnlockBy != null) {
    getOrderCpListEntryList.riskUnlockBy = riskUnlockBy;
  }
  final String? riskUnlockAt = jsonConvert.convert<String>(
      json['riskUnlockAt']);
  if (riskUnlockAt != null) {
    getOrderCpListEntryList.riskUnlockAt = riskUnlockAt;
  }
  final String? ticketName = jsonConvert.convert<String>(json['ticketName']);
  if (ticketName != null) {
    getOrderCpListEntryList.ticketName = ticketName;
  }
  final String? playLevel = jsonConvert.convert<String>(json['playLevel']);
  if (playLevel != null) {
    getOrderCpListEntryList.playLevel = playLevel;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getOrderCpListEntryList.playName = playName;
  }
  final String? betContent = jsonConvert.convert<String>(json['betContent']);
  if (betContent != null) {
    getOrderCpListEntryList.betContent = betContent;
  }
  final bool? singleGame = jsonConvert.convert<bool>(json['singleGame']);
  if (singleGame != null) {
    getOrderCpListEntryList.singleGame = singleGame;
  }
  final double? profitAmount = jsonConvert.convert<double>(
      json['profitAmount']);
  if (profitAmount != null) {
    getOrderCpListEntryList.profitAmount = profitAmount;
  }
  final String? baseRate = jsonConvert.convert<String>(json['baseRate']);
  if (baseRate != null) {
    getOrderCpListEntryList.baseRate = baseRate;
  }
  final String? bonusReduceRate = jsonConvert.convert<String>(
      json['bonusReduceRate']);
  if (bonusReduceRate != null) {
    getOrderCpListEntryList.bonusReduceRate = bonusReduceRate;
  }
  final bool? directlyMode = jsonConvert.convert<bool>(json['directlyMode']);
  if (directlyMode != null) {
    getOrderCpListEntryList.directlyMode = directlyMode;
  }
  final double? memberRebate = jsonConvert.convert<double>(
      json['memberRebate']);
  if (memberRebate != null) {
    getOrderCpListEntryList.memberRebate = memberRebate;
  }
  final String? ticketResult = jsonConvert.convert<String>(
      json['ticketResult']);
  if (ticketResult != null) {
    getOrderCpListEntryList.ticketResult = ticketResult;
  }
  final double? winAmount = jsonConvert.convert<double>(json['winAmount']);
  if (winAmount != null) {
    getOrderCpListEntryList.winAmount = winAmount;
  }
  final int? winNums = jsonConvert.convert<int>(json['winNums']);
  if (winNums != null) {
    getOrderCpListEntryList.winNums = winNums;
  }
  final bool? solo = jsonConvert.convert<bool>(json['solo']);
  if (solo != null) {
    getOrderCpListEntryList.solo = solo;
  }
  final String? chaseId = jsonConvert.convert<String>(json['chaseId']);
  if (chaseId != null) {
    getOrderCpListEntryList.chaseId = chaseId;
  }
  final String? chasePlanId = jsonConvert.convert<String>(json['chasePlanId']);
  if (chasePlanId != null) {
    getOrderCpListEntryList.chasePlanId = chasePlanId;
  }
  final int? groupMode = jsonConvert.convert<int>(json['groupMode']);
  if (groupMode != null) {
    getOrderCpListEntryList.groupMode = groupMode;
  }
  final int? device = jsonConvert.convert<int>(json['device']);
  if (device != null) {
    getOrderCpListEntryList.device = device;
  }
  final bool? seriesType = jsonConvert.convert<bool>(json['seriesType']);
  if (seriesType != null) {
    getOrderCpListEntryList.seriesType = seriesType;
  }
  final String? cancelBy = jsonConvert.convert<String>(json['cancelBy']);
  if (cancelBy != null) {
    getOrderCpListEntryList.cancelBy = cancelBy;
  }
  final String? cancelAt = jsonConvert.convert<String>(json['cancelAt']);
  if (cancelAt != null) {
    getOrderCpListEntryList.cancelAt = cancelAt;
  }
  final String? cancelDesc = jsonConvert.convert<String>(json['cancelDesc']);
  if (cancelDesc != null) {
    getOrderCpListEntryList.cancelDesc = cancelDesc;
  }
  final bool? tester = jsonConvert.convert<bool>(json['tester']);
  if (tester != null) {
    getOrderCpListEntryList.tester = tester;
  }
  final int? currencyType = jsonConvert.convert<int>(json['currencyType']);
  if (currencyType != null) {
    getOrderCpListEntryList.currencyType = currencyType;
  }
  final bool? chaseOrder = jsonConvert.convert<bool>(json['chaseOrder']);
  if (chaseOrder != null) {
    getOrderCpListEntryList.chaseOrder = chaseOrder;
  }
  final int? updateTime = jsonConvert.convert<int>(json['updateTime']);
  if (updateTime != null) {
    getOrderCpListEntryList.updateTime = updateTime;
  }
  final int? createTime = jsonConvert.convert<int>(json['createTime']);
  if (createTime != null) {
    getOrderCpListEntryList.createTime = createTime;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getOrderCpListEntryList.maxWinAmount = maxWinAmount;
  }
  return getOrderCpListEntryList;
}

Map<String, dynamic> $GetOrderCpListEntryListToJson(
    GetOrderCpListEntryList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['uid'] = entity.uid;
  data['orderId'] = entity.orderId;
  data['playId'] = entity.playId;
  data['playItemId'] = entity.playItemId;
  data['ticketId'] = entity.ticketId;
  data['playLevelId'] = entity.playLevelId;
  data['ticketPlanNo'] = entity.ticketPlanNo;
  data['memberId'] = entity.memberId;
  data['betMoney'] = entity.betMoney;
  data['validBetMoney'] = entity.validBetMoney;
  data['betNum'] = entity.betNum;
  data['seriesId'] = entity.seriesId;
  data['seriesName'] = entity.seriesName;
  data['betTime'] = entity.betTime;
  data['betNums'] = entity.betNums;
  data['betMultiple'] = entity.betMultiple;
  data['betPointId'] = entity.betPointId;
  data['betModel'] = entity.betModel;
  data['betRebate'] = entity.betRebate;
  data['betPrize'] = entity.betPrize;
  data['odd'] = entity.odd;
  data['betStatus'] = entity.betStatus;
  data['cancelStatus'] = entity.cancelStatus;
  data['cancelType'] = entity.cancelType;
  data['riskStatus'] = entity.riskStatus;
  data['riskUnlockBy'] = entity.riskUnlockBy;
  data['riskUnlockAt'] = entity.riskUnlockAt;
  data['ticketName'] = entity.ticketName;
  data['playLevel'] = entity.playLevel;
  data['playName'] = entity.playName;
  data['betContent'] = entity.betContent;
  data['singleGame'] = entity.singleGame;
  data['profitAmount'] = entity.profitAmount;
  data['baseRate'] = entity.baseRate;
  data['bonusReduceRate'] = entity.bonusReduceRate;
  data['directlyMode'] = entity.directlyMode;
  data['memberRebate'] = entity.memberRebate;
  data['ticketResult'] = entity.ticketResult;
  data['winAmount'] = entity.winAmount;
  data['winNums'] = entity.winNums;
  data['solo'] = entity.solo;
  data['chaseId'] = entity.chaseId;
  data['chasePlanId'] = entity.chasePlanId;
  data['groupMode'] = entity.groupMode;
  data['device'] = entity.device;
  data['seriesType'] = entity.seriesType;
  data['cancelBy'] = entity.cancelBy;
  data['cancelAt'] = entity.cancelAt;
  data['cancelDesc'] = entity.cancelDesc;
  data['tester'] = entity.tester;
  data['currencyType'] = entity.currencyType;
  data['chaseOrder'] = entity.chaseOrder;
  data['updateTime'] = entity.updateTime;
  data['createTime'] = entity.createTime;
  data['maxWinAmount'] = entity.maxWinAmount;
  return data;
}

extension GetOrderCpListEntryListExtension on GetOrderCpListEntryList {
  GetOrderCpListEntryList copyWith({
    String? uid,
    String? orderId,
    String? playId,
    String? playItemId,
    int? ticketId,
    String? playLevelId,
    String? ticketPlanNo,
    String? memberId,
    double? betMoney,
    int? validBetMoney,
    String? betNum,
    int? seriesId,
    String? seriesName,
    String? betTime,
    int? betNums,
    int? betMultiple,
    dynamic betPointId,
    double? betModel,
    double? betRebate,
    String? betPrize,
    String? odd,
    int? betStatus,
    bool? cancelStatus,
    int? cancelType,
    int? riskStatus,
    String? riskUnlockBy,
    String? riskUnlockAt,
    String? ticketName,
    String? playLevel,
    String? playName,
    String? betContent,
    bool? singleGame,
    double? profitAmount,
    String? baseRate,
    String? bonusReduceRate,
    bool? directlyMode,
    double? memberRebate,
    String? ticketResult,
    double? winAmount,
    int? winNums,
    bool? solo,
    String? chaseId,
    String? chasePlanId,
    int? groupMode,
    int? device,
    bool? seriesType,
    String? cancelBy,
    String? cancelAt,
    String? cancelDesc,
    bool? tester,
    int? currencyType,
    bool? chaseOrder,
    int? updateTime,
    int? createTime,
    double? maxWinAmount,
  }) {
    return GetOrderCpListEntryList()
      ..uid = uid ?? this.uid
      ..orderId = orderId ?? this.orderId
      ..playId = playId ?? this.playId
      ..playItemId = playItemId ?? this.playItemId
      ..ticketId = ticketId ?? this.ticketId
      ..playLevelId = playLevelId ?? this.playLevelId
      ..ticketPlanNo = ticketPlanNo ?? this.ticketPlanNo
      ..memberId = memberId ?? this.memberId
      ..betMoney = betMoney ?? this.betMoney
      ..validBetMoney = validBetMoney ?? this.validBetMoney
      ..betNum = betNum ?? this.betNum
      ..seriesId = seriesId ?? this.seriesId
      ..seriesName = seriesName ?? this.seriesName
      ..betTime = betTime ?? this.betTime
      ..betNums = betNums ?? this.betNums
      ..betMultiple = betMultiple ?? this.betMultiple
      ..betPointId = betPointId ?? this.betPointId
      ..betModel = betModel ?? this.betModel
      ..betRebate = betRebate ?? this.betRebate
      ..betPrize = betPrize ?? this.betPrize
      ..odd = odd ?? this.odd
      ..betStatus = betStatus ?? this.betStatus
      ..cancelStatus = cancelStatus ?? this.cancelStatus
      ..cancelType = cancelType ?? this.cancelType
      ..riskStatus = riskStatus ?? this.riskStatus
      ..riskUnlockBy = riskUnlockBy ?? this.riskUnlockBy
      ..riskUnlockAt = riskUnlockAt ?? this.riskUnlockAt
      ..ticketName = ticketName ?? this.ticketName
      ..playLevel = playLevel ?? this.playLevel
      ..playName = playName ?? this.playName
      ..betContent = betContent ?? this.betContent
      ..singleGame = singleGame ?? this.singleGame
      ..profitAmount = profitAmount ?? this.profitAmount
      ..baseRate = baseRate ?? this.baseRate
      ..bonusReduceRate = bonusReduceRate ?? this.bonusReduceRate
      ..directlyMode = directlyMode ?? this.directlyMode
      ..memberRebate = memberRebate ?? this.memberRebate
      ..ticketResult = ticketResult ?? this.ticketResult
      ..winAmount = winAmount ?? this.winAmount
      ..winNums = winNums ?? this.winNums
      ..solo = solo ?? this.solo
      ..chaseId = chaseId ?? this.chaseId
      ..chasePlanId = chasePlanId ?? this.chasePlanId
      ..groupMode = groupMode ?? this.groupMode
      ..device = device ?? this.device
      ..seriesType = seriesType ?? this.seriesType
      ..cancelBy = cancelBy ?? this.cancelBy
      ..cancelAt = cancelAt ?? this.cancelAt
      ..cancelDesc = cancelDesc ?? this.cancelDesc
      ..tester = tester ?? this.tester
      ..currencyType = currencyType ?? this.currencyType
      ..chaseOrder = chaseOrder ?? this.chaseOrder
      ..updateTime = updateTime ?? this.updateTime
      ..createTime = createTime ?? this.createTime
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount;
  }
}