import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_home_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_view.dart';
import '../bet_ty_cp_zr/ty/bets/ty_bets_logic.dart';
import '../bet_ty_cp_zr/ty/bets/ty_bets_view.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-331958bb-04a6-43f5-b772-e537b4c59455-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE 首页列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr首页-控制器extension
    - 处理底部菜单逻辑
    】】】
 *
 */
extension VrTyHomeControllerBottomNavigationBar on VrTyHomeController {
  void logicToTargetPage(int index) {
    switch (index) {
      case 0:
        Get.toNamed(Routes.matchResults);
        break;
      case 1:
        openSettingsMenu();
        break;
      case 2:
        openOngoingBetsPage();
        break;
      case 3:
        openClosedBetsPage();
        break;
      case 4:
        refreshMenu();
        break;
    }
  }

  //打开设置
  openSettingsMenu() {
    Get.lazyPut(() => SettingMenuController());
    Get.bottomSheet(
      const SettingMenuPage(),
      isScrollControlled: true,
      barrierColor: Colors.black.withValues(alpha: 0.2),
    );
  }

  //未结注单
  openOngoingBetsPage() {
    Get.lazyPut(() => TyBetsLogic(0));
    Get.dialog(
      ///新版注单
      const TyBetsWidget(),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );

    // Get.lazyPut(() => UnsettledBetsLogic());
    // Get.dialog(
    //   const UnsettledBetsPage(),
    //   barrierColor: Colors.black.withValues(alpha: 0.5),
    // );
  }

  //已结注单
  openClosedBetsPage() {
    Get.lazyPut(() => TyBetsLogic(1));
    Get.dialog(
      ///新版注单
      const TyBetsWidget(),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );

    // Get.lazyPut(() => SettledBetsLogic());
    // Get.dialog(
    //   const SettledBetsPage(),
    //   barrierColor: Colors.black.withValues(alpha: 0.5),
    // );
  }

  void refreshMenu() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    if (dailyActivities == true) {
    } else {
      animationController.forward();
    }
  }

  void IconRefresh() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    update();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  openMenu() {
    Get.lazyPut(() => SettingMenuController());
    Get.bottomSheet(
      const SettingMenuPage(),
      isScrollControlled: true,
      barrierColor: Colors.black.withValues(alpha: 0.2),
    );
  }
}