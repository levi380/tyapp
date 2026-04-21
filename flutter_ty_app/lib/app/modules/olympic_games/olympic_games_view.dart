import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/olympic_games/widgets/olympic_games_tab_widget.dart';
import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../generated/locales.g.dart';
import '../login/login_head_import.dart';
import '../main_tab/main_tab_controller.dart';
import 'olympic_games_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f0701ec9-2638-410f-a016-bc358835db9d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  奥运会专题页】】】
    【【【 AUTO_PARAGRAPH_TITLE 奥运会专题页 视图 OlympicGamesPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 奥运会专题页 视图 OlympicGamesPage
    - OlympicGamesPage
    】】】
 *
 */
class OlympicGamesPage extends StatefulWidget {
  const OlympicGamesPage({Key? key}) : super(key: key);

  @override
  State<OlympicGamesPage> createState() => _OlympicGamesPageState();
}

class _OlympicGamesPageState extends State<OlympicGamesPage> {
  final controller = Get.find<OlympicGamesController>();
  final logic = Get.find<OlympicGamesController>().logic;

  final bottomController = Get.find<MainTabController>();

  @override
  Widget build(BuildContext context) {
    InAppWebViewSettings settings = InAppWebViewSettings(
        isInspectable: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true);

    return GetBuilder<OlympicGamesController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            olympicGamesSetting = false;
            Get.back();
            controller.resetThemeDark();
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
                    if (kDebugMode) {
                      print(progress);
                    }
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
                          print(args);
                          olympicGamesSetting = false;
                          Get.back();
                          controller.resetThemeDark();
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
                    if (kDebugMode) {
                      print('专题页加载URL$url');
                    }
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
                        color: Color(0xFFD7C378),
                      ),
                    ),
                  ),
              ],
            )),
            bottomNavigationBar: logic.details == true
                ? Container(
                    height: 75.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7C378),
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
                          //赛果
                          OlympicGamesTabWidget(
                            onTap: () => bottomController.logicToTargetPage(0),
                            title: LocaleKeys.menu_itme_name_results.tr,
                            imageUrl: context.isDarkMode
                                ? 'assets/images/icon/main_tab1_night.svg'
                                : 'assets/images/icon/main_tab1.png',
                            dailyActivities: false,
                          ),
                          //设置菜单
                          OlympicGamesTabWidget(
                            onTap: () {
                              bottomController.logicToTargetPage(1);
                            },
                            title: LocaleKeys.footer_menu_set_menu.tr,
                            imageUrl: context.isDarkMode
                                ? 'assets/images/icon/main_tab2_night.svg'
                                : 'assets/images/icon/main_tab2.png',
                            dailyActivities: false,
                          ),
                          //未结注单
                          OlympicGamesTabWidget(
                            onTap: () => bottomController.logicToTargetPage(2),
                            title: LocaleKeys.app_h5_cathectic_open_bets.tr,
                            imageUrl: context.isDarkMode
                                ? 'assets/images/icon/main_tab3_night.svg'
                                : 'assets/images/icon/main_tab3.png',
                            dailyActivities: false,
                          ),
                          //已结注单
                          OlympicGamesTabWidget(
                            onTap: () => bottomController.logicToTargetPage(3),
                            title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
                            imageUrl: context.isDarkMode
                                ? 'assets/images/icon/main_tab4_night.png'
                                : 'assets/images/icon/main_tab4.png',
                            dailyActivities: false,
                          ),

                          //刷新

                          OlympicGamesTabWidget(
                            onTap: () => controller.toRefresh(),
                            title: LocaleKeys.footer_menu_refresh.tr,
                            imageUrl: 'assets/images/icon/main_tab4.png',
                            animation: true,
                            dailyActivities: false,
                            animate: controller.animationController,
                          ),
                        ]),
                  )
                : null,
          ),
        );
      },
    );
  }

  //头部
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
                olympicGamesSetting = false;
                Get.back();
                controller.resetThemeDark();
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
    Get.delete<OlympicGamesController>();
    super.dispose();
  }
}
