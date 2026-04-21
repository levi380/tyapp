import 'package:filbet/src/mine/setting/pwd_modify/verify/verify_controller.dart';
import 'package:get/get.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(
      () => VerifyController(),
    );
  }
}
