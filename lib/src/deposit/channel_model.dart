import 'package:filbet/common/currency.dart';
import 'package:filbet/utils/num_util.dart';

class ChannelModel {
  final String id;
  final String mode;
  final String tokenType;
  final int paymentType; //链路协议 1：TRC20 2:ERC20
  final int currency;
  final String name;
  final String img;
  final String frontName;
  final String minAmount;
  final String maxAmount;
  final List<int> amountLimit;
  final int sort;
  final String fee;
  final String fastDepositAddress;
  final String? recommend;
  final String? wdlUrl;
  final String? discountRate;

  ChannelModel({
    required this.id,
    required this.mode,
    required this.tokenType,
    required this.paymentType,
    required this.currency,
    required this.name,
    required this.img,
    required this.frontName,
    required this.minAmount,
    required this.maxAmount,
    required this.amountLimit,
    required this.sort,
    required this.fee,
    required this.fastDepositAddress,
    required this.recommend,
    required this.wdlUrl,
    required this.discountRate,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id']?.toString() ?? '',
      mode: json['mode']?.toString() ?? '',
      tokenType: json['token_type']?.toString() ?? '',
      paymentType: int.tryParse(json['payment_type']?.toString() ?? '0') ?? 0,
      currency: int.tryParse(json['currency']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      img: json['img']?.toString() ?? '',
      frontName: json['front_name']?.toString() ?? '',
      minAmount: json['min_amount']?.toString() ?? '',
      maxAmount: json['max_amount']?.toString() ?? '',
      amountLimit: (json['amount_limit'] as List<dynamic>?)
              ?.map((e) => int.tryParse(e.toString()) ?? 0)
              .toList() ??
          [],
      sort: int.tryParse(json['sort']?.toString() ?? '0') ?? 0,
      fee: json['fee_ratio']?.toString() ?? '',
      fastDepositAddress: json['fast_deposit_address']?.toString() ?? '',
      recommend: json['recommend']?.toString() ?? '',
      wdlUrl: json['wdl_url']?.toString() ?? '',
      discountRate: json['discount_rate']?.toString() ?? '',
    );
  }

  Currency get currencyType => Currency.fromCodeInt(currency);

  // 便捷方法
  bool get isDeposit => mode.toLowerCase() == 'deposit';

  bool get isWithdraw => mode.toLowerCase() == 'withdraw';

  bool get isTRC20 => paymentType == 1;

  bool get isERC20 => paymentType == 2;

  String get blockChainName {
    switch (paymentType) {
      case 1:
        return 'TRC20';
      case 2:
        return 'ERC20';
      case 3:
        return 'EB Pay';
      case 4:
        return 'NO Wallet';
      case 5:
        return 'HD Pay';
      case 6:
        return 'Bank';
      case 7:
        return 'Alipay';
      default:
        return 'Unknown';
    }
  }

  String get range {
    return '${toThousands(minAmount)}-${toThousands(maxAmount)}';
  }

  // 金额验证方法
  bool isAmountValid(double amount) {
    final min = double.tryParse(minAmount) ?? 0;
    final max = double.tryParse(maxAmount) ?? double.infinity;
    return amount >= min && amount <= max;
  }

  // 获取最接近的预设金额
  int getClosestAmountLimit(double targetAmount) {
    if (amountLimit.isEmpty) return 0;

    return amountLimit.reduce((closest, current) {
      return (current - targetAmount).abs() < (closest - targetAmount).abs()
          ? current
          : closest;
    });
  }
}
