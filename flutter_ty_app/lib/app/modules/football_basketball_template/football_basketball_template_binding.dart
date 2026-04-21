import 'package:get/get.dart';

import 'football_basketball_template_controller.dart';

class FootballBasketballTemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FootballBasketballTemplateController());
  }
}
