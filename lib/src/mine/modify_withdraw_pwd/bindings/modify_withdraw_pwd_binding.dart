import 'package:get/get.dart';

import '../controllers/modify_withdraw_pwd_controller.dart';

class ModifyWithdrawPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModifyWithdrawPwdController>(
      () => ModifyWithdrawPwdController(),
    );
  }
}
