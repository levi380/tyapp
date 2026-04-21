import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_order_list_entity.dart';

ZrOrderListEntity $ZrOrderListEntityFromJson(Map<String, dynamic> json) {
  final ZrOrderListEntity zrOrderListEntity = ZrOrderListEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    zrOrderListEntity.total = total;
  }
  final double? totalBetAmount = jsonConvert.convert<double>(
      json['totalBetAmount']);
  if (totalBetAmount != null) {
    zrOrderListEntity.totalBetAmount = totalBetAmount;
  }
  final double? totalValidBetAmount = jsonConvert.convert<double>(
      json['totalValidBetAmount']);
  if (totalValidBetAmount != null) {
    zrOrderListEntity.totalValidBetAmount = totalValidBetAmount;
  }
  final double? totalWinAmount = jsonConvert.convert<double>(
      json['totalWinAmount']);
  if (totalWinAmount != null) {
    zrOrderListEntity.totalWinAmount = totalWinAmount;
  }
  final double? totalCanWinAmount = jsonConvert.convert<double>(
      json['totalCanWinAmount']);
  if (totalCanWinAmount != null) {
    zrOrderListEntity.totalCanWinAmount = totalCanWinAmount;
  }
  final List<ZrOrderListList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ZrOrderListList>(e) as ZrOrderListList)
      .toList();
  if (list != null) {
    zrOrderListEntity.list = list;
  }
  return zrOrderListEntity;
}

Map<String, dynamic> $ZrOrderListEntityToJson(ZrOrderListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['totalBetAmount'] = entity.totalBetAmount;
  data['totalValidBetAmount'] = entity.totalValidBetAmount;
  data['totalWinAmount'] = entity.totalWinAmount;
  data['totalCanWinAmount'] = entity.totalCanWinAmount;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  return data;
}

extension ZrOrderListEntityExtension on ZrOrderListEntity {
  ZrOrderListEntity copyWith({
    int? total,
    double? totalBetAmount,
    double? totalValidBetAmount,
    double? totalWinAmount,
    double? totalCanWinAmount,
    List<ZrOrderListList>? list,
  }) {
    return ZrOrderListEntity()
      ..total = total ?? this.total
      ..totalBetAmount = totalBetAmount ?? this.totalBetAmount
      ..totalValidBetAmount = totalValidBetAmount ?? this.totalValidBetAmount
      ..totalWinAmount = totalWinAmount ?? this.totalWinAmount
      ..totalCanWinAmount = totalCanWinAmount ?? this.totalCanWinAmount
      ..list = list ?? this.list;
  }
}

ZrOrderListList $ZrOrderListListFromJson(Map<String, dynamic> json) {
  final ZrOrderListList zrOrderListList = ZrOrderListList();
  final dynamic uid = json['uid'];
  if (uid != null) {
    zrOrderListList.uid = uid;
  }
  final String? roundNo = jsonConvert.convert<String>(json['roundNo']);
  if (roundNo != null) {
    zrOrderListList.roundNo = roundNo;
  }
  final String? gameTypeId = jsonConvert.convert<String>(json['gameTypeId']);
  if (gameTypeId != null) {
    zrOrderListList.gameTypeId = gameTypeId;
  }
  final String? gameTypeName = jsonConvert.convert<String>(
      json['gameTypeName']);
  if (gameTypeName != null) {
    zrOrderListList.gameTypeName = gameTypeName;
  }
  final String? platformId = jsonConvert.convert<String>(json['platformId']);
  if (platformId != null) {
    zrOrderListList.platformId = platformId;
  }
  final String? platformName = jsonConvert.convert<String>(
      json['platformName']);
  if (platformName != null) {
    zrOrderListList.platformName = platformName;
  }
  final String? tableCode = jsonConvert.convert<String>(json['tableCode']);
  if (tableCode != null) {
    zrOrderListList.tableCode = tableCode;
  }
  final String? tableName = jsonConvert.convert<String>(json['tableName']);
  if (tableName != null) {
    zrOrderListList.tableName = tableName;
  }
  final String? betPointId = jsonConvert.convert<String>(json['betPointId']);
  if (betPointId != null) {
    zrOrderListList.betPointId = betPointId;
  }
  final String? betPointName = jsonConvert.convert<String>(
      json['betPointName']);
  if (betPointName != null) {
    zrOrderListList.betPointName = betPointName;
  }
  final String? betStatus = jsonConvert.convert<String>(json['betStatus']);
  if (betStatus != null) {
    zrOrderListList.betStatus = betStatus;
  }
  final int? createTime = jsonConvert.convert<int>(json['createTime']);
  if (createTime != null) {
    zrOrderListList.createTime = createTime;
  }
  final int? updateTime = jsonConvert.convert<int>(json['updateTime']);
  if (updateTime != null) {
    zrOrderListList.updateTime = updateTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    zrOrderListList.betAmount = betAmount;
  }
  final String? payAmount = jsonConvert.convert<String>(json['payAmount']);
  if (payAmount != null) {
    zrOrderListList.payAmount = payAmount;
  }
  final String? netAmount = jsonConvert.convert<String>(json['netAmount']);
  if (netAmount != null) {
    zrOrderListList.netAmount = netAmount;
  }
  final String? validBetAmount = jsonConvert.convert<String>(
      json['validBetAmount']);
  if (validBetAmount != null) {
    zrOrderListList.validBetAmount = validBetAmount;
  }
  final dynamic videoPath = json['videoPath'];
  if (videoPath != null) {
    zrOrderListList.videoPath = videoPath;
  }
  final String? odds = jsonConvert.convert<String>(json['odds']);
  if (odds != null) {
    zrOrderListList.odds = odds;
  }
  final String? judgeResult = jsonConvert.convert<String>(json['judgeResult']);
  if (judgeResult != null) {
    zrOrderListList.judgeResult = judgeResult;
  }
  final String? roundResult = jsonConvert.convert<String>(json['roundResult']);
  if (roundResult != null) {
    zrOrderListList.roundResult = roundResult;
  }
  final String? roundResult2 = jsonConvert.convert<String>(
      json['roundResult2']);
  if (roundResult2 != null) {
    zrOrderListList.roundResult2 = roundResult2;
  }
  final dynamic maxWinAmount = json['maxWinAmount'];
  if (maxWinAmount != null) {
    zrOrderListList.maxWinAmount = maxWinAmount;
  }
  return zrOrderListList;
}

Map<String, dynamic> $ZrOrderListListToJson(ZrOrderListList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['uid'] = entity.uid;
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

extension ZrOrderListListExtension on ZrOrderListList {
  ZrOrderListList copyWith({
    dynamic uid,
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
    String? odds,
    String? judgeResult,
    String? roundResult,
    String? roundResult2,
    dynamic maxWinAmount,
  }) {
    return ZrOrderListList()
      ..uid = uid ?? this.uid
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
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount;
  }
}