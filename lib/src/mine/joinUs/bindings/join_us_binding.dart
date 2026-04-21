import 'package:filbet/src/mine/joinUs/controller/jpin_us_controller.dart';
import 'package:get/get.dart';

class JoinUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JoinUsController());
  }
}
