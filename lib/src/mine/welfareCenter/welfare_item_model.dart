import 'dart:convert';

class WelfareItemModel {
  final String? id;
  final String? amount;
  final String? water;
  final int? currency;
  final String? rateCny;
  final String? rateUsd;
  final String? rateVnd;
  final String? recvAmount;
  final String? name;
  final String? remark;
  final int? recvCurrency;
  final int? type;
  final int? status;
  final int? expiredAt;
  final int createdAt;
  final String? platNames;
  final String? plats;
  final int? walletType;
  final String? content;
  final Map<String, dynamic>? modHis;

  WelfareItemModel(
      {this.id,
      this.amount,
      this.water,
      this.currency,
      this.rateCny,
      this.rateUsd,
      this.rateVnd,
      this.recvAmount,
      this.recvCurrency,
      this.type,
      this.status,
      this.expiredAt,
      this.createdAt = 0,
      this.name,
      this.remark,
      this.platNames,
      this.plats,
      this.content,
      this.modHis,
      this.walletType});

  factory WelfareItemModel.fromJson(Map<String, dynamic> json) {
    return WelfareItemModel(
      id: json['id'] as String?,
      amount: json['amount'] as String?,
      water: json['water'] as String?,
      currency: json['currency'] as int?,
      rateCny: json['rate_cny'] as String?,
      rateUsd: json['rate_usd'] as String?,
      rateVnd: json['rate_vnd'] as String?,
      recvAmount: json['recv_amount'] as String?,
      recvCurrency: json['recv_currency'] as int?,
      type: json['type'] as int?,
      status: json['status'] as int?,
      expiredAt: json['expired_at'] as int?,
      createdAt: json['created_at'],
      name: json['name'],
      remark: json['remark'],
      platNames: json['plat_names'],
      plats: json['plats'],
      walletType: json['wallet_type'],
      content: json['content'],
      modHis: parseToMap(json['mod_his']),
    );
  }

  static Map<String, dynamic>? parseToMap(dynamic input) {
    try {
      if (input == null) return null;
      if (input is Map) {
        return Map<String, dynamic>.from(input);
      }
      if (input is String) {
        if (input.trim().isEmpty) return null;
        final decoded = jsonDecode(input);
        return parseToMap(decoded);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'water': water,
      'currency': currency,
      'rate_cny': rateCny,
      'rate_usd': rateUsd,
      'rate_vnd': rateVnd,
      'recv_amount': recvAmount,
      'recv_currency': recvCurrency,
      'type': type,
      'status': status,
      'expired_at': expiredAt,
      'created_at': createdAt,
      'plat_names': platNames,
      'plats': plats,
      'remark': remark
    };
  }
}

class ItemModel {
  final int type;
  final String name;

  ItemModel({required this.type, required this.name});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      type: json['type'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
    };
  }

  @override
  String toString() => 'ItemModel(type: $type, name: $name)';
}
