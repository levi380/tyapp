import 'package:get/get.dart';
import 'game_init_controller.dart';

class GameInitViewBinding extends Bindings {
  @override
  void dependencies() {
    String? game_id;

    if (Get.arguments is Map) {
      game_id = Get.arguments["game_id"]?.toString();
    }
    
    // 使用 Get.put 立即创建，因为 TaggedGetView 在 build 时会立即访问 controller
    if (!Get.isRegistered<GameInitController>(tag: game_id)) {
      Get.put<GameInitController>(
        GameInitController(),
        tag: game_id,
      );
    }
  }
}
