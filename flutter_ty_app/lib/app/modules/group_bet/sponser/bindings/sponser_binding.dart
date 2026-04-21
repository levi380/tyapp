import 'package:get/get.dart';

import '../controllers/sponser_controller.dart';

class SponserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SponserController>(
      () => SponserController(),
    );
  }
}
