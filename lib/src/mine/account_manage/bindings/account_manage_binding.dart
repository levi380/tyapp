import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:get/get.dart';

import '../controllers/account_manage_controller.dart';

class AccountManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountManageController>(
      () => AccountManageController(),
    );
    Get.lazyPut(() => WalletService());
    Get.lazyPut(() => SecurityService());

  }
}
