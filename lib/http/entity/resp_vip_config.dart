import 'package:filbet/http/entity/vip_setting_model.dart';

/// setting : {"0":{"id":0,"vip_level":0,"upgrade_deposit":"0.00","upgrade_turnover":"0.00","retain_turnover":"0.00","retain_days":30,"daily_withdraw_times":1,"daily_withdraw_amount":"0.00","create_time":1720166400,"update_time":1720166400},"1":{"id":1,"vip_level":1,"upgrade_deposit":"100.00","upgrade_turnover":"1000.00","retain_turnover":"500.00","retain_days":30,"daily_withdraw_times":1,"daily_withdraw_amount":"1000.00","create_time":1720166400,"update_time":1720166400}}
/// weekly_bonus : [{"level":0,"week_index":1,"amount":"100.00","turnover_multiplier":"6.00","valid_days":7,"title":"每周红利","content":"完成指定流水即可领取","venue_ids":["101","102"],"distribution_day":"周一","turnover_condition":"1000","validity_type":"days","validity_value":7,"venue_configs":[{"venue_id":"101","turnover_multiplier":"6.00"},{"venue_id":"102","turnover_multiplier":"6.00"}]},{"level":1,"week_index":1,"amount":"200.00","turnover_multiplier":"6.00","valid_days":7,"title":"每周红利","content":"完成指定流水即可领取","venue_ids":["101"],"distribution_day":"周一","turnover_condition":"2000","validity_type":"days","validity_value":7,"venue_configs":[{"venue_id":"101","turnover_multiplier":"6.00"}]}]

class RespVipConfig {
  RespVipConfig({
    this.setting,
    this.weeklyBonus,
  });

  RespVipConfig.fromJson(dynamic json) {
    setting =
        json['setting'] != null ? Setting.fromJson(json['setting']) : null;
    if (json['weekly_bonus'] != null) {
      weeklyBonus = [];
      json['weekly_bonus'].forEach((v) {
        weeklyBonus?.add(WeeklyBonus.fromJson(v));
      });
    }
  }

  Setting? setting;
  List<WeeklyBonus>? weeklyBonus;
}

/// level : 0
/// week_index : 1
/// amount : "100.00"
/// turnover_multiplier : "6.00"
/// valid_days : 7
/// title : "每周红利"
/// content : "完成指定流水即可领取"
/// venue_ids : ["101","102"]
/// distribution_day : "周一"
/// turnover_condition : "1000"
/// validity_type : "days"
/// validity_value : 7
/// venue_configs : [{"venue_id":"101","turnover_multiplier":"6.00"},{"venue_id":"102","turnover_multiplier":"6.00"}]

class WeeklyBonus {
  WeeklyBonus({
    this.level,
    this.weekIndex,
    this.amount,
    this.turnoverMultiplier,
    this.validDays,
    this.title,
    this.content,
    this.venueIds,
    this.distributionDay,
    this.turnoverCondition,
    this.validityType,
    this.validityValue,
    this.venueConfigs,
  });

  WeeklyBonus.fromJson(dynamic json) {
    level = json['level'];
    weekIndex = json['week_index'];
    amount = json['amount'];
    turnoverMultiplier = json['turnover_multiplier'];
    validDays = json['valid_days'];
    title = json['title'];
    content = json['content'];
    venueIds =
        json['venue_ids'] != null ? json['venue_ids'].cast<String>() : [];
    distributionDay = json['distribution_day'];
    turnoverCondition = json['turnover_condition'];
    validityType = json['validity_type'];
    validityValue = json['validity_value'];
    if (json['venue_configs'] != null) {
      venueConfigs = [];
      json['venue_configs'].forEach((v) {
        venueConfigs?.add(VenueConfigs.fromJson(v));
      });
    }
  }

  num? level;
  num? weekIndex;
  String? amount;
  String? turnoverMultiplier;
  num? validDays;
  String? title;
  String? content;
  List<String>? venueIds;
  String? distributionDay;
  String? turnoverCondition;
  String? validityType;
  num? validityValue;
  List<VenueConfigs>? venueConfigs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['level'] = level;
    map['week_index'] = weekIndex;
    map['amount'] = amount;
    map['turnover_multiplier'] = turnoverMultiplier;
    map['valid_days'] = validDays;
    map['title'] = title;
    map['content'] = content;
    map['venue_ids'] = venueIds;
    map['distribution_day'] = distributionDay;
    map['turnover_condition'] = turnoverCondition;
    map['validity_type'] = validityType;
    map['validity_value'] = validityValue;
    if (venueConfigs != null) {
      map['venue_configs'] = venueConfigs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// venue_id : "101"
/// turnover_multiplier : "6.00"

class VenueConfigs {
  VenueConfigs({
    this.venueId,
    this.turnoverMultiplier,
  });

  VenueConfigs.fromJson(dynamic json) {
    venueId = json['venue_id'];
    turnoverMultiplier = json['turnover_multiplier'];
  }

  String? name;
  String? venueId;
  String? turnoverMultiplier;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['venue_id'] = venueId;
    map['turnover_multiplier'] = turnoverMultiplier;
    return map;
  }
}

/// 0 : {"id":0,"vip_level":0,"upgrade_deposit":"0.00","upgrade_turnover":"0.00","retain_turnover":"0.00","retain_days":30,"daily_withdraw_times":1,"daily_withdraw_amount":"0.00","create_time":1720166400,"update_time":1720166400}
/// 1 : {"id":1,"vip_level":1,"upgrade_deposit":"100.00","upgrade_turnover":"1000.00","retain_turnover":"500.00","retain_days":30,"daily_withdraw_times":1,"daily_withdraw_amount":"1000.00","create_time":1720166400,"update_time":1720166400}

class Setting {
  Setting({
    this.vipSettingModels,
  });

  Setting.fromJson(dynamic json) {
    print("object1234567 1");
    print("object1234567 ${json.runtimeType}");
    print("object1234567 2");
    vipSettingModels = [];
    for (var key in json.keys) {
      if (json[key] != null) {
        print("object1234567");
        vipSettingModels?.add(VipSettingModel.fromJson(json[key]));
      }
    }
  }

  List<VipSettingModel>? vipSettingModels;
}
