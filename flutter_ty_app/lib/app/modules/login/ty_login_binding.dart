import 'package:get/get.dart';
import 'ty_login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TyLoginController());
  }
}
