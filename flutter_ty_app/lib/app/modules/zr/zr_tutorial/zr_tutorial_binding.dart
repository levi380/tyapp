import 'package:get/get.dart';

import 'zr_tutorial_controller.dart';

class ZrTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ZrTutorialController());
  }
}
