import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/modules/football_basketball_template/widgets/football_basketball_tab_widget.dart';
import 'package:flutter_ty_app/app/modules/football_basketball_template/widgets/football_basketball_title_widget.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';

import '../../../generated/locales.g.dart';
import '../../../main.dart';

import '../login/login_head_import.dart';
import '../main_tab/main_tab_controller.dart';

import 'football_basketball_template_controller.dart';
import 'package:webview_windows/webview_windows.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-e3715fb6-bb30-4171-bb1e-edfc0b937ce1-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  篮球足球运营模版】】】
    【【【 AUTO_PARAGRAPH_TITLE 篮球足球运营模版 视图 FootballBasketballTemplatePage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球足球运营模版 视图 FootballBasketballTemplatePage
    - FootballBasketballTemplatePage
    】】】
 *
 */
class FootballBasketballTemplatePage extends StatefulWidget {
  const FootballBasketballTemplatePage({Key? key}) : super(key: key);

  @override
  State<FootballBasketballTemplatePage> createState() =>
      _FootballBasketballTemplatePageState();
}

class _FootballBasketballTemplatePageState
    extends State<FootballBasketballTemplatePage> {
  final controller = Get.find<FootballBasketballTemplateController>();
  final logic = Get.find<FootballBasketballTemplateController>().logic;
  final bottomController = Get.find<MainTabController>();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    InAppWebViewSettings settings = InAppWebViewSettings(
        isInspectable: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true);

    return GetBuilder<FootballBasketballTemplateController>(
      builder: (controller) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            isFootballBasketballTemplate = false;
            if(controller.isDarkMode){
              Get.changeThemeMode(ThemeMode.dark);
            }
            controller.toQuitAPP();
            if (didPop) return;
          },
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              controller.fullscreen.value = true;
            } else if (orientation == Orientation.portrait) {
              controller.fullscreen.value = false;
            }


            return Scaffold(
              backgroundColor: Colors.white,
              extendBody: true,
              body: Stack(
                children: [
                  Positioned.fill(
                    child: SafeArea(
                      child: Platform.isWindows
                          ? Stack(
                        children: [
                          Webview(controller.webviewController),
                          _title(),
                          _footballAndBasketballSpecialPage(),
                        ],
                      )
                          : Stack(
                        children: [
                          InAppWebView(
                            initialSettings: settings,
                            initialUrlRequest:
                            URLRequest(url: WebUri(controller.u)),
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
                              controller.inAppWebViewController = controller2;
                              controller2.addJavaScriptHandler(
                                  handlerName: 'TY_APP_BACK',
                                  callback: (args) {
                                    if(controller.isDarkMode){
                                      Get.changeThemeMode(ThemeMode.dark);
                                    }
                                    print(args);
                                    Get.back();
                                    isFootballBasketballTemplate = false;

                                    SystemChrome.setPreferredOrientations([
                                      DeviceOrientation.portraitUp,
                                      DeviceOrientation.portraitDown,
                                    ]);
                                  });
                              controller2.addJavaScriptHandler(
                                  handlerName: 'TY_APP_BET',
                                  callback: (args) {
                                    print(args);
                                    controller.betStatus = args[0]['status'];
                                    if(args[0]['status']==true){

                                      controller.details = false;
                                      controller.carousel = false;

                                    }else {
                                      if(controller.isDetails){
                                        controller.details = false;
                                      }else {
                                        controller.details = true;
                                      }
                                      controller.carousel = true;
                                    }
                                    controller.update();

                                  });

                            },

                            onPermissionRequest: (controller, request) async {
                              return PermissionResponse(resources: request.resources, action: PermissionResponseAction.GRANT);
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              if (kDebugMode) {
                                print('consoleMessage$consoleMessage');
                              }
                            },
                            onUpdateVisitedHistory: (InAppWebViewController controller3, WebUri? url, bool? isReload) {
                              if (kDebugMode) {
                                print('专题页加载URL$url');
                              }
                              if (url.toString().contains('activeTemplateDetails')) {
                                controller.details = false;
                                controller.isDetails = true;

                                setState(() {});
                              } else {
                                controller.details = true;
                                controller.isDetails = false;
                                setState(() {});
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedSlide(
                      offset: controller.details == true && !controller.fullscreen.value ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 0),
                      child: _bottomNavigationBar(),
                    ),
                  ),
                  if(controller.carousel)
                    _footballAndBasketballSpecialPage(),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return FootballBasketballTitleWidget(
      controller: controller,
    );
  }

  ///bottomNavigationBar
  Widget _bottomNavigationBar() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 75.h,
          margin: EdgeInsets.only(top: 25.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: HexColor(controller.themeColor),
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
                FootballBasketballTabWidget(
                  onTap: () =>
                      bottomController.logicToTargetPage(0),
                  title: LocaleKeys.menu_itme_name_results.tr,
                  imageUrl:
                  'assets/images/icon/footballBasketballTemplate_tabbar_1.png',
                  dailyActivities: false,
                ),

                ///未结注单
                FootballBasketballTabWidget(
                  onTap: () =>
                      bottomController.logicToTargetPage(2),
                  title: LocaleKeys.app_h5_cathectic_open_bets.tr,
                  imageUrl:
                  'assets/images/icon/footballBasketballTemplate_tabbar_2.png',
                  dailyActivities: false,
                ),
                GestureDetector(
                  onTap: () => bottomController
                      .toFootballBasketballTemplate(),
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: ImageView(
                      'assets/images/icon/football_2.png',
                      width: 72.w,
                      height: 30.w,
                    ),
                  ),
                ),

                ///已结注单
                FootballBasketballTabWidget(
                  onTap: () =>
                      bottomController.logicToTargetPage(3),
                  title:
                  LocaleKeys.app_h5_cathectic_closed_bets.tr,
                  imageUrl:
                  'assets/images/icon/footballBasketballTemplate_tabbar_3.png',
                  dailyActivities: false,
                ),

                ///刷新
                FootballBasketballTabWidget(
                  onTap: () => controller.refreshMenu(),
                  title: LocaleKeys.footer_menu_refresh.tr,
                  imageUrl:
                  'assets/images/icon/footballBasketballTemplate_tabbar_4.png',
                  dailyActivities: false,
                  animation: true,
                  animate: controller.animationController,
                ),
              ]),
        ),

        GestureDetector(
          onTap: () => bottomController.toFootballBasketballTemplate(),
          child: Container(
            width: 50.w,
            height: 50.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.isDarkMode
                  ? const Color(0xE5181A21)
                  : const Color(0xffFFFAFA),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 5.h, bottom: 5),
              child: ImageView(
                'assets/images/icon/football_1.png',
                width: 33.w,
                height: 26.w,
              ),
            ),
          ),
        )
      ],
    );
  }

  ///足球篮球专题页入口
  Widget _footballAndBasketballSpecialPage() {
    return controller.footballBasketballTemplateIsNearEdge == true
        ? Positioned(
      right: -20,
      bottom: bottomHideSwitch == true ? 360 : 90.h,
      child: GestureDetector(
        onTap: () => controller.onTap(),
        onPanUpdate: (details) => controller.onPanUpdate(details),
        child: Container(
          width: 52.w,
          height: 52.w,
          child:PageView.builder(
            itemCount: controller.queryLeagueTemplateListData.length,
            controller: controller.pageController,
            onPageChanged: (page)=>controller.onPageChanged(page),
            itemBuilder: (context, index) {
              return ImageView(
                controller.queryLeagueTemplateListData[index].activityTemplateImageH5Sdk,
                cdn: true,
                width: 52.w,

                height: 52.w,
              );
            },
          ),
        ),
      ),
    )
        : Positioned(
      left: controller.footballBasketballTemplatePosition.dx,
      top: controller.footballBasketballTemplatePosition.dy,
      child: Draggable(
        feedback: Container(
          width: 100.w,
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => controller.onPreviousPage(),
                child: ImageView(
                  'assets/images/icon/footballBasketballTemplate_5.png',
                  width: 22.w,
                  height: 22.w,
                ),
              ),
              GestureDetector(
                onTap: () => controller.toFootballBasketballTemplate(),
                child: Container(
                  width: 52.w,
                  height: 52.w,
                  child: PageView.builder(
                    itemCount:
                    controller.queryLeagueTemplateListData.length,
                    controller: controller.pageController,
                    onPageChanged: (page) =>
                        controller.onPageChanged(page),
                    itemBuilder: (context, index) {
                      return ImageView(
                        controller.queryLeagueTemplateListData[index]
                            .activityTemplateImageH5Sdk,
                        cdn: true,
                        width: 52.w,
                        height: 52.w,
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.onNextPage(),
                child: ImageView(
                  'assets/images/icon/footballBasketballTemplate_4.png',
                  width: 22.w,
                  height: 22.w,
                ),
              ),
            ],
          ),
        ),
        child: Container(
          width: 100.w,
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => controller.onPreviousPage(),
                child: ImageView(
                  'assets/images/icon/footballBasketballTemplate_5.png',
                  width: 22.w,
                  height: 22.w,
                ),
              ),
              GestureDetector(
                onTap: () => controller.toFootballBasketballTemplate(),
                child: Container(
                  width: 52.w,
                  height: 52.w,
                  child: PageView.builder(
                    itemCount:
                    controller.queryLeagueTemplateListData.length,
                    controller: controller.pageController,
                    onPageChanged: (page) =>
                        controller.onPageChanged(page),
                    itemBuilder: (context, index) {
                      return ImageView(
                        controller.queryLeagueTemplateListData[index]
                            .activityTemplateImageH5Sdk,
                        cdn: true,
                        width: 52.w,
                        height: 52.w,
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.onNextPage(),
                child: ImageView(
                  'assets/images/icon/footballBasketballTemplate_4.png',
                  width: 22.w,
                  height: 22.w,
                ),
              ),
            ],
          ),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) =>
            controller.onFootballBasketballTemplateDragEnd(details),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<FootballBasketballTemplateController>();
    super.dispose();
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor; // 添加透明度
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(String hexColor) : super(_getColorFromHex(hexColor));
}
