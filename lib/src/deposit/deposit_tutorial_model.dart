class DepositTutorialModel {
  final int paymentType; //链路协议 1：TRC20 2:ERC20  3 EB Pay ,4 NO Wallet ,5 HD Pay ,6 银行卡 ,7 支付宝 , 8 微信 ，9 Mpay 钱包
  final String name;
  final String img;

  DepositTutorialModel({
    required this.paymentType,
    required this.name,
    required this.img,
  });
}
