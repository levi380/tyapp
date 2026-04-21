import 'package:flutter_ty_app/app/modules/discount_odd/controllers/discount_odd_controller.dart';

import '../../login/login_head_import.dart';

class DiscountOddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscountOddController());
  }
}
