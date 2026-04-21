import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_big_data_annual_report_info_entity.dart';

GetBigDataAnnualReportInfoEntity $GetBigDataAnnualReportInfoEntityFromJson(
    Map<String, dynamic> json) {
  final GetBigDataAnnualReportInfoEntity getBigDataAnnualReportInfoEntity = GetBigDataAnnualReportInfoEntity();
  final int? annualBetComboCount = jsonConvert.convert<int>(
      json['annualBetComboCount']);
  if (annualBetComboCount != null) {
    getBigDataAnnualReportInfoEntity.annualBetComboCount = annualBetComboCount;
  }
  final int? annualBetCount = jsonConvert.convert<int>(json['annualBetCount']);
  if (annualBetCount != null) {
    getBigDataAnnualReportInfoEntity.annualBetCount = annualBetCount;
  }
  final int? annualBetDenseRank = jsonConvert.convert<int>(
      json['annualBetDenseRank']);
  if (annualBetDenseRank != null) {
    getBigDataAnnualReportInfoEntity.annualBetDenseRank = annualBetDenseRank;
  }
  final String? annualBetPercentRank = jsonConvert.convert<String>(
      json['annualBetPercentRank']);
  if (annualBetPercentRank != null) {
    getBigDataAnnualReportInfoEntity.annualBetPercentRank =
        annualBetPercentRank;
  }
  final int? annualBetSingleCount = jsonConvert.convert<int>(
      json['annualBetSingleCount']);
  if (annualBetSingleCount != null) {
    getBigDataAnnualReportInfoEntity.annualBetSingleCount =
        annualBetSingleCount;
  }
  final int? annualHobbyBetTime = jsonConvert.convert<int>(
      json['annualHobbyBetTime']);
  if (annualHobbyBetTime != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyBetTime = annualHobbyBetTime;
  }
  final int? annualHobbyPlay = jsonConvert.convert<int>(
      json['annualHobbyPlay']);
  if (annualHobbyPlay != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyPlay = annualHobbyPlay;
  }
  final int? annualHobbyPlayCount = jsonConvert.convert<int>(
      json['annualHobbyPlayCount']);
  if (annualHobbyPlayCount != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyPlayCount =
        annualHobbyPlayCount;
  }
  final String? annualHobbyPlayNameCn = jsonConvert.convert<String>(
      json['annualHobbyPlayNameCn']);
  if (annualHobbyPlayNameCn != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyPlayNameCn =
        annualHobbyPlayNameCn;
  }
  final String? annualHobbyPlayNameEn = jsonConvert.convert<String>(
      json['annualHobbyPlayNameEn']);
  if (annualHobbyPlayNameEn != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyPlayNameEn =
        annualHobbyPlayNameEn;
  }
  final String? annualHobbyPlayNameTw = jsonConvert.convert<String>(
      json['annualHobbyPlayNameTw']);
  if (annualHobbyPlayNameTw != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyPlayNameTw =
        annualHobbyPlayNameTw;
  }
  final int? annualHobbySport = jsonConvert.convert<int>(
      json['annualHobbySport']);
  if (annualHobbySport != null) {
    getBigDataAnnualReportInfoEntity.annualHobbySport = annualHobbySport;
  }
  final int? annualHobbySportBackgroundType = jsonConvert.convert<int>(
      json['annualHobbySportBackgroundType']);
  if (annualHobbySportBackgroundType != null) {
    getBigDataAnnualReportInfoEntity.annualHobbySportBackgroundType =
        annualHobbySportBackgroundType;
  }
  final int? annualHobbySportCount = jsonConvert.convert<int>(
      json['annualHobbySportCount']);
  if (annualHobbySportCount != null) {
    getBigDataAnnualReportInfoEntity.annualHobbySportCount =
        annualHobbySportCount;
  }
  final String? annualHobbySportNameCn = jsonConvert.convert<String>(
      json['annualHobbySportNameCn']);
  if (annualHobbySportNameCn != null) {
    getBigDataAnnualReportInfoEntity.annualHobbySportNameCn =
        annualHobbySportNameCn;
  }
  final String? annualHobbySportNameEn = jsonConvert.convert<String>(
      json['annualHobbySportNameEn']);
  if (annualHobbySportNameEn != null) {
    getBigDataAnnualReportInfoEntity.annualHobbySportNameEn =
        annualHobbySportNameEn;
  }
  final String? annualHobbySportNameTw = jsonConvert.convert<String>(
      json['annualHobbySportNameTw']);
  if (annualHobbySportNameTw != null) {
    getBigDataAnnualReportInfoEntity.annualHobbySportNameTw =
        annualHobbySportNameTw;
  }
  final int? annualHobbyTournament = jsonConvert.convert<int>(
      json['annualHobbyTournament']);
  if (annualHobbyTournament != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyTournament =
        annualHobbyTournament;
  }
  final int? annualHobbyTournamentBackgroundType = jsonConvert.convert<int>(
      json['annualHobbyTournamentBackgroundType']);
  if (annualHobbyTournamentBackgroundType != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyTournamentBackgroundType =
        annualHobbyTournamentBackgroundType;
  }
  final int? annualHobbyTournamentCount = jsonConvert.convert<int>(
      json['annualHobbyTournamentCount']);
  if (annualHobbyTournamentCount != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyTournamentCount =
        annualHobbyTournamentCount;
  }
  final String? annualHobbyTournamentNameCn = jsonConvert.convert<String>(
      json['annualHobbyTournamentNameCn']);
  if (annualHobbyTournamentNameCn != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyTournamentNameCn =
        annualHobbyTournamentNameCn;
  }
  final String? annualHobbyTournamentNameEn = jsonConvert.convert<String>(
      json['annualHobbyTournamentNameEn']);
  if (annualHobbyTournamentNameEn != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyTournamentNameEn =
        annualHobbyTournamentNameEn;
  }
  final String? annualHobbyTournamentNameTw = jsonConvert.convert<String>(
      json['annualHobbyTournamentNameTw']);
  if (annualHobbyTournamentNameTw != null) {
    getBigDataAnnualReportInfoEntity.annualHobbyTournamentNameTw =
        annualHobbyTournamentNameTw;
  }
  final int? annualMaxBetAmount = jsonConvert.convert<int>(
      json['annualMaxBetAmount']);
  if (annualMaxBetAmount != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmount = annualMaxBetAmount;
  }
  final String? annualMaxBetAmountCreateTime = jsonConvert.convert<String>(
      json['annualMaxBetAmountCreateTime']);
  if (annualMaxBetAmountCreateTime != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountCreateTime =
        annualMaxBetAmountCreateTime;
  }
  final int? annualMaxBetAmountDenseRank = jsonConvert.convert<int>(
      json['annualMaxBetAmountDenseRank']);
  if (annualMaxBetAmountDenseRank != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountDenseRank =
        annualMaxBetAmountDenseRank;
  }
  final int? annualMaxBetAmountMatchId = jsonConvert.convert<int>(
      json['annualMaxBetAmountMatchId']);
  if (annualMaxBetAmountMatchId != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountMatchId =
        annualMaxBetAmountMatchId;
  }
  final String? annualMaxBetAmountMatchIdNameCn = jsonConvert.convert<String>(
      json['annualMaxBetAmountMatchIdNameCn']);
  if (annualMaxBetAmountMatchIdNameCn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountMatchIdNameCn =
        annualMaxBetAmountMatchIdNameCn;
  }
  final String? annualMaxBetAmountMatchIdNameEn = jsonConvert.convert<String>(
      json['annualMaxBetAmountMatchIdNameEn']);
  if (annualMaxBetAmountMatchIdNameEn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountMatchIdNameEn =
        annualMaxBetAmountMatchIdNameEn;
  }
  final String? annualMaxBetAmountMatchIdNameTw = jsonConvert.convert<String>(
      json['annualMaxBetAmountMatchIdNameTw']);
  if (annualMaxBetAmountMatchIdNameTw != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountMatchIdNameTw =
        annualMaxBetAmountMatchIdNameTw;
  }
  final int? annualMaxBetAmountOrderNo = jsonConvert.convert<int>(
      json['annualMaxBetAmountOrderNo']);
  if (annualMaxBetAmountOrderNo != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountOrderNo =
        annualMaxBetAmountOrderNo;
  }
  final double? annualMaxBetAmountPercentRank = jsonConvert.convert<double>(
      json['annualMaxBetAmountPercentRank']);
  if (annualMaxBetAmountPercentRank != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountPercentRank =
        annualMaxBetAmountPercentRank;
  }
  final int? annualMaxBetAmountPlayId = jsonConvert.convert<int>(
      json['annualMaxBetAmountPlayId']);
  if (annualMaxBetAmountPlayId != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountPlayId =
        annualMaxBetAmountPlayId;
  }
  final String? annualMaxBetAmountPlayOptionNameCn = jsonConvert.convert<
      String>(json['annualMaxBetAmountPlayOptionNameCn']);
  if (annualMaxBetAmountPlayOptionNameCn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountPlayOptionNameCn =
        annualMaxBetAmountPlayOptionNameCn;
  }
  final String? annualMaxBetAmountPlayOptionNameEn = jsonConvert.convert<
      String>(json['annualMaxBetAmountPlayOptionNameEn']);
  if (annualMaxBetAmountPlayOptionNameEn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountPlayOptionNameEn =
        annualMaxBetAmountPlayOptionNameEn;
  }
  final String? annualMaxBetAmountPlayOptionNameTw = jsonConvert.convert<
      String>(json['annualMaxBetAmountPlayOptionNameTw']);
  if (annualMaxBetAmountPlayOptionNameTw != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountPlayOptionNameTw =
        annualMaxBetAmountPlayOptionNameTw;
  }
  final int? annualMaxBetAmountTournamentId = jsonConvert.convert<int>(
      json['annualMaxBetAmountTournamentId']);
  if (annualMaxBetAmountTournamentId != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountTournamentId =
        annualMaxBetAmountTournamentId;
  }
  final String? annualMaxBetAmountTournamentIdNameCn = jsonConvert.convert<
      String>(json['annualMaxBetAmountTournamentIdNameCn']);
  if (annualMaxBetAmountTournamentIdNameCn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountTournamentIdNameCn =
        annualMaxBetAmountTournamentIdNameCn;
  }
  final String? annualMaxBetAmountTournamentIdNameEn = jsonConvert.convert<
      String>(json['annualMaxBetAmountTournamentIdNameEn']);
  if (annualMaxBetAmountTournamentIdNameEn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountTournamentIdNameEn =
        annualMaxBetAmountTournamentIdNameEn;
  }
  final String? annualMaxBetAmountTournamentIdNameTw = jsonConvert.convert<
      String>(json['annualMaxBetAmountTournamentIdNameTw']);
  if (annualMaxBetAmountTournamentIdNameTw != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetAmountTournamentIdNameTw =
        annualMaxBetAmountTournamentIdNameTw;
  }
  final String? annualMaxBetCurrencyCn = jsonConvert.convert<String>(
      json['annualMaxBetCurrencyCn']);
  if (annualMaxBetCurrencyCn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetCurrencyCn =
        annualMaxBetCurrencyCn;
  }
  final String? annualMaxBetCurrencyEn = jsonConvert.convert<String>(
      json['annualMaxBetCurrencyEn']);
  if (annualMaxBetCurrencyEn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetCurrencyEn =
        annualMaxBetCurrencyEn;
  }
  final String? annualMaxBetCurrencyTw = jsonConvert.convert<String>(
      json['annualMaxBetCurrencyTw']);
  if (annualMaxBetCurrencyTw != null) {
    getBigDataAnnualReportInfoEntity.annualMaxBetCurrencyTw =
        annualMaxBetCurrencyTw;
  }
  final String? annualMaxSettleCurrencyCn = jsonConvert.convert<String>(
      json['annualMaxSettleCurrencyCn']);
  if (annualMaxSettleCurrencyCn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleCurrencyCn =
        annualMaxSettleCurrencyCn;
  }
  final String? annualMaxSettleCurrencyEn = jsonConvert.convert<String>(
      json['annualMaxSettleCurrencyEn']);
  if (annualMaxSettleCurrencyEn != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleCurrencyEn =
        annualMaxSettleCurrencyEn;
  }
  final String? annualMaxSettleCurrencyTw = jsonConvert.convert<String>(
      json['annualMaxSettleCurrencyTw']);
  if (annualMaxSettleCurrencyTw != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleCurrencyTw =
        annualMaxSettleCurrencyTw;
  }
  final int? annualMaxSettleAmount = jsonConvert.convert<int>(
      json['annualMaxSettleAmount']);
  if (annualMaxSettleAmount != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleAmount =
        annualMaxSettleAmount;
  }
  final String? annualMaxSettleAmountCreateTime = jsonConvert.convert<String>(
      json['annualMaxSettleAmountCreateTime']);
  if (annualMaxSettleAmountCreateTime != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleAmountCreateTime =
        annualMaxSettleAmountCreateTime;
  }
  final int? annualMaxSettleAmountDenseRank = jsonConvert.convert<int>(
      json['annualMaxSettleAmountDenseRank']);
  if (annualMaxSettleAmountDenseRank != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleAmountDenseRank =
        annualMaxSettleAmountDenseRank;
  }
  final int? annualMaxSettleAmountOrderNo = jsonConvert.convert<int>(
      json['annualMaxSettleAmountOrderNo']);
  if (annualMaxSettleAmountOrderNo != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleAmountOrderNo =
        annualMaxSettleAmountOrderNo;
  }
  final double? annualMaxSettleAmountPercentRank = jsonConvert.convert<double>(
      json['annualMaxSettleAmountPercentRank']);
  if (annualMaxSettleAmountPercentRank != null) {
    getBigDataAnnualReportInfoEntity.annualMaxSettleAmountPercentRank =
        annualMaxSettleAmountPercentRank;
  }
  final List<
      GetBigDataAnnualReportInfoAnnualUserTitle>? annualUserTitle = (json['annualUserTitle'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetBigDataAnnualReportInfoAnnualUserTitle>(
          e) as GetBigDataAnnualReportInfoAnnualUserTitle).toList();
  if (annualUserTitle != null) {
    getBigDataAnnualReportInfoEntity.annualUserTitle = annualUserTitle;
  }
  final int? diffFriendTime = jsonConvert.convert<int>(json['diffFriendTime']);
  if (diffFriendTime != null) {
    getBigDataAnnualReportInfoEntity.diffFriendTime = diffFriendTime;
  }
  final String? modifyDate = jsonConvert.convert<String>(json['modifyDate']);
  if (modifyDate != null) {
    getBigDataAnnualReportInfoEntity.modifyDate = modifyDate;
  }
  final int? timeYear = jsonConvert.convert<int>(json['timeYear']);
  if (timeYear != null) {
    getBigDataAnnualReportInfoEntity.timeYear = timeYear;
  }
  final int? uid = jsonConvert.convert<int>(json['uid']);
  if (uid != null) {
    getBigDataAnnualReportInfoEntity.uid = uid;
  }
  final String? userCreateTime = jsonConvert.convert<String>(
      json['userCreateTime']);
  if (userCreateTime != null) {
    getBigDataAnnualReportInfoEntity.userCreateTime = userCreateTime;
  }
  return getBigDataAnnualReportInfoEntity;
}

Map<String, dynamic> $GetBigDataAnnualReportInfoEntityToJson(
    GetBigDataAnnualReportInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['annualBetComboCount'] = entity.annualBetComboCount;
  data['annualBetCount'] = entity.annualBetCount;
  data['annualBetDenseRank'] = entity.annualBetDenseRank;
  data['annualBetPercentRank'] = entity.annualBetPercentRank;
  data['annualBetSingleCount'] = entity.annualBetSingleCount;
  data['annualHobbyBetTime'] = entity.annualHobbyBetTime;
  data['annualHobbyPlay'] = entity.annualHobbyPlay;
  data['annualHobbyPlayCount'] = entity.annualHobbyPlayCount;
  data['annualHobbyPlayNameCn'] = entity.annualHobbyPlayNameCn;
  data['annualHobbyPlayNameEn'] = entity.annualHobbyPlayNameEn;
  data['annualHobbyPlayNameTw'] = entity.annualHobbyPlayNameTw;
  data['annualHobbySport'] = entity.annualHobbySport;
  data['annualHobbySportBackgroundType'] =
      entity.annualHobbySportBackgroundType;
  data['annualHobbySportCount'] = entity.annualHobbySportCount;
  data['annualHobbySportNameCn'] = entity.annualHobbySportNameCn;
  data['annualHobbySportNameEn'] = entity.annualHobbySportNameEn;
  data['annualHobbySportNameTw'] = entity.annualHobbySportNameTw;
  data['annualHobbyTournament'] = entity.annualHobbyTournament;
  data['annualHobbyTournamentBackgroundType'] =
      entity.annualHobbyTournamentBackgroundType;
  data['annualHobbyTournamentCount'] = entity.annualHobbyTournamentCount;
  data['annualHobbyTournamentNameCn'] = entity.annualHobbyTournamentNameCn;
  data['annualHobbyTournamentNameEn'] = entity.annualHobbyTournamentNameEn;
  data['annualHobbyTournamentNameTw'] = entity.annualHobbyTournamentNameTw;
  data['annualMaxBetAmount'] = entity.annualMaxBetAmount;
  data['annualMaxBetAmountCreateTime'] = entity.annualMaxBetAmountCreateTime;
  data['annualMaxBetAmountDenseRank'] = entity.annualMaxBetAmountDenseRank;
  data['annualMaxBetAmountMatchId'] = entity.annualMaxBetAmountMatchId;
  data['annualMaxBetAmountMatchIdNameCn'] =
      entity.annualMaxBetAmountMatchIdNameCn;
  data['annualMaxBetAmountMatchIdNameEn'] =
      entity.annualMaxBetAmountMatchIdNameEn;
  data['annualMaxBetAmountMatchIdNameTw'] =
      entity.annualMaxBetAmountMatchIdNameTw;
  data['annualMaxBetAmountOrderNo'] = entity.annualMaxBetAmountOrderNo;
  data['annualMaxBetAmountPercentRank'] = entity.annualMaxBetAmountPercentRank;
  data['annualMaxBetAmountPlayId'] = entity.annualMaxBetAmountPlayId;
  data['annualMaxBetAmountPlayOptionNameCn'] =
      entity.annualMaxBetAmountPlayOptionNameCn;
  data['annualMaxBetAmountPlayOptionNameEn'] =
      entity.annualMaxBetAmountPlayOptionNameEn;
  data['annualMaxBetAmountPlayOptionNameTw'] =
      entity.annualMaxBetAmountPlayOptionNameTw;
  data['annualMaxBetAmountTournamentId'] =
      entity.annualMaxBetAmountTournamentId;
  data['annualMaxBetAmountTournamentIdNameCn'] =
      entity.annualMaxBetAmountTournamentIdNameCn;
  data['annualMaxBetAmountTournamentIdNameEn'] =
      entity.annualMaxBetAmountTournamentIdNameEn;
  data['annualMaxBetAmountTournamentIdNameTw'] =
      entity.annualMaxBetAmountTournamentIdNameTw;
  data['annualMaxBetCurrencyCn'] = entity.annualMaxBetCurrencyCn;
  data['annualMaxBetCurrencyEn'] = entity.annualMaxBetCurrencyEn;
  data['annualMaxBetCurrencyTw'] = entity.annualMaxBetCurrencyTw;
  data['annualMaxSettleCurrencyCn'] = entity.annualMaxSettleCurrencyCn;
  data['annualMaxSettleCurrencyEn'] = entity.annualMaxSettleCurrencyEn;
  data['annualMaxSettleCurrencyTw'] = entity.annualMaxSettleCurrencyTw;
  data['annualMaxSettleAmount'] = entity.annualMaxSettleAmount;
  data['annualMaxSettleAmountCreateTime'] =
      entity.annualMaxSettleAmountCreateTime;
  data['annualMaxSettleAmountDenseRank'] =
      entity.annualMaxSettleAmountDenseRank;
  data['annualMaxSettleAmountOrderNo'] = entity.annualMaxSettleAmountOrderNo;
  data['annualMaxSettleAmountPercentRank'] =
      entity.annualMaxSettleAmountPercentRank;
  data['annualUserTitle'] =
      entity.annualUserTitle.map((v) => v.toJson()).toList();
  data['diffFriendTime'] = entity.diffFriendTime;
  data['modifyDate'] = entity.modifyDate;
  data['timeYear'] = entity.timeYear;
  data['uid'] = entity.uid;
  data['userCreateTime'] = entity.userCreateTime;
  return data;
}

extension GetBigDataAnnualReportInfoEntityExtension on GetBigDataAnnualReportInfoEntity {
  GetBigDataAnnualReportInfoEntity copyWith({
    int? annualBetComboCount,
    int? annualBetCount,
    int? annualBetDenseRank,
    String? annualBetPercentRank,
    int? annualBetSingleCount,
    int? annualHobbyBetTime,
    int? annualHobbyPlay,
    int? annualHobbyPlayCount,
    String? annualHobbyPlayNameCn,
    String? annualHobbyPlayNameEn,
    String? annualHobbyPlayNameTw,
    int? annualHobbySport,
    int? annualHobbySportBackgroundType,
    int? annualHobbySportCount,
    String? annualHobbySportNameCn,
    String? annualHobbySportNameEn,
    String? annualHobbySportNameTw,
    int? annualHobbyTournament,
    int? annualHobbyTournamentBackgroundType,
    int? annualHobbyTournamentCount,
    String? annualHobbyTournamentNameCn,
    String? annualHobbyTournamentNameEn,
    String? annualHobbyTournamentNameTw,
    int? annualMaxBetAmount,
    String? annualMaxBetAmountCreateTime,
    int? annualMaxBetAmountDenseRank,
    int? annualMaxBetAmountMatchId,
    String? annualMaxBetAmountMatchIdNameCn,
    String? annualMaxBetAmountMatchIdNameEn,
    String? annualMaxBetAmountMatchIdNameTw,
    int? annualMaxBetAmountOrderNo,
    double? annualMaxBetAmountPercentRank,
    int? annualMaxBetAmountPlayId,
    String? annualMaxBetAmountPlayOptionNameCn,
    String? annualMaxBetAmountPlayOptionNameEn,
    String? annualMaxBetAmountPlayOptionNameTw,
    int? annualMaxBetAmountTournamentId,
    String? annualMaxBetAmountTournamentIdNameCn,
    String? annualMaxBetAmountTournamentIdNameEn,
    String? annualMaxBetAmountTournamentIdNameTw,
    String? annualMaxBetCurrencyCn,
    String? annualMaxBetCurrencyEn,
    String? annualMaxBetCurrencyTw,
    String? annualMaxSettleCurrencyCn,
    String? annualMaxSettleCurrencyEn,
    String? annualMaxSettleCurrencyTw,
    int? annualMaxSettleAmount,
    String? annualMaxSettleAmountCreateTime,
    int? annualMaxSettleAmountDenseRank,
    int? annualMaxSettleAmountOrderNo,
    double? annualMaxSettleAmountPercentRank,
    List<GetBigDataAnnualReportInfoAnnualUserTitle>? annualUserTitle,
    int? diffFriendTime,
    String? modifyDate,
    int? timeYear,
    int? uid,
    String? userCreateTime,
  }) {
    return GetBigDataAnnualReportInfoEntity()
      ..annualBetComboCount = annualBetComboCount ?? this.annualBetComboCount
      ..annualBetCount = annualBetCount ?? this.annualBetCount
      ..annualBetDenseRank = annualBetDenseRank ?? this.annualBetDenseRank
      ..annualBetPercentRank = annualBetPercentRank ?? this.annualBetPercentRank
      ..annualBetSingleCount = annualBetSingleCount ?? this.annualBetSingleCount
      ..annualHobbyBetTime = annualHobbyBetTime ?? this.annualHobbyBetTime
      ..annualHobbyPlay = annualHobbyPlay ?? this.annualHobbyPlay
      ..annualHobbyPlayCount = annualHobbyPlayCount ?? this.annualHobbyPlayCount
      ..annualHobbyPlayNameCn = annualHobbyPlayNameCn ??
          this.annualHobbyPlayNameCn
      ..annualHobbyPlayNameEn = annualHobbyPlayNameEn ??
          this.annualHobbyPlayNameEn
      ..annualHobbyPlayNameTw = annualHobbyPlayNameTw ??
          this.annualHobbyPlayNameTw
      ..annualHobbySport = annualHobbySport ?? this.annualHobbySport
      ..annualHobbySportBackgroundType = annualHobbySportBackgroundType ??
          this.annualHobbySportBackgroundType
      ..annualHobbySportCount = annualHobbySportCount ??
          this.annualHobbySportCount
      ..annualHobbySportNameCn = annualHobbySportNameCn ??
          this.annualHobbySportNameCn
      ..annualHobbySportNameEn = annualHobbySportNameEn ??
          this.annualHobbySportNameEn
      ..annualHobbySportNameTw = annualHobbySportNameTw ??
          this.annualHobbySportNameTw
      ..annualHobbyTournament = annualHobbyTournament ??
          this.annualHobbyTournament
      ..annualHobbyTournamentBackgroundType = annualHobbyTournamentBackgroundType ??
          this.annualHobbyTournamentBackgroundType
      ..annualHobbyTournamentCount = annualHobbyTournamentCount ??
          this.annualHobbyTournamentCount
      ..annualHobbyTournamentNameCn = annualHobbyTournamentNameCn ??
          this.annualHobbyTournamentNameCn
      ..annualHobbyTournamentNameEn = annualHobbyTournamentNameEn ??
          this.annualHobbyTournamentNameEn
      ..annualHobbyTournamentNameTw = annualHobbyTournamentNameTw ??
          this.annualHobbyTournamentNameTw
      ..annualMaxBetAmount = annualMaxBetAmount ?? this.annualMaxBetAmount
      ..annualMaxBetAmountCreateTime = annualMaxBetAmountCreateTime ??
          this.annualMaxBetAmountCreateTime
      ..annualMaxBetAmountDenseRank = annualMaxBetAmountDenseRank ??
          this.annualMaxBetAmountDenseRank
      ..annualMaxBetAmountMatchId = annualMaxBetAmountMatchId ??
          this.annualMaxBetAmountMatchId
      ..annualMaxBetAmountMatchIdNameCn = annualMaxBetAmountMatchIdNameCn ??
          this.annualMaxBetAmountMatchIdNameCn
      ..annualMaxBetAmountMatchIdNameEn = annualMaxBetAmountMatchIdNameEn ??
          this.annualMaxBetAmountMatchIdNameEn
      ..annualMaxBetAmountMatchIdNameTw = annualMaxBetAmountMatchIdNameTw ??
          this.annualMaxBetAmountMatchIdNameTw
      ..annualMaxBetAmountOrderNo = annualMaxBetAmountOrderNo ??
          this.annualMaxBetAmountOrderNo
      ..annualMaxBetAmountPercentRank = annualMaxBetAmountPercentRank ??
          this.annualMaxBetAmountPercentRank
      ..annualMaxBetAmountPlayId = annualMaxBetAmountPlayId ??
          this.annualMaxBetAmountPlayId
      ..annualMaxBetAmountPlayOptionNameCn = annualMaxBetAmountPlayOptionNameCn ??
          this.annualMaxBetAmountPlayOptionNameCn
      ..annualMaxBetAmountPlayOptionNameEn = annualMaxBetAmountPlayOptionNameEn ??
          this.annualMaxBetAmountPlayOptionNameEn
      ..annualMaxBetAmountPlayOptionNameTw = annualMaxBetAmountPlayOptionNameTw ??
          this.annualMaxBetAmountPlayOptionNameTw
      ..annualMaxBetAmountTournamentId = annualMaxBetAmountTournamentId ??
          this.annualMaxBetAmountTournamentId
      ..annualMaxBetAmountTournamentIdNameCn = annualMaxBetAmountTournamentIdNameCn ??
          this.annualMaxBetAmountTournamentIdNameCn
      ..annualMaxBetAmountTournamentIdNameEn = annualMaxBetAmountTournamentIdNameEn ??
          this.annualMaxBetAmountTournamentIdNameEn
      ..annualMaxBetAmountTournamentIdNameTw = annualMaxBetAmountTournamentIdNameTw ??
          this.annualMaxBetAmountTournamentIdNameTw
      ..annualMaxBetCurrencyCn = annualMaxBetCurrencyCn ??
          this.annualMaxBetCurrencyCn
      ..annualMaxBetCurrencyEn = annualMaxBetCurrencyEn ??
          this.annualMaxBetCurrencyEn
      ..annualMaxBetCurrencyTw = annualMaxBetCurrencyTw ??
          this.annualMaxBetCurrencyTw
      ..annualMaxSettleCurrencyCn = annualMaxSettleCurrencyCn ??
          this.annualMaxSettleCurrencyCn
      ..annualMaxSettleCurrencyEn = annualMaxSettleCurrencyEn ??
          this.annualMaxSettleCurrencyEn
      ..annualMaxSettleCurrencyTw = annualMaxSettleCurrencyTw ??
          this.annualMaxSettleCurrencyTw
      ..annualMaxSettleAmount = annualMaxSettleAmount ??
          this.annualMaxSettleAmount
      ..annualMaxSettleAmountCreateTime = annualMaxSettleAmountCreateTime ??
          this.annualMaxSettleAmountCreateTime
      ..annualMaxSettleAmountDenseRank = annualMaxSettleAmountDenseRank ??
          this.annualMaxSettleAmountDenseRank
      ..annualMaxSettleAmountOrderNo = annualMaxSettleAmountOrderNo ??
          this.annualMaxSettleAmountOrderNo
      ..annualMaxSettleAmountPercentRank = annualMaxSettleAmountPercentRank ??
          this.annualMaxSettleAmountPercentRank
      ..annualUserTitle = annualUserTitle ?? this.annualUserTitle
      ..diffFriendTime = diffFriendTime ?? this.diffFriendTime
      ..modifyDate = modifyDate ?? this.modifyDate
      ..timeYear = timeYear ?? this.timeYear
      ..uid = uid ?? this.uid
      ..userCreateTime = userCreateTime ?? this.userCreateTime;
  }
}

GetBigDataAnnualReportInfoAnnualUserTitle $GetBigDataAnnualReportInfoAnnualUserTitleFromJson(
    Map<String, dynamic> json) {
  final GetBigDataAnnualReportInfoAnnualUserTitle getBigDataAnnualReportInfoAnnualUserTitle = GetBigDataAnnualReportInfoAnnualUserTitle();
  final String? titleDescribeCn = jsonConvert.convert<String>(
      json['titleDescribeCn']);
  if (titleDescribeCn != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.titleDescribeCn = titleDescribeCn;
  }
  final String? titleDescribeEn = jsonConvert.convert<String>(
      json['titleDescribeEn']);
  if (titleDescribeEn != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.titleDescribeEn = titleDescribeEn;
  }
  final String? titleDescribeTw = jsonConvert.convert<String>(
      json['titleDescribeTw']);
  if (titleDescribeTw != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.titleDescribeTw = titleDescribeTw;
  }
  final int? titleId = jsonConvert.convert<int>(json['titleId']);
  if (titleId != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.titleId = titleId;
  }
  final String? titleNameCn = jsonConvert.convert<String>(json['titleNameCn']);
  if (titleNameCn != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.titleNameCn = titleNameCn;
  }
  final String? titleNameEn = jsonConvert.convert<String>(json['titleNameEn']);
  if (titleNameEn != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.titleNameEn = titleNameEn;
  }
  final String? titleNameTw = jsonConvert.convert<String>(json['titleNameTw']);
  if (titleNameTw != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.titleNameTw = titleNameTw;
  }
  final int? uid = jsonConvert.convert<int>(json['uid']);
  if (uid != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.uid = uid;
  }
  final int? yearId = jsonConvert.convert<int>(json['yearId']);
  if (yearId != null) {
    getBigDataAnnualReportInfoAnnualUserTitle.yearId = yearId;
  }
  return getBigDataAnnualReportInfoAnnualUserTitle;
}

Map<String, dynamic> $GetBigDataAnnualReportInfoAnnualUserTitleToJson(
    GetBigDataAnnualReportInfoAnnualUserTitle entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['titleDescribeCn'] = entity.titleDescribeCn;
  data['titleDescribeEn'] = entity.titleDescribeEn;
  data['titleDescribeTw'] = entity.titleDescribeTw;
  data['titleId'] = entity.titleId;
  data['titleNameCn'] = entity.titleNameCn;
  data['titleNameEn'] = entity.titleNameEn;
  data['titleNameTw'] = entity.titleNameTw;
  data['uid'] = entity.uid;
  data['yearId'] = entity.yearId;
  return data;
}

extension GetBigDataAnnualReportInfoAnnualUserTitleExtension on GetBigDataAnnualReportInfoAnnualUserTitle {
  GetBigDataAnnualReportInfoAnnualUserTitle copyWith({
    String? titleDescribeCn,
    String? titleDescribeEn,
    String? titleDescribeTw,
    int? titleId,
    String? titleNameCn,
    String? titleNameEn,
    String? titleNameTw,
    int? uid,
    int? yearId,
  }) {
    return GetBigDataAnnualReportInfoAnnualUserTitle()
      ..titleDescribeCn = titleDescribeCn ?? this.titleDescribeCn
      ..titleDescribeEn = titleDescribeEn ?? this.titleDescribeEn
      ..titleDescribeTw = titleDescribeTw ?? this.titleDescribeTw
      ..titleId = titleId ?? this.titleId
      ..titleNameCn = titleNameCn ?? this.titleNameCn
      ..titleNameEn = titleNameEn ?? this.titleNameEn
      ..titleNameTw = titleNameTw ?? this.titleNameTw
      ..uid = uid ?? this.uid
      ..yearId = yearId ?? this.yearId;
  }
}