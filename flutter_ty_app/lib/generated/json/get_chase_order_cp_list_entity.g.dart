import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_chase_order_cp_list_entity.dart';

GetChaseOrderCpListEntity $GetChaseOrderCpListEntityFromJson(
    Map<String, dynamic> json) {
  final GetChaseOrderCpListEntity getChaseOrderCpListEntity = GetChaseOrderCpListEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    getChaseOrderCpListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getChaseOrderCpListEntity.message = message;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getChaseOrderCpListEntity.code = code;
  }
  final GetChaseOrderCpListData? data = jsonConvert.convert<
      GetChaseOrderCpListData>(json['data']);
  if (data != null) {
    getChaseOrderCpListEntity.data = data;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    getChaseOrderCpListEntity.serverTime = serverTime;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getChaseOrderCpListEntity.msg = msg;
  }
  return getChaseOrderCpListEntity;
}

Map<String, dynamic> $GetChaseOrderCpListEntityToJson(
    GetChaseOrderCpListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['serverTime'] = entity.serverTime;
  data['msg'] = entity.msg;
  return data;
}

extension GetChaseOrderCpListEntityExtension on GetChaseOrderCpListEntity {
  GetChaseOrderCpListEntity copyWith({
    bool? status,
    String? message,
    String? code,
    GetChaseOrderCpListData? data,
    int? serverTime,
    String? msg,
  }) {
    return GetChaseOrderCpListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..serverTime = serverTime ?? this.serverTime
      ..msg = msg ?? this.msg;
  }
}

GetChaseOrderCpListData $GetChaseOrderCpListDataFromJson(
    Map<String, dynamic> json) {
  final GetChaseOrderCpListData getChaseOrderCpListData = GetChaseOrderCpListData();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    getChaseOrderCpListData.total = total;
  }
  final double? totalBetAmount = jsonConvert.convert<double>(
      json['totalBetAmount']);
  if (totalBetAmount != null) {
    getChaseOrderCpListData.totalBetAmount = totalBetAmount;
  }
  final double? totalValidBetAmount = jsonConvert.convert<double>(
      json['totalValidBetAmount']);
  if (totalValidBetAmount != null) {
    getChaseOrderCpListData.totalValidBetAmount = totalValidBetAmount;
  }
  final int? totalWinAmount = jsonConvert.convert<int>(json['totalWinAmount']);
  if (totalWinAmount != null) {
    getChaseOrderCpListData.totalWinAmount = totalWinAmount;
  }
  final dynamic totalCanWinAmount = json['totalCanWinAmount'];
  if (totalCanWinAmount != null) {
    getChaseOrderCpListData.totalCanWinAmount = totalCanWinAmount;
  }
  final List<GetChaseOrderCpListDataList>? list = (json['list'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetChaseOrderCpListDataList>(
          e) as GetChaseOrderCpListDataList).toList();
  if (list != null) {
    getChaseOrderCpListData.list = list;
  }
  return getChaseOrderCpListData;
}

