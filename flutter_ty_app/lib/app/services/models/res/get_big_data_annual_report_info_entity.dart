import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_big_data_annual_report_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_big_data_annual_report_info_entity.g.dart';

@JsonSerializable()
class GetBigDataAnnualReportInfoEntity {
	late int annualBetComboCount;
	late int annualBetCount;
	late int annualBetDenseRank;
	late String annualBetPercentRank;
	late int annualBetSingleCount;
	late int annualHobbyBetTime;
	late int annualHobbyPlay;
	late int annualHobbyPlayCount;
	late String annualHobbyPlayNameCn = '';
	late String annualHobbyPlayNameEn = '';
	late String annualHobbyPlayNameTw = '';
	late int annualHobbySport;
	late int annualHobbySportBackgroundType =1;
	late int annualHobbySportCount;
	late String annualHobbySportNameCn = '';
	late String annualHobbySportNameEn = '';
	late String annualHobbySportNameTw = '';
	late int annualHobbyTournament;
	late int annualHobbyTournamentBackgroundType =1;
	late int annualHobbyTournamentCount;
	late String annualHobbyTournamentNameCn = '';
	late String annualHobbyTournamentNameEn = '';
	late String annualHobbyTournamentNameTw = '';
	late int annualMaxBetAmount = 0;
	late String annualMaxBetAmountCreateTime = '';
	late int annualMaxBetAmountDenseRank;
	late int annualMaxBetAmountMatchId;
	late String annualMaxBetAmountMatchIdNameCn= '';
	late String annualMaxBetAmountMatchIdNameEn= '';
	late String annualMaxBetAmountMatchIdNameTw= '';
	late int annualMaxBetAmountOrderNo;
	late double annualMaxBetAmountPercentRank = 0.0;
	late int annualMaxBetAmountPlayId;
	late String annualMaxBetAmountPlayOptionNameCn= '';
	late String annualMaxBetAmountPlayOptionNameEn= '';
	late String annualMaxBetAmountPlayOptionNameTw= '';
	late int annualMaxBetAmountTournamentId;
	late String annualMaxBetAmountTournamentIdNameCn= '';
	late String annualMaxBetAmountTournamentIdNameEn= '';
	late String annualMaxBetAmountTournamentIdNameTw= '';
	late String annualMaxBetCurrencyCn= '';
	late String annualMaxBetCurrencyEn= '';
	late String annualMaxBetCurrencyTw= '';
	late String annualMaxSettleCurrencyCn= '';
	late String annualMaxSettleCurrencyEn= '';
	late String annualMaxSettleCurrencyTw= '';
	late int annualMaxSettleAmount =0;
	late String annualMaxSettleAmountCreateTime= '';
	late int annualMaxSettleAmountDenseRank;
	late int annualMaxSettleAmountOrderNo;
	late double annualMaxSettleAmountPercentRank =0;
	late List<GetBigDataAnnualReportInfoAnnualUserTitle> annualUserTitle;
	late int diffFriendTime;
	late String modifyDate= '';
	late int timeYear;
	late int uid;
	late String userCreateTime= '';

	GetBigDataAnnualReportInfoEntity();

	factory GetBigDataAnnualReportInfoEntity.fromJson(Map<String, dynamic> json) => $GetBigDataAnnualReportInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetBigDataAnnualReportInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBigDataAnnualReportInfoAnnualUserTitle {
	late String titleDescribeCn;
	late String titleDescribeEn;
	late String titleDescribeTw;
	late int titleId;
	late String titleNameCn;
	late String titleNameEn;
	late String titleNameTw;
	late int uid;
	late int yearId;

	GetBigDataAnnualReportInfoAnnualUserTitle();

	factory GetBigDataAnnualReportInfoAnnualUserTitle.fromJson(Map<String, dynamic> json) => $GetBigDataAnnualReportInfoAnnualUserTitleFromJson(json);

	Map<String, dynamic> toJson() => $GetBigDataAnnualReportInfoAnnualUserTitleToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}