import 'package:filbet/common/currency.dart';


class TransactionRecordModelItem {
  final String id;
  final String billNo;
  final String uid;
  final int businessType;
  final int cashType;
  final String cname;
  final Currency currency;
  final String amount;
  final String beforeAmount;
  final String afterAmount;
  final int createdAt;

  TransactionRecordModelItem({
    this.id = '',
    this.billNo = '',
    this.uid = '',
    this.businessType = 0,
    this.cashType = 0,
    this.cname = '',
    this.currency = Currency.rmb,
    this.amount = '0',
    this.beforeAmount = '0',
    this.afterAmount = '0',
    this.createdAt = 0,
  });

  factory TransactionRecordModelItem.fromJson(Map<String, dynamic> json) {
    return TransactionRecordModelItem(
      id: json['id']?.toString() ?? '',
      billNo: json['bill_no']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
      businessType: json['business_type'] ?? 0,
      cashType: json['cash_type'] ?? 0,
      cname: json['cname'] ?? '',
      currency: Currency.fromCodeInt(json['currency'] ?? 102),
      amount: json['amount']?.toString() ?? '0',
      beforeAmount: json['before_amount']?.toString() ?? '0',
      afterAmount: json['after_amount']?.toString() ?? '0',
      createdAt: json['created_at'] ?? 0,
    );
  }

  String get amountWithCurrencySymbol {
    return '${currency.symbol}$amount';
  }
}
