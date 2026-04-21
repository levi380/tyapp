import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/my_assets/model/item_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/dialog/recycle_result_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class MyAssetsController extends GetXBaseController {
  final isExpanded = false.obs; // 控制展开/收起状态
  final items = [
    ItemModel(
      index: 1,
      name: 'deposit'.tr,
      icon: Assets.mineIconDeposit,
    ),
    ItemModel(
      index: 2,
      name: 'transfer'.tr,
      icon: Assets.mineIconTransfer,
    ),
    ItemModel(
      index: 3,
      name: 'withdraw'.tr,
      icon: Assets.mineIconWithdraw,
    ),
    ItemModel(
      index: 4,
      name: 'bank_card'.tr,
      icon: Assets.mineIconBank,
    ),
  ];
  final GlobalKey globalKey = GlobalKey();

  // 使用 UserService 的状态
  UserServiceState get state => UserService.to.state;

  RxList<PlatformWalletModel> get walletList => state.walletList;

  RxBool get isRefreshing => state.isRefreshingWallet;

  RxString get centerAmount => state.centerBalance;

  RxString get lockAmount => state.lockBalance;

  RxString get totalAmount => state.totalBalance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    queryWalletList();
    super.onReady();
  }

  void clickItem(ItemModel model) {
    switch (model.index) {
      case 1:
        Get.toNamed(Routes.DEPOSIT);
        break;
      case 2:
        Get.toNamed(Routes.TRANSFER);
        break;
      case 3:
        Get.toNamed(Routes.WITHDRAW);
        break;
      case 4:
        Get.toNamed(Routes.ACCOUNT_MANAGE);
        break;
    }
  }

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }

  Future<void> oneKeyRecycle() async {
    SmartDialog.showLoading();
    if (walletList.isEmpty) {
      SmartDialog.dismiss();
      AppUtils.showToast('没有可回收的余额');
      return;
    }
    // 收集需要回收的钱包（余额大于0的）
    final recycleTasks = <Future<PlatformCheckOutModel?>>[];
    final recycleItems = <PlatformWalletModel>[];

    for (var item in walletList) {
      final amount = num.tryParse(item.balance ?? '0') ?? 0;
      if (amount > 0) {
        recycleTasks.add(transferOutWallet(item.walletId, item.balance));
        recycleItems.add(item);
      }
    }
    if (recycleTasks.isEmpty) {
      AppUtils.showToast('没有可回收的余额');
      SmartDialog.dismiss();
      return;
    }
    final results = await Future.wait(recycleTasks);
    final stateCode101Items = <PlatformWalletModel>[];
    for (int i = 0; i < results.length; i++) {
      final result = results[i];
      if (result != null && result.stateCode == 101) {
        recycleItems[i].remainTurnover = result.remainTurnover;
        stateCode101Items.add(recycleItems[i]);
      }
    }
    SmartDialog.dismiss();
    // 只刷新有转出的钱包余额
    for (var item in recycleItems) {
      platformBalance(item.walletId);
    }
    // 刷新中心钱包余额
    queryWalletList();

    if (stateCode101Items.isNotEmpty) {
      Get.dialog(RecycleResultDialog(
        models: stateCode101Items,
      ));
    } else {
      AppUtils.showToast('回收成功');
    }
  }

  Future queryWalletList() async {
    await UserService.to.queryWalletList();
    // if (walletList.isNotEmpty) {
    //   await UserService.to.financePlatformBalance();
    // }
  }

  void platformBalance(String? pid) async {
    if (pid == null) {
      return;
    }
    await UserService.to.platformBalance(pid);
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
}
