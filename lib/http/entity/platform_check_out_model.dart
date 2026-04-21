/// state_code : 101
/// remain_turnover : "500.00"
/// error_message : ""

class PlatformCheckOutModel {
  PlatformCheckOutModel({
      this.stateCode, 
      this.remainTurnover, 
      this.errorMessage,});

  PlatformCheckOutModel.fromJson(dynamic json) {
    stateCode = json['state_code'];
    remainTurnover = json['remain_turnover'];
    errorMessage = json['error_message'];
  }
  num? stateCode;
  String? remainTurnover;
  String? errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state_code'] = stateCode;
    map['remain_turnover'] = remainTurnover;
    map['error_message'] = errorMessage;
    return map;
  }

}