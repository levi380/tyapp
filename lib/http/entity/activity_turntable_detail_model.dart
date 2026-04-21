import 'package:filbet/http/entity/promo.dart';

/// promo : {"id":"","name":"","ty":4,"state":2,"start_at":0,"end_at":0,"images":"{\"web_list\":\"...\"}","summary":""}
/// config : {"plays":[{"play_type":1,"web_title":"","h5_title":"","web_spinner_bg":"","web_rule_bg":"","h5_spinner_bg":"","h5_rule_bg":"","target_type":1,"vip_levels":[1,2],"get_amount":"1000","get_type":1,"prizes":[{"prize_id":"prize_001","prize_name":"一等奖","reward_type":1,"reward_value":"100","prize_img":"...","is_default":2,"is_unlimited":2}]}],"page_config":{"web_main":"","web_bg":"","h5_main":"","h5_bg":"","share_img":""}}
/// play1_enabled : true
/// play2_enabled : true
/// times : {"play1_available":5,"play1_total_get":10,"play1_total_used":5,"play2_available":3,"play2_total_get":8,"play2_total_used":5,"play1_enabled":true,"play2_enabled":true}

class ActivityTurntableDetailModel {
  ActivityTurntableDetailModel({
    this.promo,
    this.config,
    this.play1Enabled,
    this.play2Enabled,
    this.times,
  });

  ActivityTurntableDetailModel.fromJson(dynamic json) {
    promo = json['promo'] != null ? Promo.fromJson(json['promo']) : null;
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
    play1Enabled = json['play1_enabled'];
    play2Enabled = json['play2_enabled'];
    times = json['times'] != null ? Times.fromJson(json['times']) : null;
  }

  Promo? promo;
  Config? config;
  bool? play1Enabled;
  bool? play2Enabled;
  Times? times;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (promo != null) {
      map['promo'] = promo?.toJson();
    }
    if (config != null) {
      map['config'] = config?.toJson();
    }
    map['play1_enabled'] = play1Enabled;
    map['play2_enabled'] = play2Enabled;
    if (times != null) {
      map['times'] = times?.toJson();
    }
    return map;
  }
}

/// play1_available : 5
/// play1_total_get : 10
/// play1_total_used : 5
/// play2_available : 3
/// play2_total_get : 8
/// play2_total_used : 5
/// play1_enabled : true
/// play2_enabled : true

class Times {
  Times({
    this.play1Available,
    this.play1TotalGet,
    this.play1TotalUsed,
    this.play2Available,
    this.play2TotalGet,
    this.play2TotalUsed,
    this.play1Enabled,
    this.play2Enabled,
  });

  Times.fromJson(dynamic json) {
    play1Available = json['play1_available'];
    play1TotalGet = json['play1_total_get'];
    play1TotalUsed = json['play1_total_used'];
    play2Available = json['play2_available'];
    play2TotalGet = json['play2_total_get'];
    play2TotalUsed = json['play2_total_used'];
    play1Enabled = json['play1_enabled'];
    play2Enabled = json['play2_enabled'];
  }

  num? play1Available;
  num? play1TotalGet;
  num? play1TotalUsed;
  num? play2Available;
  num? play2TotalGet;
  num? play2TotalUsed;
  bool? play1Enabled;
  bool? play2Enabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['play1_available'] = play1Available;
    map['play1_total_get'] = play1TotalGet;
    map['play1_total_used'] = play1TotalUsed;
    map['play2_available'] = play2Available;
    map['play2_total_get'] = play2TotalGet;
    map['play2_total_used'] = play2TotalUsed;
    map['play1_enabled'] = play1Enabled;
    map['play2_enabled'] = play2Enabled;
    return map;
  }
}

/// plays : [{"play_type":1,"web_title":"","h5_title":"","web_spinner_bg":"","web_rule_bg":"","h5_spinner_bg":"","h5_rule_bg":"","target_type":1,"vip_levels":[1,2],"get_amount":"1000","get_type":1,"prizes":[{"prize_id":"prize_001","prize_name":"一等奖","reward_type":1,"reward_value":"100","prize_img":"...","is_default":2,"is_unlimited":2}]}]
/// page_config : {"web_main":"","web_bg":"","h5_main":"","h5_bg":"","share_img":""}

class Config {
  Config({
    this.plays,
    this.pageConfig,
  });

  Config.fromJson(dynamic json) {
    if (json['plays'] != null) {
      plays = [];
      json['plays'].forEach((v) {
        plays?.add(Plays.fromJson(v));
      });
    }
    pageConfig = json['page_config'] != null
        ? PageConfig.fromJson(json['page_config'])
        : null;
  }

  List<Plays>? plays;
  PageConfig? pageConfig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (plays != null) {
      map['plays'] = plays?.map((v) => v.toJson()).toList();
    }
    if (pageConfig != null) {
      map['page_config'] = pageConfig?.toJson();
    }
    return map;
  }
}

