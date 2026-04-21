import 'package:get/get.dart';

import '../controllers/forget_withdrawal_pwd_controller.dart';

class ForgetWithdrawalPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetWithdrawalPwdController>(
      () => ForgetWithdrawalPwdController(),
    );
  }
}
