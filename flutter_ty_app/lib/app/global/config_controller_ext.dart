import 'package:flutter_ty_app/app/extension/string_extension.dart';
import '../config/app_logger/app_logger.dart';
import '../modules/home/models/main_menu.dart';
import '../services/models/res/sport_config_info.dart';
import 'config_controller.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'config_static.dart';

extension ConfigControllerExt on ConfigController {
  /// 根据sportID和一级菜单id找到对应的count
  int? getCount(String sportMi, String menuId) {
    if ([
      SportConfig.EsportsPage.sportId.toString(),
      SportConfig.VirtualSportsPage.sportId.toString(),
      SportConfig.ZRPage.sportId.toString(),
      SportConfig.CPPage.sportId.toString(),
      SportConfig.BettingPage.sportId.toString()
    ].contains(sportMi)) {
      return null;
    }
    String targetId = sportMi + menuId;
    // 冠军特殊处理
    if (menuId == '400') {
      targetId = sportMi;
      SportConfigInfo? sportConfigInfo = menuMap.safe(menuId);
      if (!ObjectUtil.isEmptyList(sportConfigInfo?.sl)) {
        for (var item in sportConfigInfo!.sl!) {
          if (item.mi == targetId) {
            return item.ct!;
          }
        }
      }
      return null;
    } else if (menuId == SportConfig.EsportsPage.sportId.toString()) {
      //电竞
      if (sportMi == SportConfig.FavoritesPage.sportId.toString()) {
        //收藏
        return 0;
      }
      SportConfigInfo? sportConfigInfo = menuMap[menuId];
      List<int> ctList = [];
      int ct = 0;
      if (!ObjectUtil.isEmptyList(sportConfigInfo?.sl)) {
        for (SportConfigInfo item in sportConfigInfo!.sl!) {
          if (item.mi == sportMi) {
            for (SportConfigInfo item2 in item.sl!) {
              if (item2.mi == "${sportMi}2" || item2.mi == "${sportMi}3") {
                //电竞为两个之和
                ctList.add(item2.ct!);
              }
            }
            if (ctList.length == 2) {
              int sumCt = ctList[0] + ctList[1];
              if (item.ct != sumCt) {
                ct = item.ct ?? 0;
              } else {
                ct = sumCt;
              }
            }
          }
        }
      }

      return ct;
    }

    /// 热门赛事特殊处理
    if (sportMi == SportConfig.HotMenuLeague.sportId.toString()) return null;
    if (menuMap[sportMi] != null) {
      return menuMap[sportMi]!.slMap[targetId]?.ct ?? 0;
    }
    return null;
  }
  /// zr 3000 cp 4000 数量为0关掉 ws C301
  /// 根据sportID找到对应的name
  String getName(String sportMi) {
    String? target = nameMap[sportMi];
    if (!ObjectUtil.isEmptyString(target)) {
      return target!;
    }
    target = configStaticData.sportNameMap[sportMi] ?? '';
    return target;
  }
  /// 根据sportID找到对应的sort优先级
  int? getNameSort(String sportMi) {

    return configStaticData.sportSortMap[sportMi];
  }
  /// 新旧id映射
  String getOldSportId(String sportMi, int menuMi) {
    try {
      String targetId = getTargetId(sportMi, menuMi);
      if (sportOldNewIdMap[targetId] != null) {
        return sportOldNewIdMap[targetId]['h'].toString();
      }
      return '';
    } catch (e) {
      return '';
    }
  }
  String getTargetId(String sportMi, int menuMi) {
    String targetId;
    if (menuMi == SportConfig.champion.sportId) {
      targetId = sportMi.toString();
    } else {
//`${常规球种id(例如足球csid 1+100 = 101)}${一级菜单(例如滚球1)}` //组合结果  滚球今日 id 1011
      targetId = sportMi + menuMi.toString();
    }
    return targetId;
  }
  int? getDjEuid(String mi) {
    /// 电竞无旧菜单id处理
    return {
      SportConfig.lol.sportId.toString(): 41002,
      SportConfig.dota2.sportId.toString(): 41001,
      SportConfig.cs2.sportId.toString(): 41004,
      SportConfig.honorOfKings.sportId.toString() : 41003,
    }[mi];
  }
  /// 热门联赛
  List<SportConfigInfo> getHotMenu(int mid) {
    List<SportConfigInfo> hotAll = [];
    /// 获取热门全部
    ///  6001滚球   6002今日  6003早盘  6004 串关 6005 PC全部
    final hotAllkey = {1: '6001', 2: '6002', 3: '6003', 6: '6004'};
    SportConfigInfo? sportConfigInfo =
    menuMap[SportConfig.HotMenuLeague.sportId.toString()];
    if (sportConfigInfo != null && sportConfigInfo.sl != null) {
      SportConfigInfo? item = sportConfigInfo.slMap[hotAllkey[mid]];
      if (item != null) {
        hotAll.add(item);
      }
    }
    /// 原来的热门数据取精选
    SportConfigInfo? hotOld = menuMap[SportConfig.hotMatches.sportId.toString()];
    if (hotOld != null) {
      SportConfigInfo? hot = hotOld.slMap[SportConfig.Featured.sportId.toString()];
      if (hot != null) {
        hotAll.add(hot);
      }
    }
    ///获取热门其他联赛
    List<SportConfigInfo> hot_other = [];
    var hot_other_key = {1: '7001', 2: '7002', 3: '7003', 6: '7004'};
    //4003001  滚球-热门 4003003  早盘-滚球热门 4003002  今日-热门 40030011  串关-热门
    var hot_other_mi = {
      1: '4003001',
      2: '4003002',
      3: '4003003',
      6: '40030011'
    };
    SportConfigInfo? sportConfigInfo1 = menuMap['7000'];
    if (sportConfigInfo1 != null && sportConfigInfo1.sl != null) {
      SportConfigInfo? item = sportConfigInfo1.slMap[hot_other_key[mid]];
      if (item != null) {
        hot_other = item.slMap[hot_other_mi[mid]]?.sl ?? [];
      }
    }
    if (hot_other.isNotEmpty) {
      hotAll.addAll(hot_other);
    }
    return hotAll;
  }
  /// 联赛 全部 7001 - 4003011
  List<SportConfigInfo> getLeagues(MainMenu menu, String sportMi) {
    int mi;
    /// 在 substring 之前进行长度检查
    if (sportMi.length >= 3) {
      /// 确保转换成功，使用 tryParse
      mi = (int.tryParse(sportMi.substring(0, 3)) ?? 0) - 100;
    } else {
      /// 兜底逻辑：如果 sportMi 长度不足，无法解析，提供一个默认值
      /// 或者，如果这种情况下不应该返回任何联赛，可以直接返回空列表
      AppLogger.error('getLeagues: sportMi 长度不足无法解析数字: $sportMi');
      mi = 0;
      /// 如果长度不足表示无效请求，直接返回空列表
       return [];
    }

    var midMap = {1: '1', 2: '2', 3: '3', 6: '11'};
    String key = '400${mi}${midMap[menu.mi]}';
    /// 滚球全部
    if (menu.mi == 1 &&
        sportMi == SportConfig.MatchAllPage.sportId.toString()) {
      key = '4003011';
    }
    final leagueKey = {1: '7001', 2: '7002', 3: '7003', 6: '7004'};
    List<SportConfigInfo> league_other = [];
    SportConfigInfo? sportConfigInfo = menuMap['7000'];
    if (sportConfigInfo != null && sportConfigInfo.sl != null) {
      for (var item in sportConfigInfo.sl!) {
        if (leagueKey.containsKey(menu.mi)) {
          if (item.mi == leagueKey[menu.mi]) {
            league_other = item.slMap[key]?.sl ?? [];
          }
        }
      }
    }
    return league_other;
  }

  List<SportConfigInfo> getDJLeagues(String sportMi) {
    var mi = sportMi.substring(1, 4).toInt();
    // final leagueKey = {1: '7001', 2: '7002', 3: '7003', 6: '7004'};
    List<SportConfigInfo> league_other = [];
    var key = '400${mi}2';
    SportConfigInfo? sportConfigInfo = menuMap['7000'];
    if (sportConfigInfo != null && sportConfigInfo.sl != null) {
      for (var item in sportConfigInfo.sl!) {
        if (item.mi == '7002') {
          league_other = item.slMap[key]?.sl ?? [];
        }
      }
    }
    return league_other;
  }

  Map<String, dynamic>? getIcon(String mi) {
    return sportOldNewIdMap[mi];
  }
}