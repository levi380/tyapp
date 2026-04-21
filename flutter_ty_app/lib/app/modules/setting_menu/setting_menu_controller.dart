import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/league_filter_view.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_home_controller.dart';
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';
import 'package:flutter_ty_app/app/utils/skin_status.dart';
import 'package:flutter_ty_app/app/utils/toast_util.dart';

import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import '../../config/getx_navigation.dart';
import '../../global/assets/webview_cache.dart';

import '../../routes/app_pages.dart';
import '../../services/api/account_api.dart';
import '../../services/api/menu_api.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/systemchrome.dart';
import '../european_cup/european_cup_controller.dart';
import '../olympic_games/olympic_games_controller.dart';
import '../pip_video/pip_video_controller.dart';
import 'league_filter/all_league_filter/all_league_filter_controller.dart';
import 'league_filter/all_league_filter/all_league_filter_view.dart';
import 'league_filter/league_filter_controller.dart';
import 'league_filter/manager/league_manager.dart';
import 'setting_menu_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5a7d82aa-a062-4061-ad30-cc1cd2482bdc-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单控制器SettingMenuController】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单控制器SettingMenuController
    - SettingMenuController
    - 包含联赛删选-投注模式-排序规则-盘口设置-主题风格-自定义快捷金额一键投注-切换语言-盘口教程-规则说明-公告中心
    - 跳转按钮处理
    ```
    ///投注模式 1新手 2专业

    int bettingMode = 2;

    ///排序规则 1热门 2时间
    int sortingRules = 1;

    ///盘口设置 1欧洲盘 2香港盘口
    int handicapSettings = 1;

    //投注按钮设置 1滑动下注 2点击下注
    int betButtonStyle = 1;

    ///主题风格 1日间 2夜间
    int themeStyle = 1;

    ///每日活动 1开启 2关闭
    int dailyActivities = 1;

    bool isDarkMode = false;

    /// 是否显示活动
    late bool showActivity = false;

    /// 是否显示联赛筛选
    late bool showMatchFilter = true;

    /// 字体大小 1 默认 2 放大
    int fontSize = 1;

    /// 投注手势 1 滑动投注  2 点击投注
    int bettingGestures = 1;

    /// 队名偏好 1 简译 2 繁译
    int teamNamePreference = 1;

    /// 当前值
    int fastBetAmount = 0;

    /// 是否开启和关闭
    bool switchOn = false;

    /// 最小投注额
    int min = 0;

    /// 最大投注额
    int max = 100000000;

    ///简译繁译加载框
    bool updateLanguage = false;

    ///商户开关 0-关，1-开 队名偏好菜单
    String languageSwitch = '0';

    ///系统级别开关 0-关，1-开 队名偏好菜单
    String languageSystemSwitch = '0';
    ```
    】】】
 *
 */

enum ConfigNotifyType {
  fontSizeSet('fontSizeSet'),
  quickBetting('quickBetting'),
  timezone('TimeZone');

  final String key;
  const ConfigNotifyType(this.key);
}

class SettingMenuController extends GetxController {
  static SettingMenuController get to => Get.put(SettingMenuController());
  final SettingMenulogic logic = SettingMenulogic();

  /// 是否显示联赛筛选
  late bool showMatchFilter = true;

  /// 队名偏好 1 简译 2 繁译
  int teamNamePreference = 1;

  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();


