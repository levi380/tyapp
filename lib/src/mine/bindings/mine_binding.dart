import 'package:filbet/src/mine/controllers/mine_controller.dart';
import 'package:filbet/src/mine/controllers/user_info_controller.dart';
import 'package:get/get.dart';

class MineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineController>(
      () => MineController(),
    );
  }
}
