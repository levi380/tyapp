/// id : 0
/// vip_level : 0
/// upgrade_deposit : "0.00"
/// upgrade_turnover : "0.00"
/// retain_turnover : "0.00"
/// retain_days : 30
/// daily_withdraw_times : 1
/// daily_withdraw_amount : "0.00"
/// create_time : 1720166400
/// update_time : 1720166400

class VipSettingModel {
  VipSettingModel({
      this.id, 
      this.vipLevel, 
      this.upgradeDeposit, 
      this.upgradeTurnover, 
      this.retainTurnover, 
      this.retainDays, 
      this.dailyWithdrawTimes, 
      this.dailyWithdrawAmount, 
      this.createTime, 
      this.updateTime,});

  VipSettingModel.fromJson(dynamic json) {
    id = json['id'];
    vipLevel = json['vip_level'];
    upgradeDeposit = json['upgrade_deposit'];
    upgradeTurnover = json['upgrade_turnover'];
    retainTurnover = json['retain_turnover'];
    retainDays = json['retain_days'];
    dailyWithdrawTimes = json['daily_withdraw_times'];
    dailyWithdrawAmount = json['daily_withdraw_amount'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }
  num? id;
  num? vipLevel;
  String? upgradeDeposit;
  String? upgradeTurnover;
  String? retainTurnover;
  num? retainDays;
  num? dailyWithdrawTimes;
  String? dailyWithdrawAmount;
  num? createTime;
  num? updateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['vip_level'] = vipLevel;
    map['upgrade_deposit'] = upgradeDeposit;
    map['upgrade_turnover'] = upgradeTurnover;
    map['retain_turnover'] = retainTurnover;
    map['retain_days'] = retainDays;
    map['daily_withdraw_times'] = dailyWithdrawTimes;
    map['daily_withdraw_amount'] = dailyWithdrawAmount;
    map['create_time'] = createTime;
    map['update_time'] = updateTime;
    return map;
  }

}