import 'package:filbet/src/deposit_activity/views/activity_service.dart';
import 'package:get/get.dart';

import '../controllers/bet_first_deposit_controller.dart';

class BettingFirstDepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BettingFirstDepositController>(
      () => BettingFirstDepositController(),
    );
    Get.put(ActivityService());
  }
}
