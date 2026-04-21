import 'dart:math';
import 'package:collection/collection.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/discount_odd/discount_odd_bean.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/match_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/home_controller_logic.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/home/views/common_match_list_view.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/services/api/match_detail_api.dart';
import 'package:flutter_ty_app/app/services/api/vr_sports_api.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/discount_odd_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/get_odd_count_bean_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/sport.dart';
import 'package:flutter_ty_app/app/config/swr/swr_service.dart';
import 'package:flutter_ty_app/app/config/swr/refresh_coordinator.dart';
import 'package:flutter_ty_app/app/config/swr/swr_config.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/req/match_list_req.dart';
import '../states/home_state.dart';
import '../widgets/menu/league/hotLeagueController.dart';
import 'home_controller.dart';

////////////////          加载数据      //////////////////
extension TyHomeControllerExtension1 on TyHomeController {
  /// 联赛列表请求 -  走SWR
  Future fetchData(
      {bool isWsFetch = false,
      bool isLeague = false,
      bool isSortChange = false}) async {
    // vr 彩种数量
    String token = StringKV.token.get() ?? '';
    if (!isWsFetch && token.isNotEmpty) {
      _getVrSportMenus();
    }

    ///  清理上次可视化，折叠的数据
    if (isWsFetch == false) {
      DataStoreController.to.showMatchIdList.clear();
      Bus.getInstance().emit(EventType.scrollToTop);
      FoldMatchManager.clearFoldTids();
      FoldMatchManager.clearGroupFold();
      FoldMatchManager.clearHids();
      FoldMatchManager.clearHidsMore();
      CollectionController.to.updateCollection();
      kFirstIndex.value = 0;

      homeState.showMatchIdSet.clear();
      homeState.visiableLastIndex = 0;
      homeState.visiableLastIndex = 0;
      homeState.firstFetch = true;
    }

    final key = _getSwrKey();
    bool isCollection =
        homeState.sportId == SportConfig.FavoritesPage.sportId.toString();

    /// SWR 绑定key
    if (matchCoordinator?.key != key) {
      matchCoordinator?.dispose();
      matchCoordinator = RefreshCoordinator<List<MatchEntity>>(
        swr: SwrService.to.manager,
        box: 'home_matches',
        key: key,
        fetcher: (t) => _fetchMatchesApi(t),
        options: SwrOptions(
          pollInterval: const Duration(seconds: 40),
          lifecycleAware: true,
          revalidateAfter: const Duration(milliseconds: 500),
          // 重新调整比对逻辑：比对 赛事ID(mid) + 比分(msc) + 赛事阶段(mmp) + 赔率数量(hps.length)
          equals: (a, b) {
            final la = a as List<MatchEntity>?;
            final lb = b as List<MatchEntity>?;
            if (la == null || lb == null) return false;
            if (identical(la, lb)) return true;
            if (la.length != lb.length) return false;

            for (int i = 0; i < la.length; i++) {
              final ma = la[i];
              final mb = lb[i];

              // 1. 赛事ID比对
              if (ma.mid != mb.mid) return false;
              // 2. 赛事阶段比对
              if (ma.mmp != mb.mmp) return false;
              // 3. 比分比对
              if (!const ListEquality().equals(ma.msc, mb.msc)) return false;
              // // 4. 赔率列表长度比对 (防止赔率列表忽有忽无)
              // if (ma.hps.length != mb.hps.length) return false;

              // 5. 倒计时比对：仅当服务端时间发生巨幅跳变（超过 40s）时才视为数据更新
              double timeA = double.tryParse(ma.mst) ?? 0;
              double timeB = double.tryParse(mb.mst) ?? 0;
              if ((timeA - timeB).abs() > 15) return false;
            }
            return true;
          },
        ),
        fromRaw: (raw) => (raw as List).map((e) {
          final match = MatchEntity.fromJson(Map<String, dynamic>.from(e));
          match.isFromCache = true;
          // 倒计时不做任何缓存处理，从持久化缓存读取时强制置零
          match.mst = '0';
          return match;
        }).toList(),
        toRaw: (data) => data.map((e) {
          final json = e.toJson();
          // 存储到磁盘缓存前，清空倒计时数据，确保下次进入时必须等待接口实时数据
          json['mst'] = '0';
          return json;
        }).toList(),
        onSuccess: (data) {
          _onSwrDataSuccess(data, isWsFetch, isCollection, isLeague);
        },
      );

      matchCoordinator!.stream.listen((state) {
        // 如果是返回首页触发的静默刷新（isWsFetch=true），即使是 loading 状态也不要显示全局 loading
        // 只有当没有任何数据时，才显示 loading
        if (state.status == SwrStatus.loading &&
            state.data == null &&
            !isWsFetch) {
          if (homeState.matchtSet.isEmpty) {
            homeState.refreshStatus = RefreshStatus.isLoading;
            update();
          }
        } else if (state.status == SwrStatus.error &&
            homeState.matchtSet.isEmpty) {
          homeState.refreshStatus = RefreshStatus.loadFailed;
          update();
        }
      });

      matchCoordinator!.firstLoad();
      matchCoordinator!.startPolling();
    } else {
      matchCoordinator!.revalidate();
    }
  }

