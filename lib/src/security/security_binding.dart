import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/security/security_controller.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:get/get.dart';

class SecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      final securityData = UserService.to.state.securityData;
      return SecurityController(securityData: securityData);
    });
    Get.lazyPut(() => SecurityService());
    Get.lazyPut(() => WalletService());
  }
}
