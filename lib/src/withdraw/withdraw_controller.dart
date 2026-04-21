import 'dart:async';

import 'package:filbet/common/currency.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/deposit/rate_model.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/accountChangeRecord/controllers/account_change_record_controller.dart'
    show AccountChangeType;
import 'package:filbet/src/security/security_controller.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/src/security/widgets/bottom_add_bank_card.dart';
import 'package:filbet/src/withdraw/wallet_account_model.dart';
import 'package:filbet/src/withdraw/wallet_model.dart';
import 'package:filbet/src/withdraw/withdraw_limit_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/widgets/dialog/recycle_result_dialog.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class WithdrawController extends GetXBaseController
    with GetTickerProviderStateMixin {
  final RxList<Currency> currencyList;
  final Rx<Currency> currency;
  final Rx<SecurityDataModel> securityData;
  late AnimationController? animationController;
  RxBool isSelectedWithdrawTypes = false.obs;

  final List<Map<String, dynamic>> withdrawTypesItems = [
    {"text": "微信提现"},
    {"text": "EBpay提币", "sub": "即时到账"},
  ];

  WithdrawController({
    required Currency currency,
    required List<Currency> avaliables,
    required SecurityDataModel securityData,
  })  : securityData = securityData.obs,
        currency = currency.obs,
        currencyList = avaliables.obs;

  final SecurityController securityController = Get.find();
  RxList<WalletAccountModel> allAccountList = RxList<WalletAccountModel>([]);

  final RxList<WalletAccountModel> accountList = <WalletAccountModel>[].obs;
  final Rx<WalletAccountModel?> selectedAccount = Rx<WalletAccountModel?>(null);

  final RxList<ChannelModel> channels = RxList<ChannelModel>([]);
  final Rx<ChannelModel?> selectedChannel = Rx<ChannelModel?>(null);
  final Rx<RateModel?> rateModel = Rx<RateModel?>(null);

//  final Rx<WalletModel?> walletModel = Rx<WalletModel?>(null);
  final Rx<WithdrawLimitModel?> withdrawLimitModel =
      Rx<WithdrawLimitModel?>(null);

  final Rx<double?> withdrawAmount = Rx<double?>(null);
  final Rx<String?> withdrawPassword = Rx<String?>(null);
  final Rx<int?> selectedAmount = Rx<int?>(null);

  var enteredWithdrawAmount = ''.obs;

  final GlobalKey welfareCenterKey = GlobalKey();

  bool get hasWithdrawPassword {
    return securityData.value.hasPayPwd;
  }

  bool get canPresentCurrencySelection {
    return currencyList.length > 1;
  }

  bool get isWithdrawEnabled {
    if (selectedChannel.value == null) {
      return false;
    }
    if (withdrawAmount.value == null || withdrawAmount.value! <= 0) {
      return false;
    }
    if (selectedAccount.value == null) {
      return false;
    }
    return selectedChannel.value!.isAmountValid(withdrawAmount.value!);
  }

  bool get isWithPasswordEnabled {
    return withdrawPassword.value?.length == 6;
  }

  late final TextEditingController withdrawAmountController;
  late final FocusNode withdrawAmountFocusNode;

  late final TextEditingController withdrawPasswordController;
  late final FocusNode withdrawPasswordFocusNode;

  final WalletService _walletService = WalletService();

  bool get isWithdrawInputAmountValid {
    if (withdrawAmount.value == null) {
      return true; // 如果没有输入金额，不显示错误
    }
    if (withdrawAmount.value == null) {
      return true;
    }
    final amount = withdrawAmount.value!;

    if (selectedChannel.value == null) {
      return false;
    }
    return selectedChannel.value!.isAmountValid(amount);
  }

  int get maxInputLength {
    if (selectedChannel.value == null) {
      return 1;
    }
    // 根据选中的渠道，获取最大输入长度
    return selectedChannel.value!.maxAmount.isNotEmpty
        ? selectedChannel.value!.maxAmount.length
        : 1;
  }

  // double get withdrawFee {
  //   if (withdrawAmount.value == null || rateModel.value == null) {
  //     return 0;
  //   }
  //   final fee = withdrawAmount.value! * (withdrawFeeRate / 100);
  //   return double.parse(fee.toStringAsFixed(2));
  // }
  //
  // double get withdrawFeeRate {
  //   if (selectedChannel.value == null) {
  //     return 0;
  //   }
  //   return double.tryParse(selectedChannel.value!.fee) ?? 0;
  // }
  //
  // String get withdrawFeePercentage {
  //   return '${(withdrawFeeRate).toStringAsFixed(2)}%';
  // }

  String get actualWithdrawAmount {
    String symblo = "";
    String? amount = "";
    if (selectedChannel.value?.paymentType == 1) {
      symblo = "USDT";
      amount = rateModel.value!.withdrawRate?.usdt;
    } else if (selectedChannel.value?.paymentType == 3) {
      symblo = "EB";
      amount = rateModel.value!.withdrawRate?.eb;
    } else if (selectedChannel.value?.paymentType == 4) {
      symblo = "NO";
      amount = rateModel.value!.withdrawRate?.no;
    } else if (selectedChannel.value?.paymentType == 5) {
      symblo = "HD";
      amount = rateModel.value!.withdrawRate?.hd;
    } else if (selectedChannel.value?.paymentType == 6) {
      symblo = "CNY";
      amount = rateModel.value!.withdrawRate?.cny;
    } else if (selectedChannel.value?.paymentType == 7) {
      symblo = "CNY";
      amount = rateModel.value!.withdrawRate?.cny;
    }
    if (withdrawAmount.value == null) {
      return '0.0 ${currency.value.abbr} = 0.0 ${symblo}';
    }

    final actualAmountInUsdt =
        (withdrawAmount.value ?? 0) * (double.tryParse(amount ?? "0.00") ?? 0);
    if (isAlipayOrBank()) {
      return '${truncateTo2(actualAmountInUsdt).toStringAsFixed(2)} $symblo';
    }
    return '${truncateTo2(withdrawAmount.value ?? 0).toStringAsFixed(2)} ${currency.value.abbr} = ${truncateTo2(actualAmountInUsdt).toStringAsFixed(2)} ${symblo}';
  }

  double truncateTo2(double value) {
    return (value * 100).truncateToDouble() / 100;
  }

  String get withdrawRangeForOneTimeText {
    if (selectedChannel.value == null) {
      return '';
    }
    return "input_min_max".trParams({
      'min': toThousands(selectedChannel.value!.minAmount),
      'max': toThousands(selectedChannel.value!.maxAmount),
    });
  }

  String get rateForUSDT {
    if (rateModel.value == null) {
      return '';
    }
    String rate = "";
    String symblo = "";
    if (selectedChannel.value?.paymentType == 1) {
      rate = rateModel.value!.withdrawRate?.usdt ?? "";
      symblo = "USDT";
    } else if (selectedChannel.value?.paymentType == 3) {
      rate = rateModel.value!.withdrawRate?.eb ?? "";
      symblo = "EB";
    } else if (selectedChannel.value?.paymentType == 4) {
      rate = rateModel.value!.withdrawRate?.eb ?? "";
      symblo = "NO";
    } else if (selectedChannel.value?.paymentType == 5) {
      rate = rateModel.value!.withdrawRate?.hd ?? "";
      symblo = "HD";
    } else if (selectedChannel.value?.paymentType == 6) {
      rate = rateModel.value!.withdrawRate?.cny ?? "";
      symblo = "CNY";
    } else if (selectedChannel.value?.paymentType == 7) {
      rate = rateModel.value!.withdrawRate?.cny ?? "";
      symblo = "CNY";
    }
    String doubleTruncate = "";
    if (rate.contains('.')) {
      doubleTruncate = truncateTo4DecimalsString(double.parse(rate));
    } else {
      doubleTruncate = rate;
    }

    //rateModel.value!.withdrawRate.getRateForCurrency(currency.value);
    switch (currency.value) {
      case Currency.rmb:
        return '1CNY≈${doubleTruncate} ${symblo}';
      // case Currency.vnd:
      //   return '1000VND≈${(double.parse(doubleTruncate ?? "0") * 1000)} ${symblo}';
      // case Currency.usd:
      //   return '1USD≈${doubleTruncate} ${symblo}';
      // case Currency.hkd:
      //   return '1HKD≈${doubleTruncate} ${symblo}';
      // case Currency.krw:
      //   return '1KRW≈${doubleTruncate} ${symblo}';
      // case Currency.idr:
      //   return '1IDR≈${doubleTruncate} ${symblo}';
      // case Currency.thb:
      //   return '1THB≈${doubleTruncate} ${symblo}';
      // case Currency.mxn:
      //   return '1MXN≈${doubleTruncate} ${symblo}';
      // case Currency.brl:
      //   return '1BRL≈${doubleTruncate} ${symblo}';
      // case Currency.inr:
      //   return '1INR≈${doubleTruncate} ${symblo}';
      // case Currency.php:
      //   return '1PHP≈${doubleTruncate} ${symblo}';
    }
  }

  String truncateTo4DecimalsString(double value) {
    if (value % 1 == 0) return value.toString(); // 整数直接返回
    double truncated = (value * 10000).truncateToDouble() / 10000;
    return truncated.toStringAsFixed(4); // 保证 4 位显示
  }

  StreamSubscription? _currencySubscription;

  @override
  void onInit() {
    queryWalletList();
    queryAmount();
    super.onInit();
    withdrawAmountController = TextEditingController();
    withdrawAmountFocusNode = FocusNode();

    withdrawPasswordController = TextEditingController();
    withdrawPasswordFocusNode = FocusNode();

    withdrawAmountController.addListener(() {
      final input = withdrawAmountController.text;
      if (input.isEmpty) {
        withdrawAmount.value = null;
      } else {
        final parsedValue = double.tryParse(input);
        if (parsedValue != null) {
          withdrawAmount.value = parsedValue;
        } else {
          withdrawAmount.value = null; // Invalid input
        }
      }
      // 手动更新指定的 GetBuilder
      update(['withdraw_amount_validation']);
    });

    withdrawPasswordController.addListener(() {
      withdrawPassword.value = withdrawPasswordController.text;
    });

    _currencySubscription = currency.listen((newCurrency) {
      // 当货币变化时，重新加载提款渠道和费率
      loadData();
    });

    animationController = AnimationController(
      vsync: this,
      //设置Ticker 动画帧的回调函数
      duration: const Duration(milliseconds: 2000),
      // 正向动画时长 //2s
      reverseDuration: const Duration(milliseconds: 2000),
      // 反向动画时长 //2s
      lowerBound: 0,
      // 开始动画数值  double类型
      upperBound: 1.0,
      // 结束动画数值 double类型
      animationBehavior: AnimationBehavior.normal,
      // 动画器行为 是否重复动画 两个枚举值
      debugLabel: "zd", // 调试标签 动画过多时方便调式，toString时显示
    );
  }

  @override
  void dispose() {
    withdrawAmountController.dispose();
    withdrawAmountFocusNode.dispose();

    withdrawPasswordController.dispose();
    withdrawPasswordFocusNode.dispose();

    _currencySubscription?.cancel();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    // 初始化时加载提款渠道列表
    loadData();
  }

  void updata() {
    // 手动更新指定的 GetBuilder
    update(['withdraw_amount_validation']);
  }

  Future<void> loadData() async {
    await _loadWithdrawData(currency.value);
    final load = Future.wait([
      _loadWithdrawRate(currency.value.code),
//      _loadWallet(),
      loadWalletAccountList(),
      _loadWithdrawLimits(currency.value),
      loadSecurityData(),
    ]);

    try {
      await fetchHandler(
        load,
        onError: toastError,
        loading: true,
      );
    } catch (_) {}
  }

  Future<void> loadSecurityData() async {
    securityData.value = await securityController.loadSecurityDataAndOutput();
  }

  Future<void> _loadWithdrawData(Currency currency) async {
    await Future.wait([
      _loadWithdrawChannels(currency),
    ]);
  }

  /// 获取提款渠道列表
  Future<void> _loadWithdrawChannels(Currency currency) async {
    final list = await _walletService.getChannelWithdrawList();
    if (list.isNotEmpty) {
      channels.value = list;
      list.sort((a, b) => a.sort.compareTo(b.sort));
      selectedChannel.value = list.firstOrNull;
    } else {
      channels.value = [];
    }
  }

  Future<void> _loadWithdrawLimits(Currency currency) async {
    final limits = await _walletService.getWithdrawLimits(currency);
    withdrawLimitModel.value = limits;
  }

  // Future<void> _loadWallet() async {
  //   walletModel.value = await _walletService.getWallet();
  // }

  Future<void> _loadWithdrawRate(String code) async {
    rateModel.value = await _walletService.getRatesAndFees(code);
  }

  Future<void> loadWalletAccountList() async {
    allAccountList.value = await _walletService.getAccountList();
    dealWithWalletTypeLogic();
  }

  void dealWithWalletTypeLogic() {
    if (allAccountList.isNotEmpty) {
      accountList.clear();
      for (var element in allAccountList) {
        if (element.paymentType == selectedChannel.value?.paymentType) {
          accountList.add(element);
        }
      }

      if (accountList.isNotEmpty) {
        selectedAccount.value = accountList.firstOrNull;
      }
    } else {
      accountList.value = [];
      selectedAccount.value = null;
    }
  }

  Future<void> withdraw() async {
    final future = _walletService.withdraw(
      selectedChannel.value!.id,
      selectedAccount.value!.id,
      withdrawAmount.value!.toString(),
      currency.value.code,
      withdrawPasswordController.text,
    );

    await fetchHandler(
      future,
      onSuccess: (_) {
        AppUtils.showToast('withdraw_order_success'.tr);
        Get.back();
        Get.toNamed(Routes.TRANSACTION_RECORD, arguments: {
          "type": AccountChangeType.withdraw.value,
        });
      },
      onError: toastError,
      loading: true,
    );
  }

  bool isAlipayOrBank() {
    return selectedChannel.value?.paymentType == 6 ||
        selectedChannel.value?.paymentType == 7;
  }

  Future queryWalletList() async {
    await UserService.to.queryWalletList() ?? [];
  }

  final hidePlatform = true.obs;

  void hideOrShowPlatform(bool hide) {
    hidePlatform.value = hide;
  }

  final welfareAmount = '--'.obs;
  final centerPlatformWallet =
      PlatformWalletModel(walletName: '中心钱包', walletId: '-1');

  // 使用 UserService 的状态
  UserServiceState get state => UserService.to.state;

  RxList<PlatformWalletModel> get walletList => state.walletList;

  RxBool get isRefreshing => state.isRefreshingWallet;

  RxString get centerAmount => state.centerBalance;

  RxString get lockAmount => state.lockBalance;

  RxString get totalAmount => state.totalBalance;

  void queryAmount() {
    financeWelfareWallet();
  }

  void financeWelfareWallet() async {
    var resp = await ApiRequest.financeWelfareWallet();
    if (resp != null) {
      welfareAmount.value = resp.balance ?? '0';
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
      SmartDialog.dismiss();
      AppUtils.showToast('没有可回收的余额');
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
    UserService.to.queryWalletList();

    if (stateCode101Items.isNotEmpty) {
      Get.dialog(RecycleResultDialog(
        models: stateCode101Items,
      ));
    } else {
      AppUtils.showToast('回收成功');
    }
  }

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

  List<int> get amountLimit {
    // selectedChannel.value
    // if (selectedChannel.value.isEmpty) {
    //   return [];
    // }
    if (selectedChannel.value == null) {
      return [];
    }
    return selectedChannel.value!.amountLimit..sort();
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

  String getPaymentTypeTitle() {
    var paymentType = selectedChannel.value?.paymentType ?? "";
    switch (paymentType) {
      case 1:
        final trc20List = accountList.where((e) => e.paymentType == 1).toList();
        return 'USDT(${trc20List.length}/5)';
      case 2:
        final list = accountList.where((e) => e.paymentType == 2).toList();
        return 'USDT(${list.length}/5)';
      case 3:
        final list = accountList.where((e) => e.paymentType == 3).toList();
        return 'EB Pay(${list.length}/5)';
      case 4:
        final list = accountList.where((e) => e.paymentType == 4).toList();
        return 'NO Wallet(${list.length}/5)';
      case 5:
        final list = accountList.where((e) => e.paymentType == 5).toList();
        return 'HD Pay(${list.length}/5)';
      case 6:
        final list = accountList.where((e) => e.paymentType == 6).toList();
        return '银行卡(${list.length}/10)';
      case 7:
        final list = accountList.where((e) => e.paymentType == 7).toList();
        return '支付宝账户(${list.length}/5)';
      case 8:
        final list = accountList.where((e) => e.paymentType == 8).toList();
        return '${selectedChannel.value?.name ?? ''}(${list.length}/5)';
      case 9:
        final list = accountList.where((e) => e.paymentType == 9).toList();
        return '${selectedChannel.value?.name ?? ''}(${list.length}/5)';
      case 10:
        final list = accountList.where((e) => e.paymentType == 10).toList();
        return '${selectedChannel.value?.name ?? ''}(${list.length}/5)';
      default:
        return selectedChannel.value?.name ?? "";
    }
  }
}
