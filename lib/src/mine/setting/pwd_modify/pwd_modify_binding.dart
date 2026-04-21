import 'package:filbet/src/mine/setting/pwd_modify/pwd_modify_controller.dart';
import 'package:get/get.dart';

class PwdModifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PwdModifyController>(
      () => PwdModifyController(),
    );
  }
}