  void _onSwrDataSuccess(List<MatchEntity> data, bool isWsFetch,
      bool isCollection, bool isLeague) {
    if (data.isNotEmpty) {
      homeState.combineList.clear();
      homeState.matchtSet.clear();

      // 同步 SWR 数据到全局 DataStore，并从中获取合并后的完整对象
      for (MatchEntity match in data) {
        DataStoreController.to.updateMatch(match, keepSecondary: true);
        // 重要：从数据仓库中获取可能已经被合并过赔率的完整对象
        final mergedMatch =
            DataStoreController.to.getMatchById(match.mid) ?? match;
        homeState.matchtSet.add(mergedMatch);
      }

      homeState.refreshStatus = RefreshStatus.loadSuccess;
      handleData(isWsFetch);

      if (HotLeagueController.to?.currentIndex == 0 &&
          homeState.sportId != SportConfig.HotMenuLeague.sportId.toString()) {
        ConfigController.to.updateTopCount(data.length, homeState.sportId);
      }
    } else {
      homeState.matchtSet.clear();
      homeState.combineList.clear();
      homeState.refreshStatus = RefreshStatus.loadNoData;
      update();
    }

    // 优化：合并优惠盘口和冠军引导的异步请求，减少多次 update 导致的性能损耗
    // 只有在数据加载成功且不是静默刷新时才强制更新 UI，避免返回时闪烁
    // 如果是静默刷新，等待数据回来后 quietly update
    _fetchExtraHomeData(isCollection, isLeague, isWsFetch);
  }

  /// 异步获取优惠盘口、冠军引导
  Future<void> _fetchExtraHomeData(
      bool isCollection, bool isLeague, bool isWsFetch) async {
    final List<Future> tasks = [];

    // 1. 优惠盘口任务
    if (!isCollection &&
        homeState.matchListReq.euid !=
            SportConfig.Featured.sportId.toString() &&
        !isLeague) {
      tasks.add(getAddedOddsMatches());
    } else {
      homeState.matchtDiscount.clear();
      homeState.discountMidStringList.clear();
    }

    // 2. 冠军引导任务
    tasks.add(getGuanjunYindao());

    // 并发执行所有额外任务
    if (tasks.isNotEmpty) {
      await Future.wait(tasks);
      // 所有异步数据回来后，统一执行一次 update 刷新 UI
      // 如果是 wsFetch (静默刷新)，只更新数据不显示全屏 loading，但需要 update UI 以显示新数据
      update();
    }
  }

  String _getSwrKey() {
    final req = homeState.matchListReq;
    final isCollection =
        homeState.sportId == SportConfig.FavoritesPage.sportId.toString();
    final hotIndex = HotLeagueController.to?.currentIndex ?? 0;
    final mi = homeState.menu.mi;
    final uid = TYUserController.to.getUid();

    return 'matches_v1_${uid}_${isCollection}_${req.euid}_${req.sort}_${req.type}_${req.md}_${req.tid}_${req.cuid}_${hotIndex}_${mi}_${homeState.sportId}';
  }

