import 'dart:collection';
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_event_bus.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/pin_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_group.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/menu_util.dart';

import '../../../services/api/match_api.dart';

import '../../main_tab/main_tab_controller.dart';
import '../models/section_group_enum.dart';

class TyHomeControllerLogic {
  /// 赛事分组,按时间的
  static List<CombineInfo> getTimeMatchHandle(List<MatchEntity> matchList) {
    matchList.removeWhere((e) => ObjectUtil.isEmptyString(e.mid));

    // 关键优化：根据当前选中的球种 ID 进行逻辑过滤
    String currentSportId = TyHomeController.to.homeState.sportId;
    String targetCsid =
        MenuUtil.getCSIDFromMi(int.tryParse(currentSportId) ?? 0);
    if (['190', '191'].contains(currentSportId) && targetCsid.isNotEmpty) {
      bool hasTargetCsid = matchList.any((e) => e.csid == targetCsid);
      ///电子足球 和 电子篮球 和足球 篮球 是一样的 。这里一定分组筛选要转换再去比对!!!
      if (!hasTargetCsid) {
        targetCsid = currentSportId == '190' ? '1' : '2';
      }
    }
    if (targetCsid.isNotEmpty) {
      matchList.removeWhere((e) => e.csid != targetCsid);
    }

    if (matchList.isEmpty) return [];

    /// 置顶赛事的分组
    List<MatchEntity> pinMatchList = PinController.to?.pinMatchList() ?? [];

    // 关键勿删：过滤置顶赛事的球种的id，防止界面闪烁
    if (targetCsid.isNotEmpty) {
      pinMatchList = pinMatchList.where((e) => e.csid == targetCsid).toList();
    }

    /// 置顶赛事的分组
    List<MatchGroup> pinMatchGroup =
        _handleMatchGroup(pinMatchList, SectionGroupEnum.Pin);

    /// 今日和串关的才分组进行中未开始,热门精选不分组
    if ((TyHomeController.to.homeState.menu.isToday ||
            (TyHomeController.to.homeState.menu.isMatchBet &&
                (TyHomeController.to.homeState.dateTime ?? 0) <= 0)) &&
        TyHomeController.to.homeState.matchListReq.euid !=
            SportConfig.Featured.sportId.toString()) {
      /// 赛事归类开赛未开赛
      List<MatchEntity> startMatchList = [];
      List<MatchEntity> noStartMatchList = [];
      // 今日/串关下面：开始。未开始 (才分组）
      // 其他显示全部

      for (var element in matchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;

        /// 赛事结束的不显示
        if (element.isEnd) continue;

        /// 滚球阶段
        if ([1, 110].contains(element.ms)) {
          element.startFlag = 3;
          startMatchList.add(element);
        } else {
          element.startFlag = 4;
          noStartMatchList.add(element);
        }
      }

      List<MatchGroup> list = [];
      if (pinMatchGroup.isNotEmpty) {
        list.addAll(pinMatchGroup);
      }
      if (startMatchList.isNotEmpty) {
        list.addAll(
            _handleMatchGroup(startMatchList, SectionGroupEnum.IN_PROGRESS));
      }
      if (noStartMatchList.isNotEmpty) {
        list.addAll(
            _handleMatchGroup(noStartMatchList, SectionGroupEnum.NOT_STARTED));
      }
      return CombineInfo.generateFromList(list);
    } else {
      List<MatchGroup> list = [];
      list.addAll(pinMatchGroup);
      List<MatchGroup> allMatchList =
          _handleMatchGroup(matchList, SectionGroupEnum.ALL);
      list.addAll(allMatchList);
      return CombineInfo.generateFromList(list);
    }
  }

