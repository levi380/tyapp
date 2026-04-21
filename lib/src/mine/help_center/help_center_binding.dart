import 'package:filbet/src/mine/help_center/help_center_controller.dart';
import 'package:get/get.dart';

class HelpCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpCenterController>(
      () => HelpCenterController(),
    );
  }
}
