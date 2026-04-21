import 'package:filbet/src/login/tg_login/login_tg_controller.dart';
import 'package:get/get.dart';

class LoginTelegramBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginTelegramController>(
      () => LoginTelegramController(),
    );
  }
}
