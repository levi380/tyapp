import 'package:filbet/common/currency.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:get/get.dart';

import 'package:filbet/utils/base_util.dart';

enum AccountChangeOrderStatus {
  pending,
  success,
  failed;

  static AccountChangeOrderStatus fromInt(int status) {
    switch (status) {
      case 1:
        return AccountChangeOrderStatus.pending;
      case 2:
        return AccountChangeOrderStatus.success;
      case 3:
        return AccountChangeOrderStatus.failed;
      default:
        return AccountChangeOrderStatus.pending;
    }
  }

  int get code {
    switch (this) {
      case AccountChangeOrderStatus.pending:
        return 1;
      case AccountChangeOrderStatus.success:
        return 2;
      case AccountChangeOrderStatus.failed:
        return 3;
    }
  }

  String get name {
    switch (this) {
      case AccountChangeOrderStatus.pending:
        return 'waiting'.tr;
      case AccountChangeOrderStatus.success:
        return 'success'.tr;
      case AccountChangeOrderStatus.failed:
        return 'failed'.tr;
    }
  }
}

// 抽象基类
abstract class AccountChangeRecordBaseModel<T> {
  final List<T> d;
  final int s;
  final int t;

  AccountChangeRecordBaseModel({
    required this.d,
    required this.s,
    required this.t,
  });

  @override
  String toString() {
    return '$runtimeType(d: ${d.length} items, s: $s, t: $t)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AccountChangeRecordBaseModel<T> &&
        other.d == d &&
        other.s == s &&
        other.t == t;
  }

  @override
  int get hashCode => Object.hash(d, s, t);
}

// 抽象基类 - 账户变更记录项
abstract class AccountChangeRecordBaseItem {
  final String amount;
  final int createdAt;
  final String fromAddress;
  final String frontChannelName;
  final String id;
  final String rate;
  final int status;
  final String toAddress;
  final String tokenType;
  final int paymentType;
  final String remark;
  final String order_amount;
  final int currency;

  final String symbol;

  AccountChangeRecordBaseItem({
    required this.amount,
    required this.createdAt,
    required this.fromAddress,
    required this.frontChannelName,
    required this.id,
    required this.rate,
    required this.status,
    required this.toAddress,
    required this.tokenType,
    required this.paymentType,
    required this.remark,
    required this.currency,
    required this.order_amount,
    required this.symbol,
  });

  /// 抽象方法：子类需要实现具体的状态枚举转换逻辑
  AccountChangeOrderStatus get orderStatus;

  /// 通用的格式化创建时间方法
  String get createdAtFormatted {
    return createdAt.toFormattedDateTimeString();
  }

  Currency get currencyType {
    return Currency.fromCodeInt(currency);
  }

  /// 通用的汇率字符串方法
  String get rateString;

  String get feeString;

  String get actualAmount;

  @override
  String toString() {
    return '$runtimeType(id: $id, amount: $amount, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AccountChangeRecordBaseItem &&
        other.id == id &&
        other.amount == amount &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(id, amount, status, createdAt);
}

// Deposit
class AccountChangeRecordDepositModel
    extends AccountChangeRecordBaseModel<AccountChangeRecordDepositItem> {
  AccountChangeRecordDepositModel({
    required super.d,
    required super.s,
    required super.t,
  });

  factory AccountChangeRecordDepositModel.fromJson(Map<String, dynamic> json) {
    return AccountChangeRecordDepositModel(
      d: (json['d'] as List<dynamic>?)
              ?.map((item) => AccountChangeRecordDepositItem.fromJson(
                  Map<String, dynamic>.from(item)))
              .toList() ??
          [],
      s: json['s']?.toInt() ?? 0,
      t: json['t']?.toInt() ?? 0,
    );
  }
}

class AccountChangeRecordDepositItem extends AccountChangeRecordBaseItem {
  // 存款特有字段
  final String currencyAmount;
  final String fee;
  final String feeAmount;
  final int paidAt;
  final int processStatus;

  AccountChangeRecordDepositItem({
    required super.amount,
    required super.createdAt,
    required super.fromAddress,
    required super.frontChannelName,
    required super.id,
    required super.rate,
    required super.status,
    required super.toAddress,
    required super.tokenType,
    required super.paymentType,
    required this.currencyAmount,
    required this.fee,
    required this.feeAmount,
    required this.paidAt,
    required this.processStatus,
    required super.remark,
    required super.currency,
    required super.order_amount,
    required super.symbol,
  });

  factory AccountChangeRecordDepositItem.fromJson(Map<String, dynamic> json) {
    return AccountChangeRecordDepositItem(
      amount: json['amount']?.toString() ?? '0.0000',
      createdAt: json['created_at'] ?? 0,
      fromAddress: json['from_address']?.toString() ?? '',
      frontChannelName: json['front_channel_name']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      rate: json['rate']?.toString() ?? '0.000000',
      status: json['order_status'] ?? 0,
      toAddress: json['to_address']?.toString() ?? '',
      tokenType: json['token_type']?.toString() ?? '',
      paymentType: json['payment_type'] ?? 0,
      currency: json['currency'] ?? 0,
      currencyAmount: json['currency_amount']?.toString() ?? '0.00000000',
      fee: json['fee']?.toString() ?? '0.000000',
      feeAmount: json['fee_amount']?.toString() ?? '0.00000000',
      paidAt: json['paid_at'] ?? 0,
      processStatus: json['process_status'] ?? 0,
      remark: json['remark']?.toString() ?? '--',
      order_amount: json['order_amount']?.toString() ?? '',
      symbol: json['symbol']?.toString() ?? '',
    );
  }

