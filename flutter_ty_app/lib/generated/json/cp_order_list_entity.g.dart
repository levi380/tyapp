import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_order_list_entity.dart';

CpOrderListEntity $CpOrderListEntityFromJson(Map<String, dynamic> json) {
  final CpOrderListEntity cpOrderListEntity = CpOrderListEntity();
  final double? total = jsonConvert.convert<double>(json['total']);
  if (total != null) {
    cpOrderListEntity.total = total;
  }
  final double? totalBetAmount = jsonConvert.convert<double>(
      json['totalBetAmount']);
  if (totalBetAmount != null) {
    cpOrderListEntity.totalBetAmount = totalBetAmount;
  }
  final double? totalValidBetAmount = jsonConvert.convert<double>(
      json['totalValidBetAmount']);
  if (totalValidBetAmount != null) {
    cpOrderListEntity.totalValidBetAmount = totalValidBetAmount;
  }
  final double? totalWinAmount = jsonConvert.convert<double>(
      json['totalWinAmount']);
  if (totalWinAmount != null) {
    cpOrderListEntity.totalWinAmount = totalWinAmount;
  }
  final dynamic totalCanWinAmount = json['totalCanWinAmount'];
  if (totalCanWinAmount != null) {
    cpOrderListEntity.totalCanWinAmount = totalCanWinAmount;
  }
  final List<CpOrderListList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CpOrderListList>(e) as CpOrderListList)
      .toList();
  if (list != null) {
    cpOrderListEntity.list = list;
  }
  return cpOrderListEntity;
}

Map<String, dynamic> $CpOrderListEntityToJson(CpOrderListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalBetAmount'] = entity.totalBetAmount;
  data['totalValidBetAmount'] = entity.totalValidBetAmount;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['totalCanWinAmount'] = entity.totalCanWinAmount;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension CpOrderListEntityExtension on CpOrderListEntity {
  CpOrderListEntity copyWith({
    double? total,
    double? totalBetAmount,
    double? totalValidBetAmount,
    double? totalWinAmount,
    dynamic totalCanWinAmount,
    List<CpOrderListList>? list,
  }) {
    return CpOrderListEntity()
      ..total = total ?? this.total
      ..totalBetAmount = totalBetAmount ?? this.totalBetAmount
      ..totalValidBetAmount = totalValidBetAmount ?? this.totalValidBetAmount
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..totalCanWinAmount = totalCanWinAmount ?? this.totalCanWinAmount
      ..list = list ?? this.list;
  }
}

CpOrderListList $CpOrderListListFromJson(Map<String, dynamic> json) {
  final CpOrderListList cpOrderListList = CpOrderListList();
  final String? chaseId = jsonConvert.convert<String>(json['chaseId']);
  if (chaseId != null) {
    cpOrderListList.chaseId = chaseId;
  }
  final String? orderId = jsonConvert.convert<String>(json['orderId']);
  if (orderId != null) {
    cpOrderListList.orderId = orderId;
  }
  final String? chasePlanId = jsonConvert.convert<String>(json['chasePlanId']);
  if (chasePlanId != null) {
    cpOrderListList.chasePlanId = chasePlanId;
  }
  final int? chaseOrderStatus = jsonConvert.convert<int>(
      json['chaseOrderStatus']);
  if (chaseOrderStatus != null) {
    cpOrderListList.chaseOrderStatus = chaseOrderStatus;
  }
  final double? finishAmount = jsonConvert.convert<double>(
      json['finishAmount']);
  if (finishAmount != null) {
    cpOrderListList.finishAmount = finishAmount;
  }
  final int? totalPlanNoCount = jsonConvert.convert<int>(
      json['totalPlanNoCount']);
  if (totalPlanNoCount != null) {
    cpOrderListList.totalPlanNoCount = totalPlanNoCount;
  }
  final String? startTicketPlanNo = jsonConvert.convert<String>(
      json['startTicketPlanNo']);
  if (startTicketPlanNo != null) {
    cpOrderListList.startTicketPlanNo = startTicketPlanNo;
  }
  final String? ticketPlanNo = jsonConvert.convert<String>(
      json['ticketPlanNo']);
  if (ticketPlanNo != null) {
    cpOrderListList.ticketPlanNo = ticketPlanNo;
  }
  final double? totalWinAmount = jsonConvert.convert<double>(
      json['totalWinAmount']);
  if (totalWinAmount != null) {
    cpOrderListList.totalWinAmount = totalWinAmount;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    cpOrderListList.type = type;
  }
  final String? odd = jsonConvert.convert<String>(json['odd']);
  if (odd != null) {
    cpOrderListList.odd = odd;
  }
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    cpOrderListList.uid = uid;
  }
  final int? finishPlanNoCount = jsonConvert.convert<int>(
      json['finishPlanNoCount']);
  if (finishPlanNoCount != null) {
    cpOrderListList.finishPlanNoCount = finishPlanNoCount;
  }
  final int? createTime = jsonConvert.convert<int>(json['createTime']);
  if (createTime != null) {
    cpOrderListList.createTime = createTime;
  }
  final String? playLevel = jsonConvert.convert<String>(json['playLevel']);
  if (playLevel != null) {
    cpOrderListList.playLevel = playLevel;
  }
  final int? cancelPlanNoCount = jsonConvert.convert<int>(
      json['cancelPlanNoCount']);
  if (cancelPlanNoCount != null) {
    cpOrderListList.cancelPlanNoCount = cancelPlanNoCount;
  }
  final double? totalValidBetAmount = jsonConvert.convert<double>(
      json['totalValidBetAmount']);
  if (totalValidBetAmount != null) {
    cpOrderListList.totalValidBetAmount = totalValidBetAmount;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    cpOrderListList.betTime = betTime;
  }
  final double? cancelWinAmount = jsonConvert.convert<double>(
      json['cancelWinAmount']);
  if (cancelWinAmount != null) {
    cpOrderListList.cancelWinAmount = cancelWinAmount;
  }
  final int? winAmountPlanNoCount = jsonConvert.convert<int>(
      json['winAmountPlanNoCount']);
  if (winAmountPlanNoCount != null) {
    cpOrderListList.winAmountPlanNoCount = winAmountPlanNoCount;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    cpOrderListList.betStatus = betStatus;
  }
  final double? totalBetAmount = jsonConvert.convert<double>(
      json['totalBetAmount']);
  if (totalBetAmount != null) {
    cpOrderListList.totalBetAmount = totalBetAmount;
  }
  final double? betMoney = jsonConvert.convert<double>(json['betMoney']);
  if (betMoney != null) {
    cpOrderListList.betMoney = betMoney;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    cpOrderListList.maxWinAmount = maxWinAmount;
  }
  final String? betContent = jsonConvert.convert<String>(json['betContent']);
  if (betContent != null) {
    cpOrderListList.betContent = betContent;
  }
  final String? ticketName = jsonConvert.convert<String>(json['ticketName']);
  if (ticketName != null) {
    cpOrderListList.ticketName = ticketName;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    cpOrderListList.playName = playName;
  }
  return cpOrderListList;
}

