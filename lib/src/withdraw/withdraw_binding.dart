import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/security/security_controller.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/src/withdraw/withdraw_controller.dart';
import 'package:get/get.dart';
import 'package:filbet/services/user/user_service.dart';
class WithdrawBinding extends Bindings {
  @override
  void dependencies() {
    final securityData = UserService.to.state.securityData;
    Get.lazyPut(() {
      final currency = UserService.to.state.currencyType;
      final avaliables = GlobalService.to.state.currencyConfig;
      return WithdrawController(
        currency: currency,
        avaliables: avaliables,
        securityData: securityData,
      );
    });
    Get.lazyPut(() => SecurityService());
    Get.lazyPut(() => WalletService());
    Get.lazyPut(() => SecurityController(securityData: securityData));
  }
}
