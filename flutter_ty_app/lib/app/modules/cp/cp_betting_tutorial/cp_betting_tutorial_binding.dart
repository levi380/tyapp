import 'package:get/get.dart';

import 'cp_betting_tutorial_controller.dart';

class CpBettingTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CpBettingTutorialController());
  }
}
