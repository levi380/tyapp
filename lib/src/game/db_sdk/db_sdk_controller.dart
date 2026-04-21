import 'package:filbet/constants/init.dart' show navigatorStateKey;
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/widgets/dialog/transfer_in_game_dialog.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/main.dart' as ty_main;

class DbSdkController extends GetxController {
  String platform_id = "";
  String game_id = "";
  final gameUrl = ''.obs;

  @override
  void onInit() {
    if (Get.arguments is Map) {
      platform_id = Get.arguments["platform_id"] ?? '';
      game_id = Get.arguments["game_id"] ?? '';
    }
    super.onInit();
  }

  @override
  void onReady() {
    queryGameUrl();
    checkAndTransferIn();
    super.onReady();
  }

  void queryGameUrl() async {
    gameUrl.value = await ApiRequest.gameInit(platform_id, game_id) ?? '';
  }

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

  @override
  void onClose() {
    // 嵌入的体育 SDK 使用独立 GetMaterialApp 且传了 navigatorKey；GetX 会通过
    // Get.addKey 把全局导航 key 指到子树。子树销毁后必须恢复主工程的 key，否则
    // 主应用里 Get.toNamed 等会报 contextless navigation。
    ty_main.oBContext = null;
    final rootKey = navigatorStateKey;
    if (rootKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.addKey(rootKey);
      });
    }
    super.onClose();
  }
}
