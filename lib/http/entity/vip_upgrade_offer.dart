/// list : [{"vip_level":0,"min_transfer":"0.00","bonus_ratio":"0.00","max_bonus":"0.00","turnover_multiple":"0.00","apply_cycle":2,"platform_ids":[107],"status":1,"can_apply":true,"reason":""}]

class VipUpgradeOffer {
  VipUpgradeOffer({
    this.list,
  });

  VipUpgradeOffer.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(UpgradeOffer.fromJson(v));
      });
    }
  }

  List<UpgradeOffer>? list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// vip_level : 0
/// min_transfer : "0.00"
/// bonus_ratio : "0.00"
/// max_bonus : "0.00"
/// turnover_multiple : "0.00"
/// apply_cycle : 2
/// platform_ids : [107]
/// status : 1
/// can_apply : true
/// reason : ""

class UpgradeOffer {
  UpgradeOffer({
    this.vipLevel,
    this.minTransfer,
    this.bonusRatio,
    this.maxBonus,
    this.turnoverMultiple,
    this.applyCycle,
    this.platformIds,
    this.status,
    this.canApply,
    this.reason,
  });

  UpgradeOffer.fromJson(dynamic json) {
    vipLevel = json['vip_level'];
    minTransfer = json['min_transfer'];
    bonusRatio = json['bonus_ratio'];
    maxBonus = json['max_bonus'];
    turnoverMultiple = json['turnover_multiple'];
    applyCycle = json['apply_cycle'];
    // 安全地转换 platform_ids，处理可能的字符串类型
    if (json['platform_ids'] != null) {
      platformIds = [];
      for (var id in json['platform_ids']) {
        if (id is num) {
          platformIds!.add(id);
        } else if (id is String) {
          num? parsedId = num.tryParse(id);
          if (parsedId != null) {
            platformIds!.add(parsedId);
          }
        }
      }
    } else {
      platformIds = [];
    }
    status = json['status'];
    canApply = json['can_apply'];
    reason = json['reason'];
  }

  num? vipLevel;
  String? minTransfer;
  String? bonusRatio;
  String? maxBonus;
  String? turnoverMultiple;
  num? applyCycle;
  List<num>? platformIds;
  num? status;
  bool? canApply;
  String? reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vip_level'] = vipLevel;
    map['min_transfer'] = minTransfer;
    map['bonus_ratio'] = bonusRatio;
    map['max_bonus'] = maxBonus;
    map['turnover_multiple'] = turnoverMultiple;
    map['apply_cycle'] = applyCycle;
    map['platform_ids'] = platformIds;
    map['status'] = status;
    map['can_apply'] = canApply;
    map['reason'] = reason;
    return map;
  }
}
