import 'package:filbet/common/currency.dart';
import 'package:filbet/src/mine/betRecord/bet_record_model.dart';
import 'package:filbet/src/mine/betRecord/controllers/bet_record_controller.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:get/get.dart';

class BetRecordDetailController extends GetxController {
  Rx<BetRecordItem> betRecordItem;
  Rx<Currency> currency;

  BetRecordDetailController({
    required BetRecordItem betRecordItem,
    required Currency currency,
  })  : betRecordItem = betRecordItem.obs,
        currency = currency.obs;

  String get betAmount {
    return '${currency.value.symbol}${betRecordItem.value.betAmount.toFixed2()}';
  }

  String get validBetAmount {
    return '${currency.value.symbol}${betRecordItem.value.validBetAmount.toFixed2()}';
  }

  bool get isWin {
    BetRecordType betRecordType =
        BetRecordType.fromCode(betRecordItem.value.status);
    return betRecordType == BetRecordType.settled &&
        double.parse(betRecordItem.value.netAmount) > 0;
  }

  String get winOrLost {
    final isPositive = double.tryParse(betRecordItem.value.netAmount) != null &&
        double.parse(betRecordItem.value.netAmount) > 0;

    return (isPositive
        ? '+ ${currency.value.symbol} ${betRecordItem.value.netAmount.toFixed2()}'
        : '${replaceStr(betRecordItem.value.netAmount.toFixed2())}');
  }

  String replaceStr(String str) {
    if (str.startsWith("-")) {
      return str.replaceFirst("-", "- ${currency.value.symbol}");
    } else {
      return "+ ${currency.value.symbol}$str";
    }
  }

  String get settleResult {
    BetRecordType betRecordType =
        BetRecordType.fromCode(betRecordItem.value.status);

    switch (betRecordType) {
      case BetRecordType.unsettled:
        return 'unsettled'.tr;
      case BetRecordType.settled:
        if (double.parse(betRecordItem.value.netAmount) > 0) {
          return 'settled'.tr + " " + 'win'.tr;
        } else if (double.parse(betRecordItem.value.netAmount) == 0) {
          return 'settled'.tr + " " + 'draw'.tr;
        } else if (double.parse(betRecordItem.value.netAmount) < 0) {
          return 'settled'.tr + " " + 'lose'.tr;
        } else {
          return 'settled'.tr + " " + 'lose'.tr;
        }

      case BetRecordType.cancel:
        return 'canceled'.tr;
      case BetRecordType.unavailable:
        return 'invalid'.tr;
    }
  }

  String get betTime {
    return betRecordItem.value.betTime.toFormattedDateTimeString02();
  }

  String get settleTime {
    return betRecordItem.value.settleTime.toFormattedDateTimeString02();
  }

  String get statisticsTime {
    return betRecordItem.value.updatedAt.toFormattedDateTimeString02();
  }
}
