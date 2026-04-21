import 'package:filbet/src/security/security_controller.dart'
    show SecuritySecondaryVerifyType;
import 'package:filbet/utils/fp.dart';

class SecurityDataModel {
  final int emailBindAt; //邮箱绑定时间秒
  final int googleBindAt; //谷歌身份验证器绑定时间秒
  final String email; //邮箱地址
  final bool hasEmail; //是否绑定邮箱 0=未绑定,1=已绑定
  final bool hasGoogle; //是否绑定谷歌验证 0=未绑定,1=已绑定
  final bool hasLoginPwd; //是否设置登录密码 0=未设置,1=已设置
  final bool hasPayPwd; //是否设置支付密码 0=未设置,1=已设置
  final int usdtWalletMax; //usdt钱包最大个数
  final int usdtNeedPhone;  // 1 绑定usdt不需要手机号 ;2 或者其他 绑定usdt需要手机号
  final SecuritySecondaryVerifyType verifyType; //安全验证方式 0无 1邮箱 2谷歌码
  final List<WalletItem> walletList; //钱包信息列表

  SecurityDataModel({
    this.emailBindAt = 0,
    this.googleBindAt = 0,
    this.email = '',
    this.hasEmail = false,
    this.hasGoogle = false,
    this.hasLoginPwd = false,
    this.hasPayPwd = false,
    this.usdtWalletMax = 0,
    this.usdtNeedPhone = 0,
    this.verifyType = SecuritySecondaryVerifyType.none,
    this.walletList = const [],
  });

  factory SecurityDataModel.fromJson(Map<String, dynamic> json) {
    final parseWalletItem = compose(
      WalletItem.fromJson,
      Map<String, dynamic>.from,
    );
    return SecurityDataModel(
      emailBindAt: json['email_bind_at'] ?? 0,
      googleBindAt: json['google_bind_at'] ?? 0,
      email: json['email'] ?? '',
      hasEmail: (json['has_email'] ?? 0) == 1,
      hasGoogle: (json['has_google'] ?? 0) == 1,
      hasLoginPwd: (json['has_login_pwd'] ?? 0) == 1,
      hasPayPwd: (json['has_pay_pwd'] ?? 0) == 1,
      usdtWalletMax: json['usdt_wallet_max'] ?? 0,
      usdtNeedPhone: json['usdt_need_phone'] ?? 0,
      verifyType: SecuritySecondaryVerifyType.fromInt(json['verify_type'] ?? 0),
      walletList: json['wallet_list'] != null
          ? (json['wallet_list'] as List)
              .map((item) => parseWalletItem(item))
              .toList()
          : [],
    );
  }
}

class WalletItem {
  final String address; //钱包地址
  final int paymentType; //钱包区块链类型
  final String paymentTypeName; //钱包区块链类型名称
  final String id; //钱包ID
  final String name; //钱包别名

  WalletItem({
    this.address = '',
    this.paymentType = 0,
    this.paymentTypeName = '',
    this.id = '',
    this.name = '',
  });

  factory WalletItem.fromJson(Map<String, dynamic> json) {
    return WalletItem(
      address: json['address'] ?? '',
      paymentType: json['payment_type'] ?? 0,
      paymentTypeName: json['payment_type_name'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
