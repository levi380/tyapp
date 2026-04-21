import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/app_life_cycle_state_change_util.dart';
import 'package:flutter_ty_app/app/global/assets/webview_cache.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/services/models/res/fireworks_activity_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import '../../../main.dart';
import '../../config/getx_navigation.dart';

import '../../config/page_stay_record/page_stay_tracker.dart';
import '../../services/models/res/query_league_template_list_entity.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../dj/controllers/dj_controller.dart';
import '../home/controllers/match_expand_controller.dart';
import '../setting_menu/setting_menu_controller.dart';
import '../shop_cart/shop_cart_controller.dart';
import 'main_tab_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE APP底部菜单 控制器 MainTabController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP底部菜单 控制器 MainTabController
    - MainTabController
    ```
    ///烟花类型
    RxInt fireworksType = 1.obs;

    ///播放几次
    RxInt fireworksNumber = 3.obs;

    ///冠军名称
    RxString championName = "".obs;

    ///冠军图标
    RxString championIcon = "".obs;

    ///开始时间
    RxInt beginTime = 0.obs;

    ///结束时间
    RxInt endTime = 0.obs;

    ///唯一ID
    RxInt fireworksId = 0.obs;

    ///是否播放
    RxBool isFireworksPaly = false.obs;
    late FireworksActivityEntity activityEntity;

    ///打开蛇年图标开关
    RxBool isNewYearSwitch = false.obs;

    ///年报 状态变量
    bool isNearEdge = false;


    ///年报 拖动位置
    Offset position = Offset(0, 0);

    ///足球篮球 拖动位置
    Offset footballBasketballTemplatePosition = Offset(0, 0);

    bool footballBasketballTemplateIsNearEdge = false;

    ///篮球足球运营模版接口
    late List<QueryLeagueTemplateListData> queryLeagueTemplateListData = [];
    ```
    】】】
 *
 */