  Future<List<MatchEntity>> _fetchMatchesApi(CancelToken cancelToken) async {
    bool isCollection =
        homeState.sportId == SportConfig.FavoritesPage.sportId.toString();
    List<MatchEntity> matchtList = [];

    try {
      if (isCollection) {
        final index = homeSportMenuState.sportMenuList
            .indexWhere((e) => e.euid.contains(','));
        if (index >= 0) {
          String euids = homeSportMenuState.sportMenuList[index].euid;
          final res = await MatchApi.instance().matchesCollectNewH5(
            TYUserController.to.getUid(),
            euids,
            homeState.matchListReq.sort,
            homeState.matchListReq.type,
            'v2_h5_st',
            homeState.matchListReq.md,
          );
          matchtList = res.data ?? [];
        }
      } else if (homeState.matchListReq.euid ==
          SportConfig.Featured.sportId.toString()) {
        final res = await MatchApi.instance().structureLiveMatches(
            cuid: TYUserController.to.getUid(),
            euid: 30199,
            type: homeState.matchListReq.type,
            sort: homeState.matchListReq.sort,
            orpt: -1,
            apiType: 1,
            hotMatches: 1);
        matchtList.addAll(res.data ?? []);
      } else if (homeState.sportId ==
              SportConfig.MatchAllPage.sportId.toString() &&
          homeState.menu.mi == 1 &&
          HotLeagueController.to?.currentIndex == 0) {
        final res = await MatchApi.instance().getAllInPlayMatchList(
            cuid: homeState.matchListReq.cuid,
            euid: homeState.matchListReq.euid,
            type: homeState.matchListReq.type,
            sort: homeState.matchListReq.sort);
        matchtList.addAll(res.data?.general ?? []);
        matchtList.addAll(res.data?.electronic ?? []);
        matchtList.addAll(res.data?.eSports ?? []);
      } else {
        MatchListReq req =
            MatchListReq.fromJson(homeState.matchListReq.toJson());
        if (((HotLeagueController.to?.currentIndex ?? 0) != 0) &&
            !homeState.menu.isChampion) {
          Get.log('matchesNew request: ${req.toJson()}');
          final res1 = await MatchApi.instance().matchesNew(req: req);
          matchtList.addAll(res1.data?.matchs ?? []);
          if (homeState.menu.isMatchBet) {
            if (res1.data?.esportMatchs != null) {
              matchtList
                  .addAll(res1.data!.esportMatchs!.where((e) => e.ispo == 2));
            }
          } else {
            matchtList.addAll(res1.data?.esportMatchs ?? []);
          }
        } else {
          final res = await MatchApi.instance().matches(req);
          final List<MatchEntity> responseData = res.data ?? [];
          if (!ObjectUtil.isEmptyString(req.tid)) {
            final Set<String> tidFilterSet = req.tid!.split(',').toSet();
            matchtList.addAll(
                responseData.where((e) => tidFilterSet.contains(e.tid)));
          } else {
            matchtList.addAll(responseData);
          }
        }
      }
    } catch (e) {
      AppLogger.error('SWR 请求错误: $e');
      rethrow;
    }
    return matchtList;
  }

  handleData([isWs = false]) {
    try {
      /// 冠军不用请求详情
      if (homeState.menu.isChampion) {
        for (MatchEntity matchEntity in homeState.matchtSet) {
          DataStoreController.to.injectMatch(matchEntity, ishomebyMyId: true);
        }
      } else {
        /// 数据分组
        homeState.combineList =
            TyHomeControllerLogic.getMatchHandle(homeState.matchtSet);
        if (!isWs) {
          /// 预加载下20条数据
          /// 只有第一次需要，用初始值判断
          if(homeState.firstFetch) {
            homeState.firstFetch = false;
            int endIndex = min(HomeState.pageCount, homeState.combineList.length);
            kLastIndex = endIndex;
            List<String> mids = TyHomeControllerLogic.getNextMatchIds(
                homeState.combineList, 0, endIndex);
            TyHomeControllerLogic.preLoadNextMatchBaseInfoList(
              mids,
            );
          }
        }
      }
      homeState.refreshStatus = RefreshStatus.loadSuccess;
      // [homeState.endScroll]
      /// 当前是搜索状态，更新数据不要刷新
      if (homeState.isSearch) {
        search(homeState.searchText);
      } else {
        update();
      }
    } catch (e) {
      AppLogger.debug('error ${e.toString()}');
    }
  }

