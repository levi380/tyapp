import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/dj_data_api.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';


import '../../../services/models/res/collection_info.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';

String COLLECTION_TID = 'collection_tid_';
String COLLECTION_MID = 'collection_mid_';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-17f9861a-212f-4ea0-8f0c-a0f521503f8b-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  收藏数据全局管理类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 收藏数据管理入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 收藏数据管理
    ```
    /// 获取收藏数量
    Future<void> fetchCollectionCount() async {
    try {
    if (!RouteCheckUtil.checkNoLogin()) return;
    final res = await MatchApi.instance().getCollectCount(TYUserController.to.getUid());
    if (res.success) {
    collectionCount = res.data ?? 0;
    ConfigController.to.updateTopCount(collectionCount, '50000');
    update(['50000']);
    }
    } catch (e) {
    AppLogger.debug('fetchCollectionCount error: $e');
    }
    }

    /// 更新收藏状态
    Future<void> updateCollection() async {
    try {
    if (!RouteCheckUtil.checkNoLogin()) return;
    final res = await MatchApi.instance().getCollectIds(TYUserController.to.getUid());
    if (res.success) {
    commonCollectionTidList.clear();
    commonCollectionMidList.clear();
    championCollectionMidList.clear();
    djCollectionMidList.clear();

    // 普通赛事联赛收藏
    commonCollectionTidList.addAll(res.data?.tIds ?? []);
    // 普通赛事收藏
    commonCollectionMidList.addAll(res.data?.mIds ?? []);
    // 冠军赛事收藏
    championCollectionMidList.addAll(res.data?.cIds ?? []);
    // 电竞赛事收藏
    djCollectionMidList.addAll(res.data?.eIds ?? []);
    update();
    }
    } catch (e) {
    AppLogger.debug('updateCollection error: $e');
    }
    }
    ```
    】】】
 *
 */

class CollectionController extends GetxController {
  Set<String> championCollectionMidList = {};
  int collectionCount = 0;
  int collectionCountDJ = 0;
  Set<String> commonCollectionMidList = {};
  Set<String> commonCollectionTidList = {};
  List<CollectionInfoExclude> commonExclude = [];
  Set<String> djCollectionMidList = {};
  Set<String> djCollectionTidList = {};
  List<CollectionInfoExclude> djExclude = [];

