import 'package:get/get.dart';

import '../controllers/withdrawal_pwd_controller.dart';

class WithdrawalPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawalPwdController>(
      () => WithdrawalPwdController(),
    );
  }
}
