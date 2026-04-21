import 'package:filbet/src/webpage/web_view_page_controller.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
class WebViewPage extends GetView<WebViewPageController> {
  const WebViewPage({super.key});

  Widget _webviewWidget() {
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: controller.webViewController.platform,
          displayWithHybridComposition: false,
        ),
      );
    } else {
      return WebViewWidget(
        controller: controller.webViewController,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
 

       return CustomScffold(
        showBgTexture: false,
        backgroundColor: appnewColors.bg4,
        appBar: CustomAppbar.normalTitle(
          bgColor: appnewColors.bg4,
           title: controller.argumentsData['title'],
        ),
      body: SafeArea(
          child: Obx(() => Stack(
                children: [
                  _webviewWidget(),
                  if (!controller.loading.value) loadinngView(),
                ],
              ))),
    );
  }
}
