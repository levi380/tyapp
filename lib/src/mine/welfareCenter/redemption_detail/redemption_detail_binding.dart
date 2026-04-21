import 'package:filbet/src/mine/welfareCenter/redemption_detail/redemption_detail_controller.dart';
import 'package:get/get.dart';

class RedemptionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedemptionDetailController>(
      () => RedemptionDetailController(),
    );
  }
}
