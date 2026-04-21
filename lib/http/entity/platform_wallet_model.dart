/// wallet_id : "108"
/// wallet_name : "AG真人"
/// balance : "1000.00"
///  | maintained | int | 维护状态：1=正常，2=维护中 |
///   | locked | int | 锁定状态：1=锁定，2=解锁 |

class PlatformWalletModel {
  PlatformWalletModel({
    this.walletId,
    this.walletName,
    this.balance,
    this.maintained,
    this.locked,});

  PlatformWalletModel.fromJson(dynamic json) {
    walletId = json['wallet_id'];
    walletName = json['wallet_name'];
    balance = json['balance'];
    maintained = json['maintained'];
    locked = json['locked'];
  }
  String? walletId;
  String? walletName;
  String? balance;
  num? maintained;
  num? locked;
  String? remainTurnover;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wallet_id'] = walletId;
    map['wallet_name'] = walletName;
    map['balance'] = balance;
    map['maintained'] = maintained;
    map['locked'] = locked;
    return map;
  }

}