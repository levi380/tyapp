import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/utils/systemchrome.dart';

import '../../../main.dart';
import '../../utils/utils.dart';
import '../login/login_head_import.dart';
import 'olympic_games_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f0701ec9-2638-410f-a016-bc358835db9d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  奥运会专题页】】】
    【【【 AUTO_PARAGRAPH_TITLE 奥运会专题页 控制器 OlympicGamesController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 奥运会专题页 控制器 OlympicGamesController
    - OlympicGamesController
    】】】
 *
 */
class OlympicGamesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final OlympicGameslogic logic = OlympicGameslogic();

  late AnimationController animationController;
  late Animation animation;
  late InAppWebViewController webViewController;

  bool appThemeisDark = Get.arguments;
  bool progress = true;
  late String u = '';
  @override
  void onInit() {
    // TODO: implement onInit
    iconRefresh();
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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

  void initData() {
    String env = StringKV.env.get() ?? 'prod';
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
    String lang = tag.split('-')[0];

    var domain;
    if (isSDK == false && env == '生产维护') {
      domain = 'https://topic.dbsportxxx1zx.com';
      topic = 'https://topic.dbsportxxx1zx.com';
    } else {
      domain = MapKV.topic.get()?['domain'];
      topic = MapKV.topic.get()?['domain'];
    }
    if (!hasStrValue(domain)) {
      domain = getStaticDomain();
    }
    domain = composeUrl(domain, 'olympic-h5/');

    u = '$domain?token=$token&gr=$gr&lang=$lang&api=$api&project=app-h5&topic=$topic&proid=1';
    if (Get.currentRoute == Routes.olympicGames) {
      initWeb(u);
    }
  }

  initWeb(String url) {
    /*webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progressa) {
            if(progressa==100){
              progress = false;
            }else {
              progress = true;
            }
            update();
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            print('url'+url);
          },
          onWebResourceError: (WebResourceError error) {
            print(error);
          },
          onNavigationRequest: (NavigationRequest request) {
            print(request);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));*/
  }

  toQuitAPP() async {
    // if(await webViewController?.canGoBack() ?? false){
    //   webViewController?.goBack();
    // }else {
    //   europeanCupSetting = false;
    //   Get.back();
    // }
    /// 66083 【UAT】【欧洲杯专题页】【SDK】首页没有返回到常规赛事页面   测试说需要直接返回常规赛事
    olympicGamesSetting = false;
    Get.back();
    resetThemeDark();
  }

  resetThemeDark() {
    if (appThemeisDark) {
      ///进入奥运会会强制设置日间模式
      ///只有原app 为暗黑模式 才会去重制app风格模式为夜间模式
      Get.changeThemeMode(ThemeMode.dark);
      BoolKV.theme.save(appThemeisDark);
      TyHomeController.to.homeState.isLight = false;
      SystemUtils.isDarkMode(appThemeisDark);
      TyHomeController.to.update();
    }
  }

  onGetColors() async {
    var canBack = await webViewController.canGoBack();
    if (canBack) {
      Colors.white.withValues(alpha: 0.0);
    } else {
      Colors.white;
    }
  }

  // toRefresh() {
  //   animationController.forward();
  //   InAppWebViewController.clearAllCache();
  //   initData();
  //     webViewController?.loadUrl(
  //       urlRequest: URLRequest(url: WebUri(u)));
  // }

  ///69097 【SIT】【奥运会】【APP】刷新每次都会回到专题页首页
  ///底部菜单刷新点击按钮 :不需要重置专题页的加载 只刷新当前页面
  toRefresh() {
    webViewController.reload();
    // animationController.forward();
    // InAppWebViewController.clearAllCache();
    // initData();
    // webViewController?.loadUrl(
    //     urlRequest: URLRequest(url: WebUri(u)));
  }
}
