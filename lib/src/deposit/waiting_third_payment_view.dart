import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_ty_app/app/utils/webview_ios_http_auth.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../src/deposit/waiting_third_payment_controller.dart';

class WaitingThirdPaymentView extends GetView<WaitingThirdPaymentController> {
  const WaitingThirdPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return WebPage();
  }
}

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    final String payUrl = Get.arguments["payUrl"] as String;
    final NavigationDelegate nav = NavigationDelegate(
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    tyWebViewBindNavigationAndLoadUnawaited(
      controller: controller,
      navigationDelegate: nav,
      loadRequestUri: Uri.parse(payUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: appnewColors.bg4,
      appBar: CustomAppbar.normalTitle(
        title: 'waiting_payment'.tr,
        bgColor: Colors.white,
        leftBackColor: appnewColors.text6,
        actions: [
          Align(
            child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () {
                    controller.reload();
                  },
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      Assets.homeGameRefresh,
                      width: 16.w,
                      height: 16.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
