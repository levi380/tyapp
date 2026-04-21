import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/src/main/main_controller.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart' as flutter_ty_app;
import 'package:get/get.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/themes/app_newcolor.dart';

class AppNavigator {
  AppNavigator._();

  static void startMain() {
    Get.offAllNamed(Routes.MAIN);
  }

  static void startMainByIndex({int? tabIndex}) {
    // 优先：如果路由栈里已经有 MAIN，就返回到 MAIN，不重新创建
    var reachedMain = false;
    try {
      Get.until((route) {
        if (route.settings.name == Routes.MAIN) {
          reachedMain = true;
          return true;
        }
        return false;
      });
    } catch (_) {
      // ignore
    }

    if (!reachedMain) {
      // 栈里没有 MAIN：用 offNamed 替换当前页回到 MAIN（不清空所有）
      Get.offNamed(
        Routes.MAIN,
        arguments: tabIndex == null ? null : {"tabIndex": tabIndex},
      );
    } else {
      // 已回到 MAIN：如果需要切 tab，直接切
      if (tabIndex != null && Get.isRegistered<MainController>()) {
        MainController.to.jumpToPage(tabIndex);
      }
    }
  }

  static void gotohome() {
    Get.until((route) => route.isFirst);
    MainController.to.jumpToPage(0);
  }

  static void gotoseveice() {
    // Get.back();
    _showgotoseveiceDialog();
    // MainController.to.jumpToPage(2);
  }

  static void gotoseveiceForMain() {
    // Get.back();
    _showgotoseveiceDialog();
    // MainController.to.jumpToPage(2);
  }

  static void gotoSeveiceForAgent() {
    _showgotoseveiceDialog();
  }

  static void gotoHelpCenter() {
    Get.toNamed(Routes.HELP_CENTER);
  }

  static void gotoJoinUs() {
    if (UserService.to.state.isVisitor) {
      _showLoginDialog();
      return;
    }
    Get.toNamed(
      Routes.JOIN_US,
    );
  }

  static void gotoMessage({String type = "0"}) {
    if (UserService.to.state.isVisitor) {
      _showLoginDialog();
      return;
    }
    Get.toNamed(Routes.MESSAGE, arguments: {"type": type});
  }

  static void gotobet() {
    if (UserService.to.state.isVisitor) {
      _showLoginDialog();
      return;
    }
    Get.toNamed(Routes.BET_RECORD);
  }

  static void gotoweb(String url, String title) {
    Get.toNamed(Routes.WABURL, arguments: {"url": url, "title": title});
  }

  static void gotoSearch(
      String platform_id, String venue_id, CategoryType categoryType) {
    Get.toNamed(Routes.GAME_SEARCH, arguments: {
      "platform_id": platform_id,
      "venue_id": venue_id,
      "type": categoryType
    });
  }

  static void gotoGame(String platform_id, String gameId, String name,
      CategoryType categoryType) {
    print("object123456 platform_id=${platform_id} gameId=$gameId name=$name");
    if (platform_id == '404') {
      toDBSport(platform_id, gameId);
    } else {
      Get.toNamed(
        Routes.GAMEINIT,
        arguments: {
          "platform_id": platform_id,
          "game_id": gameId,
          "title": name,
          "type": categoryType
        },
      );
    }
  }

  static void gotoUserinfo() {
    Get.toNamed(Routes.USER_INFO);
  }

