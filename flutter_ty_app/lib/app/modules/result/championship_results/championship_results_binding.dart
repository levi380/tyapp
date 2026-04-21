import 'package:get/get.dart';

import '../gaming_results/gaming_results_controller.dart';
import '../normal_results/normal_results_controller.dart';
import '../result_controller.dart';
import 'championship_results_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-371b80cf-eae4-4d1e-aa5e-bbccef933e87 】】】
    【【【 AUTO_DOCUMENT_MENU 一键投注弹窗 】】】
    【【【 AUTO_DOCUMENT_TITLE 视图层 】】】
    【【【 AUTO_PARAGRAPH_TITLE 组件拆分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 冠军binding
    】】】
 *
 */
class ChampionshipResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChampionshipResultsController());
    Get.lazyPut(() => ResultController());
    Get.lazyPut(() => NormalResultsController());
    Get.lazyPut(() => GamingResultsController());
  }
}
