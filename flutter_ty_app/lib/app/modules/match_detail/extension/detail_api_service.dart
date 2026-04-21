import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_analysis_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_tab_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:get/get.dart';

import '../../../db/app_cache.dart';
import '../../../global/data_store_controller.dart';
import '../../../global/ty_user_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api/match_api.dart';
import '../../../services/api/match_detail_api.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/category_list_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/sport.dart';
import '../../home/controllers/home_controller.dart';
import '../../main_tab/main_tab_controller.dart';
import '../constants/detail_constant.dart';
import '../controllers/match_detail_controller.dart';
import '../models/request_status.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-3f77167e-e24a-472a-997d-56129017feb0 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE http-api接口】】】
    【【【 AUTO_PARAGRAPH_TITLE http-api接口逻辑】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 常规赛事详情接口、电竞详情接口
    - 联赛下拉接口
    - 常规赛事、电竞玩法集 接口
    - 赛事置顶接口
    】】】
 *
 */
extension DetailApiExtension on MatchDetailController {
  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 主要业务逻辑】】】
      【【【 AUTO_PARAGRAPH_TITLE http-api接口逻辑】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 通用接口获取
      - 12秒loading还存在 去除loading 逻辑
      - 投注列表轮训
      】】】
   *
   */
  fetchData({bool changeSelect = false}) async {
    // 适配赛果、虚拟体育
    if (![Routes.matchResultsDetails, Routes.vrSportDetail]
            .contains(Get.currentRoute) &&
        ObjectUtil.isNotEmpty(detailState.mId)) {
      bool initCategoryList = false;
      // 进入参数没有csid 则请求完详情数据再请求玩法集
      if (detailState.csid == "") {
        initCategoryList = true;
      }

      // 详情数据
      fetchMatchDetailData(
          initCategoryList: initCategoryList, changeSelect: changeSelect);
      // 玩法集tab
      if (!initCategoryList) {
        fetchCategoryList(csid: detailState.csid, mid: detailState.mId);
      }
      // 投注数据拉取
      // refreshOddsInfoData(refresh: true);
      // 投注列表轮训
      repeatOddsInfo();

      /// 更新赛事分析开关
      initAnalysisSwitch();
    }
    // 12秒loading还存在 去除loading
    12.seconds.delay(() {
      if (isClosed) {
        return;
      }
      // 投注数据
      if (detailState.oddsInfoRequestStatus == RequestStatus.loading &&
          detailState.oddsInfoList.isEmpty) {
        detailState.oddsInfoRequestStatus = RequestStatus.noNetwork;
        update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
        detailState.throttleCategoryListSubject.add(null);
        detailState.throttleOddsInfoSubject.add(null);
      }

      // 详情
      if (detailState.detailLoading == true) {
        detailState.detailLoading = false;
        update();
      }
    });
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 主要业务逻辑】】】
      【【【 AUTO_PARAGRAPH_TITLE http-api接口逻辑】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取详情数据
      - mId 可选，切换赛事传入
      - initCategoryList 是否初始化玩法集（请求玩法集接口）
      - changeSelect 是否联赛选择（切换赛事）
      】】】
   *
   */
  fetchMatchDetailData(
      {String? mId,
      bool initCategoryList = false,
      bool changeSelect = false}) async {
    try {
      // 切换赛事 或者 下拉选择新赛事，先从数据仓库取
      if (mId != null) {
        pushMid(mId);
        MatchEntity? storeMatch = DataStoreController.to.getMatchById(mId);
        if (storeMatch != null) {
          detailState.match = storeMatch;
          resetMatch(mId);
          // 数据仓库已经有该赛事  直接切换赛事  mId = null 往下请求逻辑不再切换
          mId = null;
          update();
        }
      }

      // final String jsonString = await rootBundle.loadString('assets/json/test.json');
      // final data = jsonDecode(jsonString);
      // ApiRes<Map<String, dynamic>> value = ApiRes<Map<String, dynamic>>.fromJson(data);
      // _detailDataHandler(value,
      //     mId: mId,
      //     initCategoryList: initCategoryList,
      //     changeSelect: changeSelect);
      if (detailState.isDJDetail) {
        // 电竞
        await MatchDetailApi.instance()
            .getESMatchDetail(
                mId ?? detailState.mId, TYUserController.to.getUid(), "init")
            .then((value) {
          _detailDataHandler(value,
              mId: mId,
              initCategoryList: initCategoryList,
              changeSelect: changeSelect);
        });
      } else {
        // 详情数据
        await MatchDetailApi.instance()
            .getMatchDetail(
                mId ?? detailState.mId, TYUserController.to.getUid(), "init")
            .then((value) {
          _detailDataHandler(value,
              mId: mId,
              initCategoryList: initCategoryList,
              changeSelect: changeSelect);
        });
      }
    } catch (e) {
      AppLogger.debug("fetchMatchDetailData:$e");
      detailState.detailLoading = false;
      update();
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 主要业务逻辑】】】
      【【【 AUTO_PARAGRAPH_TITLE http-api接口逻辑】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 联赛下拉选择组件展开时的联赛列表获取
      】】】
   *
   */
  fetchMatchListData() async {
    if (detailState.match != null && !isClosed) {
      try {
        var res = await MatchDetailApi.instance().getMatchDetailByTournamentId(
            detailState.match!.tid,
            null,
            null,
            detailState.isDJDetail ? "1" : null);
        if (res.success && !ObjectUtil.isEmptyList(res.data)) {
          detailState.matchListData = res.data!;
        } else {
          detailState.matchListData = [
            DataStoreController.to.getMatchById(detailState.mId) ??
                detailState.match!
          ];
        }
        update([matchSelectGetBuildId]);
      } catch (e) {
        AppLogger.debug(e.toString());
      }
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 主要业务逻辑】】】
      【【【 AUTO_PARAGRAPH_TITLE http-api接口逻辑】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取玩法集
      - 更新完玩法集，需要判断当前激活项是否存在玩法集中 不存在则重置为第一项
      】】】
   *
   */
  fetchCategoryList({String? csid, String? mid}) async {
    try {
      bool isDjResult = detailState.isDJDetail &&
          detailState.isResult &&
          detailState.csid.isNotEmpty;
      if ((detailState.match != null && detailState.match?.csid != null) ||
          (csid != null && mid != null) ||
          isDjResult) {
        String sportId = "";
        String mId = "";
        if (csid != null && mid != null) {
          sportId = csid;
          mId = mid;
        } else {
          sportId = detailState.match?.csid ?? SportData.sportCsid_1.toString();
          mId = detailState.mId;
        }
        var res;
        if (detailState.isDJDetail) {
          if (detailState.isResult) {
            res = await MatchDetailApi.instance()
                .getESWCategoryList(sportId, mId, type: "99");
          } else {
            res =
                await MatchDetailApi.instance().getESCategoryList(sportId, mId);
          }
        } else {
          res = await MatchDetailApi.instance().getCategoryList(sportId, mId);
        }
        _categoryHandler(res);
      }
    } on DioException catch (e) {
      AppLogger.debug("fetchCategoryList()：$e");
    } catch (e) {
      // 网络错误 延迟2秒请求一次
      // 2.seconds.delay(() => fetchOddsListData());
    }
  }

  _categoryHandler(ApiRes<List<CategoryListData>> value) {
    if (value.success && !ObjectUtil.isEmptyList(value.data)) {
      detailState.categoryList = value.data!;

      // 绑定冠军引导盘
      bindChampionMatchTab();
      // 次要玩法进来需要计算CurCategoryTabId
      calCurCategoryTabId();
      // 更新完玩法集，需要判断当前激活项是否存在玩法集中 不存在则重置为第一项
      bool existIdFlag = false;
      for (CategoryListData data in detailState.categoryList) {
        if (data.id == detailState.curCategoryTabId) {
          existIdFlag = true;
        }
      }
      if (!existIdFlag) {
        // 玩法集删除 重置为所有列表
        detailState.curCategoryTabId =
            detailState.categoryList.safeFirst?.id ?? "0";
        // 刷新一下投注列表
        update([matchOddsInfoGetBuildId]);
      }
      update([matchBetModeTabGetBuildId]);
    }
  }

  _detailDataHandler(ApiRes<Map<String, dynamic>> value,
      {String? mId, bool initCategoryList = false, bool changeSelect = false}) {
    if (value.success && ObjectUtil.isNotEmpty(value.data)) {
      // 从数据库取原始数据 有原始数据不能直接覆盖
      MatchEntity? originMatch =
          DataStoreController.to.getMatchById(mId ?? detailState.mId);
      if (originMatch != null) {
        Map<String, dynamic> originMatchMap = originMatch.toJson();
        // 合并赛事
        originMatchMap.addAll(value.data!);
        detailState.match = MatchEntity.fromJson(originMatchMap);
      } else {
        detailState.match = MatchEntity.fromJson(value.data!);
      }

      DataStoreController.to.updateMatch(detailState.match!);
      detailState.csid = detailState.match?.csid ?? "";

      // 赛事变更 更新mid
      if (mId != null && mId != detailState.mId) {
        resetMatch(mId);
      }
      // 插入数据仓库可视化赛事
      DataStoreController.to.injecthowMatchIdByMatchEntity(detailState.mId);

      if (initCategoryList) {
        fetchCategoryList();
      }

      // 下拉联赛延迟两秒进行数据持久化
      3000.milliseconds.delay(() {
        if (isClosed) {
          return;
        }
        fetchMatchListData();
      });

      // 冠军引导盘
      fetchOutrightDisplayMatchs();
    } else {
      backHome();
    }
    detailState.detailLoading = false;
    // setTabController();
    update();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 主要业务逻辑】】】
      【【【 AUTO_PARAGRAPH_TITLE http-api接口逻辑】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取服务器置顶数据
      - 更新完玩法集，需要判断当前激活项是否存在玩法集中 不存在则重置为第一项
      】】】
   *
   */
  fetchPlayTopList() async {
    try {
      var res = await MatchDetailApi.instance().findPlayTop();
      if (res.success) {
        detailState.playTopList = res.data ?? [];
        if (detailState.oddsInfoList.isNotEmpty) {
          updateHtonOddsInfo();
        }
      }
    } catch (e) {}
  }

  /// 冠军引导盘
  /// 展示规则： 1、玩法集最后 2、全部玩法最后 3、 串关不展示
  fetchOutrightDisplayMatchs() async {
    if (detailState.match == null ||
        !Get.isRegistered<MainTabController>() ||
        !Get.isRegistered<TyHomeController>(tag: MainTabController.to.uuid) ||
        TyHomeController.to.homeState.menu.isMatchBet) return;

    try {
      var res = await MatchDetailApi.instance().getOutrightDisplayMatchs(
          detailState.match!.tid,
          TYUserController.to.getUid(),
          TyHomeController.to.homeState.matchListReq.euid,
          '${SportData.sportCsid_1},${SportData.sportCsid_2}'
          // TyHomeController.to.homeState.sportId
          );
      if (res.success) {
        detailState.championMatchs = res.data?.data ?? [];

        bindChampionMatchTab();
        filterOddsInfo();
        if (detailState.championMatchs.isEmpty) {
          // 冠军引导盘关闭，清空冠军玩法集
          detailState.categoryList.removeWhere((e) => e.isChampion);
        }

        // 更新玩法集 以及投注列表
        update([matchBetModeTabGetBuildId, matchOddsInfoGetBuildId]);
      }
    } catch (e) {
      AppLogger.debug("fetchOutrightDisplayMatchs error:" + e.toString());
    }
  }

  // 记录全屏投注引导
  cancelFirstFullBetGuild() async {
    if (!detailState.isShowBetGuide.value) {
      return;
    }

    ///接口只做记录处理
    try {
      BoolKV.quickBetting.save(false);
      detailState.isShowBetGuide.value = false;

      final res = await MatchApi.instance().setUserTimeZonePersonaliseNew(
          TYUserController.to.getUid(), {"quickBetting": "0"});
      if (res.success) {}
    } catch (e) {
      AppLogger.debug(e.toString());
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 详情页赛事结束自动切换赛事
      - 返回赛事各项id(球类id:csid/赛事id:mid/联赛id:tid)
      - 赛事切换条件
      ```
      if (matchEntity?.mmp == "999" || ![0, 1, 2, 7, 10, 110].contains(matchEntity?.ms))
      ```
      】】】
   *
   */
  eventSwitch() {
    if (detailState.eventSwitchLock ||
        isClosed ||
        Get.currentRoute != Routes.matchDetail) return;

    MatchEntity? matchEntity =
        DataStoreController.to.getMatchById(detailState.mId);
    if (matchEntity?.mmp == "999" ||
        ![
          SportData.sportMs_0,
          SportData.sportMs_1,
          SportData.sportMs_2,
          SportData.sportMs_7,
          SportData.sportMs_10,
          SportData.sportMs_110
        ].contains(matchEntity?.ms)) {
      detailState.eventSwitchLock = true;
      // 查找参数 1:赛事列表(非滚球:今日 早盘...) 2:赛事详情(滚球) 3:赛事筛选 4:赛事搜索(int) 如果不传默认 1:赛事列表
      String sm = "2";
      // 菜单ID 多个用逗号分割(字符串)
      String euid = TyHomeController.to.homeState.matchListReq.euid;
      // 早盘日期的参数 早盘 和 串关都要加 (字符串)
      // md: state_data.get_md != -1 ? state_data.get_md : "",
      // 赛事种类id
      String csid = matchEntity?.csid ?? "0";
      // 联赛id
      String tid = matchEntity?.tid ?? "0";
      // 排序 int 类型 1按热门排序 2按时间排序(整型)
      String sort = "1";
      // 搜索关键词 赛事搜索(字符串)
      String keyword = '';
      // 用户id或者uuid
      String cuid = TYUserController.to.getUid();
      String mid = matchEntity?.mid ?? "0";
      MatchDetailApi.instance()
          .getDetailVideo(sm, euid, csid, tid, sort, keyword, cuid, mid)
          .then((value) async {
        if (value.success && !isClosed) {
          if (ObjectUtil.isNotEmpty(value.data?.mid) &&
              ObjectUtil.isNotEmpty(value.data?.csid)) {
            // 普通赛事跳电竞赛事，或者电竞赛事跳普通赛事，就需要重置菜单类型
            bool flag1 = [
              SportData.sportCsid_100,
              SportData.sportCsid_101,
              SportData.sportCsid_103
            ].contains(int.tryParse(value.data!.csid));
            bool flag2 = [
              SportData.sportCsid_100,
              SportData.sportCsid_101,
              SportData.sportCsid_103
            ].contains(int.tryParse(csid));
            if (flag1 != flag2) {
              if (flag1) {
                detailState.isDJDetail = true;
              } else {
                detailState.isDJDetail = false;
              }
            }

            // 重新调用 赛事详情页面接口 已包含所有接口请求
            await fetchMatchDetailData(
                mId: value.data?.mid, initCategoryList: true);
            // useMittEmit(MITT_TYPES.EMIT_REF_API);
          } else {
            // 没有返回赛事数据就跳转到列表页
            print("赛事切换->没有返回赛事数据->退回列表页");
            backHome();
          }
        }
        detailState.eventSwitchLock = false;
      }).catchError((e) {
        detailState.eventSwitchLock = false;
      });
    }
  }
}
