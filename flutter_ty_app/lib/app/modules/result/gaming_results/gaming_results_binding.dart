import 'package:get/get.dart';

import '../normal_results/normal_results_controller.dart';
import '../result_controller.dart';
import 'gaming_results_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-986a10e2-8038-4187-b36c-717a79579d9c-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果 控制器 GamingResultsController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  电竞赛果 Binding
    】】】
 *
 */
class GamingResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GamingResultsController());
    Get.lazyPut(() => ResultController());
    Get.lazyPut(() => NormalResultsController());
  }
}
