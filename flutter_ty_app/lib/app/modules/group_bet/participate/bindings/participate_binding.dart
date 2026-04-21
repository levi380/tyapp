import 'package:get/get.dart';

import '../controllers/participate_controller.dart';

class ParticipateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipateController>(
      () => ParticipateController(),
    );
  }
}