class MainTabController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  ///兜底逻辑 添加put注册判断
  static MainTabController get to {
    if (Get.isRegistered<MainTabController>()) {
      return Get.find<MainTabController>();
    } else {
      //return Get.put(MainTabController());  //这样会导致MainTabController不释放，应该查哪里非法调用了MainTabController.to
      return MainTabController();
    }
  }
  final MainTablogic logic = MainTablogic();
  int currentIndex = 0;
  late AnimationController animationController;
  late Animation animation;

  ///活动开关
  late bool dailyActivities = false;
  bool tyLogouted = false;
  bool tyLogined = false;
  String uuid = createGcuuid();

  bool rightMenu = false;

  late Animation<double> scaleAnimation;
  late Animation scaleCurve;

  PageController pageController = PageController();
  int currentPage = 0;
  Timer? pageTimer;

  ///烟花类型
  RxInt fireworksType = 1.obs;

  ///播放几次
  RxInt fireworksNumber = 3.obs;

  ///冠军名称
  RxString championName = "".obs;

  ///冠军图标
  RxString championIcon = "".obs;

  ///开始时间
  RxInt beginTime = 0.obs;

  ///结束时间
  RxInt endTime = 0.obs;

  ///唯一ID
  RxInt fireworksId = 0.obs;

  ///是否播放
  RxBool isFireworksPaly = false.obs;
  late FireworksActivityEntity activityEntity;

  ///打开蛇年图标开关
  RxBool isNewYearSwitch = false.obs;

  ///年报 状态变量
  bool isNearEdge = false;

  ///年报 拖动位置
  Offset position = Offset(
    MediaQuery.of(Get.context!).size.width - 90,
    MediaQuery.of(Get.context!).size.height - 430,
  );


  ///足球篮球 状态变量
  bool isZNearEdge = false;

  ///足球篮球 拖动位置
  Offset footballBasketballTemplatePosition = Offset(0, 0);

  bool footballBasketballTemplateIsNearEdge = false;

  ///篮球足球运营模版接口
  late List<QueryLeagueTemplateListData> queryLeagueTemplateListData = [];
  late List<QueryLeagueTemplateListData> queryLeagueTemplateListDatas = [];

  late String userId;

  ///未结注单是否打开
  bool isOngoingBetsOpen = false;

  @override
  void onInit() {
    ///sdk/APP 初始化  优先添加商户调用标记
    setUserMark();
    ///优先获取本地存储的时区
    TimeZoneUtils.zoneIndex = IntKV.timeZone.get() ?? TimeZoneUtils.zoneIndex;

    ///春节活动装饰开关
    if (springAdornSwitch) {
      // AppLogger.debug("springAdornSwitch:${res.data?.springAdornSwitch}");
      isNewYearSwitch.value =
          TYUserController.to.userInfo.value?.springAdornSwitch == "1"
              ? true
              : false;
    }

    ///初始化 刷新动画
    iconRefresh();
    super.onInit();

    ///初始化Websocket
    initWebsocket();

    ///活动开关
    initActivity();

    Future.delayed(const Duration(seconds: 20), () {
      WidgetsBinding.instance.addObserver(this);
      ///网络监听
      // AppLifecycleStateChangeUtil.instance().onNetworkChanged();
    });

    Bus.getInstance().on(EventType.tyLogined, (value) {
      if (!tyLogined) {
        //避免重复事件
        tyLogined = true;

        //value为数组，第一个是H5跳转地址，第二个env
        if (value is Map) {
          h5ulr = value['url'] ?? '';
          h5Env = value['env'] ?? '';
          //Get.offAllNamed(Routes.home);
          if (isSDK) {
            //调用SDK的三方也使用Getx，这里需使用navigatorStateKey
            Get_TY.navigatorStateKeyDB!.currentState!.pushNamedAndRemoveUntil(
              Routes.home,
              (Route<dynamic> route) => false,
            );
            /* 在MainTabController的onReady里面执行
                .then((value) {
              ///跳转后更新收藏状态
              CollectionController.to.updateCollection();
              CollectionController.to.fetchCollectionCount();
            });
            */
          } else {
            //需要offAllNamed以删除旧MainTab
            Get.offAllNamed(Routes.home);
            /*在MainTabController的onReady里面执行
            ?.then((value) {
              ///跳转后更新收藏状态
              CollectionController.to.updateCollection();
              CollectionController.to.fetchCollectionCount();
            });
            */
          }
        }
      }
    });
    ///sdk接收外部的退出事件
    /// app 在设置菜单-退出做了刷新
    Bus.getInstance().on(EventType.tyLogout, (value) async {
      if (!tyLogouted) {
        //避免重复事件
        tyLogouted = true;

        h5ulr = '';

        TYUserController.to.userInfo.value = null;
        ShopCartController.to.clearData();
        CollectionController.to.clearCollection();

        ///退出登录 关闭ws
        AppWebSocket.unsubscribe();
        AppWebSocket.closeSocket();
        StringKV.sessionId.remove();
        //String baseUrl = StringKV.baseUrl.get()!;
        await dbClear();
        //AppDio.getInstance().setApiDomainForNoToken(baseUrl);
        //Get.offAllNamed(Routes.home);
        if (isSDK) {
          //调用SDK的三方也使用Getx，这里需使用navigatorStateKey
          Get_TY.navigatorStateKeyDB!.currentState!.pushNamedAndRemoveUntil(
            Routes.home,
            (Route<dynamic> route) => false,
          );
        } else {
          //需要offAllNamed以删除旧MainTab
          Get.offAllNamed(Routes.home);
        }
      }
    });
    Bus.getInstance().on(EventType.changeLang, (value) {
      // 菜单中 活动的显示
      SettingMenuController.to.setShowActivity();
      // tab 中活动的显示
      MainTabController.to.setShowActivity();
      //清除购物车数据
      ShopCartController.to.clearData();
    });

    ///锚点 页面停留时长统计 q3需求
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ///页面停留时长 开启
    //   PageStayTracker.instance.init();
    //   PageStayTracker.instance.reportLoadingTime();
    // });

  }

  @override
  void onReady() {
    super.onReady();
    initData();
    CollectionController.to.updateCollection();
    CollectionController.to.fetchCollectionCount();
    Future.delayed(Duration(seconds: 2), () {
      ///专题页接口
      queryLeagueTemplateList();
    });
  }

  ///app状态监控
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:

      /// 应用程序前台
      // if (kDebugMode) {
      //   AppLogger.debug('App应用程序前台');
      // }
        AppLifecycleStateChangeUtil.instance().resumed();

        break;
      case AppLifecycleState.inactive:

      /// 应用程序在前台不活跃
        AppLifecycleStateChangeUtil.instance().inactive();
        break;
      case AppLifecycleState.paused:
        //appStorage.save();

        /// 应用程序后台
        if (kDebugMode) {
          AppLogger.debug('App应用程序后台');
        }
        AppLifecycleStateChangeUtil.instance().paused();
        break;
      case AppLifecycleState.detached:
        //appStorage.save();
        /// 应用程序未被挂载
        break;
      case AppLifecycleState.hidden:

      /// 应用程序隐藏
        AppLifecycleStateChangeUtil.instance().hidden();
        break;
    }
  }

  @override
  void onClose() {
    AppWebSocket.closeSocket();
    Bus.getInstance().off(EventType.tyLogined);
    Bus.getInstance().off(EventType.tyLogout);
    Bus.getInstance().off(EventType.changeLang);
    pageTimer?.cancel();
    PageStayTracker.instance.dispose();
    super.onClose();
  }

  /// 设置商户调用标记
  setUserMark() async {
    int retryCount = 0;

    /// 最大重试次数
    const int maxRetries = 20;

    /// 重试间隔时间
    const Duration retryDelay = Duration(seconds: 2);

    while (retryCount < maxRetries) {
      try {
        var value = await AccountApi.instance().save('sdk');
          if(value.success){
            // AppLogger.debug('用户标识接口请求成功');
            break;
          }else{
            retryCount++;
            // AppLogger.debug('请求失败，${retryDelay.inSeconds}秒后重试...');
            /// 延迟1s重试
            await Future.delayed(retryDelay);
          }

      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          // AppLogger.debug('达到最大重试次数，请求失败');
          break;
        }
        // AppLogger.debug('请求失败，${retryDelay.inSeconds}秒后重试...');
        /// 延迟1s重试
        await Future.delayed(retryDelay);
      }
    }
  }

  ///刷新
  void refreshMenu() {
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    if (dailyActivities == true) {
      Get.toNamed(Routes.dailyActivities);
    } else {
      animationController.forward();
      if (Get.currentRoute == Routes.DJView) {
        DJController.to.getDateList();
      } else if (Get.currentRoute == Routes.vrHomePage) {
      } else {
        FoldMatchManager.clearHidsMore();
        FoldMatchManager.clearHids();

        /// 74454 【UAT】【赔率变动拒单逻辑优化】SDK-商户后台切换了选项，需要退出重新登录才跟着切换
        /// 刷新添加刷新用户配置
        EventBus().fire(EventType.refreshHome);
        TYUserController.to.refreshUserInfo(isRefresh: true);
        TyHomeController.to.fetchData(isWsFetch: true);

        ///判断是否登录
        if (RouteCheckUtil.checkNoLoginAndGoToLogin()) {
          /// 预加载webview
          WebviewCacheController.to.cache.clear();
          WebviewCacheController.to.getRule();
        }
      }
    }
  }

  ///初始化数据
  void initData() {
    if (Get.context != null) {
      position = Offset(
        MediaQuery.of(Get.context!).size.width - 90,
        MediaQuery.of(Get.context!).size.height - 430,
      );

      footballBasketballTemplatePosition = Offset(
        MediaQuery.of(Get.context!).size.width - 130,
        MediaQuery.of(Get.context!).size.height -
            (bottomHideSwitch == true ? 500 : 160),
      );
    }
    dailyActivities = BoolKV.dailyActivities.get() ?? false;
    update(['dailyActivities']);

    ///本地持久化存储  字号大小选择的
    bool isBiggerSize = BoolKV.isBiggerSize.get() ?? false;
    if (isBiggerSize) {
      TyTextScaler.instance()
          .setTextScaleFactor(TyTextScaler.biggerScaleFactor);
    } else {
      TyTextScaler.instance()
          .setTextScaleFactor(TyTextScaler.defaultScaleFactor);
    }
    // getUserInfo();
  }

  ///底部菜单icon 刷新旋转
  void iconRefresh() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }
}
