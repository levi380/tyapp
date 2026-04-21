import 'dart:async';

import 'package:filbet/common/currency.dart';
import 'package:filbet/http/domain/domain/domain_manager.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/deposit/rate_model.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/first_deposit_hint_dialog.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositController extends GetXBaseController {
  final RxList<Currency> currencyList;
  final Rx<Currency> currency;

  DepositController({
    required Currency currency,
    required List<Currency> avaliables,
  })  : currency = currency.obs,
        currencyList = avaliables.obs;

  final RxList<ChannelModel> channelList = RxList([]);
  final Rx<ChannelModel?> selectedChannel = Rx<ChannelModel?>(null);
  final Rx<RateModel?> rateModel = Rx<RateModel?>(null);

  final Rx<int?> selectedAmount = Rx<int?>(null);
  final Rx<double?> depositAmount = Rx<double?>(null);
  var entereddepositAmount = ''.obs;

  bool get canPresentCurrencySelection {
    return currencyList.length > 1;
  }

  int get maxInputLength {
    if (selectedChannel.value == null) {
      return 1;
    }
    // 根据选中的渠道，获取最大输入长度
    return selectedChannel.value!.maxAmount.length;
  }

  bool get isDepositEnabled {
    return selectedChannel.value != null &&
        depositAmount.value != null &&
        isDepositInputAmountValid;
  }

  List<int> get amountLimit {
    if (channelList.isEmpty) {
      return [];
    }
    if (selectedChannel.value == null) {
      return [];
    }
    return selectedChannel.value!.amountLimit..sort();
  }

  bool get isDepositInputAmountValid {
    if (selectedChannel.value == null) {
      return true;
    }
    if (depositAmount.value == null) {
      return true;
    }
    final amount = depositAmount.value!;

    return selectedChannel.value!.isAmountValid(amount);
  }

  String get protocal {
    return selectedChannel.value?.blockChainName ?? '';
  }

  double get depositFee {
    if (depositAmount.value == null || rateModel.value == null) {
      return 0;
    }
    //输入金额*手续费比例
    final fee = depositAmount.value! * (depositFeeRate / 100);
    return double.parse(fee.toStringAsFixed(2));
  }

  double get depositFeeRate {
    if (rateModel.value == null) {
      return 0.0;
    }
    final fee = selectedChannel.value?.fee ?? '0';
    return double.tryParse(fee) ?? 0.0;
  }

  String get depositFeePercentage {
    return '${(depositFeeRate).toStringAsFixed(2)}%';
  }

  double get actualDepositAmount {
    if (depositAmount.value == null || rateModel.value == null) {
      return 0.0;
    }
    //(输入金额-手续费)*汇率
    return double.parse((depositAmount.value! - depositFee).toStringAsFixed(2));
  }

  double get actualDepositAmountInCurrency {
    if (depositAmount.value == null || rateModel.value == null) {
      return 0.0;
    }

    var depositRate = double.parse(rateModel.value!.depositRate?.usdt ?? "1");
    // final depositRate = rateModel.value!.depositRate?.usdt ?? 0;
    final tokenSymbol = selectedChannel.value?.tokenType ?? '';
    if (tokenSymbol == "EB") {
      depositRate = double.parse(rateModel.value!.depositRate?.eb ?? "1");
    } else if (tokenSymbol == "NO") {
      depositRate = double.parse(rateModel.value!.depositRate?.no ?? "1");
    } else if (tokenSymbol == "CNY") {
      depositRate = double.parse(rateModel.value!.depositRate?.cny ?? "1");
    }

    switch (currency.value) {
      case Currency.rmb:
        return actualDepositAmount * depositRate;
      // case Currency.vnd:
      //   return actualDepositAmount * depositRate;
      // case Currency.usd:
      //   return actualDepositAmount * depositRate;
      // case Currency.hkd:
      //   return actualDepositAmount * depositRate;
      // case Currency.krw:
      //   return actualDepositAmount * depositRate;
      // case Currency.idr:
      //   return actualDepositAmount * depositRate;
      // case Currency.thb:
      //   return actualDepositAmount * depositRate;
      // case Currency.mxn:
      //   return actualDepositAmount * depositRate;
      // case Currency.brl:
      //   return actualDepositAmount * depositRate;
      // case Currency.inr:
      //   return actualDepositAmount * depositRate;
      // case Currency.php:
      //   return actualDepositAmount * depositRate;
    }
  }

  String get realtimeCurrencyRate {
    if (rateModel.value == null) {
      return '0.00';
    }
    final depositRate = rateModel.value!.depositRate?.usdt ?? '';
    final eb = rateModel.value!.depositRate?.eb ?? '';
    final no = rateModel.value!.depositRate?.no ?? '';
    final hd = rateModel.value!.depositRate?.hd ?? '';
    final tokenSymbol = selectedChannel.value?.tokenType ?? '';
    final appStr = "1 ${selectedChannel.value?.tokenType ?? ''}  = ";
    var rate = '';

    if (tokenSymbol == "USDT") {
      rate = depositRate;
    } else if (tokenSymbol == "EB") {
      rate = eb;
    } else if (tokenSymbol == "NO") {
      rate = no;
    } else if (tokenSymbol == "HD") {
      rate = hd;
    }
    String doubleTruncate = "";
    if (rate.contains('.')) {
      doubleTruncate = truncateTo4DecimalsString(double.parse(rate));
    } else {
      doubleTruncate = rate;
    }

    switch (currency.value) {
      case Currency.rmb:
        return '$appStr ${doubleTruncate}CNY';
      // case Currency.vnd:
      //   return '$appStr ${doubleTruncate}VND';
      // case Currency.usd:
      //   return '$appStr ${doubleTruncate}USD';
      // case Currency.hkd:
      //   return '$appStr ${doubleTruncate}HKD';
      // case Currency.krw:
      //   return '$appStr ${doubleTruncate}KRW';
      // case Currency.idr:
      //   return '$appStr ${doubleTruncate}IDR';
      // case Currency.thb:
      //   return '$appStr ${doubleTruncate}THB';
      // case Currency.mxn:
      //   return '$appStr ${doubleTruncate}MXN';
      // case Currency.brl:
      //   return '$appStr ${doubleTruncate}BRL';
      // case Currency.inr:
      //   return '$appStr ${doubleTruncate}INR';
      // case Currency.php:
      //   return '$appStr ${doubleTruncate}PHP';
    }
  }

  String truncateTo4DecimalsString(double value) {
    if (value % 1 == 0) return value.toString(); // 整数直接返回
    double truncated = (value * 10000).truncateToDouble() / 10000;
    return truncated.toStringAsFixed(4); // 保证 4 位显示
  }

  final TextEditingController depositAmountController = TextEditingController();
  final FocusNode depositAmountFocusNode = FocusNode();

  // 存款相关的网络数据
  final WalletService _walletService = Get.find<WalletService>();

  StreamSubscription? _currencySubscription;

  @override
  void onInit() {
    super.onInit();
    depositAmountController.addListener(() {
      final input = depositAmountController.text;
      if (input.isEmpty) {
        depositAmount.value = null;
      } else {
        showFirstClickToDepositDialog();
        final parsedValue = double.tryParse(input);
        if (parsedValue != null) {
          depositAmount.value = parsedValue;
        } else {
          depositAmount.value = null; // Invalid input
        }
      }
      update(['deposit_amount_validation']);
    });

    _currencySubscription = currency.listen((newCurrency) {
      // 当货币类型变化时，重新加载存款数据
      _loadDepositData(newCurrency);
    });
  }

  //<editor-fold desc="是否首次点击存款">
  void showFirstClickToDepositDialog() async {
    var firstClickToDeposit = SpStorage.getBool(StorageKey.firstClickToDeposit);
    if (!firstClickToDeposit) {
      var isResult = await Get.dialog(
        FirstDepositHintDialog(),
        barrierDismissible: false,
      );

      if (isResult) {
        SpStorage.setBool(StorageKey.firstClickToDeposit, true);
      }
    }
  }

  //</editor-fold>

  @override
  void onReady() {
    super.onReady();
    _loadDepositData(currency.value);
  }

  /// 加载存款页面所需的所有数据
  Future<void> _loadDepositData(Currency currency) async {
    final future = Future.wait([
      _loadDepositChannels(currency),
      _loadDepositRates(currency.code),
    ]);
    try {
      await fetchHandler(
        future,
        onError: toastError,
        loading: true,
      );
    } catch (_) {}
  }

  /// 获取充值渠道列表
  Future<void> _loadDepositChannels(Currency currency) async {
    final list = await _walletService.getChannelDepositList();
    if (list.isNotEmpty) {
      channelList.value = list;
      list.sort((a, b) => a.sort.compareTo(b.sort));
      selectedChannel.value = list.firstOrNull;
    } else {
      channelList.value = [];
    }
  }

  /// 获取汇率信息
  Future<void> _loadDepositRates(String code) async {
    rateModel.value = await _walletService.getRatesAndFees(code);
  }

  Future<void> deposit() async {
    final future = _walletService.deposit(
      selectedChannel.value!.id,
      depositAmount.value!,
      currency.value.code,
    );

    await fetchHandler(
      future,
      onSuccess: (model) async {
        if (model == null) {
          return;
        }
        print("payUrl: ${model.payUrl}");
        if (model.payUrl.isNotEmpty) {
          String payUrl = model.payUrl;
          bool isFindDomain = model.isFindDomain ?? false;
          if (isFindDomain) {
            List<String> domains = model.domains?.split(",") ?? [];
            if (domains.isNotEmpty) {
              String? domain = await pingDomain(domains, model.pingApi ?? '');
              if (domain?.isNotEmpty == true) {
                payUrl = '$domain${model.subUrl ?? ''}';
              }
            }
          }
          var result = await AppUtils.launchH5(payUrl);
          if (!result) {
            Get.toNamed(Routes.WAITING_THIRD_PAYMENT, arguments: {
              'payUrl': model.payUrl,
            });
          }
        } else {
          Get.toNamed(Routes.WAITING_PAYMENT, arguments: {
            'depositModel': model,
            'amount': depositAmount.value!,
            'protocol': protocal,
          });
        }
      },
      onError: toastError,
      loading: true,
    );
  }

  double truncateTo2(double value) {
    return (value * 100).truncateToDouble() / 100;
  }

  @override
  void dispose() {
    _currencySubscription?.cancel();
    depositAmountController.dispose();
    depositAmountFocusNode.dispose();
    super.dispose();
  }

  bool isAlipayOrBank() {
    return selectedChannel.value?.paymentType == 6 ||
        selectedChannel.value?.paymentType == 7;
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

  Future<String?> pingDomain(List<String> domains, String subUrl) async {
    return await DomainManager.instance.checkFastestPayDomain(domains, subUrl);
  }
}
