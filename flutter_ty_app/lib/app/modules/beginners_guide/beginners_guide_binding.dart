import 'package:get/get.dart';

import 'beginners_guide_controller.dart';

class BeginnersGuideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BeginnersGuideController());
  }
}
