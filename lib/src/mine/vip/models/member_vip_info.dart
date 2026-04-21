class MemberVipInfoModel {
  final String? currentDeposit;
  final String? targetDeposit;
  final int? currentLevel;
  final int? targetLevel;
  final String? keepDate;
  final String? currentTurnover;
  final String? exchangeVipCurrentTurnover;

  final String? targetTurnover; // 下一级别目标流水
  final String? currentKeepTurnover;
  final String? targetKeepTurnover;

  final bool? vipDepositExists;
  final String? keepDays;

  MemberVipInfoModel(
      {this.currentDeposit,
      this.targetDeposit,
      this.currentLevel,
      this.targetLevel,
      this.currentTurnover,
      this.targetTurnover,
      this.currentKeepTurnover,
      this.exchangeVipCurrentTurnover,
      this.targetKeepTurnover,
      this.keepDate,
      this.keepDays,
      this.vipDepositExists});

  factory MemberVipInfoModel.fromJson(Map<String, dynamic> json) {
    return MemberVipInfoModel(
      currentDeposit: json['current_deposit'],
      currentLevel: json['current_level'],
      targetLevel: json['target_level'],
      keepDate: "${json['keep_date'] ?? 0}",
      targetDeposit: json['target_deposit'],
      vipDepositExists: json['vip_deposit_exists'],
      currentTurnover: json['current_turnover'],
      targetTurnover: json['target_turnover'],
      currentKeepTurnover: json['current_keep_turnover'],
      targetKeepTurnover: json['target_keep_turnover'],
      exchangeVipCurrentTurnover: json['exchange_vip_current_turnover'],
      keepDays: json['keep_days'],
    );
  }

  bool get isMaxLevel {
    return currentLevel == 10;
  }
}
