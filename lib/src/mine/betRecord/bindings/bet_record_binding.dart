import 'package:filbet/src/mine/betRecord/controllers/bet_record_controller.dart';
import 'package:get/get.dart';

class BetRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BetRecordController());
  }
}
