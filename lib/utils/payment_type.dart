//钱包类型
enum PayType {
  trc20,
  erc20,
  ebPay,
  noWallet,
  hdPay,
  bankCard,
  alipay,
  wechat,
  Mpay,
  to_pay,
  cb_pay,
  w_pay,
  go_pay,
  p365_pay,
  f_pay,
  no_pay,
  ok_pay,
  qn_pay,
  bo_pay,
  union_pay,
}

extension PayTypeExt on PayType {
  /// 接口返回的 code
  int get code {
    switch (this) {
      case PayType.trc20:
        return 1;
      case PayType.erc20:
        return 2;
      case PayType.ebPay:
        return 3;
      case PayType.noWallet:
        return 4;
      case PayType.hdPay:
        return 5;
      case PayType.bankCard:
        return 6;
      case PayType.alipay:
        return 7;
      case PayType.wechat:
        return 8;
      case PayType.Mpay:
        return 9;
      case PayType.cb_pay:
        return 10;
      case PayType.p365_pay:
        return 11;
      case PayType.union_pay:
        return 12;
      case PayType.f_pay:
        return 13;
      case PayType.go_pay:
        return 14;
      case PayType.w_pay:
        return 15;
      case PayType.ok_pay:
        return 16;
      case PayType.to_pay:
        return 17;
      case PayType.qn_pay:
        return 18;
      case PayType.no_pay:
        return 19;
      case PayType.bo_pay:
        return 20;
    }
  }

  /// 接口 key
  String get key {
    switch (this) {
      case PayType.trc20:
        return 'TRC20';
      case PayType.erc20:
        return 'ERC20';
      case PayType.ebPay:
        return 'EB Pay';
      case PayType.noWallet:
        return 'NO Wallet';
      case PayType.hdPay:
        return 'HD Pay';
      case PayType.bankCard:
        return '银行卡';
      case PayType.alipay:
        return '支付宝';
      case PayType.wechat:
        return '微信';
      case PayType.Mpay:
        return 'Mpay钱包';
      case PayType.to_pay:
        return 'TOPAY';
      case PayType.cb_pay:
        return 'CBPAY';
      case PayType.w_pay:
        return 'WPAY';
      case PayType.p365_pay:
        return '365PAY';
      case PayType.f_pay:
        return 'FPAY';
      case PayType.no_pay:
        return 'NOPAY';
      case PayType.ok_pay:
        return 'OKPAY';
      case PayType.qn_pay:
        return 'QNPAY';
      case PayType.bo_pay:
        return '波币';
      case PayType.go_pay:
        return 'GOPAY';
      case PayType.union_pay:
        return '银联扫码';
    }
  }
}
