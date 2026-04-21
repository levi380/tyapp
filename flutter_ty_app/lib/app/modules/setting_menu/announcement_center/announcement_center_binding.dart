import 'package:get/get.dart';

import 'announcement_center_controller.dart';

class AnnouncementCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementCenterController());
  }
}
