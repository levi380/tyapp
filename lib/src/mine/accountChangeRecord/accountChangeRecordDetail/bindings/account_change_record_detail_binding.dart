import 'package:filbet/src/mine/accountChangeRecord/accountChangeRecordDetail/controllers/account_change_record_detail_controller.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_record_model.dart';
import 'package:get/get.dart';

class AccountChangeRecordDetailBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments == null) {
      throw Exception(
          'AccountChangeRecordDetailBinding: Missing required arguments');
    }
    final item = arguments['item'];
    if (item == null || item is! AccountChangeRecordBaseItem) {
      throw Exception(
          'AccountChangeRecordDetailBinding: Invalid or missing item argument');
    }

    final detail = AccountChangeRecordDetail(item: item);
    Get.lazyPut(
      () => AccountChangeRecordDetailController(detail: detail),
    );
  }
}
