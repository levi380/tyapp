import 'dart:async';

import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/widgets/dialog/transfer_in_dialog.dart';
import 'package:filbet/widgets/dialog/transfer_in_game_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ty_app/app/utils/webview_ios_http_auth.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'VenueSwitchSheet.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'guideOverlay.dart';
import 'package:filbet/src/game/gamelist/gamelist_controller.dart';

enum LoadGameStatus {
  loading,
  success,
  fail,
}

class GameInitController extends GetXBaseController
    with WidgetsBindingObserver {
  static GameInitController get to {
    final args = Get.arguments;
    final id = args?['game_id'] ?? '';
    return Get.find<GameInitController>(tag: id);
  }

  final Rx<Orientation> orientation = Orientation.portrait.obs;

  final Rx<LoadGameStatus> _loadStatus = LoadGameStatus.loading.obs;

  set loadStatus(LoadGameStatus v) => _loadStatus.value = v;

  LoadGameStatus get loadStatus => _loadStatus.value;

  WebViewController webViewController = WebViewController();

  RxBool webviewProgressOk = false.obs;

  String? failText;

  Timer? _webLoadWatchTimer;

  void _cancelWebLoadWatch() {
    _webLoadWatchTimer?.cancel();
    _webLoadWatchTimer = null;
  }

  /// 网页开始加载后若超过 [duration] 仍未达到可展示进度，则提示检查网络。
  void _scheduleWebLoadWatch(
      {Duration duration = const Duration(seconds: 30)}) {
    _cancelWebLoadWatch();
    _webLoadWatchTimer = Timer(duration, () {
      _webLoadWatchTimer = null;
      if (isClosed) return;
      if (loadStatus != LoadGameStatus.success) return;
      if (webviewProgressOk.value) return;
      GlobalDialogHelper.showGameWebLoadTimeoutDialog();
    });
  }

  ///全屏
  RxBool fullScreen = false.obs;
  String? platform_id;
  String? game_id;

  RxBool showGuide = false.obs;

  RxBool showGameVenue = false.obs;

  ///游戏名字
  String name = '';

  CategoryType? categoryType;
  RxString platformImageUrl = ''.obs;

  @override
  void onInit() async {
    showGuide.value = UserService.to.state.userInfo.guide ?? false;

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    if (Get.arguments is Map) {
      name = Get.arguments?['title'] ?? '';
      platform_id = Get.arguments["platform_id"];
      game_id = Get.arguments["game_id"];
      categoryType = Get.arguments["type"];

      platformImageUrl.value =
          "${Api.imageurl}/game/platform/h5/${GlobalService.to.state.language.code}/${platform_id.toString()}.webp" ??
              "";
    }
    super.onInit();
  }

  @override
  void onReady() {
    _getGameUrl();
    checkAndTransferIn();
    super.onReady();
  }

  // Future<String?> platformBalance(String? pid) async {
  //   if (pid == null) {
  //     return null;
  //   }
  //   var resp = await ApiRequest.platformBalance(pid);
  //   return resp;
  // }

  void checkAndTransferIn() {
    num amount = num.tryParse(UserService.to.state.centerBalance.value) ?? 0;
    if (UserService.to.state.userInfo.autoTransfer == 1 && amount > 0) {
      transferInCheck(platform_id, amount.toString());
    }
  }

  //转入流水检查
  Future transferInCheck(String? platId, String amount) async {
    if (platId == null) {
      return;
    }
    var resp = await ApiRequest.transferInCheck(platId, amount);
    if (resp != null) {
      num existingTurnover = num.tryParse(resp.existingTurnover ?? '') ?? 0;
      if (existingTurnover > 0) {
        Get.dialog(
          TransferInGameDialog(
            existingTurnover,
            onOneKeyRecycle: () {
              ApiRequest.balanceRecover()
                  .then((_) => UserService.to.queryTotalBalance());
            },
          ),
          barrierDismissible: false,
        ).then((value) {
          if (value is String) {
            transferInWallet(platId, value);
          }
        });
      }
      //如果没有流水稽核，后台自动转入，无需前端处理
      // else {
      //   transferInWallet(platId, amount.toString());
      // }
    }
  }

  //转进场馆
  void transferInWallet(String? pid, String? amount) async {
    if (pid == null || amount == null) {
      return;
    }
    var resp = await ApiRequest.transferInWallet(pid, amount);
    if (resp == true) {
      UserService.to.queryTotalBalance();
    }
  }

  //转出场馆
  Future<PlatformCheckOutModel?> transferOutWallet(
      String? pid, String? amount) async {
    if (pid == null || amount == null) {
      return null;
    }
    var resp = await ApiRequest.transferOutWallet(pid, amount);
    return resp;
  }

  Future<String> gameInit() async {
    String currencyint = UserService.to.state.currencyType.code;

    var response = await HttpClient.get(Api.launch, queryParameters: {
      "pid": platform_id ?? "",
      "game_id": game_id ?? "",
      "cur": currencyint
    });
    if (response.status == false) {
      throw response.error!;
    }
    return response.data;
  }

  Future<void> _configureGameWebViewAfterUrl(String content) async {
    final NavigationDelegate nav = NavigationDelegate(
      onNavigationRequest: (request) {
        return NavigationDecision.navigate;
      },
      onProgress: (progress) {
        if (progress > 90) {
          webviewProgressOk.value = true;
          fullScreen.value = false;
          _cancelWebLoadWatch();
        }
      },
      onWebResourceError: (error) {
        print('onWebResourceError $error');
      },
      onPageFinished: (String url) {
        print('onPageFinished $url');
      },
      onPageStarted: (String url) {
        print('onPageStarted $url');
      },
      onUrlChange: (change) {
        print('onUrlChange ${change.url}');
      },
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    await tyWebViewBindNavigationAndLoad(
      controller: webViewController,
      navigationDelegate: nav,
      loadRequestUri:
          content.startsWith('http') ? Uri.parse(content) : null,
      loadHtmlString: content.startsWith('http') ? null : content,
    );
    loadStatus = LoadGameStatus.success;
    _scheduleWebLoadWatch();
  }

  void _getGameUrl() {
    _cancelWebLoadWatch();
    loadStatus = LoadGameStatus.loading;
    webviewProgressOk.value = false;
    fetchHandler<String>(
      gameInit(),
      onSuccess: (response) {
        unawaited(_configureGameWebViewAfterUrl(response));
      },
      onError: (exception) {
        GlobalDialogHelper.showMaintainDialog("", onConfirm: () {
          Get.back(); // 返回上一页
        });
      },
    );
  }

  ///全屏
  void tapFullScreen() {
    fullScreen.value = !fullScreen.value;
  }

  ///刷新
  void refreshData() {
    if (loadStatus == LoadGameStatus.success && webviewProgressOk.value) {
      webviewProgressOk.value = false;
      webViewController?.clearCache();
      webViewController?.reload();
      _scheduleWebLoadWatch();
    } else if (loadStatus == LoadGameStatus.fail) {
      _getGameUrl();
    }
  }

  ///完成
  void onComplete(TopActionType type) {
    GameInitController.to.showGameVenue.value = false; //

    Future.delayed(const Duration(milliseconds: 500), () {
      if (type == TopActionType.home) {
        Get.until((route) => route.isFirst); // 回到首页
      }
      if (type == TopActionType.deposit) {
        AppNavigator.onGoRecharge();
      }
      if (type == TopActionType.reload) {
        refreshData();
      }
      if (type == TopActionType.support) {
        AppNavigator.gotoseveice();
      }
    });
  }

  // Function(VenueModel venue, CategoryModel category)? ongotogame,
  ongotogame(VenueModel venue, CategoryModel category) {
    GameInitController.to.showGameVenue.value = false;

    categoryType = CategoryType.fromId(category.id ?? 0);
    if (venue.gameId == null || venue.gameId!.isEmpty) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (Get.previousRoute == "/game-list") {
          Get.back();
          GameListController.to.ongotogame(venue, category);
        } else {
          Get.back();
          AppNavigator.gotoGameList(venue, categoryType!);
        }
      });
    } else {
      // name = venue.name ?? "";
      // platform_id = venue.id ?? "";
      // game_id = venue.gameId ?? "";
      // categoryType = CategoryType.fromId(category.id ?? 0);
      // // _getGameUrl();
      // fullScreen.refresh();
      // _getGameUrl();
      // refreshData();
      //  gotoGame(model.id ?? "", model.gameId?? "", model.name ?? "");

      if (Get.isRegistered<GameInitController>(tag: game_id)) {
        Get.delete<GameInitController>(tag: game_id, force: true);
      }

      Get.offAndToNamed(
        Get.currentRoute,
        arguments: {
          "platform_id": venue.id ?? "",
          "game_id": venue.gameId ?? "",
          "title": venue.name ?? "",
          "type": categoryType
        },
      );
    }
  }

  @override
  void onClose() async {
    _cancelWebLoadWatch();
    WidgetsBinding.instance.removeObserver(this);

    webViewController.clearCache();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // if (UserService.to.state.userInfo.autoTransfer == 1) {
    //   ApiRequest.balanceRecover().then((_) => UserService.to.queryTotalBalance());
    // }
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    final newOrientation = WidgetsBinding
                .instance.platformDispatcher.views.first.physicalSize.width >
            WidgetsBinding
                .instance.platformDispatcher.views.first.physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    if (newOrientation != orientation.value) {
      orientation.value = newOrientation;
    }

    if (orientation.value == Orientation.landscape) {
      fullScreen.value = true;
    } else {
      fullScreen.value = false;
    }
  }
}

class GlobalDialogHelper {
  static void showMaintainDialog(String message, {VoidCallback? onConfirm}) {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      SkBaseDialog(
        title: "tips".tr,
        showDeleteBtn: false,
        showDeleteBtnType: '1',
        margin: EdgeInsets.symmetric(horizontal: 30.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Text(
                message.isEmpty ? "当前场馆已维护，请返回首页".tr : message,
                style: TextStyle(fontSize: 16.sp, height: 1.5),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back(); // 关闭弹窗
                Future.delayed(const Duration(milliseconds: 200), () {
                  onConfirm?.call();
                });
              },
              child: Container(
                height: 40.r,
                alignment: Alignment.center,
                child: Text(
                  "confirm".tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appnewColors.text1,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showGameWebLoadTimeoutDialog() {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      SkBaseDialog(
        title: "tips".tr,
        showDeleteBtn: false,
        showDeleteBtnType: '1',
        margin: EdgeInsets.symmetric(horizontal: 30.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Text(
                "game_web_load_timeout_tip".tr,
                style: TextStyle(fontSize: 16.sp, height: 1.5),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 40.r,
                alignment: Alignment.center,
                child: Text(
                  "confirm".tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appnewColors.text1,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
