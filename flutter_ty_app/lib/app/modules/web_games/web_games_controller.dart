import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'web_games_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-0715b484-12fe-4fa9-97ad-7f985fe2cf06-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  真人彩票详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人彩票webView 通用详情加载页 控制器 WebGamesController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人彩票webView 通用详情加载页 控制器 WebGamesPage
    - WebGamesController
    】】】
 *
 */
class WebGamesController extends GetxController {
  final WebGameslogic logic = WebGameslogic();
  late InAppWebViewController webViewController;
  bool fullScreen = false;

  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    super.onInit();
  }

  void initData() {
    logic.title = Get.arguments[0]['title'];
    logic.url = Get.arguments[1]['url'];
    logic.isCP = Get.arguments[2]?['cp'] ?? false;
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

  onGamesRefresh() {
    webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(logic.url)));
  }

  onFullScreen() {
    fullScreen = true;
    update(["title"]);
  }
}
