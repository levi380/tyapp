import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:get/get.dart';
import '../../../core/constant/project/module/betting/bet-odds-constant.dart';
import '../setting_menu_controller.dart';
import 'handicap_settings_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5b682c84-d24f-4fa7-830c-023cfe22939a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口设置】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口设置 控制器 HandicapSettingsLogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口设置 控制器 HandicapSettingsLogic
    - HandicapSettingsLogic
    ```
    /// 更新盘口类型
    updateHandicapType(int i, String key)
    ```
    】】】
 *
 */
class HandicapSettingsLogic extends GetxController {
  static HandicapSettingsLogic get to => Get.find();

  final HandicapSettingsState state = HandicapSettingsState();

  List<BetOddsConstantModel> handicapList = [];

  @override
  void onInit() {
      oddsConstant.forEach((element){
          if(TYUserController.to.userInfo.value?.paramConfigs?[element.value] == "1") {
            handicapList.add(element);
          }
      });

      if(ShopCartController.to.state.isVrMenu){
        handicapList.removeWhere((e)=>e.value!="EU" && e.value != "HK");
      }

    super.onInit();
  }

  /// 更新盘口类型
  updateHandicapType(int i, String key) {
    SettingMenuController.to.onHandicapSettings(i, key).then((e) {
      update();
      Get.back(result: "closeSetting");
    });
  }
}
