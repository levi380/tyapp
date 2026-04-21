import 'package:filbet/src/security/security_service.dart';
import 'package:get/get.dart';

import '../controllers/real_name_authentication_controller.dart';

class RealNameAuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealNameAuthenticationController>(
      () => RealNameAuthenticationController(),
    );
    Get.lazyPut(() => SecurityService());
  }
}