/// web_main : ""
/// web_bg : ""
/// h5_main : ""
/// h5_bg : ""
/// share_img : ""

class PageConfig {
  PageConfig({
    this.webMain,
    this.webBg,
    this.h5Main,
    this.h5Bg,
    this.shareImg,
  });

  PageConfig.fromJson(dynamic json) {
    webMain = json['web_main'];
    webBg = json['web_bg'];
    h5Main = json['h5_main'];
    h5Bg = json['h5_bg'];
    shareImg = json['share_img'];
  }

  String? webMain;
  String? webBg;
  String? h5Main;
  String? h5Bg;
  String? shareImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['web_main'] = webMain;
    map['web_bg'] = webBg;
    map['h5_main'] = h5Main;
    map['h5_bg'] = h5Bg;
    map['share_img'] = shareImg;
    return map;
  }
}

/// play_type : 1
/// web_title : ""
/// h5_title : ""
/// web_spinner_bg : ""
/// web_rule_bg : ""
/// h5_spinner_bg : ""
/// h5_rule_bg : ""
/// target_type : 1
/// vip_levels : [1,2]
/// get_amount : "1000"
/// get_type : 1
/// prizes : [{"prize_id":"prize_001","prize_name":"一等奖","reward_type":1,"reward_value":"100","prize_img":"...","is_default":2,"is_unlimited":2}]

class Plays {
  Plays({
    this.playType,
    this.webTitle,
    this.h5Title,
    this.webSpinnerBg,
    this.webRuleBg,
    this.h5SpinnerBg,
    this.h5RuleBg,
    this.targetType,
    this.vipLevels,
    this.getAmount,
    this.getType,
    this.prizes,
  });

  Plays.fromJson(dynamic json) {
    playType = json['play_type'];
    webTitle = json['web_title'];
    h5Title = json['h5_title'];
    webSpinnerBg = json['web_spinner_bg'];
    webRuleBg = json['web_rule_bg'];
    h5SpinnerBg = json['h5_spinner_bg'];
    h5PrizeList = json['h5_prize_list'];
    h5RuleBg = json['h5_rule_bg'];
    targetType = json['target_type'];
    vipLevels =
        json['vip_levels'] != null ? json['vip_levels'].cast<num>() : [];
    getAmount = json['get_amount'];
    getType = json['get_type'];
    statStartAt = json['stat_start_at'];
    statEndAt = json['stat_end_at'];
    if (json['prizes'] != null) {
      prizes = [];
      json['prizes'].forEach((v) {
        prizes?.add(Prizes.fromJson(v));
      });
    }
  }

  num? playType;
  String? webTitle;
  String? h5Title;
  String? webSpinnerBg;
  String? webRuleBg;
  String? h5SpinnerBg;
  String? h5PrizeList;
  String? h5RuleBg;
  num? targetType;
  List<num>? vipLevels;
  String? getAmount;
  num? getType;
  List<Prizes>? prizes;
  num? statStartAt;
  num? statEndAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['play_type'] = playType;
    map['web_title'] = webTitle;
    map['h5_title'] = h5Title;
    map['web_spinner_bg'] = webSpinnerBg;
    map['web_rule_bg'] = webRuleBg;
    map['h5_spinner_bg'] = h5SpinnerBg;
    map['h5_rule_bg'] = h5RuleBg;
    map['target_type'] = targetType;
    map['vip_levels'] = vipLevels;
    map['get_amount'] = getAmount;
    map['get_type'] = getType;
    if (prizes != null) {
      map['prizes'] = prizes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// prize_id : "prize_001"
/// prize_name : "一等奖"
/// reward_type : 1
/// reward_value : "100"
/// prize_img : "..."
/// is_default : 2
/// is_unlimited : 2

class Prizes {
  Prizes({
    this.prizeId,
    this.prizeName,
    this.rewardType,
    this.rewardValue,
    this.prizeImg,
    this.isDefault,
    this.isUnlimited,
    this.available,
  });

  Prizes.fromJson(dynamic json) {
    prizeId = json['prize_id'];
    prizeName = json['prize_name'];
    rewardType = json['reward_type'];
    rewardValue = json['reward_value'];
    prizeImg = json['prize_img'];
    isDefault = json['is_default'];
    isUnlimited = json['is_unlimited'];
    available = json['available'];
  }

  String? prizeId;
  String? prizeName;
  num? rewardType;
  String? rewardValue;
  String? prizeImg;
  num? isDefault;
  num? isUnlimited;
  num? available;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prize_id'] = prizeId;
    map['prize_name'] = prizeName;
    map['reward_type'] = rewardType;
    map['reward_value'] = rewardValue;
    map['prize_img'] = prizeImg;
    map['is_default'] = isDefault;
    map['is_unlimited'] = isUnlimited;
    return map;
  }
}

