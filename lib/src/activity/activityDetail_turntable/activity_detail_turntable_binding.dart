import 'package:filbet/src/activity/activityDetail_turntable/activity_detail_turntable_controller.dart';
import 'package:get/get.dart';

class ActivityDetailTurntableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityDetailTurntableController>(
      () => ActivityDetailTurntableController(),
    );
  }
}
