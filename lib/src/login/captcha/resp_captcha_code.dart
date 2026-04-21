/// captcha_code : 100
/// captcha_msg : "appid-secretkey-ticket mismatch"
/// request_id : "dbebc40f-c375-4476-85c3-a7bebb1529a7"
/// score : 0
/// device_risk_category : ""
/// evil_bitmap : 0
/// evil_level : 0
/// pass : false

class RespCaptchaCode {
  RespCaptchaCode({
      this.captchaCode, 
      this.captchaMsg, 
      this.requestId, 
      this.score, 
      this.deviceRiskCategory, 
      this.evilBitmap, 
      this.evilLevel, 
      this.pass,});

  RespCaptchaCode.fromJson(dynamic json) {
    captchaCode = json['captcha_code'];
    captchaMsg = json['captcha_msg'];
    requestId = json['request_id'];
    score = json['score'];
    deviceRiskCategory = json['device_risk_category'];
    evilBitmap = json['evil_bitmap'];
    evilLevel = json['evil_level'];
    pass = json['pass'];
  }
  num? captchaCode;
  String? captchaMsg;
  String? requestId;
  num? score;
  String? deviceRiskCategory;
  num? evilBitmap;
  num? evilLevel;
  bool? pass;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['captcha_code'] = captchaCode;
    map['captcha_msg'] = captchaMsg;
    map['request_id'] = requestId;
    map['score'] = score;
    map['device_risk_category'] = deviceRiskCategory;
    map['evil_bitmap'] = evilBitmap;
    map['evil_level'] = evilLevel;
    map['pass'] = pass;
    return map;
  }

}