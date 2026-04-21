import 'package:filbet/src/game/db_sdk/db_sdk_controller.dart';
import 'package:get/get.dart';

class DbSdkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DbSdkController());
  }
}
