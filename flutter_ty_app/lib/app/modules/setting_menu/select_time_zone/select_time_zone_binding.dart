import 'package:get/get.dart';

import 'select_time_zone_controller.dart';

class SelectTimeZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectTimeZoneController());
  }
}
