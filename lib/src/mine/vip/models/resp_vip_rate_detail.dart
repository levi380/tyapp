import 'dart:convert';

/// t : 9
/// d : [{"id":"21000000009140","game_id":"MX-LIVE-018","name":"泰国博丁","rebate":"{\"0\":0.5,\"1\":0.6,\"2\":0.7,\"3\":0.8,\"4\":0.9,\"5\":1.0,\"6\":1.1,\"7\":1.2,\"8\":1.3,\"9\":1.4,\"10\":1.5}"}]

class RespVipRateDetail {
  RespVipRateDetail({
    this.t,
    this.d,
  });

  RespVipRateDetail.fromJson(dynamic json) {
    t = json['t'];
    if (json['d'] != null) {
      d = [];
      json['d'].forEach((v) {
        d?.add(VipRateDetail.fromJson(v));
      });
    }
  }

  num? t;
  List<VipRateDetail>? d;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['t'] = t;
    if (d != null) {
      map['d'] = d?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "21000000009140"
/// game_id : "MX-LIVE-018"
/// name : "泰国博丁"
/// rebate : "{\"0\":0.5,\"1\":0.6,\"2\":0.7,\"3\":0.8,\"4\":0.9,\"5\":1.0,\"6\":1.1,\"7\":1.2,\"8\":1.3,\"9\":1.4,\"10\":1.5}"

class VipRateDetail {
  VipRateDetail({
    this.id,
    this.gameId,
    this.name,
    this.rebate,
  });

  VipRateDetail.fromJson(dynamic json) {
    id = json['id'];
    gameId = json['game_id'];
    name = json['name'];
    rebate = json['rebate'];
    if (json['rebate'] != null) {
      rebateRates = RebateRates.fromJson(jsonDecode(json['rebate']));
    }
  }

  String? id;
  String? gameId;
  String? name;
  String? rebate;
  RebateRates? rebateRates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['game_id'] = gameId;
    map['name'] = name;
    map['rebate'] = rebate;
    return map;
  }
}

class RebateRates {
  RebateRates({
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

  RebateRates.fromJson(dynamic json) {
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

  num? zero;
  num? one;
  num? two;
  num? three;
  num? four;
  num? five;
  num? six;
  num? seven;
  num? eight;
  num? nine;
  num? ten;
}
