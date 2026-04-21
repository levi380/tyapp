import 'dart:ui';

import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/webview_ios_http_auth.dart';

import '../../../db/app_cache.dart';
import 'daily_activities_logic.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-4e9be854-24f7-4038-82b7-1ee2bd55e911-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 活动界面】】】
    【【【 AUTO_PARAGRAPH_TITLE 活动界面 控制器 DailyActivitiesController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 活动界面 控制器 DailyActivitiesController
    - DailyActivitiesController
    ```
    ///进度条
    int progress = 0;
    ///初始化webURL
    initData();
    ```
    】】】
 *
 */
class DailyActivitiesController extends GetxController {
  final DailyActivitieslogic logic = DailyActivitieslogic();
  late final WebViewController webViewController;



  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    super.onInit();
  }

  ///初始化数据 加载地址
  void initData() {
    String token = StringKV.token.get() ?? '';
    String gr = StringKV.gr.get() ?? 'common';
    String api = StringKV.best_api.get() ?? '';
    // 加密api
    api = apiEncrypt(api);
    // var s = MapKV.topic.get();
    String topic = MapKV.topic.get()?['domain'] ?? '';

    String theme = Get.isDarkMode ? 'theme02' : 'theme01';
    // 强制设置蓝色
    theme += '_y0';

    String tag = Get.locale!.toLanguageTag();
    String lang = tag.split('-')[0];

    // 活动域名
    String domain = MapKV.topic.get()?['activity'] ??
        '${getStaticDomain()}/activity/common/common/';

    String u =
        '$domain?token=$token&gr=$gr&theme=$theme&lang=$lang&api=$api&project=app-h5&topic=$topic';

    initWeb(u);
  }

  ///初始化webView
  initWeb(String url) {
    final NavigationDelegate nav = NavigationDelegate(
      onProgress: (int progressa) {
        logic.progress = progressa;
        update();
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
    tyWebViewBindNavigationAndLoadUnawaited(
      controller: webViewController,
      navigationDelegate: nav,
      loadRequestUri: Uri.parse(url),
    );
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
}
