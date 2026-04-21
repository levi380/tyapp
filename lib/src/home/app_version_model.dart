class AppVersionModel {
  AppVersionModel({
    this.version,
    this.packageUrl,
    this.isForceUpdate,//是否强制更新 (0: 1, 2: 是)
    this.updateAnnouncementZh,
    this.updateAnnouncementEn,
    this.updateAnnouncementVn,
  });

  AppVersionModel.fromJson(dynamic json) {
    version = json['version'];
    packageUrl = json['package_url'];
    isForceUpdate = json['is_force_update'];
    updateAnnouncementZh = json['update_announcement_zh'];
    updateAnnouncementEn = json['update_announcement_en'];
    updateAnnouncementVn = json['update_announcement_vn'];
  }

  String? version;
  String? packageUrl;
  int? isForceUpdate;
  String? updateAnnouncementZh;
  String? updateAnnouncementEn;
  String? updateAnnouncementVn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['package_url'] = packageUrl;
    map['is_force_update'] = isForceUpdate;
    map['update_announcement_zh'] = updateAnnouncementZh;
    map['update_announcement_en'] = updateAnnouncementEn;
    map['update_announcement_vn'] = updateAnnouncementVn;
    return map;
  }
}
