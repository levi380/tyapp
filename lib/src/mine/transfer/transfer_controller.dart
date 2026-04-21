import 'dart:math';

import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/transfer/widgets/bottom_auto_wallet_list.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/widgets/dialog/recycle_result_dialog.dart';
import 'package:filbet/widgets/dialog/transfer_in_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class TransferController extends GetXBaseController {
  final hidePlatform = true.obs;
  final autoTransfer = false.obs;
  final Rx<PlatformWalletModel?> outWallet = Rx(null); //转出钱包
  final Rx<PlatformWalletModel?> inWallet = Rx(null); //转入钱包
  late TextEditingController amountController;
  final welfareAmount = '--'.obs; //福利中心
  final centerPlatformWallet =
      PlatformWalletModel(walletName: '中心钱包', walletId: '-1');

  final submitEnable = false.obs; //立即转账是否可点击
  /// 金额输入错误时的提示文案，为空表示无错误
  final amountErrorMsg = ''.obs;
  final GlobalKey welfareCenterKey = GlobalKey();

  /// 防抖：上次提交时间，用于避免重复点击
  DateTime? _lastSubmitTime;
  static const int _submitDebounceMs = 3000;

  // 使用 UserService 的状态
  UserServiceState get state => UserService.to.state;

  RxList<PlatformWalletModel> get walletList => state.walletList;

  RxBool get isRefreshing => state.isRefreshingWallet;

  RxString get centerAmount => state.centerBalance;

  RxString get lockAmount => state.lockBalance;

  RxString get totalAmount => state.totalBalance;

  @override
  void onInit() {
    initEditController();
    super.onInit();
  }

  @override
  void onReady() {
    initAutoTransfer();
    financeWelfareWallet();
    queryWalletList();
  }

  void initEditController() {
    amountController = TextEditingController()..addListener(textListener);
  }

  void textListener() {
    _updateAmountState();
  }

  void _updateAmountState() {
    final text = amountController.text.trim();
    num amount = num.tryParse(text) ?? 0;
    if (amount <= 0) {
      submitEnable.value = false;
      amountErrorMsg.value = text.isEmpty ? '' : '请输入有效金额';
      return;
    }
    final pid = outWallet.value?.walletId;
    final isIn = pid == '-1';
    if (isIn) {
      num center = num.tryParse(centerAmount.value) ?? 0;
      amountErrorMsg.value = amount > center ? '中心钱包余额不足' : '';
    } else {
      num outBalance = num.tryParse(outWallet.value?.balance ?? '0') ?? 0;
      amountErrorMsg.value = amount > outBalance ? '场馆余额不足' : '';
    }
    // 有错误提示时提交按钮不可点击
    submitEnable.value = amountErrorMsg.value.isEmpty;
  }

  void initAutoTransfer() {
    autoTransfer.value = UserService.to.state.userInfo.autoTransfer == 1;
    if (autoTransfer.value) {
      recycleBalance();
    }
  }

  void initAutoWallet() {
    outWallet.value = centerPlatformWallet;
    for (var wallet in walletList) {
      if (wallet.locked != 1 && wallet.maintained != 2) {
        inWallet.value = wallet;
        return;
      }
    }
  }

  Future<void> oneKeyRecycle() async {
    SmartDialog.showLoading();
    if (walletList.isEmpty) {
      SmartDialog.dismiss();
      AppUtils.showToast('回收成功');
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
      SmartDialog.dismiss();
      AppUtils.showToast('回收成功');
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
    // for (var item in recycleItems) {
    //   platformBalance(item.walletId);
    // }
    // 刷新中心钱包余额
    refreshWalletBalance();

    if (stateCode101Items.isNotEmpty) {
      Get.dialog(RecycleResultDialog(
        models: stateCode101Items,
      ));
    } else {
      AppUtils.showToast('回收成功');
    }
  }

  void hideOrShowPlatform(bool hide) {
    hidePlatform.value = hide;
  }

  void changeAutoTransfer(bool auto) {
    updateAutoTransfer();
  }

  /// 显示转账钱包选择弹窗
  /// [isOut] true: 选择转出钱包, false: 选择转入钱包
  void showTransferWallet(bool isOut) {
    final models = [centerPlatformWallet, ...walletList];
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (c) {
        return BottomAutoWalletList(
          models: models,
          checkedModel: isOut ? outWallet.value : inWallet.value,
          walletSelect: (model) {
            if (isOut) {
              _handleOutWalletSelection(model);
            } else {
              _handleInWalletSelection(model);
            }
          },
        );
      },
    );
  }

  /// 交换转出和转入钱包
  void changeWallet() {
    print(
        "object123456 ${inWallet.value?.walletName} ${inWallet.value?.balance}");
    final tempOut = outWallet.value;
    final tempIn = inWallet.value;
    outWallet.value = tempIn;
    inWallet.value = tempOut;
    _updateAmountState();
  }

  /// 全部
  void clickAll() {
    String? pid = outWallet.value?.walletId;
    bool isIn = pid == '-1';
    if (isIn) {
      amountController.text =
          (num.tryParse(centerAmount.value) ?? 0).toString().toFixed2();
    } else {
      amountController.text =
          (num.tryParse(outWallet.value?.balance ?? '0') ?? 0)
              .toString()
              .toFixed2();
    }
  }

  void transferInPlatform(PlatformWalletModel model) {
    num center = num.tryParse(centerAmount.value) ?? 0;
    if (center <= 0) {
      AppUtils.showToast('中心钱包余额不足');
      return;
    }
    //中心钱包检查
    transferInCheck(model.walletId, center.toString());
  }

  Future<void> submitTransfer() async {
    final now = DateTime.now();
    if (_lastSubmitTime != null &&
        now.difference(_lastSubmitTime!).inMilliseconds < _submitDebounceMs) {
      return;
    }
    _lastSubmitTime = now;

    String? pid = outWallet.value?.walletId;
    bool isIn = pid == '-1';
    num amount = num.tryParse(amountController.text) ?? 0;
    if (amount <= 0) {
      AppUtils.showToast('请输入有效金额');
      return;
    }
    if (isIn) {
      num center = num.tryParse(centerAmount.value) ?? 0;
      if (amount > center) {
        AppUtils.showToast('余额不足，请重新输入金额');
        return;
      }
      //中心钱包检查
      transferInCheck(inWallet.value?.walletId, amount.toString());
    } else {
      num center = num.tryParse(outWallet.value?.balance ?? '0') ?? 0;
      if (amount > center) {
        AppUtils.showToast('转出钱包余额不足');
        return;
      }
      final result = await transferOutWallet(pid, amount.toString());
      if (result != null && result.stateCode == 101) {
        // stateCode=101 的情况，显示弹窗
        final outWalletModel = outWallet.value;
        if (outWalletModel != null) {
          outWalletModel.remainTurnover = result.remainTurnover;
          Get.dialog(RecycleResultDialog(
            models: [outWalletModel],
          ));
        }
      } else {
        if (result == null) {
          //这里逻辑改的，不想说了
          AppUtils.showToast('转出成功');
        } else if (result.stateCode == 201) {
          AppUtils.showToastForResponse(result.errorMessage);
        }
      }
      // 刷新转出钱包余额和中心钱包余额
      // if (pid != null) {
      //   platformBalance(pid);
      // }
      amountController.clear();
      refreshWalletBalance();
    }
  }

  void onlineServer() {
    Get.dialog(
      SkBaseDialog(
        bgColor: Colors.transparent,
        callback: () {
          Get.back();
        },
        cancelCallback: () {},
        showFooterBtn: false,
        showDeleteBtn: true,
        showDeleteBtnType: '2',
        child: DialogKfView(),
      ),
    );
  }

  /// 处理转出钱包选择逻辑
  /// 规则：场馆钱包之间不能直接互转，必须通过中心钱包
  void _handleOutWalletSelection(PlatformWalletModel model) {
    final isCenterWallet = model.walletId == '-1';
    if (isCenterWallet) {
      // 选择中心钱包时，如果转入钱包也是中心钱包，则交换
      if (inWallet.value?.walletId == '-1') {
        inWallet.value = outWallet.value;
      }
    } else {
      // 选择场馆钱包时，转入钱包必须设为中心钱包
      inWallet.value = centerPlatformWallet;
    }
    outWallet.value = model;
    _updateAmountState();
  }

  /// 处理转入钱包选择逻辑
  /// 规则：场馆钱包之间不能直接互转，必须通过中心钱包
  void _handleInWalletSelection(PlatformWalletModel model) {
    final isCenterWallet = model.walletId == '-1';
    if (isCenterWallet) {
      // 选择中心钱包时，如果转出钱包也是中心钱包，则交换
      if (outWallet.value?.walletId == '-1') {
        outWallet.value = inWallet.value;
      }
    } else {
      // 选择场馆钱包时，转出钱包必须设为中心钱包
      outWallet.value = centerPlatformWallet;
    }
    inWallet.value = model;
    _updateAmountState();
  }

  Future queryWalletList() async {
    await UserService.to.queryWalletList() ?? [];
    if (walletList.isNotEmpty) {
      initAutoWallet();
//      financePlatformBalance();
    }
  }

  Future refreshWalletBalance() async {
    await UserService.to.queryWalletList();

    for (var wallet in walletList) {
      if (wallet.walletId == outWallet.value?.walletId) {
        outWallet.value?.balance = wallet.balance;
      }
      if (wallet.walletId == inWallet.value?.walletId) {
        inWallet.value?.balance = wallet.balance;
      }
    }
  }

  void recycleBalance() {
    ApiRequest.balanceRecover().then((_) => UserService.to.queryTotalBalance());
  }

  void financeWelfareWallet() async {
    var resp = await ApiRequest.financeWelfareWallet();
    if (resp != null) {
      welfareAmount.value = resp.balance ?? '0';
    }
  }

  // void financePlatformBalance() {
  //   for (var model in walletList) {
  //     platformBalance(model.walletId);
  //   }
  // }

  // void platformBalance(String? pid) async {
  //   if (pid == null) {
  //     return;
  //   }
  //   var resp = await ApiRequest.platformBalance(pid);
  //   if (resp != null) {
  //     walletList.where((item) => item.walletId == pid).first.balance = resp;
  //     walletList.refresh();
  //   }
  // }

  //转进场馆
  void transferInWallet(String? pid, String? amount) async {
    if (pid == null || amount == null) {
      return;
    }
    var resp = await ApiRequest.transferInWallet(pid, amount);
    if (resp == true) {
      AppUtils.showToast('转入成功');
      refreshWalletBalance();
//      platformBalance(pid);
      amountController.clear();
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

  //更新是否自动转账
  void updateAutoTransfer() async {
    int auto = autoTransfer.value ? 2 : 1;
    var resp = await ApiRequest.updateAutoTransfer(auto);
    if (resp == true) {
      UserService.to.state.userInfo.autoTransfer = auto;
      initAutoTransfer();
    }
  }

  //转入流水检查
  Future transferInCheck(String? platId, String amount) async {
    if (platId == null) {
      AppUtils.showToast('转入钱包异常，请稍后重试');
      return;
    }
    var resp = await ApiRequest.transferInCheck(platId, amount);
    if (resp != null) {
      num existingTurnover = num.tryParse(resp.existingTurnover ?? '') ?? 0;
      if (existingTurnover > 0) {
        Get.dialog(
          TransferInDialog(existingTurnover),
          barrierDismissible: false,
        ).then((value) {
          if (value is bool && value) {
            transferInWallet(platId, amount.toString());
          }
        });
      } else {
        transferInWallet(platId, amount.toString());
      }
    }
  }
}
