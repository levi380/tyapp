/// name : "签到第二天"
/// images : ""
/// summary : ""
/// currency : 102
/// current_streak : 0
/// streak_reward_amt : ""
/// streak_target : 2
/// streak_target_amt : "10"
/// days : [{"date":"2025-08-13","day_index":13,"status":0,"reward_amt":1}]

class DailySignDetail {
  DailySignDetail({
      this.name, 
      this.images, 
      this.summary, 
      this.currency, 
      this.currentStreak, 
      this.streakRewardAmt, 
      this.streakTarget, 
      this.streakTargetAmt, 
      this.days,});

  DailySignDetail.fromJson(dynamic json) {
    name = json['name'];
    images = json['images'];
    summary = json['summary']?.toString()??"";
    currency = json['currency']?.toString()??"";
    currentStreak = json['current_streak']?.toString()??"";
    streakRewardAmt = json['streak_reward_amt']?.toString()??"";
    streakTarget = json['streak_target']?.toString()??"";
    streakTargetAmt = json['streak_target_amt']?.toString()??"";
    if (json['days'] != null) {
      days = [];
      json['days'].forEach((v) {
        days?.add(Days.fromJson(v));
      });
    }
  }
  String? name;
  String? images;
  String? summary;
  String? currency;
  String? currentStreak;
  String? streakRewardAmt;
  String? streakTarget;
  String? streakTargetAmt;
  List<Days>? days;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['images'] = images;
    map['summary'] = summary;
    map['currency'] = currency;
    map['current_streak'] = currentStreak;
    map['streak_reward_amt'] = streakRewardAmt;
    map['streak_target'] = streakTarget;
    map['streak_target_amt'] = streakTargetAmt;
    if (days != null) {
      map['days'] = days?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2025-08-13"
/// day_index : 13
/// status : 0
/// reward_amt : 1

class Days {
  Days({
      this.date, 
      this.dayIndex, 
      this.status, 
      this.rewardAmt,});

  Days.fromJson(dynamic json) {
    date = json['date'];
    dayIndex = json['day_index'];
    status = json['status'];
    rewardAmt = json['reward_amt'];
  }
  String? date;//签到状态（1=已签到，0=未签到，3=已过期，4=未开始）
  num? dayIndex;
  num? status;
  String? rewardAmt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['day_index'] = dayIndex;
    map['status'] = status;
    map['reward_amt'] = rewardAmt;
    return map;
  }

}