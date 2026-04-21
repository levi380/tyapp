import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:get/get.dart';

import '../../global/data_store_controller.dart';
import '../home/controllers/collection_controller.dart';
import '../home/controllers/pin_controller.dart';
import 'sdk_home_controller.dart';

class SdkHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConfigController(), permanent: true);
    Get.put(PinController(), permanent: true);
    Get.lazyPut(() => SdkTyHomeController());
    Get.put(DataStoreController(), permanent: true);
    Get.put(CollectionController(), permanent: true);
  }
}
