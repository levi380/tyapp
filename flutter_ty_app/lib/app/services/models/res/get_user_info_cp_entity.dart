import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_user_info_cp_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_user_info_cp_entity.g.dart';

@JsonSerializable()
class GetUserInfoCpEntity {
	late bool status;
	late String message;
	late String code;
	late GetUserInfoCpData data;
	late int serverTime;
	late String msg;

	GetUserInfoCpEntity();

	factory GetUserInfoCpEntity.fromJson(Map<String, dynamic> json) => $GetUserInfoCpEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoCpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserInfoCpData {
	late int nextFeatureConfigId;
	late String chips;
	late bool delayed;
	late bool winBeep;
	late bool featureDelayed;
	late bool doubleBetConfirm;
	late bool doubleLimitStatus;
	late List<GetUserInfoCpDataFeatureBetRangeList> featureBetRangeList;
	late int nextConfigId;
	late String clientDisplayTicketNum;
	late String colorTheme;
	late String featureDelayedTime;
	late bool virtualKeyboard;
	late bool coldHot;
	late String delayedTime;
	late int selectFeatureConfigId;
	late bool featureLimitStatus;
	late bool quickConfirm;
	late int memberId;
	late bool longDragonNumPrompt;
	late List<GetUserInfoCpDataDoubleBetRangeList> doubleBetRangeList = [];
	late int longDragonLimit;
	late String periodMaxProfitFlag;
	late List<GetUserInfoCpDataLongDragonTickets> longDragonTickets = [];
	late bool winModal;
	late bool countDownBeep;
	late int selectConfigId;
	late List<dynamic> lztConf;
	late int longDragonLimitMax;
	late bool missRemind;

	GetUserInfoCpData();

	factory GetUserInfoCpData.fromJson(Map<String, dynamic> json) => $GetUserInfoCpDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoCpDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserInfoCpDataFeatureBetRangeList {
	late int doublePlayBetMax;
	late bool current;
	late int configId;
	late int doublePlayBetMin;
	late bool nextSelect;

	GetUserInfoCpDataFeatureBetRangeList();

	factory GetUserInfoCpDataFeatureBetRangeList.fromJson(Map<String, dynamic> json) => $GetUserInfoCpDataFeatureBetRangeListFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoCpDataFeatureBetRangeListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserInfoCpDataDoubleBetRangeList {
	late int doublePlayBetMax;
	late bool current;
	late int configId;
	late int doublePlayBetMin;
	late bool nextSelect;

	GetUserInfoCpDataDoubleBetRangeList();

	factory GetUserInfoCpDataDoubleBetRangeList.fromJson(Map<String, dynamic> json) => $GetUserInfoCpDataDoubleBetRangeListFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoCpDataDoubleBetRangeListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserInfoCpDataLongDragonTickets {
	late int seriesId;
	late String ticketIds;

	GetUserInfoCpDataLongDragonTickets();

	factory GetUserInfoCpDataLongDragonTickets.fromJson(Map<String, dynamic> json) => $GetUserInfoCpDataLongDragonTicketsFromJson(json);

	Map<String, dynamic> toJson() => $GetUserInfoCpDataLongDragonTicketsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}