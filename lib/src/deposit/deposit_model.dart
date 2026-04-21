class DepositModel {
  final String orderId;
  final String toAddress;
  final String payUrl;
  final int expired;
  final int paymentType;
  final bool? isFindDomain;
  final String? pingApi;
  final String? subUrl;
  final String? domains;

  DepositModel({
    required this.orderId,
    required this.toAddress,
    required this.payUrl,
    required this.expired,
    required this.paymentType,
    required this.isFindDomain,
    required this.pingApi,
    required this.subUrl,
    required this.domains,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      orderId: json['order_id']?.toString() ?? '',
      toAddress: json['to_address']?.toString() ?? '',
      payUrl: json['pay_url']?.toString() ?? '',
      expired: json['expired'] ?? 0,
      paymentType: json['payment_type'] ?? 0,
      isFindDomain: json['is_find_domain'],
      pingApi: json['ping_api'],
      subUrl: json['sub_url'],
      domains: json['domains'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'to_address': toAddress,
      'pay_url': payUrl,
      'expired': expired,
      'payment_type': paymentType,
    };
  }

  // 获取地址的简短显示格式（前6位 + ... + 后4位）
  String get shortAddress {
    if (toAddress.length <= 10) return toAddress;
    return '${toAddress.substring(0, 6)}...${toAddress.substring(toAddress.length - 4)}';
  }

  // 便捷方法
  bool get hasValidOrderId => orderId.isNotEmpty;

  bool get hasValidAddress => toAddress.isNotEmpty;

  bool get hasValidPayUrl => payUrl.isNotEmpty;

  bool get isValid => hasValidOrderId && hasValidAddress && hasValidPayUrl;
}
