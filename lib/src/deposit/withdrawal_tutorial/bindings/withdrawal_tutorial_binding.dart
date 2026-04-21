import 'package:get/get.dart';

import '../controllers/withdrawal_tutorial_controller.dart';

class WithdrawalTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawalTutorialController>(
      () => WithdrawalTutorialController(),
    );
  }
}
