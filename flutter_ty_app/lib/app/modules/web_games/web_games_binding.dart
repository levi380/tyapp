import 'package:get/get.dart';

import 'web_games_controller.dart';

class WebGamesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebGamesController());
  }
}