  static List<MatchGroup> _handleMatchGroup(
      List<MatchEntity> matchList, SectionGroupEnum sectionGroupEnum) {
    /// 将startMatchList中相邻tid一样的赛事组合成MatchGroup
    LinkedHashMap<String, MatchGroup> allMatchMap = LinkedHashMap();

    /// tid一致的联赛分组: 同一联赛放到MatchGrouMatchGro
    for (var element in matchList) {
      element = DataStoreController.to.getMatchById(element.mid) ?? element;
      if (allMatchMap.containsKey(element.tid)) {
        final matchGroup = allMatchMap[element.tid];
        int index = matchGroup!.matches.indexWhere((e) => e.mid == element.mid);
        if (index == -1) {
          allMatchMap[element.tid]?.matches.add(element);
        }
      } else {
        allMatchMap[element.tid] = MatchGroup(
          tn: ObjectUtil.isEmptyString(element.tn) ? element.tnjc : element.tn,
          tid: element.tid,
          matches: [element],
          isSectionHeader: false,
          sectionGroupEnum: sectionGroupEnum,
          sportTitle: 'types_competitions_sport2_${element.csid}'.tr,
          sportCount: matchList.length,
          isSportHeader: false,
          csid: element.csid,
        );
      }
    }

    List<MatchGroup> allMatchGroup = allMatchMap.values.toList();

    /// 球类分组
    LinkedHashMap<String, List<MatchGroup>> sportMatchGroupMap =
        LinkedHashMap();
    for (var element in allMatchGroup) {
      if (sportMatchGroupMap.containsKey(element.csid)) {
        sportMatchGroupMap[element.csid]!.add(element);
      } else {
        sportMatchGroupMap[element.csid] = [element];
      }
    }

    /// 球类分组再展开
    List<MatchGroup> list = [];
    sportMatchGroupMap.forEach((key, value) {
      List<MatchGroup> tempList = value;
      tempList.safeFirst?.isSportHeader = true;
      int sportCount = 0;

      /// 球类数量
      for (var element in value) {
        sportCount += element.matches.length;
      }
      tempList.safeFirst?.sportCount = sportCount;
      list.addAll(tempList);
    });
    list.safeFirst?.isSectionHeader = true;
    return list;
  }

  /// 赛事分组，按热度的
  static List<CombineInfo> getHotMatchHandle(List<MatchEntity> matchList) {
    matchList.removeWhere((e) => ObjectUtil.isEmptyString(e.mid));


    String currentSportId = TyHomeController.to.homeState.sportId;
    String targetCsid =
        MenuUtil.getCSIDFromMi(int.tryParse(currentSportId) ?? 0);
    if (['190', '191'].contains(currentSportId) && targetCsid.isNotEmpty) {
      bool hasTargetCsid = matchList.any((e) => e.csid == targetCsid);
      if (!hasTargetCsid) {
        ///电子足球 和 电子篮球 和足球 篮球 是一样的 。这里一定分组筛选要转换再去比!!!
        targetCsid = currentSportId == '190' ? '1' : '2';
      }
    }
    if (targetCsid.isNotEmpty) {
      matchList.removeWhere((e) => e.csid != targetCsid);
    }

    if (matchList.isEmpty) return [];

    /// 置顶赛事的分组
    List<MatchEntity> pinMatchList = PinController.to?.pinMatchList() ?? [];

    // 关键勿删：过滤置顶赛事的球种的id，防止界面闪烁
    if (targetCsid.isNotEmpty) {
      pinMatchList = pinMatchList.where((e) => e.csid == targetCsid).toList();
    }

    /// 清理不在matchList中的置顶赛事
    // LinkedHashSet<String> midSet = LinkedHashSet();
    // for (var element in matchList) {
    //   midSet.add(element.mid);
    // }

    // pinMatchList.removeWhere((e) => !midSet.contains(e.mid));

    /// 置顶赛事的分组
    List<MatchGroup> pinMatchGroup =
        _handleMatchGroup(pinMatchList, SectionGroupEnum.Pin);

    /// 今日和串关的才分组进行中未开始
    if ((TyHomeController.to.homeState.menu.isToday ||
            (TyHomeController.to.homeState.menu.isMatchBet &&
                (TyHomeController.to.homeState.dateTime ?? 0) <= 0)) &&
        TyHomeController.to.homeState.matchListReq.euid !=
            SportConfig.Featured.sportId.toString()) {
      /// 赛事归类开赛未开赛
      List<MatchEntity> startMatchList = [];
      List<MatchEntity> noStartMatchList = [];
      // 今日/串关下面：开始。未开始 (才分组）
      // 其他显示全部
      for (var element in matchList) {
        element = DataStoreController.to.getMatchById(element.mid) ?? element;

        /// 滚球阶段
        if ([1, 110].contains(element.ms)) {
          element.startFlag = 3;
          startMatchList.add(element);
        } else {
          element.startFlag = 4;
          noStartMatchList.add(element);
        }
      }
      List<MatchGroup> list = [];
      list.addAll(pinMatchGroup);
      if (startMatchList.isNotEmpty) {
        list.addAll(
            _handleHotMatchGroup(startMatchList, SectionGroupEnum.IN_PROGRESS));
      }
      if (noStartMatchList.isNotEmpty) {
        list.addAll(_handleHotMatchGroup(
            noStartMatchList, SectionGroupEnum.NOT_STARTED));
      }

      return CombineInfo.generateFromList(list);
    } else {
      List<MatchGroup> list = [];
      list.addAll(pinMatchGroup);
      List<MatchGroup> allMatchList =
          _handleHotMatchGroup(matchList, SectionGroupEnum.ALL);
      list.addAll(allMatchList);
      return CombineInfo.generateFromList(list);
    }
  }

