import 'package:filbet/src/mine/betRecord/controllers/bet_record_controller.dart';

class BetRecordModel {
  final int totalRecords;
  final String totalWin;
  final String totalBet;
  final List<BetRecordItem> records;

  BetRecordModel({
    required this.totalRecords,
    required this.totalWin,
    required this.totalBet,
    required this.records,
  });

  factory BetRecordModel.fromJson(Map<String, dynamic> json) {
    return BetRecordModel(
      totalRecords: json['t']?.toInt() ?? 0,
      totalWin: json['wt']?.toString() ?? '0.00',
      totalBet: json['bt']?.toString() ?? '0.00',
      records: (json['d'] as List<dynamic>?)
              ?.map((item) =>
                  BetRecordItem.fromJson(Map<String, dynamic>.from(item)))
              .toList() ??
          [],
    );
  }
}

class BetRecordItem {
  final String id;
  final String recordId;

  final String roundid;
  final int settleTime;
  final int betTime;
  final String gameType;
  final String platformId;
  final String platformName;
  final String gameName;
  final String currency;
  final String betAmount;
  final String validBetAmount;
  final String settlementAmount;
  final String netAmount;
  final String detail;
  final int status;
  final int updatedAt;

  final String bill_no_hash;
  final String billNo;

  BetRecordItem({
    required this.id,
    required this.recordId,
    required this.settleTime,
    required this.betTime,
    required this.gameType,
    required this.platformId,
    required this.platformName,
    required this.gameName,
    required this.currency,
    required this.betAmount,
    required this.validBetAmount,
    required this.settlementAmount,
    required this.netAmount,
    required this.detail,
    required this.status,
    required this.updatedAt,
    required this.roundid,
    required this.bill_no_hash,
    required this.billNo,
  });

  factory BetRecordItem.fromJson(Map<String, dynamic> json) {
    return BetRecordItem(
      id: json['id'] ?? "",
      bill_no_hash: json['bill_no_hash']?.toString() ?? '',
      recordId: json['record_id']?.toString() ?? '',
      roundid: json['round_id']?.toString() ?? '',
      settleTime: json['settle_time']?.toInt() ?? 0,
      betTime: json['bet_time']?.toInt() ?? 0,
      gameType: json['game_type']?.toString() ?? '',
      platformId: json['platform_id']?.toString() ?? '',
      platformName: json['platform_name']?.toString() ?? '',
      gameName: json['game_name']?.toString() ?? '',
      currency: json['currency']?.toString() ?? '',
      betAmount: json['bet_amount']?.toString() ?? '0.00',
      validBetAmount: json['valid_bet_amount']?.toString() ?? '0.00',
      settlementAmount: json['settlement_amount']?.toString() ?? '0.00',
      netAmount: json['net_amount']?.toString() ?? '0.00',
      detail: json['detail']?.toString() ?? '',
      status: json['status']?.toInt() ?? 0,
      updatedAt: json['updated_at']?.toInt() ?? 0,
      billNo: json['bill_no']?.toString() ?? '',
    );
  }

  BetRecordType get betRecordType {
    switch (status) {
      case 0:
        return BetRecordType.unsettled;
      case 1:
        return BetRecordType.settled;
      case 2:
        return BetRecordType.cancel;
      case 3:
        return BetRecordType.unavailable;
      default:
        return BetRecordType.unavailable;
    }
  }
}
