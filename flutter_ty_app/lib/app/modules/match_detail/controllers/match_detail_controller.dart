
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_analysis_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_api_service.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_bus_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_tab_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_throttle_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/match_video/match_video_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/webview_extension.dart';
import 'package:flutter_ty_app/app/routes/route_manager.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../db/app_cache.dart';
import '../../../global/data_store_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../services/models/res/category_list_entity.dart';

import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/systemchrome.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';

import '../../shop_cart/shop_cart_controller.dart';
import '../constants/detail_constant.dart';
import '../models/header_type_enum.dart';
import '../states/match_detail_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-49352840-6abc-4f32-8478-6da0de121978 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 详情控制器层主要操作方法
    - 包含常规赛事详情、电竞详情。vr详情投注列表、赛果详情赛果列表
    - 初始化以及销毁逻辑回调
    】】】
 *
 */
class MatchDetailController extends GetxController
    with GetTickerProviderStateMixin {
  // 通过外部注入tag 全部的控制器都需要加上tag
  MatchDetailController({required String tag}) {
    detailState.tag = tag;
  }

  MatchDetailState detailState = MatchDetailState();

  @override
  void onInit() {
    // PerfMonitor().startSection("详情主列表");
    _init();
    super.onInit();
  }

  @override
  void onReady() {
    fetchData(changeSelect: true);
    super.onReady();
    FireworksController.to.getFireworksActivity();
  }

  @override
  void onClose() async {
    // await PerfMonitor().endSection("详情主列表");
    _close();
    super.onClose();
  }

  /**
   * 初始化控制器
   * 处理路由参数、初始化状态、设置监听等
   */
  _init() {
    DataStoreController.to.isEnterDatail = true;

    // 列表进入
    if (Get.arguments is Map) {
      final arguments = Get.arguments as Map<String, dynamic>;
      final Map<String, dynamic>? args = arguments;

      // 使用解构和空值合并简化参数提取
      final mid = args?['mid'] ?? ''; // 赛事ID
      final csid = args?['csid'] ?? ''; // 联赛ID
      final playId = args?['playId'] ?? ''; // 次要玩法playId
      final cid = args?['cid'] ?? ''; // 玩法集ID 跳转对应玩法集
      final pids = args?['pids'] ?? ''; // 次要玩法玩法集
      final isESports = args?['isESports'] ?? false; // 电竞进入

      // 批量设置状态
      final state = detailState;
      if (mid.isNotEmpty) {
        state.mId = mid;
        pushMid(mid);
      }
      if (csid.isNotEmpty) state.csid = csid;
      if (playId.isNotEmpty) state.playId = playId;
      if (cid.isNotEmpty) state.cid = cid;
      if (pids.isNotEmpty) state.pids = pids;

      state.isDJDetail = isESports;

      // 从数据仓库获取数据
      state.match = DataStoreController.to.getMatchById(mid);
      if (state.match != null) {
        state.detailLoading = false;
        fetchOutrightDisplayMatchs();
      }
    } else {
      // 赛果、vr体育
    }

    // 初始化赛事分析tab
    setTabController();
    initBus(); // ws 监听初始化
    initWebView();
    initThrottle(); // 节流
    fetchPlayTopList(); // 置顶数据
    initFullGuide(); // 初始化全屏投注引导
  }

  /**
   * 清理资源
   * 取消监听、释放控制器、清理WebView等
   */
  _close() {
    DataStoreController.to.isEnterDatail = false;
    disposeBus();
    detailState.tabController?.dispose();
    detailState.scrollController.dispose();
    // detailState.gifController?.dispose();
    // 取消所有节流器
    detailState.throttleCategoryList.cancel();
    detailState.throttleCategoryListSubject.close();
    detailState.throttleOddsInfo.cancel();
    detailState.throttleOddsInfoSubject.close();
    detailState.throttleOddsInfoWithOneSecond.cancel();
    detailState.throttleOddsInfoSubjectWithOneSecond.close();

    // 取消定时器
    detailState.analysisTimer?.cancel();
    detailState.analysisTimer = null;
    // 清理WebView
    try {
      detailState.webViewController.loadRequest(Uri.parse('about:blank'));
      sendMessage({"cmd": 'destroy_video'});

      detailState.webViewController.clearCache();
      detailState.webViewController.clearLocalStorage();
    } catch (e) {}

    /// 退出详情页面恢复竖屏 防止横屏时左滑
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 进详情状态栏颜色改变，退出时恢复
    SystemUtils.isDarkMode(detailState.isDarkMode);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 添加赛事id到详情访问赛事池
      】】】
   *
   */
  pushMid(String mId) {
    if (!detailState.mIds.contains(mId)) {
      detailState.mIds.add(mId);
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 刷新 主要接口：详情主接口、玩法集、投注列表
      】】】
   *
   */
  refreshData() {
    fetchMatchDetailData();
    fetchCategoryList();
    refreshOddsInfoData(refresh: true, noLoading: true);
    // 赛事分析开关
    initAnalysisSwitch();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 联赛选择修改赛事
      】】】
   *
   */
  selectChangeMatch(String newMId) {
    // 不同赛事才更新数据
    if (newMId != detailState.mId) {
      // fetchMatchDetailData(mId: newMId, changeSelect: true);
      // backHome();
      RouteManager.replaceMatchDetail(
        mid: newMId,
        csid: detailState.csid,
        isESports: detailState.isDJDetail,
      );
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 赛事变更重置
      - 1、赛事变更重置玩法集tab 投注数据 视频链接
      - 2、修改赛事id
      - 3、赛事变更 关闭视频
      - 4、头部类型重置为HeaderType.normal
      - 5、触发详情页页面初始化BUS Bus.getInstance().emit(EventType.matchTimeInit, null);
      】】】
   *
   */
  resetMatch(String mId) {
    // 赛事变更重置玩法集tab 投注数据 视频链接
    detailState.mId = mId;

    // 赛事变更 关闭视频
    detailState.videoUrl = "";
    detailState.animationUrl = "";
    try {
      // InAppWebViewController.clearAllCache();
      detailState.webViewController.clearCache();
      detailState.webViewController.clearLocalStorage();
      // 关闭页面还在播放声音解决方法
      detailState.webViewController.loadRequest(Uri.parse('about:blank'));
    } catch (e) {
      print("InAppWebViewController = $e");
    }
    detailState.liveLoading.value = true;
    detailState.headerType.value = HeaderType.normal;
    sendMessage({"cmd": 'destroy_video'});
    detailState.isOpenVideoInfo.value = false;
    fullscreen(false);

    // 投注数据重置
    detailState.curCategoryTabId = "0";
    detailState.categoryList = [
      CategoryListData.fromJson({
        "id": "0",
        "marketName": LocaleKeys.app_play_category.tr,
        "orderNo": -2147483648
      }),
    ];
    if (detailState.isAppreciationOddsOpen == true) {
      detailState.categoryList.add(CategoryListData.fromJson({
        "id": "1",
        "marketName": LocaleKeys.discount_odd_odds_value_increase.tr,
        "orderNo": -2147483641
      }));
    }
    detailState.oddsInfoList.clear();
    detailState.oddsInfoIsNoData = true;
    // 切换赛事 置顶数据更新
    // initHton();
    // 玩法tab更新
    fetchCategoryList();
    // 投注数据拉取
    refreshOddsInfoData(refresh: true);

    100.milliseconds.delay(() {
      // 触发详情页页面初始化
      Bus.getInstance().emit(EventType.matchTimeInit, null);
    });

    // 清空冠军引导盘数据
    detailState.championMatchs.clear();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 返回逻辑：打开动画和视频时返回详情，详情时退出页面
      】】】
   *
   */
  back() {
    if (detailState.headerType.value == HeaderType.normal) {
      backHome();
    } else {
      try {
        detailState.webViewController.clearCache();
        detailState.webViewController.clearLocalStorage();
        // HeaderType headerType = detailState.headerType.value;
        sendMessage({"cmd": 'destroy_video'});
        // 关闭页面还在播放声音解决方法
        detailState.webViewController.loadRequest(Uri.parse('about:blank'));
      } catch (e) {
        AppLogger.debug("返回关闭webView报错" + e.toString());
      } finally {
        detailState.headerType.value = HeaderType.normal;
        detailState.isOpenVideoInfo.value = false;
        // detailState.pinnedHeaderHeight.value = statusBarHeight + obtyAppbarHeight;
        detailState.pinnedHeaderHeight.value = detailState.obtyHeaderHeight;
        fullscreen(false);

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        update();
      }
    }
  }

  backHome() {
    if (Get.currentRoute == Routes.matchDetail ||
        ShopCartController.to.state.currentRoute == Routes.matchDetail) {
      Get.back(result: detailState.mIds);
    }
  }

  // 关盘
  closeOrder() {
    detailState.oddsInfoIsNoData = true;
    update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
  }

  // 是否支持快速投注
  void initFullGuide() {
    detailState.isShowBetGuide.value = BoolKV.quickBetting.get() ?? false;
  }

  // 计算一键回顶部
  void calShowTop(ScrollNotification notification) {
    double pixels = notification.metrics.pixels.roundToDouble();

    if (pixels == 0 &&
        detailState.showTopBtn.value &&
        !detailState.appbarPinned.value) {
      detailState.showTopBtn.value = false;
    }

    if (notification is ScrollUpdateNotification &&
        notification.metrics.axis == Axis.vertical &&
        pixels != 0) {
      final currentOffset = notification.metrics.pixels;
      final shouldShow = currentOffset > 0.25.sh;

      // 添加防抖逻辑，避免频繁状态更新 置顶时 才有可能需要滚动条
      if (shouldShow != detailState.showTopBtn.value &&
          detailState.appbarPinned.value) {
        detailState.showTopBtn.value = shouldShow;
      }
    }
  }

  // 计算置顶标志
  void calAppbarPin(ScrollNotification notification) {
    // 头部固定
    double offset = detailState.scrollController.offset.roundToDouble() -
        (detailState.obtyHeaderHeight - detailState.pinnedHeaderHeight.value)
            .roundToDouble();

    if (detailState.scrollController.hasClients &&
        offset >= 0 &&
        !detailState.appbarPinned.value) {
      detailState.appbarPinned.value = true;
    }

    if (detailState.scrollController.hasClients &&
        offset < 0 &&
        detailState.appbarPinned.value) {
      detailState.appbarPinned.value = false;
    }
  }
}
