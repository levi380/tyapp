import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

import '../../../main.dart';


import '../../services/models/res/query_league_template_list_entity.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_bus.dart';
import '../../utils/bus/event_enum.dart';

import '../../utils/utils.dart';

import '../login/login_head_import.dart';

import 'football_basketball_template_logic.dart';
import 'package:webview_windows/webview_windows.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-e3715fb6-bb30-4171-bb1e-edfc0b937ce1-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  篮球足球运营模版】】】
    【【【 AUTO_PARAGRAPH_TITLE 篮球足球运营模版 控制器 FootballBasketballTemplateController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球足球运营模版 控制器 FootballBasketballTemplateController
    - FootballBasketballTemplateController
    ```
    ///初始化数据
    initData();
    ///初始化刷新动画
    iconRefresh();
    ```
    】】】
 *
 */
class FootballBasketballTemplateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FootballBasketballTemplateLogic logic =
      FootballBasketballTemplateLogic();
  late InAppWebViewController inAppWebViewController;
  bool progress = true;

  bool canBack = true;

  bool details = false;
  bool isDetails = false;
  bool betStatus = false;

  bool carousel = true;
  late AnimationController animationController;
  ///年报 状态变量
  bool isZNearEdge = false;

  ///足球篮球 拖动位置
  Offset footballBasketballTemplatePosition = Offset(0, 0);

  bool footballBasketballTemplateIsNearEdge = false;



  late String u = '';
  late String themeColor = '#225241';
  late String tid = '';

  late WebviewController webviewController;

  bool canGoBack = false;
  bool isFtNearEdge = false;
  bool isDarkMode = false;
  bool isPageLoaded = false;
  double webHeight = 900;

  ///篮球足球运营模版接口
  late List<QueryLeagueTemplateListData> queryLeagueTemplateListData = [];
  PageController pageController = PageController();
  int currentPage = 0;
  Timer? pageTimer;

  /// 全屏标识
  RxBool fullscreen = false.obs;

  @override
  void onInit() {
    isFootballBasketballTemplate = true;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    queryLeagueTemplateListData = Get.arguments[0]['queryLeagueTemplateListData'];
    currentPage = Get.arguments[1]['currentPage'];

    themeColor = queryLeagueTemplateListData[currentPage].themeColor;
    footballBasketballTemplateThemeColor = themeColor;
    tid = queryLeagueTemplateListData[currentPage].tid;
    // TODO: implement onInit
    webviewController = WebviewController();
    initData();
    footballBasketballTemplatePosition = Offset(
      MediaQuery.of(Get.context!).size.width - 130,
      MediaQuery.of(Get.context!).size.height -
          (bottomHideSwitch == true ? 250 : 150),
    );

    startAutoScroll();

    ///初始化刷新动画
    iconRefresh();

    /// 监听历史状态变化
    webviewController.historyChanged.listen((historyChanged) {
      canGoBack = historyChanged.canGoBack;
      update();
    });

    super.onInit();
  }

  Future<void> initPlatformState() async {
    await webviewController.initialize();
    await webviewController.setCacheDisabled(false);
    await webviewController.loadUrl(u);
    await webviewController.setBackgroundColor(Colors.white);
    update();
  }

  void iconRefresh() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  ///刷新按钮
  void refreshMenu() {
    animationController.forward();
    initData();
    clearCacheAndReload();
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    animationController.dispose();
    webviewController.clearCache();
    webviewController.clearCookies();
    webviewController.dispose();
    pageController.dispose();
    pageTimer?.cancel();
    super.onClose();
  }

  ///初始化数据加载webView
  Future<void> initData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isDarkMode = Get.arguments[2]['isDarkMode'];
      if(isDarkMode){
        Get.changeThemeMode(ThemeMode.light);
      }
    });

    String token;

    token = StringKV.token.get() ?? '';
    //SDK 兼容
    if (token.isEmpty) {
      token = h5Token;
    }
    String gr = StringKV.gr.get() ?? 'common';
    String api = StringKV.best_api.get() ?? '';
    // 加密api
    api = apiEncrypt(api);
    // var s = MapKV.topic.get();
    String topic;

    String tag = Get.locale!.toLanguageTag();
    String lang ='zh';

    if(tag.contains('zh-CN')){
      ///中文-简体
      lang ='zh';
    }else if(tag.contains('zh-TW')){
      ///中文-繁体
      lang ='tw';
    }else if(tag.contains('en-GB')){
      ///英式-英语
      lang ='en';
    }else {
      lang ='zh';
    }
    var domain;
    domain = MapKV.topic.get()?['domain'];
    topic = MapKV.topic.get()?['domain'];
    domain = composeUrl(domain, 'operation-template-h5/');

    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
    String? countryCode = Get.locale?.countryCode.toString();
    if(countryCode=='CN' || countryCode=='TW'){
      u = '$domain?token=$token&gr=$gr&lang=$lang&api=$api&topic=$topic&project=app-h5&proid=1&timestamp=$nowTimeStamp#/activeTemplate/$tid/1';
    }else {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.updateLocale(Locale('en', 'GB'));
        update();
      });
      u = '$domain?token=$token&gr=$gr&lang=en&api=$api&topic=$topic&project=app-h5&proid=1&timestamp=$nowTimeStamp#/activeTemplate/$tid/1';
    }
    AppLogger.debug('专题页地址: $u');
    if(Platform.isWindows)
    initPlatformState();

    update();
  }


  ///返回按钮
  toQuitAPP() async {
    if(Platform.isWindows){
      if (canGoBack) {
        webviewController.goBack();
      }else {
        if(isDarkMode){
          Get.changeThemeMode(ThemeMode.dark);
        }
        Get.back();
        String? countryCode = Get.locale?.countryCode.toString();
        if(!(countryCode=='CN' || countryCode=='TW'))
          toBackLanguage();
      }
      print(canGoBack);
    }else {
      var canBack = await inAppWebViewController.canGoBack();
      if (canBack) {
        inAppWebViewController.goBack();
      }else {
        if(isDarkMode){
          Get.changeThemeMode(ThemeMode.dark);
        }
        Get.back();
        String? countryCode = Get.locale?.countryCode.toString();
        if(!(countryCode=='CN' || countryCode=='TW'))
          toBackLanguage();
      }
    }



  }


  toBackLanguage() async {
    String language = StringKV.language.get() ?? "";
    print(language);
    if (language.isNotEmpty) {
      if (language.contains('CN')) {
         Get.updateLocale( Locale('zh', 'CN')) ; ///中文-简体
      } else if (language.contains('GB')) {
         Get.updateLocale(Locale('en', 'GB'));  ///英式-英语
      } else if (language.contains('TW')) {
          Get.updateLocale(Locale('zh', 'TW'));  ///中文-繁体
      } else if (language.contains('VN')) {
         Get.updateLocale(Locale('vi', 'VN'));  ///越南
      }else if (language.contains('TH')) {
         Get.updateLocale(Locale('th', 'TH'));  ///泰国
      }else if (language.contains('MY')) {
         Get.updateLocale(Locale('ms', 'MY'));  ///马来西亚
      }else if (language.contains('KR')) {
         Get.updateLocale(Locale('ko', 'KR'));   ///韩国
      }else if (language.contains('PT')) {
         Get.updateLocale(Locale('pt', 'PT'));  ///葡萄牙
      }else if (language.contains('PT')) {
         Get.updateLocale(Locale('id', 'ID')); ///印尼语
      }else if (language.contains('ES')) {
         Get.updateLocale(Locale('es', 'ES')); ///西班牙语
      }else if (language.contains('MM')) {
         Get.updateLocale(Locale('my', 'MM')); ///缅甸语
      }else if (language.contains('ar')) {
         Get.updateLocale(Locale('ar', 'AE')) ;  ///阿拉伯语
      }else if (language.contains('RU')) {
         Get.updateLocale(Locale('ru', 'RU')) ;  ///俄语
      }else if (language.contains('IN')) {
         Get.updateLocale(Locale('hi', 'IN') );  ///印地语
      }else if (language.contains('HANS')) {
         Get.updateLocale(Locale('zh', 'HANS'));  ///设置菜单特殊繁译
      }
    }
    Bus.getInstance().emit(EventType.changeLang);
    EventBus().fire(EventType.changeLang);
  }


  ///切换页面索引
  onPageChanged(int page) {
    print(page);
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
      print(1);
    }
  }

  ///足球篮球专题页下一页
  onNextPage() {

    if (currentPage < queryLeagueTemplateListData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      print(2);
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
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
        newY >= screenHeight - safeAreaBottom - 130);
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
      MediaQuery.of(Get.context!).size.width - 100,
      MediaQuery.of(Get.context!).size.height -
          (bottomHideSwitch == true ? 420 : 150),
    );
    update();
  }


  toFootballBasketballTemplate() {
    themeColor = queryLeagueTemplateListData[currentPage].themeColor;
    footballBasketballTemplateThemeColor = themeColor;
    tid = queryLeagueTemplateListData[currentPage].tid;
    initData();
    clearCacheAndReload();
  }

  void clearCacheAndReload() async {
    if(Platform.isWindows){
      await webviewController.clearCache();
      await  webviewController.clearCookies();
      await webviewController.loadUrl(u);
    }else {

      /// 重新加载当前页面
      await inAppWebViewController.loadUrl(urlRequest: URLRequest(url: WebUri(u)));
    }
    update();

  }

}
