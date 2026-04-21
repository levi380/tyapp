import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:get/get.dart';


class DJLeagueSearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<SportConfigInfo> tabs = [];
  late SportConfigInfo sportMenu;

  final List<String> searchHistory = [];

  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  int index = 0;
  StreamSubscription? screm;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    /// 截取Game.leagueList后面的元素不要第一个
    tabs = DJController.to.getMenuData().sublist(1);

    /// 同步数据
    int i = tabs
        .indexWhere((element) => element.mi == DJController.to.DJState.gameId);
    if (i != -1) {
      sportMenu = tabs[i];
      index = i;
    } else {
      sportMenu = tabs.first;
    }

    loadHistory();

    screm = EventBus().on<EventType>().listen((event) {
      if (event == EventType.leagueSearchClick) {
        onSearch();
      }
    });
  }

  void onChanged(int index) {
    sportMenu = tabs[index];
    loadHistory();
  }

  void loadHistory() {
    searchHistory.clear();
    List<String> list = (appStorage.get(getKey()) ?? [])
        .map((e) => e.toString())
        .toList();
    searchHistory.addAll(list);
    update();
  }

  void onSearch() {
    String searchText = searchController.text;
    addHistory(searchText);
    Get.back(
      result: {
        "searchText": searchText,
        "sportMenu": sportMenu,
      },
    );
  }

  void addHistory(String value) {
    if (value.isEmpty) {
      return;
    }
    /// 先移除旧的
    searchHistory.remove(value);
    /// 新的放最前面
    searchHistory.insert(0, value);
    /// 限制搜索历史数量50条，删除最旧的，新的放在最前面,仅展示3条
    if (searchHistory.length > 50) {
      searchHistory.removeRange(50, searchHistory.length);
    }
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
    return "dj_searchHistory";
    // return "dj_searchHistory_${sportMenu.mi}";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    screm?.cancel();
    searchController.dispose();
    
    super.onClose();
  }

  onClearSearchText() {
    searchController.clear();
  }
}