  Future getAddedOddsMatches() async {
    ApiRes<DiscountOddEntity> res;
    if (homeState.isSearch) return;

    /// 获取优惠盘口赛事
    try {
      res = await MatchApi.instance().getAddedOddsMatches(
        cuid: TYUserController.to.getUid(),
        euid: homeState.matchListReq.euid,

        ///篮球为2，足球1
        sportId: homeState.sportId == "102"
            ? "2"
            : (homeState.sportId == "101" ? "1" : homeState.sportId),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        AppLogger.debug('getAddedOddsMatches请求超时');
        return;
      }
      rethrow;
    }

    if (res.success && ObjectUtil.isNotEmpty(res.data)) {
      homeState.matchtDiscount.clear();
      homeState.discountMidStringList.clear();
      homeState.matchtDiscount = res.data!.data
          .where((element) =>
              element.csid == (homeState.matchtSet.safeFirst?.csid ?? ''))
          .toList();
      List<MatchEntity> matchDiscount = homeState.matchtDiscount;
      List<DiscountOddBean> discountOddBeans = [];
      List<DiscountOddBean> doc1List = [];
      List<DiscountOddBean> doc2List = [];
      matchDiscount.forEach((MatchEntity match) {
        for (int j = 0; j < match.hps.length; j++) {
          MatchHps hps = match.hps[j];
          MatchHpsHl? hl = hps.hl.safeFirst;
          List<MatchHpsHlOl>? ols = hl?.ol;
          for (int k = 0; k < ols!.length; k++) {
            MatchHpsHlOl ol = ols[k];

            ///根据doc 进行分组 doc等于1 一组  等于0为一组
            if (ol.doc == 1) {
              doc1List.add(DiscountOddBean(match, ol, hps, hl));
            } else {
              doc2List.add(DiscountOddBean(match, ol, hps, hl));
            }
          }
        }
      });
      discountOddBeans = [...doc1List, ...doc2List];
      List<DiscountOddBean> matchtDiscountTempList = discountOddBeans.slice(
          0, discountOddBeans.length >= 6 ? 6 : discountOddBeans.length);

      List<Map<String, String>> map = [];
      for (DiscountOddBean item in matchtDiscountTempList) {
        String? hid = item.hl?.hid;
        if (hid == null || hid.isEmpty) {
          ///跳过空参数
          continue;
        }
        map.add({
          "sportId": item.matchEntity.csid,
          "matchId": item.matchEntity.mid,
          "playId": item.hps.hpid,
          "marketId": item.hl?.hid ?? "",
          "playOptionId": item.ol.oid,
          "matchType":
              "${homeState.menu.isEarly ? 1 : 2}" // 赛事类型，1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
        });
      }
      if (map.isEmpty) return;
      // AppLogger.debug("==========>map  ${map}");
      try {
        final oddCountRes =
            await MatchApi.instance().getQueryBetCount(paramList: map);
        homeState.oddCountBeanEntity = oddCountRes.data;
      } on DioException catch (e) {
        if (e.response?.statusCode == 404) {
          homeState.oddCountBeanEntity = null;
          return;
        }
        rethrow;
      }
      homeState.discountMidStringList =
          homeState.matchtDiscount.map((matchModel) => matchModel.mid).toList();
      homeState.discountCount = res.data!.count;

      for (int i = 0; i < homeState.matchtDiscount.length; i++) {
        MatchEntity matchEntity = homeState.matchtDiscount[i];

        ///优惠盘口   数据仓库不插入赛事级别
        ///使用 expand 展平嵌套列表
        matchEntity.hps
            .expand((MatchHps hps) => hps.hl)
            .expand((MatchHpsHl hpsHl) => hpsHl.ol)
            .forEach((MatchHpsHlOl ol) {
          DataStoreController.to.updateOl(ol);
        });
      }
      // update(); // 移除此处 update，由 _fetchExtraHomeData 统一刷新
    }
  }

