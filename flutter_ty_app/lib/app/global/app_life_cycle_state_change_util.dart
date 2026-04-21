import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';
import '../modules/vr/vr_sport_detail/import_head.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-e72477e4-056c-4054-97ac-12b67ca7ccd5-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  全局状态监听工具类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全局状态监听工具类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设备前后台切换 状态处理
    ```
    ///前台
    resumed() {
    ///取消后台计数器
    cancelBackTimer();
    if (backHome == true) {
    ///回到首页
    Get.until((route) => route.settings.name == Routes.mainTab);
    }
    isResumed = true;
    if (AppWebSocket.channel == null) {
    AppWebSocket.connect();
    }

    ///激活接口
    activeApi();
    cancelTime();
    instance().wsTimer =
    Timer.periodic(const Duration(milliseconds: 4000), (timer) {

    if(AppWebSocket.channel != null){

    ///赛事订阅

    ///=============================== 新玩法級賠率推送樣式  1：新样式  不传：老样式  ===================///
    // AppWebSocket.instance().skt_send_initiative_push({});
    ///===============================  ===================///
    AppWebSocket.instance().skt_send_menu();
    AppWebSocket.instance().skt_send_initiative_push({});
    AppWebSocket.instance().sktSendMatchStatus();
    AppWebSocket.instance().skt_send_switch();
    AppWebSocket.instance()
    .sktSendOrder({'cuid': TYUserController.to.getUid()});
    }

    // AppWebSocket.instance().skt_send_bat_handicap_odds_c118();
    });
    }

    ///后台
    paused() {
    backHome = false;
    startTimer();
    isResumed = false;

    ///取消接口
    cancelApi();
    cancelTime();
    AppWebSocket.unsubscribe();
    AppWebSocket.closeSocket();
    }
    ```
    - ws定时器订阅
    ```
    ///前台
    resumed() {
    ///取消后台计数器
    cancelBackTimer();
    if (backHome == true) {
    ///回到首页
    Get.until((route) => route.settings.name == Routes.mainTab);
    }
    isResumed = true;
    if (AppWebSocket.channel == null) {
    AppWebSocket.connect();
    }

    ///激活接口
    activeApi();
    cancelTime();
    instance().wsTimer =
    Timer.periodic(const Duration(milliseconds: 4000), (timer) {

    if(AppWebSocket.channel != null){

    ///赛事订阅

    ///=============================== 新玩法級賠率推送樣式  1：新样式  不传：老样式  ===================///
    // AppWebSocket.instance().skt_send_initiative_push({});
    ///===============================  ===================///
    AppWebSocket.instance().skt_send_menu();
    AppWebSocket.instance().skt_send_initiative_push({});
    AppWebSocket.instance().sktSendMatchStatus();
    AppWebSocket.instance().skt_send_switch();
    AppWebSocket.instance()
    .sktSendOrder({'cuid': TYUserController.to.getUid()});
    }

    // AppWebSocket.instance().skt_send_bat_handicap_odds_c118();
    });
    }
    ```
    - 全局网络状态监听
    ```
    ///全局网络状态监听
    void onNetworkChanged() {
    Connectivity().onConnectivityChanged.listen((connectionState) {
    switch (connectionState) {
    case ConnectivityResult.wifi:
    case ConnectivityResult.mobile:
    if(noNetwork){
    AppLogger.debug('恢复网络');
    }
    noNetwork = false;
    break;
    case ConnectivityResult.none:
    if(!noNetwork  && isResumed ){
    AppLogger.debug('无网络');
    // Get.snackbar(
    //   LocaleKeys.app_h5_cathectic_kind_tips.tr,
    //   LocaleKeys.common_no_network.tr,
    //   colorText: Colors.white,
    //   snackPosition: SnackPosition.TOP,
    // );
    noNetwork = true;
    }

    break;
    case ConnectivityResult.bluetooth:
    // TODO: Handle this case.
    case ConnectivityResult.ethernet:
    // TODO: Handle this case.
    case ConnectivityResult.vpn:
    // TODO: Handle this case.
    case ConnectivityResult.other:
    // TODO: Handle this case.
    }
    });
    }
    ```
    】】】
 *
 */
class AppLifecycleStateChangeUtil {
  static AppLifecycleStateChangeUtil? _instance;

  static AppLifecycleStateChangeUtil instance() {
    _instance ??= AppLifecycleStateChangeUtil._();
    remainTime = remain;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    return _instance!;
  }

  static final StreamController<int> _streamController = StreamController();

  static bool noNetwork = false;

