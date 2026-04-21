import 'package:filbet/src/mine/vip/privilege/controllers/vip_privilege_logic.dart';
import 'package:get/get.dart';

class VipPrivilegeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return VipRPrivilegeController();
    });
  }
}
