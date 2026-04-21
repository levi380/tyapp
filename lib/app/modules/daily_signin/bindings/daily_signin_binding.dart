import 'package:get/get.dart';

import '../controllers/daily_signin_controller.dart';

class DailySigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DailySigninController());
  }
}
