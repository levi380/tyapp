import 'package:get/get.dart';

import 'bet_order_notification_controller.dart';

class BetOrderNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BetOrderNotificationController());
  }
}
