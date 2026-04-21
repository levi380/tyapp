import 'package:get/get.dart';

import 'cp_setting_menu_controller.dart';

class CpSettingMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CpSettingMenuController());
  }
}
