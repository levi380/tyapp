import 'package:filbet/src/activity/winner_record/winner_record_controller.dart';
import 'package:get/get.dart';

class WinnerRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WinnerRecordController>(
      () => WinnerRecordController(),
    );
  }
}
