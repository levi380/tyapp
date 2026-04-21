import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/webview_ios_http_auth.dart';

import 'cp_ticket_web_view_logic.dart';

class CpTicketWebViewController extends GetxController {
  static CpTicketWebViewController get to =>
      Get.put(CpTicketWebViewController());
  final CpTicketWebViewlogic logic = CpTicketWebViewlogic();
  late final WebViewController webViewController;
  bool isInit = false;

  late Widget webviewWidget;

  late String ticketId;

  int progress = 0;

  @override
  void onInit() {
    ticketId = Get.arguments?['ticketId'] as String? ?? '';
    _initData();
    super.onInit();
  }

  void _initData() {
    if (isInit) return;
    isInit = true;

    String url = 'https://app-h5.dbsportxxx1zx.com/#/cp?ticketId=$ticketId';
    initWeb(url);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  initWeb(String url) {
    final NavigationDelegate nav = NavigationDelegate(
      onProgress: (int progressa) {
        progress = progressa;
        // update();
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

    webviewWidget = WebViewWidget(
      controller: webViewController,
    );
  }
}
