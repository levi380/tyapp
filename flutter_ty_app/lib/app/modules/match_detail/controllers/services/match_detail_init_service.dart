import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import '../../../../global/data_store_controller.dart';
import '../../../../utils/systemchrome.dart';
import '../match_detail_controller.dart';
import '../../extension/detail_api_service.dart';
import '../../extension/detail_bus_extension.dart';
import '../../extension/detail_tab_extension.dart';
import '../../extension/detail_throttle_extension.dart';
import '../../extension/webview_extension.dart';

/**
 * 详情初始化服务类
 * 负责处理详情控制器的初始化和清理逻辑
 */
class MatchDetailInitService {
  /**
   * 初始化控制器
   * 处理路由参数、初始化状态、设置监听等
   * 
   * @param controller 详情控制器
   */
  static void init(MatchDetailController controller) {
    DataStoreController.to.isEnterDatail = true;

    // 列表进入
    if (Get.arguments is Map) {
      final arguments = Get.arguments as Map<String, dynamic>;
      final Map<String, dynamic>? args = arguments;

      // 使用解构和空值合并简化参数提取
      final mid = args?['mid'] ?? ''; // 赛事ID
      final csid = args?['csid'] ?? ''; // 联赛ID
      final playId = args?['playId'] ?? ''; // 次要玩法playId
      final pids = args?['pids'] ?? ''; // 次要玩法玩法集
      final isESports = args?['isESports'] ?? false; // 电竞进入

      // 批量设置状态
      final state = controller.detailState;
      if (mid.isNotEmpty) {
        state.mId = mid;
        controller.pushMid(mid);
      }
      if (csid.isNotEmpty) state.csid = csid;
      if (playId.isNotEmpty) state.playId = playId;
      if (pids.isNotEmpty) state.pids = pids;

      state.isDJDetail = isESports;

      // 从数据仓库获取数据
      state.match = DataStoreController.to.getMatchById(mid);
      if (state.match != null) {
        state.detailLoading = false;
        controller.fetchOutrightDisplayMatchs();
      }
    } else {
      // 赛果、vr体育
    }

    // 初始化赛事分析tab
    controller.setTabController();
    controller.initBus(); // ws 监听初始化
    controller.initWebView();
    controller.initThrottle(); // 节流
    controller.fetchPlayTopList(); // 置顶数据
    controller.initFullGuide(); // 初始化全屏投注引导
  }

  /**
   * 清理资源
   * 取消监听、释放控制器、清理WebView等
   * 
   * @param controller 详情控制器
   */
  static void close(MatchDetailController controller) {
    DataStoreController.to.isEnterDatail = false;
    controller.disposeBus();
    controller.detailState.tabController?.dispose();
    controller.detailState.scrollController.dispose();
    // detailState.gifController?.dispose();
    // 取消所有节流器
    controller.detailState.throttleCategoryList.cancel();
    controller.detailState.throttleCategoryListSubject.close();
    controller.detailState.throttleOddsInfo.cancel();
    controller.detailState.throttleOddsInfoSubject.close();
    controller.detailState.throttleOddsInfoWithOneSecond.cancel();
    controller.detailState.throttleOddsInfoSubjectWithOneSecond.close();

    // 取消定时器
    controller.detailState.analysisTimer?.cancel();
    controller.detailState.analysisTimer = null;
    // 清理WebView
    try {
      controller.detailState.webViewController.loadRequest(Uri.parse('about:blank'));
      controller.sendMessage({"cmd": 'destroy_video'});

      controller.detailState.webViewController.clearCache();
      controller.detailState.webViewController.clearLocalStorage();
    } catch (e) {}

    /// 退出详情页面恢复竖屏 防止横屏时左滑
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 进详情状态栏颜色改变，退出时恢复
    SystemUtils.isDarkMode(controller.detailState.isDarkMode);
  }
}

