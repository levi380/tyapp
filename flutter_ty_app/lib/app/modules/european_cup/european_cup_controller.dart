import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../main.dart';

import '../../utils/utils.dart';
import '../login/login_head_import.dart';
import 'european_cup_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f1b34266-096b-4d78-a654-5e05e0610732-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  欧洲杯界面】】】
    【【【 AUTO_PARAGRAPH_TITLE 欧洲杯界面 控制器 EuropeanCupController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 欧洲杯界面 控制器 EuropeanCupController
    - EuropeanCupController
    】】】
 *
 */
class EuropeanCupController extends GetxController {
  final EuropeanCuplogic logic = EuropeanCuplogic();
  late InAppWebViewController webViewController;
  late String u = '';
  bool progress = true;

  @override
  void onInit() {
    // TODO: implement onInit
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
    domain = composeUrl(domain, 'eurocup-h5/');

    u = '$domain?token=$token&gr=$gr&lang=$lang&api=$api&project=app-h5&topic=$topic&proid=1';
    if (Get.currentRoute == Routes.europeanCup) {
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
            AppLogger.debug('url'+url);
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
    europeanCupSetting = false;
    Get.back();
  }

  onGetColors() async {
    var canBack = await webViewController.canGoBack();
    if (canBack) {
      Colors.white.withValues(alpha: 0.0);
    } else {
      Colors.white;
    }
  }

  onUpdate() {}
}
