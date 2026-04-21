import 'package:filbet/services/global/global_service.dart';

import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/deposit/deposit_controller.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:get/get.dart';

class DepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      final currency = UserService.to.state.currencyType;
      final avaliables = GlobalService.to.state.currencyConfig;
      return DepositController(currency: currency, avaliables: avaliables);
    });
    Get.lazyPut(() => WalletService());
  }
}
