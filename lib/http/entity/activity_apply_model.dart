/// id : ""
/// uid : ""
/// parent_name : ""
/// parent_uid : ""
/// username : ""
/// promo_id : ""
/// vip_level : 0
/// ip : ""
/// device_no : ""
/// state : 0
/// apply_mode : 0
/// created_at : 0
/// wallet_type : 0
/// platform_id : ""
/// apply_amount : ""
/// bouns_amount : ""
/// base_wr : ""
/// device_type : 0
/// reg_type : ""
/// cancel_at : 0
/// cancel_uid : ""
/// cancel_name : ""
/// bonus_status : 0
/// remark : ""
/// completed_at : 0
/// updated_at : 0

class ActivityApplyModel {
  ActivityApplyModel({
      this.id, 
      this.uid, 
      this.parentName, 
      this.parentUid, 
      this.username, 
      this.promoId, 
      this.vipLevel, 
      this.ip, 
      this.deviceNo, 
      this.state, 
      this.applyMode, 
      this.createdAt, 
      this.walletType, 
      this.platformId, 
      this.applyAmount, 
      this.bounsAmount, 
      this.baseWr, 
      this.deviceType, 
      this.regType, 
      this.cancelAt, 
      this.cancelUid, 
      this.cancelName, 
      this.bonusStatus, 
      this.remark, 
      this.completedAt, 
      this.updatedAt,});

  ActivityApplyModel.fromJson(dynamic json) {
    id = json['id'];
    uid = json['uid'];
    parentName = json['parent_name'];
    parentUid = json['parent_uid'];
    username = json['username'];
    promoId = json['promo_id'];
    vipLevel = json['vip_level'];
    ip = json['ip'];
    deviceNo = json['device_no'];
    state = json['state'];
    applyMode = json['apply_mode'];
    createdAt = json['created_at'];
    walletType = json['wallet_type'];
    platformId = json['platform_id'];
    applyAmount = json['apply_amount'];
    bounsAmount = json['bouns_amount'];
    baseWr = json['base_wr'];
    deviceType = json['device_type'];
    regType = json['reg_type'];
    cancelAt = json['cancel_at'];
    cancelUid = json['cancel_uid'];
    cancelName = json['cancel_name'];
    bonusStatus = json['bonus_status'];
    remark = json['remark'];
    completedAt = json['completed_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? uid;
  String? parentName;
  String? parentUid;
  String? username;
  String? promoId;
  num? vipLevel;
  String? ip;
  String? deviceNo;
  num? state;
  num? applyMode;
  num? createdAt;
  num? walletType;
  String? platformId;
  String? applyAmount;
  String? bounsAmount;
  String? baseWr;
  num? deviceType;
  String? regType;
  num? cancelAt;
  String? cancelUid;
  String? cancelName;
  num? bonusStatus;
  String? remark;
  num? completedAt;
  num? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['uid'] = uid;
    map['parent_name'] = parentName;
    map['parent_uid'] = parentUid;
    map['username'] = username;
    map['promo_id'] = promoId;
    map['vip_level'] = vipLevel;
    map['ip'] = ip;
    map['device_no'] = deviceNo;
    map['state'] = state;
    map['apply_mode'] = applyMode;
    map['created_at'] = createdAt;
    map['wallet_type'] = walletType;
    map['platform_id'] = platformId;
    map['apply_amount'] = applyAmount;
    map['bouns_amount'] = bounsAmount;
    map['base_wr'] = baseWr;
    map['device_type'] = deviceType;
    map['reg_type'] = regType;
    map['cancel_at'] = cancelAt;
    map['cancel_uid'] = cancelUid;
    map['cancel_name'] = cancelName;
    map['bonus_status'] = bonusStatus;
    map['remark'] = remark;
    map['completed_at'] = completedAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}