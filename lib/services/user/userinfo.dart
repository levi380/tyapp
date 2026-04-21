class UserInfoEntity {
  String? uid;
  String? tgid;
  String? username;
  int? emailCheckState;
  String? phone;
  int? phoneCheckState;
  String? password;
  int? state;
  String? countryCode;
  int? isAgent;
  String? regType;
  String? lastLoginIp;
  String? lastLoginDevice;
  String? tags;
  int? lastLoginAt;
  String? nickName;
  int? regAt;
  String? regIp;
  String? device;
  String? deviceNo;
  String? remark;
  String? googleKey;
  int? createdTime;
  int? tester;
  String? referralCode;
  String? avatar;
  String? email;
  String? parentUid;
  String? parentName;
  int? gender;
  int? createdAt;
  int? currency;
  int? updatedAt;
  bool? hasLoginPassword;
  bool? hasEmail;
  bool? hasPhoneNumber;
  String? birthday;
  String? xp;
  int? vip;
  int? currentVipBirthHasGift; //当前等级是否有生日礼金，1有，2无
  int? currentVipWeekHasGift; //当前等级是否有周礼金，1有，2无
  int? nextVipUpgradeHasGift; //下一等级是否有升级礼金，1有，2无
  bool? guide;
  bool? modify; //是否可以编辑用户资料（新用户为true）
  String? realName;
  String? phoneEnc;
  String? realNameEnc;
  int? autoTransfer;
  int? depositWhitelist;

  //是否引导过
  UserInfoEntity({
    this.uid,
    this.tgid,
    this.username,
    this.emailCheckState,
    this.phone,
    this.phoneCheckState,
    this.password,
    this.state,
    this.countryCode,
    this.isAgent,
    this.regType,
    this.lastLoginIp,
    this.lastLoginDevice,
    this.tags,
    this.lastLoginAt,
    this.nickName,
    this.regAt,
    this.regIp,
    this.device,
    this.deviceNo,
    this.remark,
    this.googleKey,
    this.createdTime,
    this.tester,
    this.referralCode,
    this.avatar,
    this.email,
    this.parentUid,
    this.parentName,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.hasLoginPassword,
    this.hasEmail,
    this.hasPhoneNumber,
    this.birthday,
    this.xp,
    this.vip,
    this.currency,
    this.currentVipBirthHasGift,
    this.currentVipWeekHasGift,
    this.nextVipUpgradeHasGift,
    this.guide,
    this.modify,
    this.realName,
    this.phoneEnc,
    this.realNameEnc,
    this.autoTransfer,
    this.depositWhitelist,
  });

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) => UserInfoEntity(
        uid: json['uid'],
        tgid: json['tgid'],
        username: json['username'],
        currentVipBirthHasGift: json['current_vip_birth_has_gift'],
        currentVipWeekHasGift: json['current_vip_week_has_gift'],
        nextVipUpgradeHasGift: json['next_vip_upgrade_has_gift'],
        emailCheckState: json['email_check_state'],
        phone: json['phone'],
        guide: json['guide'],
        modify: json['modify'],
        phoneCheckState: json['phone_check_state'],
        password: json['password'],
        state: json['state'],
        countryCode: json['country_code'],
        isAgent: json['is_agent'],
        regType: json['reg_type'],
        lastLoginIp: json['last_login_ip'],
        lastLoginDevice: json['last_login_device'],
        tags: json['tags'],
        lastLoginAt: json['last_login_at'],
        nickName: json['nick_name'],
        regAt: json['reg_at'],
        regIp: json['reg_ip'],
        device: json['device'],
        deviceNo: json['device_no'],
        remark: json['remark'],
        googleKey: json['google_key'],
        createdTime: json['created_time'],
        tester: json['tester'],
        referralCode: json['referral_code'],
        avatar: json['avatar'],
        email: json['email'],
        parentUid: json['parent_uid'],
        parentName: json['parent_name'],
        gender: json['gender'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        hasLoginPassword: json['has_login_password'],
        hasEmail: json['has_email'],
        hasPhoneNumber: json['has_phone_number'],
        birthday: json['birthday'],
        xp: json['xp'],
        vip: json['vip'],
        currency: json['currency'],
        realName: json['real_name'],
        phoneEnc: json['phone_enc'],
        realNameEnc: json['real_name_enc'],
        autoTransfer: json['auto_transfer'],
        depositWhitelist: json['deposit_whitelist'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'tgid': tgid,
        'username': username,
        'email_check_state': emailCheckState,
        'phone': phone,
        'phone_check_state': phoneCheckState,
        'password': password,
        'state': state,
        'country_code': countryCode,
        'is_agent': isAgent,
        'reg_type': regType,
        'last_login_ip': lastLoginIp,
        'last_login_device': lastLoginDevice,
        'tags': tags,
        'last_login_at': lastLoginAt,
        'nick_name': nickName,
        'reg_at': regAt,
        'reg_ip': regIp,
        'device': device,
        'device_no': deviceNo,
        'remark': remark,
        'google_key': googleKey,
        'created_time': createdTime,
        'tester': tester,
        'referral_code': referralCode,
        'avatar': avatar,
        'parent_uid': parentUid,
        'parent_name': parentName,
        'gender': gender,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'has_login_password': hasLoginPassword,
        'has_email': hasEmail,
        'has_phone_number': hasPhoneNumber,
        'birthday': birthday,
        'xp': xp,
        'vip': vip,
        'currency': currency,
        "current_vip_birth_has_gift": currentVipBirthHasGift,
        "current_vip_week_has_gift": currentVipWeekHasGift,
        "next_vip_upgrade_has_gift": nextVipUpgradeHasGift,
        "guide": guide,
        "modify": modify,
        "real_name": realName,
        "phone_enc": phoneEnc,
        "real_name_enc": realNameEnc,
      };

  UserInfoEntity copyWith({
    String? uid,
    String? tgid,
    String? username,
    int? emailCheckState,
    String? phone,
    int? phoneCheckState,
    String? password,
    int? state,
    String? countryCode,
    int? isAgent,
    String? regType,
    String? lastLoginIp,
    String? lastLoginDevice,
    String? tags,
    int? lastLoginAt,
    String? nickName,
    int? regAt,
    String? regIp,
    String? device,
    String? deviceNo,
    String? remark,
    String? googleKey,
    int? createdTime,
    int? tester,
    String? referralCode,
    String? avatar,
    String? parentUid,
    String? parentName,
    int? gender,
    int? createdAt,
    int? updatedAt,
    bool? hasLoginPassword,
    bool? hasEmail,
    bool? hasPhoneNumber,
    String? birthday,
    String? xp,
    int? vip,
    int? currency,
    int? currentVipBirthHasGift,
    int? currentVipWeekHasGift,
    int? nextVipUpgradeHasGift,
    bool? guide,
    bool? modify,
  }) {
    return UserInfoEntity(
      uid: uid ?? this.uid,
      tgid: tgid ?? this.tgid,
      username: username ?? this.username,
      emailCheckState: emailCheckState ?? this.emailCheckState,
      phone: phone ?? this.phone,
      phoneCheckState: phoneCheckState ?? this.phoneCheckState,
      password: password ?? this.password,
      state: state ?? this.state,
      countryCode: countryCode ?? this.countryCode,
      isAgent: isAgent ?? this.isAgent,
      regType: regType ?? this.regType,
      lastLoginIp: lastLoginIp ?? this.lastLoginIp,
      lastLoginDevice: lastLoginDevice ?? this.lastLoginDevice,
      tags: tags ?? this.tags,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      nickName: nickName ?? this.nickName,
      regAt: regAt ?? this.regAt,
      regIp: regIp ?? this.regIp,
      device: device ?? this.device,
      deviceNo: deviceNo ?? this.deviceNo,
      remark: remark ?? this.remark,
      googleKey: googleKey ?? this.googleKey,
      createdTime: createdTime ?? this.createdTime,
      tester: tester ?? this.tester,
      referralCode: referralCode ?? this.referralCode,
      avatar: avatar ?? this.avatar,
      parentUid: parentUid ?? this.parentUid,
      parentName: parentName ?? this.parentName,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hasLoginPassword: hasLoginPassword ?? this.hasLoginPassword,
      hasEmail: hasEmail ?? this.hasEmail,
      hasPhoneNumber: hasPhoneNumber ?? this.hasPhoneNumber,
      birthday: birthday ?? this.birthday,
      xp: xp ?? this.xp,
      vip: vip ?? this.vip,
      currency: currency ?? this.currency,
      currentVipBirthHasGift:
          currentVipBirthHasGift ?? this.currentVipBirthHasGift,
      currentVipWeekHasGift:
          currentVipWeekHasGift ?? this.currentVipWeekHasGift,
      nextVipUpgradeHasGift:
          nextVipUpgradeHasGift ?? this.nextVipUpgradeHasGift,
      guide: guide ?? this.guide,
      modify: modify ?? this.modify,
    );
  }
}
