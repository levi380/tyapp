import 'package:filbet/src/mine/verity_identity/verity_identity_controller.dart';
import 'package:get/get.dart';

class VerityIdentityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerityIdentityController>(
      () => VerityIdentityController(),
    );
  }
}
