import 'package:filbet/src/withdraw/flow_detail/flow_detail_controller.dart';
import 'package:get/get.dart';

class FlowDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlowDetailController>(() => FlowDetailController());
  }
}
