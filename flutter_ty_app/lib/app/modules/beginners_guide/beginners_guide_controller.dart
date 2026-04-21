
import 'package:flutter_ty_app/app/config/getx_navigation.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';

import '../../services/api/menu_api.dart';

import '../home/controllers/home_controller.dart';
import '../login/login_head_import.dart';
import 'beginners_guide_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1356b157-6c7f-43df-adaa-7e21cd8621f9-yd 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  新手引导】】】
    【【【 AUTO_PARAGRAPH_TITLE 新手引导 控制器 BeginnersGuideController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 新手引导 控制器 BeginnersGuideController
    ```
    ///引导页试图索引
    int currentPage = 0;
    ///默认加载引导页语言
    String language = 'zh';
    ```
    】】】
 *
 */

class BeginnersGuideController extends GetxController {
  final BeginnersGuideLogic logic = BeginnersGuideLogic();

  final PageController pageController = PageController();


  @override
  void onInit() {
    // TODO: implement onInit
    ///印尼语   缅甸语   西班牙语  弹英语
    if (Get.locale!.countryCode == 'ID' || Get.locale!.countryCode == 'MM' || Get.locale!.countryCode == 'ES') {
      logic.language = 'gb';
    } else {
      logic.language = Get.locale!.countryCode.toString().toLowerCase();
    }

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    logic.currentPage = index;
    update();
  }

  ///关闭按钮
  void toBack() {
    if (logic.currentPage == 3) {
      ///更新弹出状态
      getUserPersonalise();
      Get_TY.back();
    } else if ((Get.locale!.countryCode == 'PT' || Get.locale!.countryCode == 'IN' || Get.locale!.countryCode == 'MY') && logic.currentPage == 2) {
      ///更新弹出状态
      getUserPersonalise();
      Get_TY.back();
    } else {
      pageController.animateToPage(
        logic.currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
    update();
  }

  ///更新弹出状态
  Future<void> getUserPersonalise() async {
    final res = await MenuApi.instance().setUserPersonalisePopUps(
      1,
      0,
    );
    print(res.data);
    update();
  }

  ///专业版 新手版  切换
  void onBettingMode(bool bool) {
    TyHomeController.to.changeNew(bool);
    pageController.animateToPage(
      logic.currentPage + 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