  static List<MatchGroup> _handleHotMatchGroup(
      List<MatchEntity> matchList, SectionGroupEnum sectionGroupEnum) {
    /// 将startMatchList中所有tid一样的赛事组合成MatchGroup
    LinkedHashMap<String, MatchGroup> allMatchMap = LinkedHashMap();

    /// tid一致的联赛分组
    for (var element in matchList) {
      element = DataStoreController.to.getMatchById(element.mid) ?? element;

      if (allMatchMap.containsKey(element.tid)) {
        final matchGroup = allMatchMap[element.tid];
        int index = matchGroup!.matches.indexWhere((e) => e.mid == element.mid);

        /// 不存在才加入
        if (index == -1) {
          allMatchMap[element.tid]?.matches.add(element);
        }
      } else {
        MatchGroup matchGroup = MatchGroup(
          tn: ObjectUtil.isEmptyString(element.tn) ? element.tnjc : element.tn,
          tid: element.tid,
          matches: [element],
          isSectionHeader: false,
          sectionGroupEnum: sectionGroupEnum,
          sportTitle: 'types_competitions_sport2_${element.csid}'.tr,
          sportCount: matchList.length,
          isSportHeader: false,
          csid: element.csid,
        );
        allMatchMap[element.tid] = matchGroup;
      }
    }

    /// 球类分组
    LinkedHashMap<String, List<MatchGroup>> sportMatchGroupMap =
        LinkedHashMap();
    for (var element in allMatchMap.values) {
      if (sportMatchGroupMap.containsKey(element.csid)) {
        sportMatchGroupMap[element.csid]!.add(element);
      } else {
        sportMatchGroupMap[element.csid] = [element];
      }
    }

    List<MatchGroup> list = [];
    sportMatchGroupMap.forEach((key, value) {
      List<MatchGroup> tempList = value;
      tempList.safeFirst?.isSportHeader = true;
      int sportCount = 0;

      /// 球类数量
      for (var element in value) {
        sportCount += element.matches.length;
      }
      tempList.safeFirst?.sportCount = sportCount;
      list.addAll(tempList);
    });
    list.safeFirst?.isSectionHeader = true;
    return list;
  }

  /// 赛事分组
  /// 今日和串关的才分组进行中未开始
  /// 其他显示全部
  /// 进行中的未开始的全部的大分组下面
  /// 将tid相同的组合为matchgroup
  /// csid相同的归位一组显示球类标题
  /// 分组
  static List<CombineInfo> getMatchHandle(List<MatchEntity> matchList) {
    matchList.removeWhere((e) => ObjectUtil.isEmptyString(e.mid));
    if (BoolKV.sort.get() ?? true) {
      return getHotMatchHandle(matchList);
    } else {
      return getTimeMatchHandle(matchList);
    }
  }

  /// 获取下次的赛事ids
  static List<String> getNextMatchIds(
    List<CombineInfo> combineList,
    int startIndex,
    int endIndex,
  ) {
    List<String> mids = [];
    int targetEndIndex = min(endIndex, combineList.length - 1);
    for (int i = startIndex; i <= targetEndIndex; i++) {
      /// 如果是展开的，就加入
      CombineInfo combineInfo = combineList.elementAt(i);
      if (combineInfo.type == CombineType.matchWithHeader ||
          combineInfo.type == CombineType.match) {
        mids.add(combineInfo.data!.mid);
      }
    }
    return mids;
  }

