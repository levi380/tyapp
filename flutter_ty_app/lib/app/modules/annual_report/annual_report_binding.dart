import 'package:get/get.dart';

import 'annual_report_controller.dart';

class AnnualReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnualReportController());
  }
}
