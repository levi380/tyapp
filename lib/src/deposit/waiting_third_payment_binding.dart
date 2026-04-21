import 'package:get/get.dart';

import 'waiting_third_payment_controller.dart';

class WaitingThirdPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingThirdPaymentController>(
      () => WaitingThirdPaymentController(),
    );
  }
}
