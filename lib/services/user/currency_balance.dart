import 'package:filbet/utils/base_util.dart';

class CurrencyBalance {
  final String? balance;
  final String? totalWithdraw;

  CurrencyBalance({
    this.balance = '0.00',
    this.totalWithdraw = '0.00',
  });

  /// ✅ 静态方法：截取到小数点后两位（不四舍五入）
  static String truncateTo2(double value) {
    final truncated = (value * 100).truncateToDouble() / 100;
    return truncated.toStringAsFixed(2);
  }

  /// ✅ 工厂构造函数（可从 JSON 创建对象）
  factory CurrencyBalance.fromJson(Map<String, dynamic> json) {
    String parse(String key) {
      final v = double.tryParse(json[key]?.toString() ?? '0') ?? 0.0;
      return truncateTo2(v);
    }

    return CurrencyBalance(
      balance: parse('balance'),
      totalWithdraw: parse('total_withdraw'),
    );
  }

  String getCurrencySymbol(String code) {
    switch (code.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'CNY':
        return '¥';
      case 'VND':
        return '₫';
      case 'HKD':
        return 'HK';
      case 'KRW':
        return '₩';
      case 'IDR':
        return 'Rp';
      case 'THB':
        return '฿';
      case 'MXN':
        return '\$';
      case 'BRL':
        return 'R';
      case 'INR':
        return '₹';
      case 'PHP':
        return '₱';
      default:
        return '';
    }
  }
}
