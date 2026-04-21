import 'package:filbet/src/deposit/deposit_model.dart';
import 'package:filbet/src/deposit/waiting_payment_controller.dart';
import 'package:get/get.dart';

class WaitingPaymentBinding extends Bindings {
  @override
  void dependencies() {
    // 从路由参数中获取数据
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments == null) {
      throw Exception('WaitingPaymentBinding: Missing required arguments');
    }

    final depositModel = arguments['depositModel'] as DepositModel?;
    final amount = arguments['amount'] as double?;
    final protocol = arguments['protocol'] as String?;

    if (depositModel == null || amount == null || protocol == null) {
      throw Exception(
          'WaitingPaymentBinding: Missing required parameters (depositModel or amount)');
    }

    Get.lazyPut<WaitingPaymentController>(
      () => WaitingPaymentController(
        amountValue: amount,
        protocolValue: protocol,
        depositModel: depositModel.obs,
      ),
    );
  }
}
