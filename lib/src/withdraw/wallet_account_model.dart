import 'dart:convert';

import 'package:filbet/http/entity/address_info.dart';
import 'package:get/get.dart';

class WalletAccountModel {
  final String address;
  final int paymentType; //payment_type = 6 银行卡  payment_type = 7 支付宝
  final String id; // 提现时需要传入的 account_id
  final String name; // 名称
  final int status; // 1可用 2不可用
  final String tokenType;
  final String uid;
  AddressInfo? addressInfo;
  bool isObscured = false;
  String decAddress = "";

  WalletAccountModel({
    required this.address,
    required this.paymentType,
    required this.id,
    required this.name,
    required this.status,
    required this.tokenType,
    required this.uid,
    required this.addressInfo,
  });

  factory WalletAccountModel.fromJson(Map<String, dynamic> json) {
    String address = json['address_info'] ?? '';
    return WalletAccountModel(
      address: json['address']?.toString() ?? '',
      paymentType: json['payment_type']?.toInt() ?? 0,
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      status: json['status']?.toInt() ?? 0,
      tokenType: json['token_type']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
      addressInfo: address.isNotEmpty == true ? AddressInfo.fromJson(jsonDecode(address)) : null,
    );
  }

  String get blockChainTitleName {
    switch (paymentType) {
      case 1: // TRC20
        return 'usdt_wallet_address'.tr;
      case 2:
      case 3: // ERC20
        return 'eb_wallet_address'.tr;
      case 4: // ERC20
        return 'no_wallet_address'.tr;
      case 6: // ERC20
        return 'bank_card'.tr;
      case 7:
        return 'alipay'.tr;

      default:
        return '';
    }
  }

  String get blockChainName {
    switch (paymentType) {
      case 1:
        return 'TRC20';
      case 2:
      case 3: // ERC20
        return 'ERC20';
      case 4: // ERC20
        return 'NO Wallet';

      default:
        return '';
    }
  }
}
