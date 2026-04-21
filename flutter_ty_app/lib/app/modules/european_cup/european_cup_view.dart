
import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';


import '../../../generated/locales.g.dart';
import '../../../main.dart';

import '../login/login_head_import.dart';
import '../main_tab/main_tab_controller.dart';
import '../main_tab/widgets/tab_widget.dart';
import 'european_cup_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f1b34266-096b-4d78-a654-5e05e0610732-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  欧洲杯界面】】】
    【【【 AUTO_PARAGRAPH_TITLE 欧洲杯界面 视图 EuropeanCupPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 欧洲杯界面 视图 EuropeanCupPage
    - EuropeanCupPage
    】】】
 *
 */
class EuropeanCupPage extends StatefulWidget {
  const EuropeanCupPage({Key? key}) : super(key: key);

  @override
  State<EuropeanCupPage> createState() => _EuropeanCupPageState();
}

class _EuropeanCupPageState extends State<EuropeanCupPage> {
  final controller = Get.find<EuropeanCupController>();
  final logic = Get.find<EuropeanCupController>().logic;
  final bottomController = Get.find<MainTabController>();

  @override
  Widget build(BuildContext context) {
    InAppWebViewSettings settings = InAppWebViewSettings(
        isInspectable: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true);

    return GetBuilder<EuropeanCupController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            europeanCupSetting = false;
            Get.back();
            if (didPop) return;
          },
          child: Scaffold(
            body: SafeArea(
                child: Stack(
              children: [
                InAppWebView(
                  initialSettings: settings,
                  initialUrlRequest: URLRequest(url: WebUri(controller.u)),
                  onProgressChanged: (controllerx, progress) {
                    if (progress == 100) {
                      setState(() {
                        controller.progress = false;
                      });
                    }
                  },
                  onWebViewCreated: (controller2) async {
                    controller.webViewController = controller2;
                    controller2.addJavaScriptHandler(
                        handlerName: 'TY_APP_BACK',
                        callback: (args) {
                          europeanCupSetting = false;
                          Get.back();
                        });
                  },
                  onPermissionRequest: (controller, request) async {
                    return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT);
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    if (kDebugMode) {
                      print('consoleMessage$consoleMessage');
                    }
                  },
                  onUpdateVisitedHistory: (InAppWebViewController controller3,
                      WebUri? url, bool? isReload) {
                    if (url.toString().contains('details')) {
                      logic.details = false;
                      setState(() {});
                    } else {
                      logic.details = true;
                      setState(() {});
                    }
                  },
                ),
                if (logic.details == true) _title(),
                if (controller.progress == true)
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: ImageView(
                        oddsInfoLoadingGif,
                        width: 70.w,
                      ),
                    ),
                  ),
                /* WebViewWidget(
                    controller: controller.webViewController,

                  ),*/
              ],
            )),
            floatingActionButton: GestureDetector(
              onTap: () => bottomController.toEuropeanCup(),
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode
                      ? const Color(0xE5181A21)
                      : const Color(0xffFFFAFA),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 5.h, bottom: 5),
                  child: ImageView(
                    'assets/images/icon/europeanCup2.png',
                    width: 33.w,
                    height: 26.w,
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar:  bottomHideSwitch ? Container(height: 0.5,) : Container(
              height: 75.h,
              decoration: BoxDecoration(
                color: const Color(0xFF000C43),
                boxShadow: [
                  BoxShadow(
                    color: context.isDarkMode
                        ? Colors.black.withAlpha(90)
                        : Colors.grey.withAlpha(90),
                    blurRadius: 4.r,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ///赛果
                    TabWidget(
                      onTap: () => bottomController.logicToTargetPage(0),
                      title: LocaleKeys.menu_itme_name_results.tr,
                      imageUrl: context.isDarkMode
                          ? 'assets/images/icon/main_tab1_night.svg'
                          : 'assets/images/icon/main_tab1.png',
                      dailyActivities: false,
                    ),
                    ///设置菜单
                    TabWidget(
                      onTap: () {
                        bottomController.logicToTargetPage(1);
                      },
                      title: LocaleKeys.footer_menu_set_menu.tr,
                      imageUrl: context.isDarkMode
                          ? 'assets/images/icon/main_tab2_night.svg'
                          : 'assets/images/icon/main_tab2.png',
                      dailyActivities: false,
                    ),
                    GestureDetector(
                      onTap: () => bottomController.toEuropeanCup(),
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: ImageView(
                          'assets/images/icon/europeanCup3.png',
                          width: 72.w,
                          height: 30.w,
                        ),
                      ),
                    ),
                    ///未结注单
                    TabWidget(
                      onTap: () => bottomController.logicToTargetPage(2),
                      title: LocaleKeys.app_h5_cathectic_open_bets.tr,
                      imageUrl: context.isDarkMode
                          ? 'assets/images/icon/main_tab3_night.svg'
                          : 'assets/images/icon/main_tab3.png',
                      dailyActivities: false,
                    ),
                    ///已结注单
                    TabWidget(
                      onTap: () => bottomController.logicToTargetPage(3),
                      title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
                      imageUrl: context.isDarkMode
                          ? 'assets/images/icon/main_tab4_night.png'
                          : 'assets/images/icon/main_tab4.png',
                      dailyActivities: false,
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return SizedBox(
      height: 48.h,
      child: Container(
        margin: EdgeInsets.only(left: 10.w, top: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => controller.toQuitAPP(),
              onDoubleTap: () {
                europeanCupSetting = false;
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 35.w,
                color: Colors.white.withValues(alpha:0.0),
              ),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<EuropeanCupController>();
    super.dispose();
  }
}
