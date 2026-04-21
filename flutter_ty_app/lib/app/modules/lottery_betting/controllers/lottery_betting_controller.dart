import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/safe_update_extensions.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_view.dart';

import 'package:flutter_ty_app/app/routes/app_pages.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../bet_ty_cp_zr/ty/bets/ty_bets_logic.dart';
import '../../bet_ty_cp_zr/ty/bets/ty_bets_view.dart';

class LotteryBettingController extends GetxController
    with GetTickerProviderStateMixin {
  late bool dailyActivities = false;
  late AnimationController animationController;

  final tabTitles = [
    LocaleKeys.footer_menu_collect.tr,
    LocaleKeys.footer_menu_all.tr,
    '经典'.tr,
    LocaleKeys.ouzhou_match_featured.tr,
  ];
  int selTabIndex = 0;

  bool isLoading = false;
  bool isLoadFailed = false;

  int selCateIndex = 0;
  List lotteryBettingCateItems = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];
  List lotteryBettingItems = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];

  onSelTabChangedNewChange(int index) {
    if (index == selTabIndex) return;
    selTabIndex = index;
    safeUpdate();
  }

  onCateChanged(int index) {
    if (selCateIndex == index) return;
    selCateIndex = index;
    safeUpdate(['game_cate_grid_list']);
  }

  @override
  void onInit() {
    registerBus();
    iconRefresh();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  registerBus() {
    Bus.getInstance().on(EventType.changeLang, (wsObj) {
      // 回到首页
      Get.until((route) => route.settings.name == Routes.mainTab);
    });
  }
}

extension LotteryBettingControllerBottomNavBar on LotteryBettingController {
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
      barrierColor: Colors.black.withValues(alpha:0.2),
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
  //
  // Get.lazyPut(() => UnsettledBetsLogic());
  // Get.dialog(
  //   const UnsettledBetsPage(),
  //   barrierColor: Colors.black.withValues(alpha:0.5),
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
  //Get.lazyPut(() => SettledBetsLogic());
  //Get.dialog(
  //  const SettledBetsPage(),
  //  barrierColor: Colors.black.withValues(alpha:0.5),
  //);
  }

  void refreshMenu() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    if (dailyActivities == true) {
    } else {
      animationController.forward();
    }
  }

  void iconRefresh() {
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
      barrierColor: Colors.black.withValues(alpha:0.2),
    );
  }
}
