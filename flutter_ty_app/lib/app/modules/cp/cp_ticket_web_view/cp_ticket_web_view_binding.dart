import 'package:get/get.dart';

import 'cp_ticket_web_view_controller.dart';

class CpTicketWebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CpTicketWebViewController());
  }
}
