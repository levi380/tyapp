import 'package:filbet/src/mine/help_center/transfer_tutorial_controller.dart';
import 'package:get/get.dart';

class TransferTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransferTutorialController());
  }
}

