import 'package:filbet/src/mine/controllers/mine_controller.dart';
import 'package:filbet/src/mine/controllers/user_info_controller.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:get/get.dart';

class UserinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserInfoController>(
      () => UserInfoController(),
    );
    Get.put(SecurityService());
  }
}
