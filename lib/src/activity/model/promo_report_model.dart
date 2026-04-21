class PromoReportModel {
  String? id;
  String? promoId;
  String? activeId;
  int? activeType;
  String? uid;
  String? username;
  int? vipLevel;
  int? isAgent;
  String? regType;
  String? parentUid;
  String? parentUsername;
  String? title;
  int? payoutStatus;
  int? submitAt;
  String? submitResult;
  String? payoutAmount;
  String? contestName;
  String? result;
  String? payoutUid;
  String? payoutName;
  String? remark;
  int? createdAt;
  int? updatedAt;

  PromoReportModel(
      {this.id,
      this.promoId,
      this.activeId,
      this.activeType,
      this.uid,
      this.username,
      this.vipLevel,
      this.isAgent,
      this.regType,
      this.parentUid,
      this.parentUsername,
      this.title,
      this.payoutStatus,
      this.submitAt,
      this.submitResult,
      this.payoutAmount,
      this.contestName,
      this.result,
      this.payoutUid,
      this.payoutName,
      this.remark,
      this.createdAt,
      this.updatedAt});

  PromoReportModel.fromJson(Map json) {
    id = json['id'];
    promoId = json['promo_id'];
    activeId = json['active_id'];
    activeType = json['active_type'];
    uid = json['uid'];
    username = json['username'];
    vipLevel = json['vip_level'];
    isAgent = json['is_agent'];
    regType = json['reg_type'];
    parentUid = json['parent_uid'];
    parentUsername = json['parent_username'];
    title = json['title'];
    payoutStatus = json['payout_status'];
    submitAt = json['submit_at'];
    submitResult = json['submit_result'];
    payoutAmount = json['payout_amount'];
    contestName = json['contest_name'];
    result = json['result'];
    payoutUid = json['payout_uid'];
    payoutName = json['payout_name'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['promo_id'] = this.promoId;
    data['active_id'] = this.activeId;
    data['active_type'] = this.activeType;
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['vip_level'] = this.vipLevel;
    data['is_agent'] = this.isAgent;
    data['reg_type'] = this.regType;
    data['parent_uid'] = this.parentUid;
    data['parent_username'] = this.parentUsername;
    data['title'] = this.title;
    data['payout_status'] = this.payoutStatus;
    data['submit_at'] = this.submitAt;
    data['submit_result'] = this.submitResult;
    data['payout_amount'] = this.payoutAmount;
    data['contest_name'] = this.contestName;
    data['result'] = this.result;
    data['payout_uid'] = this.payoutUid;
    data['payout_name'] = this.payoutName;
    data['remark'] = this.remark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