  static Set<String> sMidList = HashSet();

  /// 单独加载主动被展开的赛事
  static preLoadOnlyMatchGroupBaseInfoList(List<String> midList) async {
    try {
      if (midList.isEmpty) return;
      DataStoreController.to.setShowMatchIdList(midList, needMerge: true);

      String mids = midList.join(',');
      final res = await MatchApi.instance().getMatchBaseInfo(
          mids,
          TYUserController.to.getUid(),
          TyHomeController.to.homeState.matchListReq.sort,
          null,
          'v2_h5_st',
          null,
          null,
          null,
          /*   "0",
          null,
          0,*/
          null,
          []);

      if (res.success && ObjectUtil.isNotEmpty(res.data)) {
        AppLogger.debug(res.data!.first.kySwitch.toString());
        for (var element in res.data!) {
          DataStoreController.to
              .updateMatch(element, keepSecondary: true, ishomebyMyId: true);
          // MatchEntity match = element;
          // debugPrint("=========>kyswitch${match.kySwitch.toString()}");
          // if(isMap(match.kySwitch)){
          //   Map<String, dynamic> kyswitch = Map<String, dynamic>.from(match.kySwitch);
          //   match.kySwitch = KySwitch.fromJson(kyswitch);
          // }else{
          //   match.kySwitch = null;
          // }
          //
          // DataStoreController.to
          //     .updateMatch(match, keepSecondary: true, ishomebyMyId: true);
        }
      }
    } catch (e) {
      AppLogger.debug('preLoadOnlyMatchGroupBaseInfoList error: $e');
    }
  }

  /// 加载下10条赛事基本信息
  static Future<void> preLoadNextMatchBaseInfoList(List<String> midList,
      [bool needMerge = false]) async {
    /// 加載下一頁數據 判斷主入口控制器是否初始化註冊完成
    if (!Get.isRegistered<MainTabController>()) return;

    try {
      if (midList.isEmpty) {
        return;
      }

      //print("preLoadNextMatchBaseInfoList:" + midList.toString());

      /// 将定时更新的取消
      TyHomeController.to.cancelTimerUpdate();
      DataStoreController.to.setShowMatchIdList(midList, needMerge: needMerge);
      String mids = midList.join(',');
      final res = await MatchApi.instance().getMatchBaseInfo(
          mids,
          TYUserController.to.getUid(),
          TyHomeController.to.homeState.matchListReq.sort,
          null,
          'v2_h5_st',
          null,
          null,
          null,
          /*   "0",
        null,
        0,*/
          DateTime.now().millisecond,
          [
            //{"mid":"4793363","playId":1004},{"mid":"4796696","playId":1004}
          ]);
      if (res.success && ObjectUtil.isNotEmpty(res.data)) {
        //print(res.data!.first.kySwitch.toString());
        // Map<String, dynamic>? kyswitchMap = res.data?.safeFirst?.kySwitch;
        // KySwitch? kySwitch;
        // if(isMap(kyswitchMap)) {
        //   kySwitch= KySwitch.fromJson(kyswitchMap!);
        // }
        for (var element in res.data!) {
          TyHomeController.to.homeState.showMatchIdSet.add(element.mid);
          DataStoreController.to.updateMatch(element,
              keepSecondary: !needMerge, ishomebyMyId: true);

          // debugPrint("=========>kyswitch${match.kySwitch.toString()}");
          // MatchEntity match = element;
          // if(isMap(match.kySwitch)){
          //   Map<String, dynamic> kyswitch = Map<String, dynamic>.from(match.kySwitch);
          //   match.kySwitch = KySwitch.fromJson(kyswitch);
          // }else{
          //   match.kySwitch = null;
          // }
          // // match.kySwitch = kySwitch;
          // DataStoreController.to.updateMatch(match,
          //     keepSecondary: !needMerge, ishomebyMyId: true);
        }
      }
    } catch (e) {
      AppLogger.debug('preLoadNext10MatchBaseInfoList error: $e');
    } finally {
      /// 防止定時器刷新時候，用戶退出或者其他銷毀主入口控制器時候報錯
      if (!Get.isRegistered<MainTabController>()) return;

      /// 距离上次刷新超过30秒，再次刷新
      TyHomeController.to.timerUpdateMathcOdds();
    }
  }
}
