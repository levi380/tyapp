import 'package:get/get.dart';

import '../controllers/welfare_center_controller.dart';

class WelfareCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelfareCenterController>(
      () => WelfareCenterController(),
    );
  }
}
