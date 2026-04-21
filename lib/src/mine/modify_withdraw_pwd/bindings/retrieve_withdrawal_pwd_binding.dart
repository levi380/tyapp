import 'package:get/get.dart';

import '../controllers/retrieve_withdrawal_pwd_controller.dart';

class RetrieveWithdrawalPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RetrieveWithdrawalPwdController>(
      () => RetrieveWithdrawalPwdController(),
    );
  }
}
