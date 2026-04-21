class FirstDepositModel {
  String? id;
  String? name;
  int? ty;
  int? tagType;
  int? display;
  int? displayStartAt;
  int? displayEndAt;
  int? state;
  String? clientType;
  String? config;
  int? isDelete;
  int? startAt;
  int? endAt;
  String? multiple;
  int? recommend;
  int? automatic;
  int? sort;
  String? images;
  String? summary;
  int? detailImage;
  int? displayType;
  int? createdAt;
  String? platformIds;
  int? requirePhone;
  int? requireBankcard;
  int? isLimitIp;
  int? isLimitDevice;
  int? applyMode;
  int? classify;
  String? requireAmount;
  int? specialOffer;
  String? giftRatio;
  int? ruleDisplay;
  int? webTop;
  int? h5Top;
  String? h5Summary;
  int? activityCycle;
  int? grantMode;
  String? grantLimit;
  int? updatedAt;
  String? updatedName;

  FirstDepositModel(
      {this.id,
      this.name,
      this.ty,
      this.tagType,
      this.display,
      this.displayStartAt,
      this.displayEndAt,
      this.state,
      this.clientType,
      this.config,
      this.isDelete,
      this.startAt,
      this.endAt,
      this.multiple,
      this.recommend,
      this.automatic,
      this.sort,
      this.images,
      this.summary,
      this.detailImage,
      this.displayType,
      this.createdAt,
      this.platformIds,
      this.requirePhone,
      this.requireBankcard,
      this.isLimitIp,
      this.isLimitDevice,
      this.applyMode,
      this.classify,
      this.requireAmount,
      this.specialOffer,
      this.giftRatio,
      this.ruleDisplay,
      this.webTop,
      this.h5Top,
      this.h5Summary,
      this.activityCycle,
      this.grantMode,
      this.grantLimit,
      this.updatedAt,
      this.updatedName});

  FirstDepositModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    ty = json['ty'];
    tagType = json['tag_type'];
    display = json['display'];
    displayStartAt = json['display_start_at'];
    displayEndAt = json['display_end_at'];
    state = json['state'];
    clientType = json['client_type'];
    config = json['config'];
    isDelete = json['is_delete'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    multiple = json['multiple'];
    recommend = json['recommend'];
    automatic = json['automatic'];
    sort = json['sort'];
    images = json['images'];
    summary = json['summary'];
    detailImage = json['detail_image'];
    displayType = json['display_type'];
    createdAt = json['created_at'];
    platformIds = json['platform_ids'];
    requirePhone = json['require_phone'];
    requireBankcard = json['require_bankcard'];
    isLimitIp = json['is_limit_ip'];
    isLimitDevice = json['is_limit_device'];
    applyMode = json['apply_mode'];
    classify = json['classify'];
    requireAmount = json['require_amount'];
    specialOffer = json['special_offer'];
    giftRatio = json['gift_ratio'];
    ruleDisplay = json['rule_display'];
    webTop = json['web_top'];
    h5Top = json['h5_top'];
    h5Summary = json['h5_summary'];
    activityCycle = json['activity_cycle'];
    grantMode = json['grant_mode'];
    grantLimit = json['grant_limit'];
    updatedAt = json['updated_at'];
    updatedName = json['updated_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ty'] = this.ty;
    data['tag_type'] = this.tagType;
    data['display'] = this.display;
    data['display_start_at'] = this.displayStartAt;
    data['display_end_at'] = this.displayEndAt;
    data['state'] = this.state;
    data['client_type'] = this.clientType;
    data['config'] = this.config;
    data['is_delete'] = this.isDelete;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['multiple'] = this.multiple;
    data['recommend'] = this.recommend;
    data['automatic'] = this.automatic;
    data['sort'] = this.sort;
    data['images'] = this.images;
    data['summary'] = this.summary;
    data['detail_image'] = this.detailImage;
    data['display_type'] = this.displayType;
    data['created_at'] = this.createdAt;
    data['platform_ids'] = this.platformIds;
    data['require_phone'] = this.requirePhone;
    data['require_bankcard'] = this.requireBankcard;
    data['is_limit_ip'] = this.isLimitIp;
    data['is_limit_device'] = this.isLimitDevice;
    data['apply_mode'] = this.applyMode;
    data['classify'] = this.classify;
    data['require_amount'] = this.requireAmount;
    data['special_offer'] = this.specialOffer;
    data['gift_ratio'] = this.giftRatio;
    data['rule_display'] = this.ruleDisplay;
    data['web_top'] = this.webTop;
    data['h5_top'] = this.h5Top;
    data['h5_summary'] = this.h5Summary;
    data['activity_cycle'] = this.activityCycle;
    data['grant_mode'] = this.grantMode;
    data['grant_limit'] = this.grantLimit;
    data['updated_at'] = this.updatedAt;
    data['updated_name'] = this.updatedName;
    return data;
  }
}
