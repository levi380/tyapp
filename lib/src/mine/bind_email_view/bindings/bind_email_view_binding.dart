import 'package:get/get.dart';

import '../controllers/bind_email_view_controller.dart';

class BindEmailViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindEmailViewController>(
      () => BindEmailViewController(),
    );
  }
}
