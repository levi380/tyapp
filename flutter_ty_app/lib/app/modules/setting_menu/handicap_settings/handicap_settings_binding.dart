import 'package:get/get.dart';

import 'handicap_settings_logic.dart';

class HandicapSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HandicapSettingsLogic());
  }
}
