import 'package:filbet/src/activity/controllers/activity_controller.dart';
import 'package:get/get.dart';

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityController>(
      () => ActivityController(),
    );
  }
}
