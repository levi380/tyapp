import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/utils/image_util.dart';

import '../../config/app_logger/app_logger.dart';
import '../../config/analytic/analytics_utils.dart';
import 'main_tab_controller.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_view.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/settled_cp_bets_logic.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import '../../../main.dart';
import '../../config/getx_navigation.dart';
import '../../services/api/result_api.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/oss_util.dart';
import '../bet_ty_cp_zr/ty/bets/ty_bets_logic.dart';
import '../bet_ty_cp_zr/ty/bets/ty_bets_view.dart';
import '../cp/cp_setting_menu/cp_setting_menu_controller.dart';
import '../cp/cp_setting_menu/cp_setting_menu_view.dart';
import '../home/models/match_list_type.dart';
import '../quick_bet/quick_bet_controller.dart';
import '../setting_menu/setting_menu_controller.dart';
import '../settled_bets/cp/settled_cp_bets_view.dart';
import '../settled_bets/zr/settled_zr_bets_logic.dart';
import '../settled_bets/zr/settled_zr_bets_view.dart';
import '../zr/zr_setting_menu/zr_setting_menu_controller.dart';
import '../zr/zr_setting_menu/zr_setting_menu_view.dart';

extension MainTabControllerExt on MainTabController {
  ///底部菜单选择
  void logicToTargetPage(int index) {
    // 菜单切换型埋点
    Analytics.track(AnalyticsEvent.menu_sport_xxx,
        pagePath: '', clickTarget: (AnalyticsEvent.menu_sport_xxx).toString());
    switch (index) {
      case 0:

        ///跳转真人教程
        if (TyHomeController.to.homeState.listType == MatchListType.zr) {
          Get.toNamed(Routes.zRTutorial);
        } else if (TyHomeController.to.homeState.listType == MatchListType.cp) {
          ///跳转彩票教程
          Get.toNamed(Routes.cPBettingTutorial);
        } else {
          ///跳转赛果
          Get_TY.toNamed(Routes.matchResults);
        }
        break;
      case 1:

        ///设置
        openSettingsMenu();
        break;
      case 2:

        ///判断是否登录
        if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;

        ///3000真人 4000彩票  其他体育
        if (TyHomeController.to.homeState.listType == MatchListType.zr) {
          openZrOngoingBetsPage();
        } else if (TyHomeController.to.homeState.listType == MatchListType.cp) {
          openCPOngoingBetsPage();
        } else {
          openOngoingBetsPage();
        }
        break;
      case 3:

        ///判断是否登录
        if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;

        ///已结注单
        if (TyHomeController.to.homeState.listType == MatchListType.zr) {
          openZrClosedBetsPage();
        } else if (TyHomeController.to.homeState.listType == MatchListType.cp) {
          openCPClosedBetsPage();
        } else {
          openClosedBetsPage();
        }
        break;
      case 4:

        ///刷新
        refreshMenu();

        break;
    }
  }

  ///活动开关
  initActivity() {
    dailyActivities = TYUserController.to.isHaveActivity() &&
        BoolKV.dailyActivities.get() == true;
  }

  setShowActivity() {
    initActivity();
    update(['dailyActivities']);
  }

  ///打开设置
  openSettingsMenu() {
    SettingMenuController.to.onInit();

    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;

    ///真人菜单设置
    if (TyHomeController.to.homeState.listType == MatchListType.zr) {
      Get.lazyPut(() => ZrSettingMenuController());
      Get_TY.bottomSheet(
        isDismissible: false,
        const ZrSettingMenuPage(),
        isScrollControlled: true,
        barrierColor: Colors.black.withValues(alpha: 0.2),
      );
    } else if (TyHomeController.to.homeState.listType == MatchListType.cp) {
      ///彩票菜单设置
      Get.lazyPut(() => CpSettingMenuController());
      Get_TY.bottomSheet(
        isDismissible: false,
        const CpSettingMenuPage(),
        isScrollControlled: true,
        barrierColor: Colors.black.withValues(alpha: 0.2),
      );
    } else {
      ///默认设置菜单
      QuickBetController.to.isTempClose.value = true;
      Get.lazyPut(() => SettingMenuController());
      Get_TY.bottomSheet(
        const SettingMenuPage(),
        isScrollControlled: true,
        barrierColor: Colors.black.withValues(alpha: 0.2),
      ).then((e) {
        QuickBetController.to.isTempClose.value = false;
      });
    }
  }

