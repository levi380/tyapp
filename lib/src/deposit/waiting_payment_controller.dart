import 'dart:async';
import 'dart:convert';

import 'package:filbet/http/entity/address_info.dart';
import 'package:filbet/mixin/copy_mixin.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/deposit_model.dart';
import 'package:filbet/src/mine/accountChangeRecord/controllers/account_change_record_controller.dart'
    show AccountChangeType;
import 'package:get/get.dart';
import 'package:filbet/services/user/user_service.dart';

class WaitingPaymentController extends GetXBaseController with CopyMixin {
  final RxDouble amount;
  final RxString protocol;
  final Rx<DepositModel> depositModel;
  final addressInfo = AddressInfo().obs;

  final RxInt countDown = (30 * 60).obs;
  Timer? _timer;

  WaitingPaymentController({
    required double amountValue,
    required String protocolValue,
    required this.depositModel,
  })  : amount = amountValue.obs,
        protocol = protocolValue.obs;

  @override
  void onReady() {
    super.onReady();
    countDown.value = depositModel.value.expired;
    initAddressInfo();
    _startCountDown();
  }

  /// 开始倒计时
  void _startCountDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown.value > 0) {
        countDown.value--;
      } else {
        _stopCountDown();
        _onCountDownFinished();
      }
    });
  }

  /// 停止倒计时
  void _stopCountDown() {
    _timer?.cancel();
    _timer = null;
  }

  /// 倒计时结束处理
  void _onCountDownFinished() {
    goToAccountChangeRecordDeposit();
  }

  /// 获取格式化的倒计时字符串 (MM:SS)
  String get formattedCountDown {
    final minutes = countDown.value ~/ 60;
    final seconds = countDown.value % 60;
    return 'm_fen_s_miao'
        .tr
        .replaceAll('{{m}}', minutes.toString().padLeft(2, '0'))
        .replaceAll('{{s}}', seconds.toString().padLeft(2, '0'));
  }

  /// 检查倒计时是否结束
  bool get isCountDownFinished => countDown.value <= 0;

  void copyPaymentAddress() {
    copyAndshowCopyOKDialog(depositModel.value.toAddress);
  }

  void copyOrderId() {
    copyAndshowCopyOKDialog(depositModel.value.orderId);
  }

  void copyInfo(String content) {
    copyAndshowCopyOKDialog(content);
  }

  void goToAccountChangeRecordDeposit() {
    int count = 0;
    Get.until((route) => count++ >= 2);
    Get.toNamed(Routes.TRANSACTION_RECORD, arguments: {
      "type": AccountChangeType.deposit.value,
    })?.then((value) {
      UserService.to.queryTotalBalance();
    });
  }

  @override
  void onClose() {
    _stopCountDown();
    super.onClose();
  }

  @override
  void dispose() {
    _stopCountDown();
    super.dispose();
  }

  void initAddressInfo() {
    if (depositModel.value.paymentType == 6 ||
        depositModel.value.paymentType == 7) {
      try {
        addressInfo.value =
            AddressInfo.fromJson(jsonDecode(depositModel.value.toAddress));
      } catch (e) {}
    }
  }

  bool isAlipayOrBank() {
    return depositModel.value.paymentType == 6 ||
        depositModel.value.paymentType == 7;
  }
}
