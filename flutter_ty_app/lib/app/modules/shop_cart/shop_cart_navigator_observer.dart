import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../home/models/main_menu.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 路由监控类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 路由监控类
    监控路由变动，设置ShopCartController的变量
    】】】
 *
 */
class ShopCartNavigatorObserver extends GetObserver {
  final state = ShopCartController.to.state;
  bool isBottomSheetVisible = false;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = true;
    }
    if (route.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = true;
    }
    if (route.settings.name == 'TYBottomSheet' || route.settings.name == 'TYDialog') {
      isBottomSheetVisible = true;
    }
    ShopCartController.to.state.isMaintabDialogicOpen.value =
        (Get.currentRoute == Routes.mainTab || Get.currentRoute == Routes.matchDetail)
            && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true || isBottomSheetVisible);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
    state.currentRoute = route.settings.name;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = false;
      ShopCartController.to.isVrParlay.value = false;
    }
    if (route.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = false;
      ShopCartController.to.isEsportParlay.value = false;
    }
    if (route.settings.name == Routes.mainTab) {
      //reset保存的首页菜单
      ShopCartController.to.state.menu = MainMenu(0,'',0,0);
    }
    if(route.settings.name == Routes.matchDetail){
      //从详情页面返回，就退出自选波胆
      ShopCartController.to.isComboCourageBet.value = false;
    }

    if (route.settings.name == 'TYBottomSheet' || route.settings.name == 'TYDialog') {
      isBottomSheetVisible = false;
    }

    ShopCartController.to.state.isMaintabDialogicOpen.value =
        (Get.currentRoute == Routes.mainTab || Get.currentRoute == Routes.matchDetail)
            && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true || isBottomSheetVisible);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
    state.currentRoute = route.settings.name;
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = false;
      ShopCartController.to.isVrParlay.value = false;
    }
    if (route.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = false;
      ShopCartController.to.isEsportParlay.value = false;
    }
    if (route.settings.name == Routes.mainTab) {
      //reset保存的首页菜单
      ShopCartController.to.state.menu = MainMenu(0,'',0,0);
    }
    if(route.settings.name == Routes.matchDetail){
      //从详情页面返回，就退出自选波胆
      ShopCartController.to.isComboCourageBet.value = false;
    }
    if (route.settings.name == 'TYBottomSheet' || route.settings.name == 'TYDialog') {
      isBottomSheetVisible = false;
    }
    ShopCartController.to.state.isMaintabDialogicOpen.value =
        Get.currentRoute == (Get.currentRoute == Routes.mainTab || Get.currentRoute == Routes.matchDetail)
          && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true || isBottomSheetVisible);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
    state.currentRoute = route.settings.name;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute?.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = true;
    } else if (oldRoute?.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = false;
      ShopCartController.to.isVrParlay.value = false;
    }
    if (newRoute?.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = true;
    } else if (oldRoute?.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = false;
      ShopCartController.to.isEsportParlay.value = false;
    }else if (oldRoute?.settings.name == 'TYBottomSheet' || oldRoute?.settings.name == 'TYDialog') {
      isBottomSheetVisible = false;
    }
    ShopCartController.to.state.isMaintabDialogicOpen.value =
        (Get.currentRoute == Routes.mainTab || Get.currentRoute == Routes.matchDetail)
          && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true || isBottomSheetVisible);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
    state.currentRoute = newRoute?.settings.name;
  }
}