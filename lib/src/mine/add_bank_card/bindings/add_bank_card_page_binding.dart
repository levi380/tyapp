import 'package:filbet/src/security/security_service.dart';
import 'package:get/get.dart';

import '../controllers/add_bank_card_page_controller.dart';

class AddBankCardPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankCardPageController>(
      () => AddBankCardPageController(),
    );
    Get.lazyPut(() => SecurityService());
  }
}
