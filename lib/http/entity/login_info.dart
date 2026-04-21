/// sid : "12345678901234567890123456789012"
/// has_phone : true
/// masked_phone : "138****5678"

class LoginInfo {
  LoginInfo({
    this.sid,
    this.hasPhone,
    this.maskedPhone,
  });

  LoginInfo.fromJson(dynamic json) {
    sid = json['sid'];
    hasPhone = json['has_phone'];
    maskedPhone = json['masked_phone'];
    errorCount = json['error_count'];
    errorMessage = json['error_message'];
  }

  String? sid;
  bool? hasPhone;
  String? maskedPhone;
  num? errorCount;
  String? errorMessage;
  bool? failed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sid'] = sid;
    map['has_phone'] = hasPhone;
    map['masked_phone'] = maskedPhone;
    return map;
  }
}
