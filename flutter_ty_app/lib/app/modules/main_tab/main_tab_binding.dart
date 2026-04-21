import 'package:flutter_ty_app/app/modules/cp/controllers/cp_controller.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/zr_controller.dart';
import 'package:get/get.dart';

import '../setting_menu/setting_menu_controller.dart';
import 'main_tab_controller.dart';

class MainTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
      CpController(),
      //permanent: true,
    );
    Get.lazyPut(() =>
      ZrController(),
      //permanent: true,
    );
    Get.lazyPut(() => MainTabController());
    //Get.put(MainTabController(), permanent: true);
    Get.lazyPut(() => SettingMenuController());
  }
}
