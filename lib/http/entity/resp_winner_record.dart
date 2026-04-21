/// d : [{"id":56,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员fzf5uF85","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321311706_a8e9gstez","prize_name":"心想事成","reward_type":1,"reward_amount":"18","status":1,"created_at":1766384120076},{"id":57,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员vhuTkmyv","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321311706_a8e9gstez","prize_name":"心想事成","reward_type":1,"reward_amount":"18","status":1,"created_at":1766384120076},{"id":54,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员yNpe7LrG","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321310549_1g3bull7j","prize_name":"财源滚滚","reward_type":1,"reward_amount":"38","status":1,"created_at":1766384120074},{"id":55,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员wEWHwmdd","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321310549_1g3bull7j","prize_name":"财源滚滚","reward_type":1,"reward_amount":"38","status":1,"created_at":1766384120074},{"id":52,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员oggZyhW4","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321252273_liqvasyka","prize_name":"富贵常伴","reward_type":1,"reward_amount":"88","status":1,"created_at":1766384120072},{"id":53,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员sek8LPcb","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321252273_liqvasyka","prize_name":"富贵常伴","reward_type":1,"reward_amount":"88","status":1,"created_at":1766384120072},{"id":50,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员BO9OmesH","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321251689_2ynkysd6a","prize_name":"富贵荣华","reward_type":1,"reward_amount":"188","status":1,"created_at":1766384120069},{"id":51,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员3iCDvXt7","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321251689_2ynkysd6a","prize_name":"富贵荣华","reward_type":1,"reward_amount":"188","status":1,"created_at":1766384120069},{"id":49,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员aKaoh25n","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321251008_n3dc036r6","prize_name":"步步高升","reward_type":1,"reward_amount":"388","status":1,"created_at":1766384120067},{"id":48,"uid":"fake_2264770994520457216_1766384","username":"系统随机会员s3qKjcjA","vip_level":0,"promo_id":"2264770994520457216","play_type":1,"prize_type":1,"prize_id":"prize_1766321251008_n3dc036r6","prize_name":"步步高升","reward_type":1,"reward_amount":"388","status":1,"created_at":1766384120067}]
/// t : 20
/// s : 10

class RespWinnerRecord {
  RespWinnerRecord({
    this.d,
    this.t,
    this.s,
  });

  RespWinnerRecord.fromJson(dynamic json) {
    if (json['d'] != null) {
      d = [];
      json['d'].forEach((v) {
        d?.add(WinnerRecord.fromJson(v));
      });
    }
    t = json['t'];
    s = json['s'];
    summary =
        json['summary'] == null ? null : Summary.fromJson(json['summary']);
  }

  List<WinnerRecord>? d;
  num? t;
  num? s;
  Summary? summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (d != null) {
      map['d'] = d?.map((v) => v.toJson()).toList();
    }
    map['t'] = t;
    map['s'] = s;
    return map;
  }
}

/// id : 56
/// uid : "fake_2264770994520457216_1766384"
/// username : "系统随机会员fzf5uF85"
/// vip_level : 0
/// promo_id : "2264770994520457216"
/// play_type : 1
/// prize_type : 1
/// prize_id : "prize_1766321311706_a8e9gstez"
/// prize_name : "心想事成"
/// reward_type : 1
/// reward_amount : "18"
/// status : 1
/// created_at : 1766384120076

class WinnerRecord {
  WinnerRecord({
    this.id,
    this.uid,
    this.username,
    this.vipLevel,
    this.promoId,
    this.playType,
    this.prizeType,
    this.prizeId,
    this.prizeName,
    this.rewardType,
    this.rewardAmount,
    this.status,
    this.createdAt,
  });

  WinnerRecord.fromJson(dynamic json) {
    id = json['id'];
    uid = json['uid'];
    username = json['username'];
    vipLevel = json['vip_level'];
    promoId = json['promo_id'];
    playType = json['play_type'];
    prizeType = json['prize_type'];
    prizeId = json['prize_id'];
    prizeName = json['prize_name'];
    rewardType = json['reward_type'];
    rewardAmount = json['reward_amount'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  num? id;
  String? uid;
  String? username;
  num? vipLevel;
  String? promoId;
  num? playType;
  num? prizeType;
  String? prizeId;
  String? prizeName;
  num? rewardType;
  String? rewardAmount;
  num? status;
  num? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['uid'] = uid;
    map['username'] = username;
    map['vip_level'] = vipLevel;
    map['promo_id'] = promoId;
    map['play_type'] = playType;
    map['prize_type'] = prizeType;
    map['prize_id'] = prizeId;
    map['prize_name'] = prizeName;
    map['reward_type'] = rewardType;
    map['reward_amount'] = rewardAmount;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }
}

class Summary {
  Summary({
    this.cashAmount,
    this.physicalCount,
    this.rewardTotals,
  });

  Summary.fromJson(dynamic json) {
    cashAmount = json['cash_amount'];
    physicalCount = json['physical_count'];
    if (json['reward_totals'] != null) {
      rewardTotals = [];
      json['reward_totals'].forEach((v) {
        rewardTotals?.add(RewardTotal.fromJson(v));
      });
    }
  }

  String? cashAmount;
  num? physicalCount;
  List<RewardTotal>? rewardTotals;
}

class RewardTotal {
  RewardTotal({
    this.rewardType,
    this.rewardAmount,
    this.count,
  });

  RewardTotal.fromJson(dynamic json) {
    rewardType = num.tryParse('${json['reward_type']}');
    rewardAmount = json['reward_amount'];
    count = json['count'];
  }

  num? rewardType;
  String? rewardAmount;
  num? count;
}
