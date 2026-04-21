import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_user_info_cp_entity.dart';

GetUserInfoCpEntity $GetUserInfoCpEntityFromJson(Map<String, dynamic> json) {
  final GetUserInfoCpEntity getUserInfoCpEntity = GetUserInfoCpEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    getUserInfoCpEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getUserInfoCpEntity.message = message;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getUserInfoCpEntity.code = code;
  }
  final GetUserInfoCpData? data = jsonConvert.convert<GetUserInfoCpData>(
      json['data']);
  if (data != null) {
    getUserInfoCpEntity.data = data;
  }
  final int? serverTime = jsonConvert.convert<int>(json['serverTime']);
  if (serverTime != null) {
    getUserInfoCpEntity.serverTime = serverTime;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getUserInfoCpEntity.msg = msg;
  }
  return getUserInfoCpEntity;
}

Map<String, dynamic> $GetUserInfoCpEntityToJson(GetUserInfoCpEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['serverTime'] = entity.serverTime;
  data['msg'] = entity.msg;
  return data;
}

extension GetUserInfoCpEntityExtension on GetUserInfoCpEntity {
  GetUserInfoCpEntity copyWith({
    bool? status,
    String? message,
    String? code,
    GetUserInfoCpData? data,
    int? serverTime,
    String? msg,
  }) {
    return GetUserInfoCpEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..serverTime = serverTime ?? this.serverTime
      ..msg = msg ?? this.msg;
  }
}

