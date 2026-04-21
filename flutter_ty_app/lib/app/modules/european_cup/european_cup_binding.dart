import 'package:get/get.dart';

import 'european_cup_controller.dart';

class EuropeanCupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EuropeanCupController());
  }
}
