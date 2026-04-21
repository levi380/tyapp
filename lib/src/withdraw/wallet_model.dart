class WalletModel {
  final String cny; // 人民币
  final String usd; // 美元
  final String vnd; // 越南盾

  WalletModel({
    required this.cny,
    required this.usd,
    required this.vnd,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      cny: json['cny']?.toString() ?? '0.00',
      usd: json['usd']?.toString() ?? '0.00',
      vnd: json['vnd']?.toString() ?? '0.00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cny': cny,
      'usd': usd,
      'vnd': vnd,
    };
  }

  /// 获取指定货币的余额
  String getBalance(String currency) {
    switch (currency.toLowerCase()) {
      case 'cny':
        return cny;
      case 'usd':
        return usd;
      case 'vnd':
        return vnd;
      default:
        return '0.00';
    }
  }

  /// 检查是否有足够的余额
  bool hasSufficientBalance(String currency, double amount) {
    final balance = double.tryParse(getBalance(currency)) ?? 0.0;
    return balance >= amount;
  }

  /// 获取所有非零余额的货币
  Map<String, String> get nonZeroBalances {
    final Map<String, String> result = {};

    if (double.tryParse(cny) != 0) result['cny'] = cny;
    if (double.tryParse(usd) != 0) result['usd'] = usd;
    if (double.tryParse(vnd) != 0) result['vnd'] = vnd;

    return result;
  }

  /// 检查钱包是否为空（所有余额都为0）
  bool get isEmpty {
    return (double.tryParse(cny) ?? 0) == 0 &&
        (double.tryParse(usd) ?? 0) == 0 &&
        (double.tryParse(vnd) ?? 0) == 0;
  }

  /// 获取总余额（转换为美元计算，需要汇率）
  double getTotalInUSD({double cnyToUsd = 0.14, double vndToUsd = 0.00004}) {
    final cnyAmount = double.tryParse(cny) ?? 0;
    final usdAmount = double.tryParse(usd) ?? 0;
    final vndAmount = double.tryParse(vnd) ?? 0;

    return (cnyAmount * cnyToUsd) + usdAmount + (vndAmount * vndToUsd);
  }

  @override
  String toString() {
    return 'Wallet{cny: $cny, usd: $usd, vnd: $vnd}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletModel &&
          runtimeType == other.runtimeType &&
          cny == other.cny &&
          usd == other.usd &&
          vnd == other.vnd;

  @override
  int get hashCode => cny.hashCode ^ usd.hashCode ^ vnd.hashCode;
}
