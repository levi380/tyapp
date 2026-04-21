class MemberVipTextDataModel {
  final int? upgradeLevelGiftTurnoverLimit;
  final int? birthdayTurnoverLimit;
  final num? birthdayLimit;
  final int? weekGiftTurnoverLimit;
  final num? rebateTurnoverLimit;
  final int? declineLevelDayLimit;
  final int? vipMaxLevel;
  final int? everyLevelGetLevelgiftTimes;

  MemberVipTextDataModel({
    this.upgradeLevelGiftTurnoverLimit,
    this.birthdayLimit,
    this.birthdayTurnoverLimit,
    this.weekGiftTurnoverLimit,
    this.declineLevelDayLimit,
    this.vipMaxLevel,
    this.everyLevelGetLevelgiftTimes,
    this.rebateTurnoverLimit,
  });

  factory MemberVipTextDataModel.fromJson(Map<String, dynamic> json) {
    return MemberVipTextDataModel(
      birthdayLimit: json['birthday_limit'],
      birthdayTurnoverLimit: json['birthday_turnover_limit'],
      rebateTurnoverLimit: json['rebate_turnover_limit'],
      weekGiftTurnoverLimit: json['week_gift_turnover_limit'],
      declineLevelDayLimit: json['decline_level_day_limit'],
      vipMaxLevel: json['vip_max_level'],
      everyLevelGetLevelgiftTimes: json['every_level_get_levelgift_times'],
      upgradeLevelGiftTurnoverLimit: json['upgrade_level_gift_turnover_limit'],
    );
  }
}
