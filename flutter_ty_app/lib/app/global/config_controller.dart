import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/conif_controller_ext_s.dart';
import 'package:flutter_ty_app/app/global/hourly_task_runner.dart';
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/access_config.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import '../db/db_config.dart';
import '../db/menu_init.dart';
import '../db/name_init_map.dart';
import '../db/old_new_id_map.dart';
import '../modules/home/controllers/home_controller.dart';

import '../modules/main_tab/main_tab_controller.dart';
import '../services/api/match_api.dart';
import '../services/models/res/event_info_entity.dart';
import '../services/models/res/origin_data_entity.dart';

import '../utils/csid_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-da4b4c1f-3795-4671-a303-06f4dd3ee01d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  元数据配置管理类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 元数据配置管理入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 菜单原数据
    ```
    class ConfigController extends GetxController {
    static ConfigController get to =>
    Get.put(ConfigController(), permanent: true);
    Rx<AccessConfig> accessConfig = AccessConfig.init().obs;

    List<SportConfigInfo> menuInit = [];
    //足球菜单列表
    List<SportConfigInfo> _sportMenuList = [];

    Map<String, dynamic> sportOldNewIdMap = oldNewIdMap;

    ///球种名称
    Map<String, dynamic> nameMap = nameInitMap;

    /// 元数据
    OriginDataEntity originData = OriginDataEntity();
    Map<String, dynamic> tournamentMatchMap = {};

    @override
    void onInit() {
    super.onInit();
    loadCache();

    Bus.getInstance().on(EventType.changeLang, (value) {
    fetchConfig();
    });

    /// 整点拉去元数据
    final taskRunner = HourlyTaskRunner();
    taskRunner.start();
    }

    @override
    void onClose() {
    Bus.getInstance().off(EventType.changeLang);
    super.onClose();
    }
    }
    ```
    】】】
 *
 */
class ConfigController extends GetxController {
  static ConfigController get to => Get.find();
  Rx<AccessConfig> accessConfig = AccessConfig.init().obs;
  List<SportConfigInfo> menuInit = [];
  //足球菜单列表
  List<SportConfigInfo> _sportMenuList = [];
  Map<String, dynamic> sportOldNewIdMap = oldNewIdMap;
  ///球种名称
  Map<String, dynamic> nameMap = nameInitMap;
  /// 元数据
  OriginDataEntity originData = OriginDataEntity();
  Map<String, dynamic> tournamentMatchMap = {};
  /// 列表item弹出提示数据
  List<EventInfo2Data> EventInfoList = [];

