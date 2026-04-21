import 'package:filbet/src/mine/transfer/transfer_controller.dart';
import 'package:get/get.dart';

class TransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferController>(() => TransferController());
  }
}
