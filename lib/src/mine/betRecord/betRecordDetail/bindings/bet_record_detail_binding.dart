import 'package:filbet/common/currency.dart';
import 'package:filbet/src/mine/betRecord/betRecordDetail/controllers/bet_record_detail_controller.dart';
import 'package:filbet/src/mine/betRecord/bet_record_model.dart';
import 'package:get/get.dart';

class BetRecordDetailBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments == null) {
      throw Exception('BetRecordDetailBinding: Missing required arguments');
    }

    final betRecordItem = arguments['betRecordItem'] as BetRecordItem?;
    final currency = arguments['currency'] as Currency?;

    if (betRecordItem == null || currency == null) {
      throw Exception(
          'BetRecordDetailBinding: Missing required parameters (betRecordItem or currency)');
    }

    Get.lazyPut<BetRecordDetailController>(
      () => BetRecordDetailController(
        betRecordItem: betRecordItem,
        currency: currency,
      ),
    );
  }
}
