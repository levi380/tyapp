import 'package:get/get.dart';

import 'results_details_controller.dart';

class ResultsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultsDetailsController());
    // Get.lazyPut(() => MatchDetailController());
  }
}