GetUserInfoCpData $GetUserInfoCpDataFromJson(Map<String, dynamic> json) {
  final GetUserInfoCpData getUserInfoCpData = GetUserInfoCpData();
  final int? nextFeatureConfigId = jsonConvert.convert<int>(
      json['nextFeatureConfigId']);
  if (nextFeatureConfigId != null) {
    getUserInfoCpData.nextFeatureConfigId = nextFeatureConfigId;
  }
  final String? chips = jsonConvert.convert<String>(json['chips']);
  if (chips != null) {
    getUserInfoCpData.chips = chips;
  }
  final bool? delayed = jsonConvert.convert<bool>(json['delayed']);
  if (delayed != null) {
    getUserInfoCpData.delayed = delayed;
  }
  final bool? winBeep = jsonConvert.convert<bool>(json['winBeep']);
  if (winBeep != null) {
    getUserInfoCpData.winBeep = winBeep;
  }
  final bool? featureDelayed = jsonConvert.convert<bool>(
      json['featureDelayed']);
  if (featureDelayed != null) {
    getUserInfoCpData.featureDelayed = featureDelayed;
  }
  final bool? doubleBetConfirm = jsonConvert.convert<bool>(
      json['doubleBetConfirm']);
  if (doubleBetConfirm != null) {
    getUserInfoCpData.doubleBetConfirm = doubleBetConfirm;
  }
  final bool? doubleLimitStatus = jsonConvert.convert<bool>(
      json['doubleLimitStatus']);
  if (doubleLimitStatus != null) {
    getUserInfoCpData.doubleLimitStatus = doubleLimitStatus;
  }
  final List<
      GetUserInfoCpDataFeatureBetRangeList>? featureBetRangeList = (json['featureBetRangeList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetUserInfoCpDataFeatureBetRangeList>(
          e) as GetUserInfoCpDataFeatureBetRangeList).toList();
  if (featureBetRangeList != null) {
    getUserInfoCpData.featureBetRangeList = featureBetRangeList;
  }
  final int? nextConfigId = jsonConvert.convert<int>(json['nextConfigId']);
  if (nextConfigId != null) {
    getUserInfoCpData.nextConfigId = nextConfigId;
  }
  final String? clientDisplayTicketNum = jsonConvert.convert<String>(
      json['clientDisplayTicketNum']);
  if (clientDisplayTicketNum != null) {
    getUserInfoCpData.clientDisplayTicketNum = clientDisplayTicketNum;
  }
  final String? colorTheme = jsonConvert.convert<String>(json['colorTheme']);
  if (colorTheme != null) {
    getUserInfoCpData.colorTheme = colorTheme;
  }
  final String? featureDelayedTime = jsonConvert.convert<String>(
      json['featureDelayedTime']);
  if (featureDelayedTime != null) {
    getUserInfoCpData.featureDelayedTime = featureDelayedTime;
  }
  final bool? virtualKeyboard = jsonConvert.convert<bool>(
      json['virtualKeyboard']);
  if (virtualKeyboard != null) {
    getUserInfoCpData.virtualKeyboard = virtualKeyboard;
  }
  final bool? coldHot = jsonConvert.convert<bool>(json['coldHot']);
  if (coldHot != null) {
    getUserInfoCpData.coldHot = coldHot;
  }
  final String? delayedTime = jsonConvert.convert<String>(json['delayedTime']);
  if (delayedTime != null) {
    getUserInfoCpData.delayedTime = delayedTime;
  }
  final int? selectFeatureConfigId = jsonConvert.convert<int>(
      json['selectFeatureConfigId']);
  if (selectFeatureConfigId != null) {
    getUserInfoCpData.selectFeatureConfigId = selectFeatureConfigId;
  }
  final bool? featureLimitStatus = jsonConvert.convert<bool>(
      json['featureLimitStatus']);
  if (featureLimitStatus != null) {
    getUserInfoCpData.featureLimitStatus = featureLimitStatus;
  }
  final bool? quickConfirm = jsonConvert.convert<bool>(json['quickConfirm']);
  if (quickConfirm != null) {
    getUserInfoCpData.quickConfirm = quickConfirm;
  }
  final int? memberId = jsonConvert.convert<int>(json['memberId']);
  if (memberId != null) {
    getUserInfoCpData.memberId = memberId;
  }
  final bool? longDragonNumPrompt = jsonConvert.convert<bool>(
      json['longDragonNumPrompt']);
  if (longDragonNumPrompt != null) {
    getUserInfoCpData.longDragonNumPrompt = longDragonNumPrompt;
  }
  final List<
      GetUserInfoCpDataDoubleBetRangeList>? doubleBetRangeList = (json['doubleBetRangeList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetUserInfoCpDataDoubleBetRangeList>(
          e) as GetUserInfoCpDataDoubleBetRangeList).toList();
  if (doubleBetRangeList != null) {
    getUserInfoCpData.doubleBetRangeList = doubleBetRangeList;
  }
  final int? longDragonLimit = jsonConvert.convert<int>(
      json['longDragonLimit']);
  if (longDragonLimit != null) {
    getUserInfoCpData.longDragonLimit = longDragonLimit;
  }
  final String? periodMaxProfitFlag = jsonConvert.convert<String>(
      json['periodMaxProfitFlag']);
  if (periodMaxProfitFlag != null) {
    getUserInfoCpData.periodMaxProfitFlag = periodMaxProfitFlag;
  }
  final List<
      GetUserInfoCpDataLongDragonTickets>? longDragonTickets = (json['longDragonTickets'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetUserInfoCpDataLongDragonTickets>(
          e) as GetUserInfoCpDataLongDragonTickets).toList();
  if (longDragonTickets != null) {
    getUserInfoCpData.longDragonTickets = longDragonTickets;
  }
  final bool? winModal = jsonConvert.convert<bool>(json['winModal']);
  if (winModal != null) {
    getUserInfoCpData.winModal = winModal;
  }
  final bool? countDownBeep = jsonConvert.convert<bool>(json['countDownBeep']);
  if (countDownBeep != null) {
    getUserInfoCpData.countDownBeep = countDownBeep;
  }
  final int? selectConfigId = jsonConvert.convert<int>(json['selectConfigId']);
  if (selectConfigId != null) {
    getUserInfoCpData.selectConfigId = selectConfigId;
  }
  final List<dynamic>? lztConf = (json['lztConf'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (lztConf != null) {
    getUserInfoCpData.lztConf = lztConf;
  }
  final int? longDragonLimitMax = jsonConvert.convert<int>(
      json['longDragonLimitMax']);
  if (longDragonLimitMax != null) {
    getUserInfoCpData.longDragonLimitMax = longDragonLimitMax;
  }
  final bool? missRemind = jsonConvert.convert<bool>(json['missRemind']);
  if (missRemind != null) {
    getUserInfoCpData.missRemind = missRemind;
  }
  return getUserInfoCpData;
}

Map<String, dynamic> $GetUserInfoCpDataToJson(GetUserInfoCpData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nextFeatureConfigId'] = entity.nextFeatureConfigId;
  data['chips'] = entity.chips;
  data['delayed'] = entity.delayed;
  data['winBeep'] = entity.winBeep;
  data['featureDelayed'] = entity.featureDelayed;
  data['doubleBetConfirm'] = entity.doubleBetConfirm;
  data['doubleLimitStatus'] = entity.doubleLimitStatus;
  data['featureBetRangeList'] =
      entity.featureBetRangeList.map((v) => v.toJson()).toList();
  data['nextConfigId'] = entity.nextConfigId;
  data['clientDisplayTicketNum'] = entity.clientDisplayTicketNum;
  data['colorTheme'] = entity.colorTheme;
  data['featureDelayedTime'] = entity.featureDelayedTime;
  data['virtualKeyboard'] = entity.virtualKeyboard;
  data['coldHot'] = entity.coldHot;
  data['delayedTime'] = entity.delayedTime;
  data['selectFeatureConfigId'] = entity.selectFeatureConfigId;
  data['featureLimitStatus'] = entity.featureLimitStatus;
  data['quickConfirm'] = entity.quickConfirm;
  data['memberId'] = entity.memberId;
  data['longDragonNumPrompt'] = entity.longDragonNumPrompt;
  data['doubleBetRangeList'] =
      entity.doubleBetRangeList.map((v) => v.toJson()).toList();
  data['longDragonLimit'] = entity.longDragonLimit;
  data['periodMaxProfitFlag'] = entity.periodMaxProfitFlag;
  data['longDragonTickets'] =
      entity.longDragonTickets.map((v) => v.toJson()).toList();
  data['winModal'] = entity.winModal;
  data['countDownBeep'] = entity.countDownBeep;
  data['selectConfigId'] = entity.selectConfigId;
  data['lztConf'] = entity.lztConf;
  data['longDragonLimitMax'] = entity.longDragonLimitMax;
  data['missRemind'] = entity.missRemind;
  return data;
}

extension GetUserInfoCpDataExtension on GetUserInfoCpData {
  GetUserInfoCpData copyWith({
    int? nextFeatureConfigId,
    String? chips,
    bool? delayed,
    bool? winBeep,
    bool? featureDelayed,
    bool? doubleBetConfirm,
    bool? doubleLimitStatus,
    List<GetUserInfoCpDataFeatureBetRangeList>? featureBetRangeList,
    int? nextConfigId,
    String? clientDisplayTicketNum,
    String? colorTheme,
    String? featureDelayedTime,
    bool? virtualKeyboard,
    bool? coldHot,
    String? delayedTime,
    int? selectFeatureConfigId,
    bool? featureLimitStatus,
    bool? quickConfirm,
    int? memberId,
    bool? longDragonNumPrompt,
    List<GetUserInfoCpDataDoubleBetRangeList>? doubleBetRangeList,
    int? longDragonLimit,
    String? periodMaxProfitFlag,
    List<GetUserInfoCpDataLongDragonTickets>? longDragonTickets,
    bool? winModal,
    bool? countDownBeep,
    int? selectConfigId,
    List<dynamic>? lztConf,
    int? longDragonLimitMax,
    bool? missRemind,
  }) {
    return GetUserInfoCpData()
      ..nextFeatureConfigId = nextFeatureConfigId ?? this.nextFeatureConfigId
      ..chips = chips ?? this.chips
      ..delayed = delayed ?? this.delayed
      ..winBeep = winBeep ?? this.winBeep
      ..featureDelayed = featureDelayed ?? this.featureDelayed
      ..doubleBetConfirm = doubleBetConfirm ?? this.doubleBetConfirm
      ..doubleLimitStatus = doubleLimitStatus ?? this.doubleLimitStatus
      ..featureBetRangeList = featureBetRangeList ?? this.featureBetRangeList
      ..nextConfigId = nextConfigId ?? this.nextConfigId
      ..clientDisplayTicketNum = clientDisplayTicketNum ??
          this.clientDisplayTicketNum
      ..colorTheme = colorTheme ?? this.colorTheme
      ..featureDelayedTime = featureDelayedTime ?? this.featureDelayedTime
      ..virtualKeyboard = virtualKeyboard ?? this.virtualKeyboard
      ..coldHot = coldHot ?? this.coldHot
      ..delayedTime = delayedTime ?? this.delayedTime
      ..selectFeatureConfigId = selectFeatureConfigId ??
          this.selectFeatureConfigId
      ..featureLimitStatus = featureLimitStatus ?? this.featureLimitStatus
      ..quickConfirm = quickConfirm ?? this.quickConfirm
      ..memberId = memberId ?? this.memberId
      ..longDragonNumPrompt = longDragonNumPrompt ?? this.longDragonNumPrompt
      ..doubleBetRangeList = doubleBetRangeList ?? this.doubleBetRangeList
      ..longDragonLimit = longDragonLimit ?? this.longDragonLimit
      ..periodMaxProfitFlag = periodMaxProfitFlag ?? this.periodMaxProfitFlag
      ..longDragonTickets = longDragonTickets ?? this.longDragonTickets
      ..winModal = winModal ?? this.winModal
      ..countDownBeep = countDownBeep ?? this.countDownBeep
      ..selectConfigId = selectConfigId ?? this.selectConfigId
      ..lztConf = lztConf ?? this.lztConf
      ..longDragonLimitMax = longDragonLimitMax ?? this.longDragonLimitMax
      ..missRemind = missRemind ?? this.missRemind;
  }
}

GetUserInfoCpDataFeatureBetRangeList $GetUserInfoCpDataFeatureBetRangeListFromJson(
    Map<String, dynamic> json) {
  final GetUserInfoCpDataFeatureBetRangeList getUserInfoCpDataFeatureBetRangeList = GetUserInfoCpDataFeatureBetRangeList();
  final int? doublePlayBetMax = jsonConvert.convert<int>(
      json['doublePlayBetMax']);
  if (doublePlayBetMax != null) {
    getUserInfoCpDataFeatureBetRangeList.doublePlayBetMax = doublePlayBetMax;
  }
  final bool? current = jsonConvert.convert<bool>(json['current']);
  if (current != null) {
    getUserInfoCpDataFeatureBetRangeList.current = current;
  }
  final int? configId = jsonConvert.convert<int>(json['configId']);
  if (configId != null) {
    getUserInfoCpDataFeatureBetRangeList.configId = configId;
  }
  final int? doublePlayBetMin = jsonConvert.convert<int>(
      json['doublePlayBetMin']);
  if (doublePlayBetMin != null) {
    getUserInfoCpDataFeatureBetRangeList.doublePlayBetMin = doublePlayBetMin;
  }
  final bool? nextSelect = jsonConvert.convert<bool>(json['nextSelect']);
  if (nextSelect != null) {
    getUserInfoCpDataFeatureBetRangeList.nextSelect = nextSelect;
  }
  return getUserInfoCpDataFeatureBetRangeList;
}

Map<String, dynamic> $GetUserInfoCpDataFeatureBetRangeListToJson(
    GetUserInfoCpDataFeatureBetRangeList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['doublePlayBetMax'] = entity.doublePlayBetMax;
  data['current'] = entity.current;
  data['configId'] = entity.configId;
  data['doublePlayBetMin'] = entity.doublePlayBetMin;
  data['nextSelect'] = entity.nextSelect;
  return data;
}

extension GetUserInfoCpDataFeatureBetRangeListExtension on GetUserInfoCpDataFeatureBetRangeList {
  GetUserInfoCpDataFeatureBetRangeList copyWith({
    int? doublePlayBetMax,
    bool? current,
    int? configId,
    int? doublePlayBetMin,
    bool? nextSelect,
  }) {
    return GetUserInfoCpDataFeatureBetRangeList()
      ..doublePlayBetMax = doublePlayBetMax ?? this.doublePlayBetMax
      ..current = current ?? this.current
      ..configId = configId ?? this.configId
      ..doublePlayBetMin = doublePlayBetMin ?? this.doublePlayBetMin
      ..nextSelect = nextSelect ?? this.nextSelect;
  }
}

GetUserInfoCpDataDoubleBetRangeList $GetUserInfoCpDataDoubleBetRangeListFromJson(
    Map<String, dynamic> json) {
  final GetUserInfoCpDataDoubleBetRangeList getUserInfoCpDataDoubleBetRangeList = GetUserInfoCpDataDoubleBetRangeList();
  final int? doublePlayBetMax = jsonConvert.convert<int>(
      json['doublePlayBetMax']);
  if (doublePlayBetMax != null) {
    getUserInfoCpDataDoubleBetRangeList.doublePlayBetMax = doublePlayBetMax;
  }
  final bool? current = jsonConvert.convert<bool>(json['current']);
  if (current != null) {
    getUserInfoCpDataDoubleBetRangeList.current = current;
  }
  final int? configId = jsonConvert.convert<int>(json['configId']);
  if (configId != null) {
    getUserInfoCpDataDoubleBetRangeList.configId = configId;
  }
  final int? doublePlayBetMin = jsonConvert.convert<int>(
      json['doublePlayBetMin']);
  if (doublePlayBetMin != null) {
    getUserInfoCpDataDoubleBetRangeList.doublePlayBetMin = doublePlayBetMin;
  }
  final bool? nextSelect = jsonConvert.convert<bool>(json['nextSelect']);
  if (nextSelect != null) {
    getUserInfoCpDataDoubleBetRangeList.nextSelect = nextSelect;
  }
  return getUserInfoCpDataDoubleBetRangeList;
}

Map<String, dynamic> $GetUserInfoCpDataDoubleBetRangeListToJson(
    GetUserInfoCpDataDoubleBetRangeList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['doublePlayBetMax'] = entity.doublePlayBetMax;
  data['current'] = entity.current;
  data['configId'] = entity.configId;
  data['doublePlayBetMin'] = entity.doublePlayBetMin;
  data['nextSelect'] = entity.nextSelect;
  return data;
}

extension GetUserInfoCpDataDoubleBetRangeListExtension on GetUserInfoCpDataDoubleBetRangeList {
  GetUserInfoCpDataDoubleBetRangeList copyWith({
    int? doublePlayBetMax,
    bool? current,
    int? configId,
    int? doublePlayBetMin,
    bool? nextSelect,
  }) {
    return GetUserInfoCpDataDoubleBetRangeList()
      ..doublePlayBetMax = doublePlayBetMax ?? this.doublePlayBetMax
      ..current = current ?? this.current
      ..configId = configId ?? this.configId
      ..doublePlayBetMin = doublePlayBetMin ?? this.doublePlayBetMin
      ..nextSelect = nextSelect ?? this.nextSelect;
  }
}

GetUserInfoCpDataLongDragonTickets $GetUserInfoCpDataLongDragonTicketsFromJson(
    Map<String, dynamic> json) {
  final GetUserInfoCpDataLongDragonTickets getUserInfoCpDataLongDragonTickets = GetUserInfoCpDataLongDragonTickets();
  final int? seriesId = jsonConvert.convert<int>(json['seriesId']);
  if (seriesId != null) {
    getUserInfoCpDataLongDragonTickets.seriesId = seriesId;
  }
  final String? ticketIds = jsonConvert.convert<String>(json['ticketIds']);
  if (ticketIds != null) {
    getUserInfoCpDataLongDragonTickets.ticketIds = ticketIds;
  }
  return getUserInfoCpDataLongDragonTickets;
}

Map<String, dynamic> $GetUserInfoCpDataLongDragonTicketsToJson(
    GetUserInfoCpDataLongDragonTickets entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['seriesId'] = entity.seriesId;
  data['ticketIds'] = entity.ticketIds;
  return data;
}

extension GetUserInfoCpDataLongDragonTicketsExtension on GetUserInfoCpDataLongDragonTickets {
  GetUserInfoCpDataLongDragonTickets copyWith({
    int? seriesId,
    String? ticketIds,
  }) {
    return GetUserInfoCpDataLongDragonTickets()
      ..seriesId = seriesId ?? this.seriesId
      ..ticketIds = ticketIds ?? this.ticketIds;
  }
}