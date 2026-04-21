import 'package:get/get.dart';

import '../controllers/first_deposit_activity_controller.dart';

class FirstDepositActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstDepositActivityController>(
      () => FirstDepositActivityController(),
    );
  }
}
