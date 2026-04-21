class MemberVipGifytConfigModel {
  final String? upgradeGift;
  final String? birthdayGift;
  final String? weeklyGift;
  final String? rebateTurnoverLimit;
  final int? vipLevel;
  final String? birthdayGiftTurnoverMultiple;
  final int? id;
  final String? weeklyGiftTurnoverMultiple;
  final String? upgradeGiftTurnoverMultiple;
  final String? dailyWithdrawAmount;
  final String? upgradeTurnover;
  final num? dailyWithdrawTimes;
  final String? upgradeDeposit;
  final String? retainTurnover;
  final String? appTips;
  final String? appDescription;

  MemberVipGifytConfigModel(
      {this.upgradeGift,
      this.birthdayGift,
      this.weeklyGift,
      this.vipLevel,
      this.birthdayGiftTurnoverMultiple,
      this.rebateTurnoverLimit,
      this.weeklyGiftTurnoverMultiple,
      this.upgradeGiftTurnoverMultiple,
      this.dailyWithdrawAmount,
      this.dailyWithdrawTimes,
      this.upgradeTurnover,
      this.upgradeDeposit,
      this.retainTurnover,
      this.appTips,
      this.appDescription,
      this.id});

  factory MemberVipGifytConfigModel.fromJson(Map<String, dynamic> json) {
    return MemberVipGifytConfigModel(
      id: json['id'],
      vipLevel: json['vip_level'],
      upgradeGift: json['upgrade_gift'],
      upgradeDeposit: json['upgrade_deposit'],
      upgradeGiftTurnoverMultiple: json['upgrade_gift_turnover_multiple'],
      birthdayGift: json['birthday_gift'],
      weeklyGift: json['weekly_gift'],
      dailyWithdrawAmount: json['daily_withdraw_amount'],
      dailyWithdrawTimes: json['daily_withdraw_times'],
      upgradeTurnover: json['upgrade_turnover'],
      retainTurnover: json['retain_turnover'],
      weeklyGiftTurnoverMultiple: json['weekly_gift_turnover_multiple'],
      birthdayGiftTurnoverMultiple: json['birthday_gift_turnover_multiple'],
      appTips: json['app_tips'],
      appDescription: json['app_description'],
    );
  }
}
