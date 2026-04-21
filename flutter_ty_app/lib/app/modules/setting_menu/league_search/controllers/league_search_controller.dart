import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/all_league_filter/all_league_filter_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/league_filter_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/menu_util.dart';
import 'package:get/get.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  搜索界面控制器 LeagueSearchController  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  搜索界面控制器 LeagueSearchController
    - LeagueSearchController
    ```
    List<SportMenu> tabs = [];
    late SportMenu sportMenu;
    bool isLoadingHot = false;

    final List<String> searchHistory = [];
    final List<Map<String, dynamic>> hotSearch = [];

    late TextEditingController searchController;
    int index = 0;
    StreamSubscription? screm;
    ```
    】】】
 *
 */
class LeagueSearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<SportMenu> tabs = [];
  late SportMenu sportMenu;
  bool isLoadingHot = false;

  final List<String> searchHistory = [];
  final List<Map<String, dynamic>> hotSearch = [];

  late TextEditingController searchController;
  int index = 0;
  StreamSubscription? screm;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    TyHomeController.to.homeSportMenuState.sportMenuList.forEach((element) {
      /// 去掉电竞和VR
      if (element.mi.toInt() < 2000 &&
          element.mi != SportConfig.VirtualSportsPage.sportId.toString()) {
        tabs.add(element);
      }
    });

    /// 同步数据
    int i = tabs.indexWhere(
        (element) => element.mi == TyHomeController.to.homeState.sportId);
    if (i != -1) {
      sportMenu = tabs[i];
      index = i;
    } else {
      sportMenu = tabs.first;
    }

    loadHot();
    loadHistory();

    screm = EventBus().on<EventType>().listen((event) {
      if (event == EventType.leagueSearchClick) {
        AppLogger.debug('LeagueSearchController leagueSearchClick');
        onSearch();
      }
    });
  }

  void onChanged(int index) {
    this.index = index;
    sportMenu = tabs[index];
    hotSearch.clear();
    update();

    /// 热门没有搜索热词
    if (sportMenu.mi == SportConfig.HotMenuLeague.sportId.toString()) {
      EventBus().fire(EventPayLoad(EventType.isHot, true));
      isLoadingHot = false;
      update();
    } else {
      EventBus().fire(EventPayLoad(EventType.isHot, false));
      LeagueManager.euid = sportMenu.euid;
      LeagueFilterController.to?.initData();
      AllLeagueFilterController.to?.initData();
      loadHot();
    }
  }

  void loadHistory() {
    searchHistory.clear();
    update();
    final data = appStorage.get(getKey());
    List<String> list = [];
    if (data is List) {
      list = data
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }
    searchHistory.addAll(list);
  }

  Future<void> loadHot() async {
    try {
      isLoadingHot = true;
      String? sportId = MenuUtil.getCSIDFromMi(sportMenu.mi.toInt());
      final res = await MatchApi.instance().getKeywordList(
          sportId == '0' ? null : sportId,
          TyHomeController.to.homeState.menu.munuId,
          TyHomeController.to.homeState.matchListReq.md);

      hotSearch.addAll(
          (res.data ?? []).where((e) => e['sportId'] == sportId).toList());

      /// 根据 postitionSort排序
      hotSearch.sort((a, b) {
        try {
          int aSort = int.tryParse(a['positionSort']?.toString() ?? '0') ?? 0;
          int bSort = int.tryParse(b['positionSort']?.toString() ?? '0') ?? 0;
          return bSort - aSort;
        } catch (e) {
          return 0;
        }
      });

      /// hotSearch 只展示前10条
      if (hotSearch.length > 10) {
        hotSearch.removeRange(10, hotSearch.length);
      }
      isLoadingHot = false;
      update();
    } catch (e) {
      isLoadingHot = false;
      update();
      AppLogger.debug('e ${e.toString()}');
    }
  }

  void onSearch() {
    String searchText = searchController.text;
    addHistory(searchText);
    EventBus().fire(EventPayLoad(
      EventType.leagueSearchContent,
      {
        "searchText": searchText,
        "sportMenu": sportMenu,
      },
    ));
    Get.back(closeOverlays: true);
  }

  void onSearchHot(String keyword) {
    EventBus().fire(EventPayLoad(
      EventType.leagueSearchContent,
      {
        "searchText": keyword,
        "sportMenu": sportMenu,
      },
    ));
    Get.back(closeOverlays: true);
  }

  void addHistory(String value) {
    if (value.isEmpty) {
      return;
    }

    /// 限制搜索历史数量50条，删除最旧的，新的放在最前面，仅展示3条
    if (searchHistory.length >= 50) {
      searchHistory.removeLast();
    }
    if (searchHistory.contains(value)) {
      searchHistory.remove(value);
    }
    searchHistory.insert(0, value);
    update();
    appStorage.put(getKey(), searchHistory);
  }

  void removeHistory(String value) {
    searchHistory.remove(value);
    update();
    appStorage.put(getKey(), searchHistory);
  }

  void clearHistory() {
    searchHistory.clear();
    appStorage.delete(getKey());
    update();
  }

  String getKey() {
    return "searchHistory";
    // return "searchHistory_${sportMenu.mi}";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    screm?.cancel();
    searchController = TextEditingController();
    super.onClose();
  }

  onClearSearchText() {
    searchController.clear();
  }
}
