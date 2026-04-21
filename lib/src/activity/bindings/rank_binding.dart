import 'package:filbet/src/activity/controllers/rank_controller.dart';
import 'package:get/get.dart';

class RankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankController>(
      () => RankController(),
    );
  }
}
