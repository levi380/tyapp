import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/web_games/widgets/game_button.dart';

import '../../global/ty_user_controller.dart';
import '../../utils/ty_text_scaler.dart';
import '../login/login_head_import.dart';
import 'web_games_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-0715b484-12fe-4fa9-97ad-7f985fe2cf06-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  真人彩票详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人彩票webView 通用详情加载页 视图 WebGamesPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人彩票webView 通用详情加载页 视图 WebGamesPage
    - WebGamesPage
    ```
    ///头部
    Widget _title()

    ///账户余额
    Widget _buildBalance(BuildContext context)

    ///webView
    Widget _webGame(InAppWebViewSettings settings)
    ```
    】】】
 *
 */
class WebGamesPage extends StatefulWidget {
  const WebGamesPage({Key? key}) : super(key: key);

  @override
  State<WebGamesPage> createState() => _WebGamesPageState();
}

class _WebGamesPageState extends State<WebGamesPage> {
  final controller = Get.find<WebGamesController>();
  final logic = Get.find<WebGamesController>().logic;

  @override
  Widget build(BuildContext context) {
    InAppWebViewSettings settings = InAppWebViewSettings(
        isInspectable: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        underPageBackgroundColor: context.isDarkMode
            ? const Color(0xFF1E2029)
            : const Color(0xFFf8f9fa),
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true);

    return GetBuilder<WebGamesController>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: context.isDarkMode
                ? const Color(0xFF1E2029)
                : const Color(0xFFf8f9fa),
            body: Stack(
              /// 让背景图片充满整个屏幕
              fit: StackFit.expand,
              children: [
                if (logic.isCP)
                  ImageView(
                    context.isDarkMode
                        ? 'assets/images/cp-bg-02.png'
                        : 'assets/images/cp-bg-01.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    boxFit: BoxFit.cover,
                  ),
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      GetBuilder<WebGamesController>(
                        id: "title",
                        builder: (controller) {
                          return controller.fullScreen == false
                              ? _title()
                              : Container();
                        },
                      ),
                      _webGame(settings),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  ///头部
  Widget _title() {
    return SizedBox(
      height: 40.h,
      child: Container(
        margin: EdgeInsets.only(left: 5.w, right: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: ImageView(
                        'assets/images/icon/games_off.png',
                        width: 25.w,
                        height: 25.w,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      )),
                  Container(
                    width: 14.w,
                  ),
                  InkWell(
                      onTap: () => controller.onGamesRefresh(),
                      child: ImageView(
                        'assets/images/icon/games_refresh.png',
                        width: 25.w,
                        height: 25.w,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                child: Text(
                  logic.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white
                        : const Color(0xFF303442),
                    fontSize: TyTextScaler.instance().scale(18.sp),
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  _buildBalance(context),
                  Container(
                    width: 14.w,
                  ),
                  InkWell(
                      onTap: () => controller.onFullScreen(),
                      child: ImageView(
                        'assets/images/icon/games_screen.png',
                        width: 25.w,
                        height: 25.w,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///账户余额
  Widget _buildBalance(BuildContext context) {
    return GetBuilder<TYUserController>(builder: (controller) {
      return Container(
        height: 22.h,
        padding: EdgeInsets.only(
          left: 6.w,
          right: 6.w,
        ),
        margin: EdgeInsets.all(2.w),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.03999999910593033)
              : const Color(0xFFF2F2F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            TYUserController.to.getBalance();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageView('assets/images/home/icon_trans_nor.svg',
                  width: 16.w, height: 16.w),
              Container(
                width: 5.w,
              ),
              Text(
                controller.balance.value != null
                    ? controller.toAmountSplit(
                        controller.balance.value!.amount.toStringAsFixed(2))
                    : '-',
                style: TextStyle(
                  color: context.isDarkMode
                      ? const Color(0xE5FFFFFF)
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'DIN Alternate',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  ///webView
  Widget _webGame(InAppWebViewSettings settings) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            color: context.isDarkMode
                ? const Color(0xFF1E2029)
                : const Color(0xFFf8f9fa),
            child: InAppWebView(
              initialSettings: settings,
              initialUrlRequest: URLRequest(url: WebUri(logic.url)),
              onWebViewCreated: (controllerx) {
                controller.webViewController = controllerx;
              },
              onProgressChanged: (controllerx, progress) {
                if (progress == 100) {
                  setState(() {
                    logic.progress = false;
                  });
                }
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
            ),
          ),
          if (logic.progress == true)
            Center(
              child: Container(
                alignment: Alignment.center,
                color: context.isDarkMode
                    ? const Color(0xFF1E2029)
                    : const Color(0xFFf8f9fa),
                child: ImageView(
                  oddsInfoLoadingGif,
                  width: 70.w,
                ),
              ),
            ),
          GetBuilder<WebGamesController>(
            id: "title",
            builder: (controller) {
              return controller.fullScreen == true
                  ? NSuspension(
                      childSize: const Size(35, 35),
                      bgChild: Container(
                        color: Colors.black.withValues(
                            alpha: 0.0), //Color.fromRGBO(242, 243, 248, 1),
                      ),
                      child: ImageView(
                        'assets/images/icon/games_out.png',
                        width: 35.w,
                        height: 35.w,
                      ),
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<WebGamesController>();
    super.dispose();
  }
}
