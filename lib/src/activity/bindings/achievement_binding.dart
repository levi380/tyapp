import 'package:filbet/src/activity/controllers/achievement_controller.dart';
import 'package:get/get.dart';

class AchievementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AchievementController>(
      () => AchievementController(),
    );
  }
}
