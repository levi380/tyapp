import 'package:filbet/http/entity/platform_wallet_model.dart';

/// total_balance : "1500.50"
/// wallets : [{"wallet_id":"108","wallet_name":"AG真人","balance":"1000.00","maintained":1,"locked":2},{"wallet_id":"109","wallet_name":"CQ9电子","balance":"0","maintained":1,"locked":2},{"wallet_id":"110","wallet_name":"DB真人","balance":"500.50","maintained":2,"locked":1}]

class RespPlatformWallet {
  RespPlatformWallet({
      this.platformBalance,
      this.balance,
      this.lockBalance,
      this.wallets,});

  RespPlatformWallet.fromJson(dynamic json) {
    platformBalance = json['platform_balance'];
    balance = json['balance'];
    lockBalance = json['lock_balance'];
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(PlatformWalletModel.fromJson(v));
      });
    }
  }
  String? platformBalance;
  String? balance;
  String? lockBalance;
  List<PlatformWalletModel>? wallets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