Map<String, dynamic> $GetChaseOrderCpListDataToJson(
    GetChaseOrderCpListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalBetAmount'] = entity.totalBetAmount;
  data['totalValidBetAmount'] = entity.totalValidBetAmount;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['totalCanWinAmount'] = entity.totalCanWinAmount;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension GetChaseOrderCpListDataExtension on GetChaseOrderCpListData {
  GetChaseOrderCpListData copyWith({
    int? total,
    double? totalBetAmount,
    double? totalValidBetAmount,
    int? totalWinAmount,
    dynamic totalCanWinAmount,
    List<GetChaseOrderCpListDataList>? list,
  }) {
    return GetChaseOrderCpListData()
      ..total = total ?? this.total
      ..totalBetAmount = totalBetAmount ?? this.totalBetAmount
      ..totalValidBetAmount = totalValidBetAmount ?? this.totalValidBetAmount
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..totalCanWinAmount = totalCanWinAmount ?? this.totalCanWinAmount
      ..list = list ?? this.list;
  }
}

GetChaseOrderCpListDataList $GetChaseOrderCpListDataListFromJson(
    Map<String, dynamic> json) {
  final GetChaseOrderCpListDataList getChaseOrderCpListDataList = GetChaseOrderCpListDataList();
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    getChaseOrderCpListDataList.uid = uid;
  }
  final String? chaseId = jsonConvert.convert<String>(json['chaseId']);
  if (chaseId != null) {
    getChaseOrderCpListDataList.chaseId = chaseId;
  }
  final String? chasePlanId = jsonConvert.convert<String>(json['chasePlanId']);
  if (chasePlanId != null) {
    getChaseOrderCpListDataList.chasePlanId = chasePlanId;
  }
  final String? ticketName = jsonConvert.convert<String>(json['ticketName']);
  if (ticketName != null) {
    getChaseOrderCpListDataList.ticketName = ticketName;
  }
  final String? startTicketPlanNo = jsonConvert.convert<String>(
      json['startTicketPlanNo']);
  if (startTicketPlanNo != null) {
    getChaseOrderCpListDataList.startTicketPlanNo = startTicketPlanNo;
  }
  final String? playLevel = jsonConvert.convert<String>(json['playLevel']);
  if (playLevel != null) {
    getChaseOrderCpListDataList.playLevel = playLevel;
  }
  final String? odd = jsonConvert.convert<String>(json['odd']);
  if (odd != null) {
    getChaseOrderCpListDataList.odd = odd;
  }
  final int? totalPlanNoCount = jsonConvert.convert<int>(
      json['totalPlanNoCount']);
  if (totalPlanNoCount != null) {
    getChaseOrderCpListDataList.totalPlanNoCount = totalPlanNoCount;
  }
  final int? winAmountPlanNoCount = jsonConvert.convert<int>(
      json['winAmountPlanNoCount']);
  if (winAmountPlanNoCount != null) {
    getChaseOrderCpListDataList.winAmountPlanNoCount = winAmountPlanNoCount;
  }
  final int? finishPlanNoCount = jsonConvert.convert<int>(
      json['finishPlanNoCount']);
  if (finishPlanNoCount != null) {
    getChaseOrderCpListDataList.finishPlanNoCount = finishPlanNoCount;
  }
  final int? cancelPlanNoCount = jsonConvert.convert<int>(
      json['cancelPlanNoCount']);
  if (cancelPlanNoCount != null) {
    getChaseOrderCpListDataList.cancelPlanNoCount = cancelPlanNoCount;
  }
  final double? totalBetAmount = jsonConvert.convert<double>(
      json['totalBetAmount']);
  if (totalBetAmount != null) {
    getChaseOrderCpListDataList.totalBetAmount = totalBetAmount;
  }
  final double? totalValidBetAmount = jsonConvert.convert<double>(
      json['totalValidBetAmount']);
  if (totalValidBetAmount != null) {
    getChaseOrderCpListDataList.totalValidBetAmount = totalValidBetAmount;
  }
  final int? totalWinAmount = jsonConvert.convert<int>(json['totalWinAmount']);
  if (totalWinAmount != null) {
    getChaseOrderCpListDataList.totalWinAmount = totalWinAmount;
  }
  final double? finishAmount = jsonConvert.convert<double>(
      json['finishAmount']);
  if (finishAmount != null) {
    getChaseOrderCpListDataList.finishAmount = finishAmount;
  }
  final int? cancelWinAmount = jsonConvert.convert<int>(
      json['cancelWinAmount']);
  if (cancelWinAmount != null) {
    getChaseOrderCpListDataList.cancelWinAmount = cancelWinAmount;
  }
  final int? chaseOrderStatus = jsonConvert.convert<int>(
      json['chaseOrderStatus']);
  if (chaseOrderStatus != null) {
    getChaseOrderCpListDataList.chaseOrderStatus = chaseOrderStatus;
  }
  final int? createTime = jsonConvert.convert<int>(json['createTime']);
  if (createTime != null) {
    getChaseOrderCpListDataList.createTime = createTime;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getChaseOrderCpListDataList.betTime = betTime;
  }
  final String? betContent = jsonConvert.convert<String>(json['betContent']);
  if (betContent != null) {
    getChaseOrderCpListDataList.betContent = betContent;
  }
  return getChaseOrderCpListDataList;
}