  ///电竞菜单
  openDjSettingsMenu() {
    Get.lazyPut(() => SettingMenuController());
    Get_TY.bottomSheet(
      const SettingMenuPage(),
      isScrollControlled: true,
      barrierColor: Colors.black.withValues(alpha: 0.2),
    );
  }

  ///真人未结注单
  openZrOngoingBetsPage() {
    Get.lazyPut(() => SettledZrBetsLogic(0));
    Get.dialog(
      const settledZrBetsPage(
        settled: 0,
      ),
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );
  }

  ///真人已结注单
  openZrClosedBetsPage() {
    Get.lazyPut(() => SettledZrBetsLogic(1));
    Get.dialog(
      const settledZrBetsPage(
        settled: 1,
      ),
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );
  }

  ///彩票未结注单
  openCPOngoingBetsPage() {
    Get.lazyPut(() => SettledCpBetsLogic());
    Get.dialog(
      const settledCpBetsPage(
        settled: 0,
      ),
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );
  }

  ///彩票已结注单
  openCPClosedBetsPage() {
    Get.lazyPut(() => SettledCpBetsLogic());
    Get.dialog(
      const settledCpBetsPage(
        settled: 1,
      ),
      barrierColor: Colors.black.withValues(alpha: 0.5),
    );
  }

  ///未结注单
  openOngoingBetsPage() {
    Bus.getInstance().emit(EventType.tyOpenDialog);
    QuickBetController.to.isTempClose.value = true;
    isOngoingBetsOpen = true;
    Get.lazyPut(() => TyBetsLogic(0));
    Get.dialog(
      ///新版注单
      const TyBetsWidget(),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
    ).then((e) {
      QuickBetController.to.isTempClose.value = false;
      isOngoingBetsOpen = false;
    });

    ///旧版注单
    // Get.lazyPut(() => UnsettledBetsLogic());
    // Get.dialog(
    //   const UnsettledBetsPage(),
    //   barrierDismissible:false,
    //   barrierColor: Colors.black.withValues(alpha:0.5),
    // ).then((e) {
    //   QuickBetController.to.isTempClose.value = false;
    // });
  }

  ///已结注单
  openClosedBetsPage() {
    Bus.getInstance().emit(EventType.tyOpenDialog);
    QuickBetController.to.isTempClose.value = true;
    Get.lazyPut(() => TyBetsLogic(1));
    Get.dialog(
      ///新版注单
      const TyBetsWidget(),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
    ).then((e) {
      QuickBetController.to.isTempClose.value = false;
    });

    ///旧版注单
    // Get.lazyPut(() => SettledBetsLogic());
    // Get.dialog(
    //   const SettledBetsPage(),
    //   barrierDismissible:false,
    //   barrierColor: Colors.black.withValues(alpha:0.5),
    // ).then((e) {
    //   QuickBetController.to.isTempClose.value = false;
    // });
  }

  ///初始化长连接 和 数据仓库
  void initWebsocket() {
    String? token = StringKV.token.get();
    DataStoreController.to.initObj();

    ///SDK 未登录时 不链接ws
    if (!ObjectUtil.isEmptyString(token)) {
      AppWebSocket.setWebSocketUrl();
      AppWebSocket.connect();
    }
  }

  ///去欧洲杯专题页
  toEuropeanCup() {
    europeanCupSetting = true;
    Get.toNamed(Routes.europeanCup);
  }

  ///奥运会专题页
  toOlympicGames() {
    olympicGamesSetting = true;
    Get.toNamed(Routes.olympicGames);
  }

  ///右侧悬浮底部菜单
  onRightMenu() {
    rightMenu = !rightMenu;
    update();
  }

  ///年报入口拖拽
  onDragEnd(DraggableDetails details) {
    /// 计算新的位置
    double newX = details.offset.dx - 25;

    /// 调整偏移量
    double newY = details.offset.dy - 25;

    /// 获取屏幕尺寸
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double screenHeight = MediaQuery.of(Get.context!).size.height;

    /// 获取安全区边距
    EdgeInsets padding = MediaQuery.of(Get.context!).padding;
    double safeAreaTop = padding.top;
    double safeAreaBottom = padding.bottom;

    /// 限制图标不超出边界
    newX = newX.clamp(0.0, screenWidth - 60 - 10);
    newY = newY.clamp(safeAreaTop, screenHeight - safeAreaBottom - 110);

    /// 检查是否靠近边缘
    isNearEdge = (newX <= 10 ||
        newX >= screenWidth - 70 ||
        newY <= safeAreaTop + 10 ||
        newY >= screenHeight - safeAreaBottom - 120);

    /// 更新位置
    position = Offset(newX, newY);

    update();
  }

