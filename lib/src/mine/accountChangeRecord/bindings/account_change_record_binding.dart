import 'package:filbet/common/currency.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_service.dart';
import 'package:filbet/src/mine/accountChangeRecord/controllers/account_change_record_controller.dart';
import 'package:get/get.dart';
import 'package:filbet/services/user/user_service.dart';

class AccountChangeRecordBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments;
    int index = 0;
    if (arguments != null && arguments is Map<String, dynamic>) {
      final type = arguments['type'];
      if (type is int && AccountChangeType.fromValue(type) != null) {
        index = type;
      }
    }
    final currency = UserService.to.state.currencyType;
    var availableCurrency = GlobalService.to.state.currencyConfig;

    if (availableCurrency.isEmpty) {
      availableCurrency = [Currency.rmb].obs;
    }

    Get.lazyPut(() {
      return AccountChangeRecordController(
        initialIndex: index,
        currency: currency,
        availableCurrency: availableCurrency,
      );
    });
    Get.lazyPut(() => AccountChangeService());
  }
}