  @override
  AccountChangeOrderStatus get orderStatus {
    return AccountChangeOrderStatus.fromInt(status);
  }

  String get amountWithSymbol {
    return symbol + amount.toFixed2Truncate();
  }

  String get actualAmountWithCurrenySymbol {
    return strforcurrencyCode(currencyAmount.toFixed2Truncate(), currency);
  }

  String get amountWithUSDTSymbol {
    return '$symbol${amount.toFixed2Truncate()}';
  }

  String get order_amountWithUSDTSymbol {
    return '$symbol${order_amount.toFixed2Truncate()}';
  }

  @override
  String get rateString {
    return '1 $tokenType = ${rate.toFixed2()} ${currencyType.abbr.toUpperCase()}';
  }

  @override
  String get ratefourString {
    return '1 $tokenType = ${rate.toFixed4()} ${currencyType.abbr.toUpperCase()}';
  }

  @override
  String get actualAmount {
    return symbol + currencyAmount.toFixed2();
  }

  @override
  String get feeString {
    return '$symbol${fee.toFixed2()}';
  }
}

// Withdraw
class AccountChangeRecordWithdrawModel
    extends AccountChangeRecordBaseModel<AccountChangeRecordWithdrawItem> {
  AccountChangeRecordWithdrawModel({
    required super.d,
    required super.s,
    required super.t,
  });

  factory AccountChangeRecordWithdrawModel.fromJson(Map<String, dynamic> json) {
    return AccountChangeRecordWithdrawModel(
      d: (json['d'] as List<dynamic>?)
              ?.map((item) => AccountChangeRecordWithdrawItem.fromJson(
                  Map<String, dynamic>.from(item)))
              .toList() ??
          [],
      s: json['s']?.toInt() ?? 0,
      t: json['t']?.toInt() ?? 0,
    );
  }
}

class AccountChangeRecordWithdrawItem extends AccountChangeRecordBaseItem {
  // 提现特有字段
  final String currencyAmount;
  final String fee;
  final String feeCurrencyAmount;
  final String accountId;
  final String accountName;

  AccountChangeRecordWithdrawItem({
    required super.amount,
    required super.createdAt,
    required super.fromAddress,
    required super.frontChannelName,
    required super.id,
    required super.rate,
    required super.status,
    required super.toAddress,
    required super.tokenType,
    required super.paymentType,
    required this.currencyAmount,
    required this.fee,
    required this.feeCurrencyAmount,
    required this.accountId,
    required this.accountName,
    required super.currency,
    required super.remark,
    required super.order_amount,
    required super.symbol,
  });

  factory AccountChangeRecordWithdrawItem.fromJson(Map<String, dynamic> json) {
    return AccountChangeRecordWithdrawItem(
      amount: json['amount']?.toString() ?? '0.00000000',
      createdAt: json['created_at'] ?? 0,
      fromAddress: json['from_address']?.toString() ?? '',
      frontChannelName: json['front_channel_name']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      rate: json['rate']?.toString() ?? '0.0',
      status: json['order_status'] ?? 1,
      toAddress: json['to_address']?.toString() ?? '',
      tokenType: json['token_type']?.toString() ?? '',
      paymentType: json['payment_type'] ?? 0,
      currencyAmount: json['currency_amount']?.toString() ?? '0',
      fee: json['fee']?.toString() ?? '0.00',
      feeCurrencyAmount: json['fee_currency_amount']?.toString() ?? '0',
      accountId: json['account_id']?.toString() ?? '',
      accountName: json['account_name']?.toString() ?? '',
      currency: json['currency'] ?? 0,
      remark: json['remark']?.toString() ?? '--',
      order_amount: json['order_amount']?.toString() ?? '',
      symbol: json['symbol']?.toString() ?? '',
    );
  }

  @override
  AccountChangeOrderStatus get orderStatus {
    return AccountChangeOrderStatus.fromInt(status);
  }

  String get amountWithSymbol {
    Currency currency = super.currencyType;
    return '${currency.symbol}${currencyAmount.toFixed2()}';
  }

  String get amountWithCurrencySymbol {
    return '$symbol${amount.toFixed2()}';
  }

  @override
  String get rateString {
    return '1 ${currencyType.abbr} = ${rate.toFixed4()} $symbol';
  }

  @override
  String get actualAmount {
    return '$symbol${amount.toFixed2()}';
  }

  @override
  String get feeString {
    return '$symbol${fee.toFixed2()}';
  }
}

extension StringTruncateExtension on String {
  /// 保留 2 位小数，直接截断，不四舍五入
  String toFixed2Truncate() {
    if (isEmpty) return "0.00";

    final value = double.tryParse(this);
    if (value == null) return "0.00";

    final truncated = (value * 100).truncateToDouble() / 100;
    return truncated.toStringAsFixed(2);
  }
}