  @override
  void onClose() {
    // Bus.getInstance().off(EventType.appSignOut);
    Bus.getInstance().off(EventType.tyLogout);
    // Bus.getInstance().off(EventType.tyLogined);
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.tyLogout, (value) {
      clearCollection();
    });
  }

  static CollectionController get to => Get.find<CollectionController>();

  /// 清空收藏数据
  clearCollection() {
    commonCollectionTidList.clear();
    commonCollectionMidList.clear();
    championCollectionMidList.clear();
    commonExclude.clear();
    djCollectionMidList.clear();
    collectionCount = 0;
    ConfigController.to.updateTopCount(
        collectionCount, SportConfig.FavoritesPage.sportId.toString());
    update([SportConfig.FavoritesPage.sportId.toString()]);
    update();
  }

  ///常规赛事-联赛收藏
  addOrCancelTournament(String tid, MatchEntity match) {

    // AppLogger.debug("==========>收藏/取消收藏该赛事埋点上传  tid  ${tid}  ");
    // 收藏/取消收藏该赛事埋点上传
    Analytics.track(AnalyticsEvent.btn_favorite_1, pagePath: '', clickTarget: (AnalyticsEvent.btn_favorite_1).toString());
    if (MatchUtil.isEsport(match)) {
      addOrCancelTournamentDJ(tid);
    } else {
      addOrCancelTournamentCommon(tid);
    }
  }

  ///常规赛事-联赛收藏
  addOrCancelTournamentCommon(String tid) {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;

    bool tf = commonCollectionTidList.contains(tid);
    MatchApi.instance()
        .addOrCancelTournament(TYUserController.to.getUid(), tid, tf ? 0 : 1)
        .then((value) {
      if (value.success) {
        if (tf) {
          TyHomeController.to.removeMatchs(tid);
        }
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
      }
    });
  }

  ///电竞赛事-联赛收藏
  addOrCancelTournamentDJ(String tid) {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;

    bool cf = djCollectionTidList.contains(tid); // 操作类型（0: 取消收藏, 1: 添加收藏）

    MatchApi.instance()
        .addOrCancelTournament(TYUserController.to.getUid(), tid, cf ? 0 : 1,
            dota2: 1)
        .then((value) {
      if (value.success) {
        if (cf) {
          // 如果当前在收藏列表 移除赛事

          if (Get.currentRoute == Routes.DJView) {
            DJController.to.removeMatchs(tid);
          } else {
            TyHomeController.to.removeMatchs(tid);
          }
        }
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
        CollectionController.to.getDJCollectCount();
      }
    });
  }

  /// 冠军赛事收藏
  addOrCancelTournamentGuanjun(MatchEntity match) {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
    String mid = match.mid;
    bool tf = championCollectionMidList.contains(mid) || match.tf;
    match.tf = !tf;
    championCollectionMidList.remove(mid);
    DataStoreController.to.updateMatch(match, ishomebyMyId: true);
    MatchApi.instance()
        .addOrCancelTournamentGuanjun(
            TYUserController.to.getUid(), mid, tf ? 0 : 1)
        .then((value) {
      if (value.success) {
        if (tf) {
          TyHomeController.to.removeMatch(mid);
        }
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
      }
    });
  }

  /// 常规赛事收藏
  addOrCancelMatch(MatchEntity match) {
    Analytics.track(AnalyticsEvent.btn_favorite_2, pagePath: '', clickTarget: (AnalyticsEvent.btn_favorite_2).toString());
    if (MatchUtil.isEsport(match)) {
      addOrCancelMatchDJ(match);
    } else {
      addOrCancelMatchCommon(match);
    }
  }

  /// 常规赛事收藏
  addOrCancelMatchCommon(MatchEntity match) {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
    bool mf = isCollection(match) || match.mf;
    MatchApi.instance()
        .addOrCancelMatch(TYUserController.to.getUid(), match.mid, mf ? 0 : 1)
        .then((value) {
      if (value.success) {
        if (mf) {
          TyHomeController.to.removeMatch(match.mid);
        }
        match.mf = !mf;
        DataStoreController.to.updateMatch(match, ishomebyMyId: true);
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
      }
    }).catchError((e) {
      // showToast(LocaleKeys.msg_msg_nodata_09.tr);
    });
  }

  /// 电竞赛事收藏
  addOrCancelMatchDJ(MatchEntity match) {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
    bool mf = isCollection(match) || match.mf;
    MatchApi.instance()
        .addOrCancelMatch(TYUserController.to.getUid(), match.mid, mf ? 0 : 1,
            dota2: 1)
        .then((value) {
      if (value.success) {
        if (mf) {
          if (Get.currentRoute == Routes.DJView) {
            DJController.to.removeMatch(match.mid);
          } else {
            TyHomeController.to.removeMatch(match.mid);
          }
        }
        match.mf = !mf;
        DataStoreController.to.updateMatch(match);
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
        CollectionController.to.getDJCollectCount();
      }
    }).catchError((e) {
      // showToast(LocaleKeys.msg_msg_nodata_09.tr);
    });
  }

  updateCollection() async {
    try {
      final res = await MatchApi.instance()
          .collectMatches(0, TYUserController.to.getUid());

      if (res.success && res.data != null) {
        final Map<String, CollectionInfo?> data =
            res.data ?? <String, CollectionInfo?>{};

        ///普通赛事收藏key
        const commonKey = '1';

        ///冠军赛事收藏key
        const championKey = '2';

        ///电竞赛事收藏key
        const djKey = '3';

        final commonInfo = data[commonKey] ?? CollectionInfo();
        final championInfo = data[championKey] ?? CollectionInfo();
        final djInfo = data[djKey] ?? CollectionInfo();

        /// 普通赛事收藏
        commonCollectionTidList = commonInfo.tids.toSet();
        commonCollectionMidList = commonInfo.mids.toSet();
        commonExclude = commonInfo.exclude;

        /// 冠军赛事收藏
        championCollectionMidList = championInfo.mids.toSet();

        /// 电竞赛事收藏
        djCollectionTidList = djInfo.tids.toSet();
        djCollectionMidList = djInfo.mids.toSet();
        djExclude = djInfo.exclude;

        update();
      } else {
        // AppLogger.debug('collectMatches 无数据');
      }
    } catch (e) {
      AppLogger.error(e);
    }
  }

  ///判断联赛是否收藏，赛事收藏状态改变，不影响联赛收藏状态，所以要独立的方法
  bool isCollectionTournament(MatchEntity match) {
    bool isContain = false;
    if (MatchUtil.isEsport(match)) {
      if (djCollectionTidList.contains(match.tid)) {
        isContain = true;
      }
    } else {
      if (commonCollectionTidList.contains(match.tid)) {
        isContain = true;
      }
    }

    return isContain;
  }

  /// 常规赛事判断是否收藏
  bool isCollection(MatchEntity match) {
    if (MatchUtil.isEsport(match)) {
      return isCollectionDJ(match);
    }
    return isCollectionCommon(match);
  }

  /// 是否收藏
  bool isCollectionCommon(MatchEntity match) {
    ///普通赛事的判断
    bool isContain = commonCollectionMidList.contains(match.mid) ||
        djCollectionMidList.contains(match.mid);
    if (!isContain) {
      ///查看联赛是否收藏
      if (commonCollectionTidList.contains(match.tid)) {
        isContain = true;

        /// 是否在联赛收藏的排除赛事中
        if (commonExclude.isNotEmpty) {
          for (var item in commonExclude) {
            if (item.tids == match.tid) {
              isContain = !item.mids.contains(match.mid);
            }
          }
        }
      }
    }
    return isContain;
  }

  /// 是否收藏电竞
  bool isCollectionDJ(MatchEntity match) {
    ///普通赛事的判断
    bool isContain = djCollectionMidList.contains(match.mid);
    if (!isContain) {
      ///查看联赛是否收藏
      if (djCollectionTidList.contains(match.tid)) {
        isContain = true;

        /// 是否在联赛收藏的排除赛事中
        if (djExclude.isNotEmpty) {
          for (var item in djExclude) {
            if (item.tids == match.tid) {
              isContain = !item.mids.contains(match.mid);
            }
          }
        }
      }
    }
    return isContain;
  }

  /// 更新收藏数据
  Future<void> fetchCollectionCount() async {
    try {
      //更新收藏数据
      final index = TyHomeController.to.homeSportMenuState.sportMenuList
          .indexWhere((e) => e.euid.contains(','));
      if (index >= 0) {
        String euids =
            TyHomeController.to.homeSportMenuState.sportMenuList[index].euid;
        final res = await MatchApi.instance().updateCollectMatches(
            TYUserController.to.getUid(),
            euids,
            TyHomeController.to.homeState.matchListReq.sort,
            TyHomeController.to.homeState.matchListReq.type);
        if (res.success) {
          collectionCount = res.data ?? 0;
          update([SportConfig.FavoritesPage.sportId.toString()]);
        }
      }
    } catch (e) {
      AppLogger.debug('fetchCollectionCount error: $e');
    }
  }

  // 更新电竞收藏数量
  Future<int> getDJCollectCount() async {
    int count = djCollectionMidList.length;

    final res = await DjDataApi.instance().updateCollectMatches(
      TYUserController.to.getUid(),
      DJController.to.DJState.djListReq.euid,
      "v2_h5_st",
      1,
      DJController.to.DJState.djListReq.type,
      DJController.to.getCsid(),
    );
    if (res.success) {
      collectionCountDJ = res.data ?? 0;
      update([SportConfig.FavoritesPage.sportId.toString()]);
    }
    return count;
  }
}
