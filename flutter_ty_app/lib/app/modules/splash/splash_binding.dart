
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    //因为SdkHomeBinding是initialBinding，所以这里可以去除
    //Get.put(DataStoreController(), permanent: true);
    //Get.put(CollectionController(), permanent: true);
  }
}