  ///跳转年报页面
  onToAnnualReport() {
    /// 获取图片路径
    String imagePath = OssUtil.getServerPath(nbBg0);
    late ImageProvider imageProvider = NetworkImage(imagePath);

    /// 预加载图片
    if (Get.context != null) precacheImage(imageProvider, Get.context!);

    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
    Get.toNamed(Routes.annualReport);
  }

  ///年报拖动点击处理
  onToAnnualReports() {
    isNearEdge = false;
    update();
  }

  ///年报拖动
  onDragEnds(DraggableDetails details) {
    isNearEdge = false;
    update();
  }

  ///年报关闭
  onNbClose() {
    isNearEdge = true;
    update();
  }

  ///切换页面索引
  onPageChanged(int page) {
    currentPage = page;
    update();
  }

  ///足球篮球专题页上一页
  onPreviousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  ///足球篮球专题页下一页
  onNextPage() {
    if (currentPage < queryLeagueTemplateListData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  ///足球篮球专题页自动滚动
  startAutoScroll() {
    pageTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPage < queryLeagueTemplateListData.length - 1) {
        currentPage++;
      } else {
        currentPage = 0; // 回到第一页
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  ///足球篮球专题页拖动位置
  onFootballBasketballTemplateDragEnd(DraggableDetails details) {
    /// 计算新的位置
    double newX = details.offset.dx - 25;

    /// 调整偏移量
    double newY = details.offset.dy - 25;

    /// 获取屏幕尺寸
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double screenHeight = MediaQuery.of(Get.context!).size.height;

    /// 获取安全区边距
    EdgeInsets padding = MediaQuery.of(Get.context!).padding;
    double safeAreaTop = padding.top;
    double safeAreaBottom = padding.bottom;

    /// 限制图标不超出边界
    newX = newX.clamp(0.0, screenWidth - 60 - 10);
    newY = newY.clamp(safeAreaTop, screenHeight - safeAreaBottom - 110);

    /// 检查是否靠近边缘
    isZNearEdge = (newX <= 10 ||
        newX >= screenWidth - 70 ||
        newY <= safeAreaTop + 10 ||
        newY >= screenHeight - safeAreaBottom - 120);
    if (isZNearEdge) {
      footballBasketballTemplateIsNearEdge = true;
    }

    footballBasketballTemplatePosition = Offset(newX, newY);
    update();
  }

  ///足球篮球专题页靠边界拖动按钮
  onPanUpdate(DragUpdateDetails details) {
    onTap();
  }

  ///足球篮球专题页靠边界点击按钮
  onTap() {
    footballBasketballTemplateIsNearEdge = false;
    footballBasketballTemplatePosition = Offset(
      MediaQuery.of(Get.context!).size.width - 130,
      MediaQuery.of(Get.context!).size.height -
          (bottomHideSwitch == true ? 500 : 160),
    );
    update();
  }

  ///去足球篮球运营模版
  toFootballBasketballTemplate() {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
    footballBasketballTemplateSetting = true;
    Get.toNamed(Routes.footballBasketballTemplate, arguments: [
      {"queryLeagueTemplateListData": queryLeagueTemplateListData},
      {"currentPage": currentPage},
      {"isDarkMode": Get.isDarkMode}
    ]);
  }

  ///足球篮球运营模版接口
  Future<void> queryLeagueTemplateList() async {
    footballBasketballTemplate = false;
    footballBasketballTemplateSetting = false;
    final res = await ResultApi.instance().queryLeagueTemplateLis(
      TYUserController.to.getUid(),
    );
    AppLogger.json(res.toJson(), tag: 'queryLeagueTemplateLis');
    if (res.code == '0000000') {
      queryLeagueTemplateListDatas = res.data;
      if (queryLeagueTemplateListDatas.length > 0) {
        for (int i = 0; i < queryLeagueTemplateListDatas.length; i++) {
          if (queryLeagueTemplateListDatas[i].templateStatus == 1) {
            queryLeagueTemplateListData.add(queryLeagueTemplateListDatas[i]);
          }
        }
      }
      if (queryLeagueTemplateListData.length > 0) {
        currentPage = queryLeagueTemplateListData.length;
        footballBasketballTemplate = true;
        footballBasketballTemplateSetting = true;
      }
    }

    if (footballBasketballTemplate == true) {
      startAutoScroll();
    }
    update();
  }
}