  static _showdialog() {
    Get.dialog(SkBaseDialog(
        title: "tips".tr,
        // showFooterBtn: true,
        showDeleteBtn: false,
        showDeleteBtnType: '1',
        // leftBtnTitle: "login".tr,
        // rightBtnTitle: "register".tr,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              child: Text(
                "当前场馆已维护，请返回首页".tr,
                style: TextStyle(
                    fontSize: 16.sp, height: 1.5, fontWeight: FontWeight.w400),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back(); // 关闭 dialog
                Future.delayed(const Duration(milliseconds: 200), () {
                  Get.back(); // 再返回上一页
                });
              },
              child: Container(
                  height: 40.r,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    "confirm".tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: appnewColors.text1,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          ],
        )));
  }

  static onGoRecharge() {
    if (UserService.to.state.isVisitor) {
      EventBus.emit(EventType.goToRegister);
      return;
    }
    Get.toNamed(Routes.DEPOSIT);
  }

  static void gotoGameList(VenueModel model, CategoryType categoryType) {
    if (UserService.to.state.isVisitor) {
      _showLoginDialog();
      return;
    }
    print('[AppNavigator.gotoGameList] model.id=' +
        (model.id?.toString() ?? 'null') +
        ' venue_id=' +
        (model.venueId?.toString() ?? 'null') +
        ' category=' +
        categoryType.id.toString());
    GlobalService.to.click(model.id ?? "", categoryType.id);
    if (model.gameId == null || model.gameId!.isEmpty) {
      Get.toNamed(
        Routes.GAME_LIST,
        arguments: {
          "platform_id": model.id,
          "venue_id": model.venueId,
          "title": model.name,
          "type": categoryType
        },
        // preventDuplicates: false, // 👈 强制新建 Binding
      );
    } else {
      print("object123456 gotoGame");
      gotoGame(
          model.id ?? "", model.gameId ?? "", model.name ?? "", categoryType);
    }
  }

  static void _showLoginDialog() {
    Get.dialog(SkBaseDialog(
      callback: () {
        Get.back();
        EventBus.emit(EventType.goToRegister);
      },
      cancelCallback: () {
        EventBus.emit(EventType.goToLogin);
      },
      title: "tips".tr,
      showFooterBtn: true,
      showDeleteBtn: false,
      showDeleteBtnType: '1',
      leftBtnTitle: "login".tr,
      rightBtnTitle: "register".tr,
      child: Container(
        padding: EdgeInsets.all(20.r),
        child: Text(
          "log_in_to_start_playing_proceed_to_log_in_now".tr,
          style: TextStyle(
              fontSize: 16.sp, height: 1.5, fontWeight: FontWeight.w400),
        ),
      ),
    ));
  }

  static void _showgotoseveiceDialog() {
    Get.dialog(SkBaseDialog(
        bgColor: Colors.transparent,
        callback: () {
          Get.back();
          EventBus.emit(EventType.goToRegister);
        },
        cancelCallback: () {
          EventBus.emit(EventType.goToLogin);
        },
        // title: "tips".tr,
        showFooterBtn: false,
        showDeleteBtn: true,
        showDeleteBtnType: '2',
        child: DialogKfView()));
  }

  static void gotoRegister() {
    Get.toNamed(Routes.LOGIN_AND_REGISTER, arguments: {"type": 1});
  }

  static void gotoLogin() {
    Get.toNamed(Routes.LOGIN_AND_REGISTER, arguments: {"type": 0});
  }

  static void toFeedBack() {
    Get.toNamed(Routes.FEEDBACK);
  }

  static Future toMyAssets() async {
    return Get.toNamed(Routes.MY_ASSETS);
  }

  static Future toTransactionRecord() async {
    return Get.toNamed(Routes.TRANSACTION_RECORD);
  }

  static void showLoginDialog() {
    _showLoginDialog();
  }

  static void toDBSport(String platform_id, String gameId) async {
    ///初始化数据
    await flutter_ty_app.TYInit();
    Get.toNamed(
      Routes.GAME_DB_SDK,
      arguments: {
        "platform_id": platform_id,
        "game_id": gameId,
      },
    );
    // String url =
    //     'https://app-h5.gtxy26.com/?token=153d72fd09d1a286b4d016fa003bb7eb40618371&gr=commo%20n&tm=1&lg=zh&mk=0&api=gbTX9lcytsMPH3Uq91etJEThmOzFIBolpj3HRS7no4Q=&sessionId=53274%20577951530532417764201965253';
    // print("12345 12345");
    // Navigator.of(Get.context!).push(
    //   GetPageRoute(
    //     page: () => WillPopScope(
    //       onWillPop: () async {
    //         Get.back();
    //         return false;
    //       },
    //       child: Scaffold(
    //         backgroundColor: Colors.white,
    //
    //         // 加载体育APP  locale  国际话语言,url  h5场馆url,env  体育环境
    //         body: flutter_ty_app.MyApp(
    //           locale: const Locale('zh', 'CN'), //默认中文
    //           url: url,
    //           env: 'prod', //默认生产环境
    //           context: Get.context, // 默认传 context  有首页返回场馆按钮， 不要首页返回按钮 传 null
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

// static void showdialog() {
//   _showdialog();
// }
}
