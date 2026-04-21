import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_list_zr_entity.dart';

GetOrderListZrEntity $GetOrderListZrEntityFromJson(Map<String, dynamic> json) {
  final GetOrderListZrEntity getOrderListZrEntity = GetOrderListZrEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    getOrderListZrEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getOrderListZrEntity.message = message;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getOrderListZrEntity.code = code;
  }
  final GetOrderListZrData? data = jsonConvert.convert<GetOrderListZrData>(
      json['data']);
  if (data != null) {
    getOrderListZrEntity.data = data;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    getOrderListZrEntity.serverTime = serverTime;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getOrderListZrEntity.msg = msg;
  }
  return getOrderListZrEntity;
}

Map<String, dynamic> $GetOrderListZrEntityToJson(GetOrderListZrEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['serverTime'] = entity.serverTime;
  data['msg'] = entity.msg;
  return data;
}

extension GetOrderListZrEntityExtension on GetOrderListZrEntity {
  GetOrderListZrEntity copyWith({
    bool? status,
    String? message,
    String? code,
    GetOrderListZrData? data,
    int? serverTime,
    String? msg,
  }) {
    return GetOrderListZrEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..serverTime = serverTime ?? this.serverTime
      ..msg = msg ?? this.msg;
  }
}

GetOrderListZrData $GetOrderListZrDataFromJson(Map<String, dynamic> json) {
  final GetOrderListZrData getOrderListZrData = GetOrderListZrData();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    getOrderListZrData.total = total;
  }
  final int? totalBetAmount = jsonConvert.convert<int>(json['totalBetAmount']);
  if (totalBetAmount != null) {
    getOrderListZrData.totalBetAmount = totalBetAmount;
  }
  final int? totalValidBetAmount = jsonConvert.convert<int>(
      json['totalValidBetAmount']);
  if (totalValidBetAmount != null) {
    getOrderListZrData.totalValidBetAmount = totalValidBetAmount;
  }
  final int? totalWinAmount = jsonConvert.convert<int>(json['totalWinAmount']);
  if (totalWinAmount != null) {
    getOrderListZrData.totalWinAmount = totalWinAmount;
  }
  final int? totalCanWinAmount = jsonConvert.convert<int>(
      json['totalCanWinAmount']);
  if (totalCanWinAmount != null) {
    getOrderListZrData.totalCanWinAmount = totalCanWinAmount;
  }
  final List<GetOrderListZrDataList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetOrderListZrDataList>(e) as GetOrderListZrDataList)
      .toList();
  if (list != null) {
    getOrderListZrData.list = list;
  }
  return getOrderListZrData;
}