Map<String, dynamic> $GetChaseOrderCpListDataListToJson(
    GetChaseOrderCpListDataList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['uid'] = entity.uid;
  data['chaseId'] = entity.chaseId;
  data['chasePlanId'] = entity.chasePlanId;
  data['ticketName'] = entity.ticketName;
  data['startTicketPlanNo'] = entity.startTicketPlanNo;
  data['playLevel'] = entity.playLevel;
  data['odd'] = entity.odd;
  data['totalPlanNoCount'] = entity.totalPlanNoCount;
  data['winAmountPlanNoCount'] = entity.winAmountPlanNoCount;
  data['finishPlanNoCount'] = entity.finishPlanNoCount;
  data['cancelPlanNoCount'] = entity.cancelPlanNoCount;
  data['totalBetAmount'] = entity.totalBetAmount;
  data['totalValidBetAmount'] = entity.totalValidBetAmount;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['finishAmount'] = entity.finishAmount;
  data['cancelWinAmount'] = entity.cancelWinAmount;
  data['chaseOrderStatus'] = entity.chaseOrderStatus;
  data['createTime'] = entity.createTime;
  data['betTime'] = entity.betTime;
  data['betContent'] = entity.betContent;
  return data;
}

extension GetChaseOrderCpListDataListExtension on GetChaseOrderCpListDataList {
  GetChaseOrderCpListDataList copyWith({
    String? uid,
    String? chaseId,
    String? chasePlanId,
    String? ticketName,
    String? startTicketPlanNo,
    String? playLevel,
    String? odd,
    int? totalPlanNoCount,
    int? winAmountPlanNoCount,
    int? finishPlanNoCount,
    int? cancelPlanNoCount,
    double? totalBetAmount,
    double? totalValidBetAmount,
    int? totalWinAmount,
    double? finishAmount,
    int? cancelWinAmount,
    int? chaseOrderStatus,
    int? createTime,
    String? betTime,
    String? betContent,
  }) {
    return GetChaseOrderCpListDataList()
      ..uid = uid ?? this.uid
      ..chaseId = chaseId ?? this.chaseId
      ..chasePlanId = chasePlanId ?? this.chasePlanId
      ..ticketName = ticketName ?? this.ticketName
      ..startTicketPlanNo = startTicketPlanNo ?? this.startTicketPlanNo
      ..playLevel = playLevel ?? this.playLevel
      ..odd = odd ?? this.odd
      ..totalPlanNoCount = totalPlanNoCount ?? this.totalPlanNoCount
      ..winAmountPlanNoCount = winAmountPlanNoCount ?? this.winAmountPlanNoCount
      ..finishPlanNoCount = finishPlanNoCount ?? this.finishPlanNoCount
      ..cancelPlanNoCount = cancelPlanNoCount ?? this.cancelPlanNoCount
      ..totalBetAmount = totalBetAmount ?? this.totalBetAmount
      ..totalValidBetAmount = totalValidBetAmount ?? this.totalValidBetAmount
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..finishAmount = finishAmount ?? this.finishAmount
      ..cancelWinAmount = cancelWinAmount ?? this.cancelWinAmount
      ..chaseOrderStatus = chaseOrderStatus ?? this.chaseOrderStatus
      ..createTime = createTime ?? this.createTime
      ..betTime = betTime ?? this.betTime
      ..betContent = betContent ?? this.betContent;
  }
}