  /**
   * 根据Item获取热门人数
   */
  GetOddCountBeanStatInfoList? getOddCountBeanEntity(String oid) {
    for (GetOddCountBeanStatInfoList getOddCountBeanStatInfoItem
        in (homeState.oddCountBeanEntity?.statInfoList ?? [])) {
      if (getOddCountBeanStatInfoItem.playOptionId == oid) {
        getOddCountBeanStatInfoItem.orderCountAlias =
            "${((getOddCountBeanStatInfoItem.orderCount ?? 0)) ~/ 1000}";
        return getOddCountBeanStatInfoItem;
      }
    }
    return null;
  }

  //冠军引导
  Future getGuanjunYindao() async {
    homeState.outrightDisplayMap.clear();

    //串关不显示引导盘
    if (TyHomeController.to.homeState.menu.isMatchBet) return;
    List tids = [];
    for (var element in homeState.matchtSet) {
      tids.add(element.tid);
    }
    String tidsStr = "";
    if (tids.length > 0) {
      for (int i = 0; i < tids.length; i++) {
        if (i == 0) {
          tidsStr += tids[i];
        } else {
          tidsStr += "," + tids[i];
        }
      }
    }
    // tidsStr="822164";//墨西哥
    // tidsStr="1194634";//希腊
    try {
      var res = await MatchDetailApi.instance().getOutrightDisplayMatchs(
          tidsStr,
          TYUserController.to.getUid(),
          TyHomeController.to.homeState.matchListReq.euid,
          '${SportData.sportCsid_1},${SportData.sportCsid_2}');
      if (res.success) {
        homeState.outrightDisplayMap.clear();
        homeState.outrightDisplayMatchsEntity = null;
        homeState.outrightDisplayMatchsEntity = res.data;
        if (homeState.outrightDisplayMatchsEntity != null) {
          for (int i = 0;
              i < homeState.outrightDisplayMatchsEntity!.data.length;
              i++) {
            MatchEntity matchEntity =
                homeState.outrightDisplayMatchsEntity!.data[i];

            // AppLogger.debug("插入数据仓库 = "+ matchEntity.toString());
            ///插入数据仓库
            MatchEntity? match =
                DataStoreController.to.getMatchById(matchEntity.mid);

            if (match != null) {
              // match.isExpand = false;
              DataStoreController.to.updateMatch(match);
            } else {
              // matchEntity.isExpand = false;
              DataStoreController.to.injectMatch(matchEntity);
            }

            ///更新盘口赔率
            matchEntity.hps
                .expand((MatchHps hps) => hps.ol) // 展平 MatchHpsHlOl 列表
                .forEach((MatchHpsHlOl ol) {
              DataStoreController.to.updateOl(ol);
            });
          }
        }
        if (res.data != null) {
          res.data!.data.forEach((element) {
            homeState.outrightDisplayMap[element.tid] = element;
          });
        }
        // update(); // 移除此处 update，由 _fetchExtraHomeData 统一刷新
      }
    } catch (e) {}
  }
}

extension TyHomeControllerVrSportMenus on TyHomeController {
  _getVrSportMenus() async {
    try {
      final res = await VrSportsApi.instance().getVrSportsMenus(
        'V1_H5',
        '${DateTime.now().millisecondsSinceEpoch}',
      );

      showVrSportMenu = res.data?.isNotEmpty == true;
      //AppLogger.debug('showVrSportMenu: $showVrSportMenu');
      update();
    } catch (e) {
      AppLogger.debug('getVrSportMenus error: $e');
    }
  }
}
