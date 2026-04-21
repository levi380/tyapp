import 'package:filbet/common/currency.dart';
import 'package:filbet/utils/fp.dart';

class RateModel {
  RateModel({
    this.currency,
    this.depositRate,
    this.withdrawRate,
  });

  RateModel.fromJson(dynamic json) {
    currency = json['currency'];
    depositRate = json['deposit_rate'] != null ? DepositRate.fromJson(json['deposit_rate']) : null;
    withdrawRate = json['withdraw_rate'] != null ? WithdrawRate.fromJson(json['withdraw_rate']) : null;
  }

  int? currency;
  DepositRate? depositRate;
  WithdrawRate? withdrawRate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    if (depositRate != null) {
      map['deposit_rate'] = depositRate?.toJson();
    }
    if (withdrawRate != null) {
      map['withdraw_rate'] = withdrawRate?.toJson();
    }

    return map;
  }
}

class DepositRate {
  String? usdt;
  String? eb;
  String? no;
  String? hd;
  String? cny;
  DepositRate({
    this.usdt,
    this.eb,
    this.no,
    this.hd,
    this.cny,
  });

  DepositRate.fromJson(dynamic json) {
    usdt = json['USDT'] ?? "";
    eb = json['EB'] ?? "";
    no = json['NO'] ?? "";
    hd = json['HD'] ?? "";
    cny = json['CNY'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USDT'] = usdt;
    map['EB'] = eb;
    map['NO'] = no;
    map['HD'] = hd;
    map['CNY'] = cny;
    return map;
  }
}

class WithdrawRate {
  String? usdt;
  String? eb;
  String? no;
  String? hd;
  String? cny;
  WithdrawRate({
    this.usdt,
    this.eb,
    this.no,
    this.hd,
    this.cny,
  });

  WithdrawRate.fromJson(dynamic json) {
    usdt = json['USDT'] ?? "";
    eb = json['EB'] ?? "";
    no = json['NO'] ?? "";
    hd = json['HD'] ?? "";
    cny = json['CNY'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USDT'] = usdt;
    map['EB'] = eb;
    map['NO'] = no;
    map['HD'] = hd;
    map['CNY'] = cny;
    return map;
  }
}
