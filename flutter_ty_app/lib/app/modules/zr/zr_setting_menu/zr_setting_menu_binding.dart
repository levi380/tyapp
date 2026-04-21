import 'package:get/get.dart';

import 'zr_setting_menu_controller.dart';

class ZrSettingMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ZrSettingMenuController());
  }
}