Map<String, dynamic> $GetOrderListZrDataToJson(GetOrderListZrData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalBetAmount'] = entity.totalBetAmount;
  data['totalValidBetAmount'] = entity.totalValidBetAmount;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['totalCanWinAmount'] = entity.totalCanWinAmount;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension GetOrderListZrDataExtension on GetOrderListZrData {
  GetOrderListZrData copyWith({
    int? total,
    int? totalBetAmount,
    int? totalValidBetAmount,
    int? totalWinAmount,
    int? totalCanWinAmount,
    List<GetOrderListZrDataList>? list,
  }) {
    return GetOrderListZrData()
      ..total = total ?? this.total
      ..totalBetAmount = totalBetAmount ?? this.totalBetAmount
      ..totalValidBetAmount = totalValidBetAmount ?? this.totalValidBetAmount
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..totalCanWinAmount = totalCanWinAmount ?? this.totalCanWinAmount
      ..list = list ?? this.list;
  }
}

GetOrderListZrDataList $GetOrderListZrDataListFromJson(
    Map<String, dynamic> json) {
  final GetOrderListZrDataList getOrderListZrDataList = GetOrderListZrDataList();
  final String? roundNo = jsonConvert.convert<String>(json['roundNo']);
  if (roundNo != null) {
    getOrderListZrDataList.roundNo = roundNo;
  }
  final String? gameTypeId = jsonConvert.convert<String>(json['gameTypeId']);
  if (gameTypeId != null) {
    getOrderListZrDataList.gameTypeId = gameTypeId;
  }
  final String? gameTypeName = jsonConvert.convert<String>(
      json['gameTypeName']);
  if (gameTypeName != null) {
    getOrderListZrDataList.gameTypeName = gameTypeName;
  }
  final String? platformId = jsonConvert.convert<String>(json['platformId']);
  if (platformId != null) {
    getOrderListZrDataList.platformId = platformId;
  }
  final String? platformName = jsonConvert.convert<String>(
      json['platformName']);
  if (platformName != null) {
    getOrderListZrDataList.platformName = platformName;
  }
  final String? tableCode = jsonConvert.convert<String>(json['tableCode']);
  if (tableCode != null) {
    getOrderListZrDataList.tableCode = tableCode;
  }
  final String? tableName = jsonConvert.convert<String>(json['tableName']);
  if (tableName != null) {
    getOrderListZrDataList.tableName = tableName;
  }
  final String? betPointId = jsonConvert.convert<String>(json['betPointId']);
  if (betPointId != null) {
    getOrderListZrDataList.betPointId = betPointId;
  }
  final String? betPointName = jsonConvert.convert<String>(
      json['betPointName']);
  if (betPointName != null) {
    getOrderListZrDataList.betPointName = betPointName;
  }
  final String? betStatus = jsonConvert.convert<String>(json['betStatus']);
  if (betStatus != null) {
    getOrderListZrDataList.betStatus = betStatus;
  }
  final int? createTime = jsonConvert.convert<int>(json['createTime']);
  if (createTime != null) {
    getOrderListZrDataList.createTime = createTime;
  }
  final int? updateTime = jsonConvert.convert<int>(json['updateTime']);
  if (updateTime != null) {
    getOrderListZrDataList.updateTime = updateTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getOrderListZrDataList.betAmount = betAmount;
  }
  final String? payAmount = jsonConvert.convert<String>(json['payAmount']);
  if (payAmount != null) {
    getOrderListZrDataList.payAmount = payAmount;
  }
  final String? netAmount = jsonConvert.convert<String>(json['netAmount']);
  if (netAmount != null) {
    getOrderListZrDataList.netAmount = netAmount;
  }
  final String? validBetAmount = jsonConvert.convert<String>(
      json['validBetAmount']);
  if (validBetAmount != null) {
    getOrderListZrDataList.validBetAmount = validBetAmount;
  }
  final dynamic videoPath = json['videoPath'];
  if (videoPath != null) {
    getOrderListZrDataList.videoPath = videoPath;
  }
  final dynamic odds = json['odds'];
  if (odds != null) {
    getOrderListZrDataList.odds = odds;
  }
  final dynamic judgeResult = json['judgeResult'];
  if (judgeResult != null) {
    getOrderListZrDataList.judgeResult = judgeResult;
  }
  final String? roundResult = jsonConvert.convert<String>(json['roundResult']);
  if (roundResult != null) {
    getOrderListZrDataList.roundResult = roundResult;
  }
  final String? roundResult2 = jsonConvert.convert<String>(
      json['roundResult2']);
  if (roundResult2 != null) {
    getOrderListZrDataList.roundResult2 = roundResult2;
  }
  final int? maxWinAmount = jsonConvert.convert<int>(json['maxWinAmount']);
  if (maxWinAmount != null) {
    getOrderListZrDataList.maxWinAmount = maxWinAmount;
  }
  return getOrderListZrDataList;
}

Map<String, dynamic> $GetOrderListZrDataListToJson(
    GetOrderListZrDataList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['roundNo'] = entity.roundNo;
  data['gameTypeId'] = entity.gameTypeId;
  data['gameTypeName'] = entity.gameTypeName;
  data['platformId'] = entity.platformId;
  data['platformName'] = entity.platformName;
  data['tableCode'] = entity.tableCode;
  data['tableName'] = entity.tableName;
  data['betPointId'] = entity.betPointId;
  data['betPointName'] = entity.betPointName;
  data['betStatus'] = entity.betStatus;
  data['createTime'] = entity.createTime;
  data['updateTime'] = entity.updateTime;
  data['betAmount'] = entity.betAmount;
  data['payAmount'] = entity.payAmount;
  data['netAmount'] = entity.netAmount;
  data['validBetAmount'] = entity.validBetAmount;
  data['videoPath'] = entity.videoPath;
  data['odds'] = entity.odds;
  data['judgeResult'] = entity.judgeResult;
  data['roundResult'] = entity.roundResult;
  data['roundResult2'] = entity.roundResult2;
  data['maxWinAmount'] = entity.maxWinAmount;
  return data;
}

extension GetOrderListZrDataListExtension on GetOrderListZrDataList {
  GetOrderListZrDataList copyWith({
    String? roundNo,
    String? gameTypeId,
    String? gameTypeName,
    String? platformId,
    String? platformName,
    String? tableCode,
    String? tableName,
    String? betPointId,
    String? betPointName,
    String? betStatus,
    int? createTime,
    int? updateTime,
    String? betAmount,
    String? payAmount,
    String? netAmount,
    String? validBetAmount,
    dynamic videoPath,
    dynamic odds,
    dynamic judgeResult,
    String? roundResult,
    String? roundResult2,
    int? maxWinAmount,
    bool? isExpand,
  }) {
    return GetOrderListZrDataList()
      ..roundNo = roundNo ?? this.roundNo
      ..gameTypeId = gameTypeId ?? this.gameTypeId
      ..gameTypeName = gameTypeName ?? this.gameTypeName
      ..platformId = platformId ?? this.platformId
      ..platformName = platformName ?? this.platformName
      ..tableCode = tableCode ?? this.tableCode
      ..tableName = tableName ?? this.tableName
      ..betPointId = betPointId ?? this.betPointId
      ..betPointName = betPointName ?? this.betPointName
      ..betStatus = betStatus ?? this.betStatus
      ..createTime = createTime ?? this.createTime
      ..updateTime = updateTime ?? this.updateTime
      ..betAmount = betAmount ?? this.betAmount
      ..payAmount = payAmount ?? this.payAmount
      ..netAmount = netAmount ?? this.netAmount
      ..validBetAmount = validBetAmount ?? this.validBetAmount
      ..videoPath = videoPath ?? this.videoPath
      ..odds = odds ?? this.odds
      ..judgeResult = judgeResult ?? this.judgeResult
      ..roundResult = roundResult ?? this.roundResult
      ..roundResult2 = roundResult2 ?? this.roundResult2
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..isExpand = isExpand ?? this.isExpand;
  }
}