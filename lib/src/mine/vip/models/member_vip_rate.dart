import 'dart:convert';

/// platform_id : "102"
/// platform_name : "PP真人"
/// max_rebate_rates : {"7":"0.0000","9":"0.0000","1":"0.0000","2":"0.0000","3":"0.0000","4":"0.0000","5":"0.0000","6":"0.0000","8":"0.0000","0":"0.0000","10":"0.0000"}

class MemberVipRate {
  MemberVipRate({
    this.platformId,
    this.platformName,
    this.maxRebateRates,
  });

  MemberVipRate.fromJson(dynamic json) {
    platformId = json['platform_id'];
    platformName = json['platform_name'];
    maxRebateRates = json['max_rebate_rates'] != null
        ? MaxRebateRates.fromJson(json['max_rebate_rates'])
        : null;
  }

  String? platformId;
  String? platformName;
  MaxRebateRates? maxRebateRates;
}

/// 7 : "0.0000"
/// 9 : "0.0000"
/// 1 : "0.0000"
/// 2 : "0.0000"
/// 3 : "0.0000"
/// 4 : "0.0000"
/// 5 : "0.0000"
/// 6 : "0.0000"
/// 8 : "0.0000"
/// 0 : "0.0000"
/// 10 : "0.0000"

class MaxRebateRates {
  MaxRebateRates({
    this.zero,
    this.one,
    this.two,
    this.three,
    this.four,
    this.five,
    this.six,
    this.seven,
    this.eight,
    this.nine,
    this.ten,
  });

  MaxRebateRates.fromJson(dynamic json) {
    zero = json['0'];
    one = json['1'];
    two = json['2'];
    three = json['3'];
    four = json['4'];
    five = json['5'];
    six = json['6'];
    seven = json['7'];
    eight = json['8'];
    nine = json['9'];
    ten = json['10'];
  }

  String? zero;
  String? one;
  String? two;
  String? three;
  String? four;
  String? five;
  String? six;
  String? seven;
  String? eight;
  String? nine;
  String? ten;
}
