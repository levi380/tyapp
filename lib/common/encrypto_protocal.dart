// ignore_for_file: constant_identifier_names

enum BlockChain {
  usdt_trc20,
  eb_pay,
  no_wallet,
  bank_pay,
  alipay,
  hd_pay,
  m_pay,
  weChat_pay,
  cb_pay,
  f_pay,
  go_pay,
  p365_pay,
  w_pay,
  ok_pay;
  // usdt_erc20;//暂时屏蔽erc20

  String get name {
    switch (this) {
      // case BlockChain.usdt_erc20:
      //   return 'ERC20';
      case BlockChain.usdt_trc20:
        return 'TRC20';
      case BlockChain.eb_pay:
        return 'EB Pay';
      case BlockChain.no_wallet:
        return 'No Wallet';
      case BlockChain.hd_pay:
        return 'HD Pay';
      case BlockChain.bank_pay:
        return '银行卡';
      case BlockChain.alipay:
        return '支付宝';
      case BlockChain.m_pay:
        return 'Mpay';
      case BlockChain.weChat_pay:
        return '微信';
      case BlockChain.cb_pay:
        return 'CBPAY';
      case BlockChain.f_pay:
        return 'FPAY';
      case BlockChain.go_pay:
        return 'GOPAY';
      case BlockChain.p365_pay:
        return '365PAY';
      case BlockChain.w_pay:
        return 'WPAY';
      case BlockChain.ok_pay:
        return 'OKPAY';
    }
  }

  int get code {
    switch (this) {
      // case BlockChain.usdt_erc20:
      //   return 2; // ERC20
      case BlockChain.usdt_trc20:
        return 1; // TRC20
      case BlockChain.eb_pay:
        return 3; // EBPay
      case BlockChain.no_wallet:
        return 4; // No Wallet
      case BlockChain.hd_pay:
        return 5; // No Wallet
      case BlockChain.bank_pay:
        return 6;
      case BlockChain.alipay:
        return 7;
      case BlockChain.weChat_pay:
        return 8;
      case BlockChain.m_pay:
        return 9;
      case BlockChain.cb_pay:
        return 10;
      case BlockChain.p365_pay:
        return 11;
      case BlockChain.f_pay:
        return 13;
      case BlockChain.go_pay:
        return 14;
      case BlockChain.w_pay:
        return 15;
      case BlockChain.ok_pay:
        return 16;
    }
  }

  static BlockChain fromCode(int code) {
    switch (code) {
      case 1:
        return BlockChain.usdt_trc20;
      case 4:
        return BlockChain.no_wallet;
      case 3:
        return BlockChain.eb_pay;
      case 5:
        return BlockChain.hd_pay;
      case 6:
        return BlockChain.bank_pay;
      case 7:
        return BlockChain.alipay;
      case 8:
        return BlockChain.weChat_pay;
      case 9:
        return BlockChain.m_pay;
      default:
        throw ArgumentError('Invalid BlockChain code: $code');
    }
  }
}