  @override
  void onInit() {
    getUserInfo();

    /// 先从全局取开关值
    logic.switchOn = TYUserController.to.isOneClickBet.value;
    initData();
    initActivity();
    getUserCustomizeInfo();
    super.onInit();

    logic.handicapSettings = TYUserController.to.curOdds == 'EU' ? 1 : 2;

    /// 初始化状态
    logic.min = TYUserController.to.userInfo.value?.cvo?.single?.min ?? 0;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getUserInfo();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getUserInfo() async {
    final res =
        await AccountApi.instance().getUserInfo(StringKV.token.get() ?? '');
    if (res.success) {
      logic.languageSwitch = res.data!.languageSwitch;
      logic.languageSystemSwitch = res.data!.languageSystemSwitch;
      teamNamePreference = res.data!.languageName == 'hk' ? 2 : 1;
      update();
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        getUserInfo();
      });
      update();
    }
  }

  Future<void> getUserCustomizeInfo() async {
    final res = await MenuApi.instance().getUserCustomizeInfo();
    if (res.code == '0000000') {
      logic.fastBetAmount =
          int.tryParse(res.data.fastBetAmount.toString()) ?? 0;
      textEditingController.text = logic.fastBetAmount.toString();
      TYUserController.to.getUserCustomizeInfoBetAmount(infoRes: res);
      update();
    } else {
      if (res.code != '0401013') {
        ToastUtils.show(res.msg);
      }
    }
  }

  initActivity() {
    bool hasActivity = TYUserController.to.isHaveActivity();
    if (hasActivity) {
      logic.showActivity = true;
    } else {
      logic.showActivity = false;
    }
  }

  setShowActivity() {
    initActivity();
    update(['SettingMenuShowActivity']);
  }

  ///投注模式
  onBettingMode(int i) {
    logic.bettingMode = i;
    TyHomeController.to.changeNew(i == 2 ? true : false);
    update();
  }

  ///投注按钮设置
  onBetButtonStyle(int buttonStyle) async {
    try {
      final res = await AccountApi.instance()
          .setUserParamConfig("betGesture", buttonStyle == 1 ? "0" : "1");
      if (res.success) {
        logic.betButtonStyle = buttonStyle;
        BoolKV.slideBet.save(logic.betButtonStyle == 1);
        update();
      } else {
        showToast(res.msg ?? "${res.code ?? ""} error");
      }
    } catch (e) {
      AppLogger.debug('getUserParamConfig error: $e');
    }
  }

  ///排序规则
  onSortingRules(int i) async {
    logic.sortingRules = i;
    TyHomeController.to.changeHot(i == 1 ? true : false);
    update();
  }

  onHandicapSettings(int i, String key) async {
    if (ShopCartController.to.isEuOnly()) {
      // 冠军、串关默认欧洲盘
      return;
    }
    final res = await MenuApi.instance().setUserPersonalise(i);
    if (res.code == "0000000") {
      logic.handicapSettings = i;

      TYUserController.to.setCur(key);
      update();
      Bus.getInstance().emit(EventType.changeOddType);

      //清除购物车数据
      ShopCartController.to.clearData();
      if (europeanCup == true) {
        final europeanCupController = Get.find<EuropeanCupController>();
        europeanCupController.initData();
        europeanCupController.progress = true;
        europeanCupController.update();
        europeanCupController.webViewController.loadUrl(
            urlRequest: URLRequest(url: WebUri(europeanCupController.u)));
      }

      if (olympicGames == true) {
        final olympicGamesController = Get.find<OlympicGamesController>();
        olympicGamesController.initData();
        olympicGamesController.progress = true;
        olympicGamesController.update();
        olympicGamesController.webViewController.loadUrl(
            urlRequest: URLRequest(url: WebUri(olympicGamesController.u)));
      }
    } else {
      ToastUtils.show(res.msg);
    }
  }

  ///主题风格
  onThemeStyle(int theme) {
    logic.themeStyle = theme;

    ///当前设置菜单 切换是否为黑夜模式
    bool isThemeModeDark = theme == 1 ? false : true;
    Get.changeThemeMode(!isThemeModeDark ? ThemeMode.light : ThemeMode.dark);
    BoolKV.theme.save(isThemeModeDark);
    TyHomeController.to.homeState.isLight = isThemeModeDark ? false : true;
    TyHomeController.to.update();
    PipVideoController.to?.changeTheme();
    logic.isDarkMode = isThemeModeDark ? true : false;
    SystemUtils.isDarkMode(isThemeModeDark ? true : false);
    if (Get.currentRoute == Routes.vrHomePage) {
      // Bus.getInstance().emit(EventType.changeOddType);
      // VrTyHomeController.to.update(['match_list','sport_menus','sport_sport_head_menus', 'all_expand_toggle']);
      Get.back();
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   VrTyHomeController.to.update();
      // });
      Future.delayed(Duration(milliseconds: 100), () {
        VrTyHomeController.to.update();
      });
    } else {
      update();
    }
  }

  ///主题风格
  setModeStatus(Status state) {
    ChangeSkinToneColorUtil.instance().setModeStatus(state);
    TyHomeController.to.update();
    DJController.to.update();
    // Bus.getInstance().emit(EventType.changeOddType);
    // update();
    Get.forceAppUpdate();
  }

  ///初始化数据
  Future<void> initData() async {
    logic.bettingMode = TyHomeController.to.homeState.isProfess ? 2 : 1;
    logic.sortingRules = TyHomeController.to.homeState.isHot ? 1 : 2;
    Get.isDarkMode ? logic.themeStyle = 1 : logic.themeStyle = 0;
    logic.themeStyle = Get.isDarkMode ? 2 : 1;
    logic.isDarkMode = Get.isDarkMode ? true : false;
    bool da = BoolKV.dailyActivities.get() ?? false;
    logic.dailyActivities = da == true ? 1 : 2;
    logic.betButtonStyle = (BoolKV.slideBet.get() ?? true) ? 1 : 2;

    bool isBiggerSize = BoolKV.isBiggerSize.get() ?? false;
    logic.fontSize = isBiggerSize == false ? 1 : 2;

    /// 初始化状态
    logic.min = TYUserController.to.userInfo.value?.cvo?.single?.min ?? 0;
    logic.singleList = TYUserController.to.singleList;
    if (logic.singleList.isEmpty) {
      await TYUserController.to.getUserCustomizeInfo();
      logic.singleList = TYUserController.to.singleList;
      update();
    }

    /// 预加载webVew
    WebviewCacheController.to.getRule();
    update();
  }

  ///规则说明
  void toRuleDescription() {
    Get.toNamed(Routes.ruleDescription);
  }

  ///公告中心
  void toNoticeCenter() {
    // Get.toNamed(Routes.noticeCenter);a
    Get.toNamed(Routes.announcementCenter);
  }

  ///盘口教程
  onTutorial() {
    Get.toNamed(Routes.tutorial);
  }

  ///切换语言
  toLanguage() {
    Get.toNamed(Routes.language);
  }

  ///联赛删选
  static onLeagueFilter([int? index, bool isHot = false]) async {
    Get.back(closeOverlays: true);
    Bus.getInstance().emit(EventType.tyOpenDialog);
    // 获取到列表的参数
    var type = TyHomeController.to.homeState.matchListReq.type;
    String euid = TyHomeController.to.homeState.matchListReq.euid;
    LeagueManager.type.value = type;
    LeagueManager.euid = euid;

    // 做判断删除 已选择联赛数据
    // 如果从赛果页面过来 则删除tid缓存
    if (LeagueManager.entryName != 'home') {
      LeagueManager.tid.clear();
      LeagueManager.entryName = 'home';
    }

    /// TyHomeController.to.homeState.sportId ==100 滚球全部页面赛果接口不一致，单独处理
    if (TyHomeController.to.homeState.sportId
        .contains(SportConfig.MatchAllPage.sportId.toString())) {
      Get.lazyPut(() => AllLeagueFilterController(finishCb: (str) {
            // 联赛塞选 数据
            TyHomeController.to.homeState.matchListReq.tid = str;
            TyHomeController.to.fetchData();
          }));
      Get_TY.bottomSheet(
        AllLeagueFilterPage(
          index: index,
          isHot: isHot,
        ),
        isDismissible: false,
        enableDrag: true,
        isScrollControlled: true,
        barrierColor: Colors.black.withValues(alpha: 0.2),
      ).then((value) => Bus.getInstance().emit(EventType.tyCloseDialog));
    } else {
      Get.lazyPut(() => LeagueFilterController(finishCb: (str) {
            // 联赛塞选 数据
            TyHomeController.to.homeState.matchListReq.tid = str;
            TyHomeController.to.fetchData();
          }));
      Get_TY.bottomSheet(
        LeagueFilterPage(
          index: index,
          isHot: isHot,
        ),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: true,
        barrierColor: Colors.black.withValues(alpha: 0.2),
      ).then((value) => Bus.getInstance().emit(EventType.tyCloseDialog));
    }
  }

  ///退出登录
  toSignOut() async {
    ///因为TYUserController有判断userInfo是否为空，如果不为空就不取userInfo(避免重复获取)。所以要置空
    TYUserController.to.userInfo.value = null;
    ShopCartController.to.clearData();
    CollectionController.to.clearCollection();
    TyHomeController.to.update();
    WebviewCacheController.to.cache.clear();

    ///退出登录 关闭ws
    AppWebSocket.unsubscribe();
    AppWebSocket.closeSocket();
    // h5ulr = '';
    StringKV.sessionId.remove();
    await dbClear();
    Get.offAllNamed(Routes.splash);
  }
}
