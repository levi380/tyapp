import 'package:filbet/common/currency.dart';
import 'package:filbet/utils/num_util.dart';

class WithdrawLimitModel {
  // final String flow;
  final String withdrawLimit;
  final String withdrawRemain;
  final String turnover;
  
  final int currency;
  final int useBank;// 1 必须要显示用银行卡提现一次,0 或者其他就不用了

  WithdrawLimitModel({
    // required this.flow,
    required this.withdrawLimit,
    required this.withdrawRemain,
    required this.currency,
    required this.useBank,
    required this.turnover,
  });

  factory WithdrawLimitModel.fromJson(Map<String, dynamic> json) {
    return WithdrawLimitModel(
      // flow: json['flow'] as String,
      withdrawLimit: json['withdraw_limit'] as String,
      withdrawRemain: json['withdraw_remain'] as String,
      currency: json['currency'] as int,
      useBank: json['use_bank'] as int,
      turnover: json['turnover'] ,
    );
  }

  Currency get currencyType => Currency.fromCodeInt(currency);

  String get flowRequiredText {
    return isNumber(turnover) ? '$turnover ${currencyType.abbr}' : '$turnover ${currencyType.abbr}';
  }

  bool isNumber(String s) {
    return RegExp(r'^\d+$').hasMatch(s);
  }

  String get withdrawRemainText {
    return isNumber(toThousands(withdrawRemain))
        ? '${toThousands(withdrawRemain)} ${currencyType.abbr}'
        : '${toThousands(withdrawRemain)} ${currencyType.abbr}';
  }
}
