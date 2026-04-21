import 'package:filbet/src/activity/lottery_record/lottery_record_controller.dart';
import 'package:get/get.dart';

class LotteryRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LotteryRecordController>(
      () => LotteryRecordController(),
    );
  }
}
