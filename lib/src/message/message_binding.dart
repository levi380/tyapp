

import 'package:filbet/src/message/message_center_controller.dart';
import 'package:get/get.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageCenterController());
  }
}
