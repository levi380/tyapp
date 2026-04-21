import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/game/gameinit/draggable_icon.dart';
import 'package:filbet/src/game/gameinit/game_init_controller.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'guideOverlay.dart';
import 'package:filbet/services/user/user_service.dart';
import 'gameVenueOverlay.dart';

abstract class TaggedGetView<T extends GetxController> extends StatelessWidget {
  const TaggedGetView({super.key});

  String? get tag;

  T get controller {
    // 确保 controller 已注册，如果未注册则抛出更清晰的错误
    if (!Get.isRegistered<T>(tag: tag)) {
      throw Exception('Controller $T not found with tag: $tag. '
          'Make sure the binding is properly configured.');
    }
    return Get.find<T>(tag: tag);
  }
}

class GameInitView extends TaggedGetView<GameInitController> {
  const GameInitView({super.key});

  @override
  String? get tag => (Get.arguments as Map?)?["game_id"]?.toString();

  Widget _error(GameInitController ctrl) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(40.r),
      child: Text(
        ctrl.failText ?? "",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }

  Widget _gameView(GameInitController ctrl) {
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: ctrl.webViewController!.platform,
          displayWithHybridComposition: false,
        ),
      );
    } else {
      return WebViewWidget(
        controller: ctrl.webViewController!,
      );
    }
  }

  Widget _body(GameInitController ctrl) {
    switch (ctrl.loadStatus) {
      case LoadGameStatus.success:
        return Stack(
          alignment: Alignment.center,
          children: [
            _gameView(ctrl),
            if (ctrl.fullScreen.value)
              OrientationWidget(
                childSize: 30.r,
                child: _fullScreenIcon(ctrl),
              ),
            if (!ctrl.webviewProgressOk.value) loadinngView()
          ],
        );

      case LoadGameStatus.fail:
        return Stack(
          alignment: Alignment.center,
          children: [
            _error(ctrl),
            if (ctrl.fullScreen.value)
              OrientationWidget(
                childSize: 30.r,
                child: _fullScreenIcon(ctrl),
              ),
          ],
        );

      default:
        return loadinngView();
    }
  }

  Widget _fullScreenIcon(GameInitController ctrl) {
    return GestureDetector(
      onTap: () {
        ctrl.tapFullScreen();
      },
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Obx(() => Image.asset(
              ctrl.fullScreen.value
                  ? Assets.homeDownScreen
                  : Assets.homeFullScreen,
              width: ctrl.fullScreen.value ? 30.w : 16.w,
              height: ctrl.fullScreen.value ? 30.w : 16.w,
              fit: BoxFit.fill,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 确保 controller 已注册，如果未注册则显示加载或错误
    if (!Get.isRegistered<GameInitController>(tag: tag)) {
      return const Center(child: CircularProgressIndicator());
    }

    final ctrl = controller; // 提前获取 controller，避免在 Obx 中重复查找

    return Stack(
      children: [
        Obx(() => CustomScffold(
              needAppbar: !ctrl.fullScreen.value,
              showBgTexture: false,
              backgroundColor: appnewColors.bg2,
              appBar: ctrl.fullScreen.value
                  ? null
                  : CustomAppbar.backcenterView(
                      left: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 28.w,
                              height: 28.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.asset(
                                Assets.homeIconGameCloes,
                                width: 16.w,
                                height: 16.w,
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                      center: Column(children: [
                        Container(
                          color: Colors.transparent,
                          child: Image.asset(
                            Assets.homeGameTop,
                            width: 79,
                            height: 20,
                          ),
                        ).toBtn(
                          onTap: () {
                            ctrl.showGameVenue.value = true;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => SKNetworkImage(
                                  imageUrl: ctrl.platformImageUrl.value,
                                  width: 24.w,
                                  height: 24.w,
                                )),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              ctrl.name ?? "",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0xff131416),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ]),
                      actions: [
                        Align(
                          child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: GestureDetector(
                                onTap: () {
                                  ctrl.refreshData();
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
                        Align(
                          child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: _fullScreenIcon(ctrl)),
                        )
                      ],

                      // style: const TextStyle(
                      //   fontSize: 20,
                      //   color: PageStyle.c_FFFFFF,
                      // ),
                      backgroundColor: appnewColors.bg1,
                      // actions: _buildActions(),
                    ),
              body: SafeArea(child: _body(ctrl)),
            )),
        // 引导层
        Obx(() {
          return (ctrl.showGuide.value)
              ? Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [Color(0xffE6F1FE), Colors.white],
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        // ),
                        color: Colors.black54,
                      ),
                      child: GuideOverlay(
                        onClose: () {
                          ctrl.showGuide.value = false;

                          UserService.to.state.userInfo.guide = false;
                          // Get.back();
                          // onComplete?.call();
                        },
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink();
        }),

        Obx(() {
          final show = ctrl.showGameVenue.value;

          return Positioned.fill(
              child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: show
                ? GameVenueOverlay(
                    key: const ValueKey("panel"),
                  )
                : const SizedBox.shrink(),
          ));
        }),
      ],
    );
  }
}