  ///记录当前的时间
  static int remainTime = 0;
  static int remain = 15 * 60;
  static bool isResumed = false;
  static bool backHome = false;

  AppLifecycleStateChangeUtil._() {}
  Timer? wsTimer;
  Timer? backTimer;

  ///后台半小时 进行资源回收
  startTimer() {
    backTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainTime -= 1;

      ///如果计完成取消定时
      if (remainTime <= 0) {
        backHome = true;
        remainTime = 0;
        cancelBackTimer();
      }

      ///流数据更新
      _streamController.sink.add(remainTime);
    });
  }

  ///前台
  resumed() {
    ///取消后台计数器
    cancelBackTimer();
    if (backHome == true) {
      ///回到首页
      Get.until((route) => route.settings.name == Routes.mainTab);
    }
    isResumed = true;
    if (AppWebSocket.channel == null) {
      AppWebSocket.connect();
    }

    ///激活接口
    activeApi();
    cancelTime();
    instance().wsTimer =
        Timer.periodic(const Duration(milliseconds: 4000), (timer) {
      if (AppWebSocket.channel != null) {
        ///赛事订阅

        ///=============================== 新玩法級賠率推送樣式  1：新样式  不传：老样式  ===================///
        // AppWebSocket.instance().skt_send_initiative_push({});
        ///===============================  ===================///
        ///添加优惠盘口赔率订阅
        AppWebSocket.instance().skt_send_discounts();
        AppWebSocket.instance().skt_send_menu();
        AppWebSocket.instance().skt_send_initiative_push({});
        AppWebSocket.instance().sktSendMatchStatus();
        AppWebSocket.instance().skt_send_switch();
        // 赛事分析玩法数据
        // AppWebSocket.instance().analysis_trend_switch(true);
        AppWebSocket.instance()
            .sktSendOrder({'cuid': TYUserController.to.getUid()});
        AppWebSocket.instance()
            .skt_fireworks_edit_send({'cuid': TYUserController.to.getUid()});
      }

      // AppWebSocket.instance().skt_send_bat_handicap_odds_c118();
    });
  }

  ///后台
  paused() {
    backHome = false;
    startTimer();
    isResumed = false;

    ///取消接口
    cancelApi();
    cancelTime();
    AppWebSocket.unsubscribe();
    AppWebSocket.closeSocket();
  }

  ///不活跃
  inactive() {}

  ///隐藏
  hidden() {
    cancelTime();
  }

  ///前台激活接口
  void activeApi() {
    if (Get.currentRoute == Routes.mainTab) {
      // 每次切换球种和菜单都会走到这里，有点奇怪，先去掉
      // if(Get.isRegistered<MainTabController>() && Get.isRegistered<TyHomeController>(tag:MainTabController.to.uuid)) {
      //   // TyHomeController.to.fetchData(isWsFetch: true);
      // }
    } else if (Get.currentRoute == Routes.matchDetail) {
      // ///详情需要激活接口
      // MatchDetailController detailController =
      //     Get.find<MatchDetailController>();
      // detailController.refreshData();
    }
    if (Get.isRegistered<ShopCartController>()) {
      ShopCartController.to.refreshData();
    }
  }

  ///前台取消接口
  void cancelApi() {
    if (Get.currentRoute == Routes.mainTab) {
    } else if (Get.currentRoute == Routes.matchDetail) {}
  }

  ///定时器取消
  cancelTime() {
    if (wsTimer != null) {
      wsTimer?.cancel();
      wsTimer = null;
    }
  }

  cancelBackTimer() {
    backTimer?.cancel();
    backTimer = null;
  }

  ///全局网络状态监听
  void onNetworkChanged() {
    Connectivity().onConnectivityChanged.listen((connectionState) {
      switch (connectionState[0]) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          if (noNetwork) {
            // AppLogger.debug('恢复网络');
          }
          noNetwork = false;
          break;
        case ConnectivityResult.none:
          if (!noNetwork && isResumed) {
            // AppLogger.debug('无网络');
            // Get.snackbar(
            //   LocaleKeys.app_h5_cathectic_kind_tips.tr,
            //   LocaleKeys.common_no_network.tr,
            //   colorText: Colors.white,
            //   snackPosition: SnackPosition.TOP,
            // );
            noNetwork = true;
          }

          break;
        case ConnectivityResult.bluetooth:
        // TODO: Handle this case.
        case ConnectivityResult.ethernet:
        // TODO: Handle this case.
        case ConnectivityResult.vpn:
        // TODO: Handle this case.
        case ConnectivityResult.other:
        // TODO: Handle this case.
        case ConnectivityResult.satellite:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    });
  }
}
