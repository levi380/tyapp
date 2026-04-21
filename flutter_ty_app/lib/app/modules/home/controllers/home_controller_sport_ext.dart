import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';


import '../../../services/models/res/menu_count_info_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-2bb81bd0-39de-4ec2-bb5c-ea27b888e48c-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页菜单球种赛事数量ws同步更新 】】】
    【【【 AUTO_DOCUMENT_TITLE 首页菜单球种赛事数量ws同步更新-业务逻辑 】】】
    【【【 AUTO_PARAGRAPH_TITLE 主控制器 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 首页球种ws推送监听
    ```
  /// 监听菜单栏目统计变化事件
  addListenerC301() {
    Bus.getInstance().on(EventType.RCMD_C301, (wsObj) {
      List<MenuCountInfoEntity> list = [];DOCUMENT_TITLE 菜单列表
      for (var element in (wsObj as List)) {
        list.add(MenuCountInfoEntity.fromJson(element));
      }
      bool isRefresh = false;

      /// 遍历菜单统计信息列表，更新对应的菜单数量
      for (var menuCountInfoEntity in list) {
        int index = homeSportMenuState.sportMenuList.indexWhere((element) =>
            element.euid.toString() == menuCountInfoEntity.menuId.toString());
        if (index >= 0) {
          homeSportMenuState.sportMenuList[index].count =
              menuCountInfoEntity.count;
          isRefresh = true;
        }

        /// 预加载数据，更新主菜单下的子菜单数量
        MainMenu.menuList.forEach((menu) {
          List<SportMenu> sportMenus =
              ConfigController.to.getSportMenuListByMenuMi(menu);

          int index = sportMenus.indexWhere((element) =>
              element.euid.toString() == menuCountInfoEntity.menuId.toString());
          if (index > 0) {
            sportMenus[index].count = menuCountInfoEntity.count;
          }
        });
      }
      if (isRefresh) {
        homeSportMenuState.sportMenuList.refresh();
      }
    });
  }

  /// 移除菜单栏目统计变化事件监听器
  removeListenerC301() {
    Bus.getInstance().off(EventType.RCMD_C301);
  }

  /// 判断是否为竟足
  bool isJinZu() {
    return ['50101', '50102'].contains(homeState.matchListReq.euid);
  }

  /// 判断是否为精选
  bool isJingxuan() {
    return ['50199'].contains(homeState.matchListReq.euid);
  }
    ```
    】】】
 *
 */
extension TyHomeControllerSportExt on TyHomeController {
  /// 监听菜单栏目统计变化事件
  addListenerC301() {
    Bus.getInstance().on(EventType.RCMD_C301, (wsObj) {
      List<MenuCountInfoEntity> list = [];
      for (var element in (wsObj as List)) {
        list.add(MenuCountInfoEntity.fromJson(element));
      }
      bool isRefresh = false;

      /// 遍历菜单统计信息列表，更新对应的菜单数量
      final Map<String, int> menuCountMap = {
        for (var item in list) item.menuId.toString(): item.count
      };

      // 更新主菜单
      for (var menu in homeSportMenuState.sportMenuList) {
        final menuId = menu.euid.toString();
        if (menuCountMap.containsKey(menuId)) {
          menu.count = menuCountMap[menuId]!;
          isRefresh = true;
        }
      }

      // 更新子菜单
      for (var mainMenu in MainMenu.menuList) {
        final sportMenus =
        ConfigController.to.getSportMenuListByMenuMi(mainMenu);
        for (var sportMenu in sportMenus) {
          final menuId = sportMenu.euid.toString();
          if (menuCountMap.containsKey(menuId)) {
            sportMenu.count = menuCountMap[menuId]!;
          }
        }
      }

      // 刷新菜单状态
      if (isRefresh) {
        homeSportMenuState.sportMenuList.refresh();
      }
    });
  }

  /// 移除菜单栏目统计变化事件监听器
  removeListenerC301() {
    Bus.getInstance().off(EventType.RCMD_C301);
  }

  /// 判断是否为竟足
  bool isJinZu() {
    return [SportConfig.jingZu.sportId.toString(), SportConfig.jingLan.sportId.toString()].contains(homeState.matchListReq.euid);
  }

  /// 判断是否为精选
  bool isJingxuan() {
    return [SportConfig.Featured.sportId.toString()].contains(homeState.matchListReq.euid);
  }
}
