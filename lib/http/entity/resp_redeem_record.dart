/// t : 10
/// s : 2
/// d : [{"id":"LH2003354488240341481","status":2,"claimed_at":1734937263000,"activity_name":"投注/首存","prize_name":"1元礼金","prize_type":"礼金","prize_amount":"1.00","water_multiple":"2.00","wallet_type":2,"platform_id":"106"},{"id":"LH2003129931613099733","status":2,"claimed_at":1734901058000,"activity_name":"投注/首存","prize_name":"1元礼金","prize_type":"礼金","prize_amount":"1.00","water_multiple":"2.00","wallet_type":1,"platform_id":""}]

class RespRedeemRecord {
  RespRedeemRecord({
    this.t,
    this.s,
    this.d,
  });

  RespRedeemRecord.fromJson(dynamic json) {
    t = json['t'];
    s = json['s'];
    if (json['d'] != null) {
      d = [];
      json['d'].forEach((v) {
        d?.add(RedeemRecordModel.fromJson(v));
      });
    }
  }

  num? t;
  num? s;
  List<RedeemRecordModel>? d;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['t'] = t;
    map['s'] = s;
    if (d != null) {
      map['d'] = d?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "LH2003354488240341481"
/// status : 2
/// claimed_at : 1734937263000
/// activity_name : "投注/首存"
/// prize_name : "1元礼金"
/// prize_type : "礼金"
/// prize_amount : "1.00"
/// water_multiple : "2.00"
/// wallet_type : 2
/// platform_id : "106"

class RedeemRecordModel {
  RedeemRecordModel({
    this.id,
    this.status,
    this.claimedAt,
    this.activityName,
    this.prizeName,
    this.prizeType,
    this.prizeAmount,
    this.waterMultiple,
    this.walletType,
    this.platformId,
  });

  RedeemRecordModel.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    claimedAt = json['claimed_at'];
    activityName = json['activity_name'];
    prizeName = json['prize_name'];
    prizeType = json['prize_type'];
    prizeAmount = json['prize_amount'];
    waterMultiple = json['water_multiple'];
    walletType = json['wallet_type'];
    platformId = json['platform_id'];
  }

  String? id;
  num? status;
  num? claimedAt;
  String? activityName;
  String? prizeName;
  String? prizeType;
  String? prizeAmount;
  String? waterMultiple;
  num? walletType;
  String? platformId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['claimed_at'] = claimedAt;
    map['activity_name'] = activityName;
    map['prize_name'] = prizeName;
    map['prize_type'] = prizeType;
    map['prize_amount'] = prizeAmount;
    map['water_multiple'] = waterMultiple;
    map['wallet_type'] = walletType;
    map['platform_id'] = platformId;
    return map;
  }
}
