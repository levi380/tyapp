import 'package:filbet/src/security/security_service.dart';
import 'package:get/get.dart';

import '../controllers/add_usdt_controller.dart';

class AddUsdtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUsdtController>(
      () => AddUsdtController(),
    );
    Get.put(SecurityService());
  }
}