Map<String, dynamic> $CpOrderListListToJson(CpOrderListList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['chaseId'] = entity.chaseId;
  data['orderId'] = entity.orderId;
  data['chasePlanId'] = entity.chasePlanId;
  data['chaseOrderStatus'] = entity.chaseOrderStatus;
  data['finishAmount'] = entity.finishAmount;
  data['totalPlanNoCount'] = entity.totalPlanNoCount;
  data['startTicketPlanNo'] = entity.startTicketPlanNo;
  data['ticketPlanNo'] = entity.ticketPlanNo;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['type'] = entity.type;
  data['odd'] = entity.odd;
  data['uid'] = entity.uid;
  data['finishPlanNoCount'] = entity.finishPlanNoCount;
  data['createTime'] = entity.createTime;
  data['playLevel'] = entity.playLevel;
  data['cancelPlanNoCount'] = entity.cancelPlanNoCount;
  data['totalValidBetAmount'] = entity.totalValidBetAmount;
  data['betTime'] = entity.betTime;
  data['cancelWinAmount'] = entity.cancelWinAmount;
  data['winAmountPlanNoCount'] = entity.winAmountPlanNoCount;
  data['betStatus'] = entity.betStatus;
  data['totalBetAmount'] = entity.totalBetAmount;
  data['betMoney'] = entity.betMoney;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['betContent'] = entity.betContent;
  data['ticketName'] = entity.ticketName;
  data['playName'] = entity.playName;
  return data;
}

extension CpOrderListListExtension on CpOrderListList {
  CpOrderListList copyWith({
    String? chaseId,
    String? orderId,
    String? chasePlanId,
    int? chaseOrderStatus,
    double? finishAmount,
    int? totalPlanNoCount,
    String? startTicketPlanNo,
    String? ticketPlanNo,
    double? totalWinAmount,
    String? type,
    String? odd,
    String? uid,
    int? finishPlanNoCount,
    int? createTime,
    String? playLevel,
    int? cancelPlanNoCount,
    double? totalValidBetAmount,
    String? betTime,
    double? cancelWinAmount,
    int? winAmountPlanNoCount,
    int? betStatus,
    double? totalBetAmount,
    double? betMoney,
    double? maxWinAmount,
    String? betContent,
    String? ticketName,
    String? playName,
    bool? isExpand,
  }) {
    return CpOrderListList()
      ..chaseId = chaseId ?? this.chaseId
      ..orderId = orderId ?? this.orderId
      ..chasePlanId = chasePlanId ?? this.chasePlanId
      ..chaseOrderStatus = chaseOrderStatus ?? this.chaseOrderStatus
      ..finishAmount = finishAmount ?? this.finishAmount
      ..totalPlanNoCount = totalPlanNoCount ?? this.totalPlanNoCount
      ..startTicketPlanNo = startTicketPlanNo ?? this.startTicketPlanNo
      ..ticketPlanNo = ticketPlanNo ?? this.ticketPlanNo
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..type = type ?? this.type
      ..odd = odd ?? this.odd
      ..uid = uid ?? this.uid
      ..finishPlanNoCount = finishPlanNoCount ?? this.finishPlanNoCount
      ..createTime = createTime ?? this.createTime
      ..playLevel = playLevel ?? this.playLevel
      ..cancelPlanNoCount = cancelPlanNoCount ?? this.cancelPlanNoCount
      ..totalValidBetAmount = totalValidBetAmount ?? this.totalValidBetAmount
      ..betTime = betTime ?? this.betTime
      ..cancelWinAmount = cancelWinAmount ?? this.cancelWinAmount
      ..winAmountPlanNoCount = winAmountPlanNoCount ?? this.winAmountPlanNoCount
      ..betStatus = betStatus ?? this.betStatus
      ..totalBetAmount = totalBetAmount ?? this.totalBetAmount
      ..betMoney = betMoney ?? this.betMoney
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..betContent = betContent ?? this.betContent
      ..ticketName = ticketName ?? this.ticketName
      ..playName = playName ?? this.playName
      ..isExpand = isExpand ?? this.isExpand;
  }
}