  @override
  void onInit() {
    super.onInit();

    Bus.getInstance().on(EventType.changeLang, (value) {
      loadNameList(switchLanguages: true);
    });

    /// 整点拉去元数据
    final taskRunner = HourlyTaskRunner();
    taskRunner.start();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.changeLang);
    super.onClose();
  }

  getEventInfo() async {
    try {
      final res = await MatchApi.instance().getEventInfo();
      if (ObjectUtil.isNotEmpty(res.data)) {
        EventInfoList = res.data;
      }
    } catch (e) {
      AppLogger.error(e);
    }
  }

  ///足球菜单mi 600是热门联赛
  List<SportConfigInfo> get sportMenuList {
    if (_sportMenuList.isEmpty) {
      for (var item in menuInit) {
        // 600 是热门联赛
        if ((item.mi.toNum()) < 200 ||
            item.mi == SportConfig.HotMenuLeague.sportId.toString()) {
          _sportMenuList.add(item);
        }
      }
    }

    /// 将600放到第一个，其他的顺不动
    if (_sportMenuList.isNotEmpty) {
      int index = _sportMenuList.indexWhere((element) {
        return element.mi == SportConfig.HotMenuLeague.sportId.toString();
      });
      if (index > 0) {
        SportConfigInfo hotSport = _sportMenuList.removeAt(index);
        _sportMenuList.insert(0, hotSport);
      }
    }
    return _sportMenuList;
  }

  ///显示vr菜单
  bool hasVrMenu() {
    bool hasVR = false;
    if (menuInit.isNotEmpty) {
      for (var item in menuInit) {
        if ((item.mi.toNum()) == 300) {
          hasVR = true;
        }
      }
    }
    // AppLogger.debug("hasVR = $hasVR");
    return hasVR;
  }

  List<SportConfigInfo> get gameMenuList {
    List<SportConfigInfo> list = [];
    for (var item in menuInit) {
      var num = (item.mi.toNum());
      if (num == 2000) {
        list.addAll(item.sl ?? []);
        break;
      }
      if (num > 2000 && num < 3000) {
        list.add(item);
      }
    }
    return list;
  }

  LinkedHashMap<String, SportConfigInfo> menuMap = LinkedHashMap();

  loadCache() {
    // 新旧id映射
    try {
      try {
        loadCacheInit();
        loadNameCache();
        loadCacheOrigin();
        loadMenuCache();
        loadCacheTournamentMatch();
      } catch (e) {
        // TODO
      }

      /// 菜单初始化
      if (menuInit.isEmpty) {
        menuInit = menuInitMap.map((e) => SportConfigInfo.fromJson(e)).toList();
      }
      for (var item in menuInit) {
        menuMap[item.mi] = item;
      }

      /// 联赛数据
      if (tournamentMatchMap.isEmpty) {
        tournamentMatchMap = loadTournameMatch;
      }
      TyHomeController.to.changeMenu(TyHomeController.to.homeState.menu);
    } catch (e) {
      // AppLogger.debug(' config_controller e $e');
    }
  }

  fetchConfig() async {
    try {
      loadCache();
      await Future.wait([
        loadMenuInit(),
        loadMenuMapping(),
        loadNameList(),
      ]);
      TyHomeController.to.changeMenu(TyHomeController.to.homeState.menu);
      loadTournamentMatch();
      loadOriginData();
      // 客户端-获取紧急开关配置
      await getAccessConfig();

      ///赛事信息动画提示
      getEventInfo();

      // /// 预加载数据
      MainMenu.menuList.forEach((menu) {
        getSportMenuListByMenuMi(menu);
      });
    } catch (e) {
      // AppLogger.debug('error in fetchConfig: $e');
    }
  }

  LinkedHashMap<String, List<SportMenu>> sportMenuMap = LinkedHashMap();

  /// mi ==>  2000-电竞,300-vr,3000-真人,4000-彩票
  /// 根据menuId补充收藏和全部的euid
  List<SportMenu> getSportMenuListByMenuMi(MainMenu menu) {
    List<SportMenu> sportMenus = [];
    //sportMenuMap[menu.mi.toString()] ?? [];

    // if (sportMenus.isNotEmpty) {
    //   if (menu.type == 100) {
    //     sportMenus.sort((a, b) {
    //       return (a?.sort ?? 99) - (b?.sort ?? 99);
    //     });
    //   }
    //   return sportMenus;
    // }
    List<SportConfigInfo> sportConfigList = getSportConfigListByMenuId(menu);
    int sortIndex = 0;
    ///首页循环添加赛种配置的
    for (var item in sportConfigList) {
      /// 串关和早盘不支持电子足球和电子篮球
      if ((menu.isMatchBet || menu.isEarly) &&
          ['190', '191'].contains(item.mi)) {
        continue;
      }

      String mi = item.mi;
      String euid = getOldSportId(
          item.mi,
          item.mi == SportConfig.HotMenuLeague.sportId.toString()
              ? menu.munuId
              : menu.mi);

      /// 对应球类图标
      int iconIndex = SpriteImagesPosition.getPosition(item.mi, menu);

      ///对应球类名称
      String title = getName(item.mi);

      ///对应球类数量
      int? count = getCount(item.mi, menu.mi.toString());

      /// 全部：euid是将所有的id拼接，count所有的count累加
      if (item.mi == SportConfig.MatchAllPage.sportId.toString()) {
        int sum = 0;
        List<String> euids = [];
        for (var item in sportMenuList) {
          sum += getCount(item.mi, menu.mi.toString()) ?? 0;
          String temp = getOldSportId(item.mi, menu.mi);
          if (!ObjectUtil.isEmptyString(temp) &&
              !temp.contains(SportConfig.HotMenuLeague.sportId.toString())) {
            euids.add(temp);
          }
        }
        count = sum;
        euid = euids.join(',');
      }

      /// 收藏：euid是所有count非空的id拼接，count是接口获取
      if (item.mi == SportConfig.FavoritesPage.sportId.toString()) {
        List<String> euids = [];
        if (menu.isChampion) {
          sportConfigList.forEach((element) {
            String tempEuid = getOldSportId(element.mi, menu.mi);
            if (!ObjectUtil.isEmptyString(tempEuid)) {
              euids.add(tempEuid);
            }
          });
        } else {
          for (var sportMenuItem in sportMenuList) {
            String tempEuid = getOldSportId(sportMenuItem.mi, menu.mi);
            if (!ObjectUtil.isEmptyString(tempEuid) &&
                !tempEuid
                    .startsWith(SportConfig.HotMenuLeague.sportId.toString())) {
              euids.add(tempEuid);
            }
          }
        }
        euid = euids.join(',');
      }
      // 2000-电竞,300-vr,3000-真人,4000-彩票
      if (euid.isEmpty &&
          ![
            SportConfig.VirtualSportsPage.sportId.toString(),
            SportConfig.EsportsPage.sportId.toString(),
            SportConfig.ZRPage.sportId.toString(),
            SportConfig.CPPage.sportId.toString(),
            SportConfig.BettingPage.sportId.toString()
          ].contains(mi)) continue;


      int sourtIndex = getNameSort(mi) ?? sortIndex;

      SportMenu sportMenu = SportMenu(
          mi: mi,
          euid: euid,
          iconIndex: iconIndex,
          title: title,
          count: count,
          sort: sourtIndex);


      sportMenus.add(sportMenu);
      sortIndex++;
    }
    if (menu.type == 100) {
      sportMenus.sort((a, b) {
        return (a.sort ?? 99) - (b.sort ?? 99);
      });
    }
    sportMenuMap[menu.mi.toString()] = sportMenus;
    return sportMenus;
  }

  String getFirstSportId(MainMenu menu) {
    if (menu.isChampion) {
      SportConfigInfo? sportConfigInfo = menuMap[menu.mi.toString()];
      return sportConfigInfo?.sl?.safeFirst?.mi ?? '';
    } else {
      return sportMenuList.safeFirst?.mi ?? '';
    }
  }

  ///根据主菜单 配置 球种菜单
  List<SportConfigInfo> getSportConfigListByMenuId(MainMenu menu) {
    List<SportConfigInfo> list = [];
    // 收藏
    SportConfigInfo collectSportConfig = SportConfigInfo();
    collectSportConfig.mi = SportConfig.FavoritesPage.sportId.toString();

    // 全部
    SportConfigInfo allSportConfig = SportConfigInfo();
    allSportConfig.mi = SportConfig.MatchAllPage.sportId.toString();

    ///添加收藏球种
    /// 今日早盘冠军仅有收藏
    // if ([2, 3, 400].contains(menu.mi)) {
    if ([2, 3, 400, 6].contains(menu.mi)) {
      list.add(collectSportConfig);

      /// 滚球收藏和全部
    } else if (menu.isPlay) {
      List<SportConfigInfo> tempList = [];
      tempList.add(collectSportConfig);
      tempList.add(allSportConfig);
      list.addAll(tempList);
    }

    // 如果是冠军的话取冠军的sl
    if (menu.isChampion) {
      SportConfigInfo? sportConfigInfo = menuMap.safe(menu.mi.toString());
      if (!ObjectUtil.isEmptyList(sportConfigInfo?.sl)) {
        list.addAll(sportConfigInfo!.sl!);
      }
    } else {
      // 其他的
      list.addAll(sportMenuList);
      if (sportMenuList.isEmpty) {
        return list;
      }
      //电竞和vr菜单位置
      int betIndex = 1;
      int djIndex = 4;
      int vrIndex = 7;
      if (menu.isToday) {
        betIndex = 1;
        djIndex = 5;
        vrIndex = 8;
      }
      if (menu.isPlay) {
        betIndex = 1;
        djIndex = 6;
        vrIndex = 9;
      }
      if (menu.isEarly) {
        betIndex = 1;
        djIndex = 5;
        vrIndex = 6;
      }
      if (menu.isMatchBet) {
        // betIndex = 0;
        betIndex = 1;
        djIndex = 4;
        vrIndex = 5;
      }

      // 添加电竞和VR体育  2000-电竞,300-vr,3000-真人,4000-彩票, 用户开关
      if (gameMenuList.isNotEmpty) {
        SportConfigInfo betSportConfigInfo = SportConfigInfo();
        betSportConfigInfo.mi = SportConfig.BettingPage.sportId.toString();
        /// 优化 确保 betIndex 不会越界
        int safeBetIndex = betIndex.clamp(0, list.length);
        list.insert(safeBetIndex, betSportConfigInfo);

        // SportConfigInfo zrSportConfigInfo = SportConfigInfo();
        // zrSportConfigInfo.mi = '3000';
        // list.insert(zrIndex, zrSportConfigInfo);

        //后台管理控制电竞显示隐藏
        SportConfigInfo djSportConfigInfo = SportConfigInfo();
        djSportConfigInfo.mi = SportConfig.EsportsPage.sportId.toString();

        /// 优化 确保 djIndex 不会越界
        /// 这里的 list.length 已经是插入 djSportConfigInfo 后的长度
        int safeDjIndex = djIndex.clamp(0, list.length);
        list.insert(safeDjIndex, djSportConfigInfo);
      }

      ///添加 插入vr菜单
      if (hasVrMenu()) {
        SportConfigInfo vrSportConfigInfo = SportConfigInfo();
        vrSportConfigInfo.mi = SportConfig.VirtualSportsPage.sportId.toString();
        /// 优化 确保 vrIndex 不会越界
        int safeVrIndex = vrIndex.clamp(0, list.length);
        list.insert(safeVrIndex, vrSportConfigInfo);
      }
    }

    return list;
  }

  List<SportConfigInfo> getGameMenuListByMenuId() {
    List<SportConfigInfo> list = [];
    list.addAll(gameMenuList);

    ///收藏插入第一个位置
    if (ConfigController.to.accessConfig.value.collectSwitch) {
      SportConfigInfo collectSportConfig = SportConfigInfo();
      collectSportConfig.mi = SportConfig.FavoritesPage.sportId.toString();
      list.insert(0, collectSportConfig);
    }
    return list;
  }

  ///更新球种赛事数量
  updateTopCount(int count, String mi) {
    if (!Get.isRegistered<MainTabController>()) {
      return;
    }
    TyHomeController.to.homeSportMenuState.sportMenuList.forEach((element) {
      if (element.mi == mi) {
        element.count = count;
        CollectionController.to.update([mi]);
      }
    });
  }
}
