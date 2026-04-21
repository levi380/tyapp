class UserVipLevelModel {
  int? level;
  String? zhName;
  String? vnName;
  String? enName;
  String? ty;
  String? xp;//经验上限
  String? upgrade;
  String? birthday;
  String? multiple;
  String? img;
  int? createdAt;
  int? updatedAt;
  String? updatedUid;
  String? updatedName;
  // xp经验 vip等级
  UserVipLevelModel(
      {this.level,
      this.zhName,
      this.vnName,
      this.enName,
      this.ty,
      this.xp,
      this.upgrade,
      this.birthday,
      this.multiple,
      this.img,
      this.createdAt,
      this.updatedAt,
      this.updatedUid,
      this.updatedName});

  UserVipLevelModel.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    zhName = json['zh_name'];
    vnName = json['vn_name'];
    enName = json['en_name'];
    ty = json['ty'];
    xp = json['xp'];
    upgrade = json['upgrade'];
    birthday = json['birthday'];
    multiple = json['multiple'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedUid = json['updated_uid'];
    updatedName = json['updated_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['zh_name'] = this.zhName;
    data['vn_name'] = this.vnName;
    data['en_name'] = this.enName;
    data['ty'] = this.ty;
    data['xp'] = this.xp;
    data['upgrade'] = this.upgrade;
    data['birthday'] = this.birthday;
    data['multiple'] = this.multiple;
    data['img'] = this.img;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_uid'] = this.updatedUid;
    data['updated_name'] = this.updatedName;
    return data;
  }
}
