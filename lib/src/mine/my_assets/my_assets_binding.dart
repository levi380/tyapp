import 'package:filbet/src/mine/my_assets/my_assets_controller.dart';
import 'package:get/get.dart';

class MyAssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAssetsController>(() => MyAssetsController());
  }
}
