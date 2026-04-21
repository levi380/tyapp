class WithdrawModel {
  final String orderNo; // 我们平台的订单id
  final String? externalOrderId; // 三方返回的订单id(有些渠道可能不会返回)

  WithdrawModel({
    required this.orderNo,
    this.externalOrderId,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      orderNo: json['order_no']?.toString() ?? '',
      externalOrderId: json['external_order_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'order_no': orderNo,
    };

    if (externalOrderId != null) {
      data['external_order_id'] = externalOrderId;
    }

    return data;
  }
}
