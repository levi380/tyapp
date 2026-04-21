import 'package:get/get.dart';

import 'gamelist_controller.dart';

class GameListBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    print('[GameListBinding] args=' + args.toString());

    String? platform_id;

    if (args is Map) {
      platform_id = args["platform_id"];
    }
    print('[GameListBinding] register tag=' + (platform_id?.toString() ?? 'null') + ' type=' + (platform_id?.runtimeType.toString() ?? 'null'));

    Get.lazyPut<GameListController>(() => GameListController(), tag: platform_id);
  }
}
