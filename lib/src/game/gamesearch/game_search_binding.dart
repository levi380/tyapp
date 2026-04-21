

import 'package:get/get.dart';

import 'game_search_controller.dart';

class GameSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameSearchController());
  }
}
