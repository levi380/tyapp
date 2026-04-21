import 'package:filbet/src/mine/transactionRecord/controllers/transaction_record_controller.dart';

import 'package:get/get.dart';

class TransactionRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionRecordController());
  }
}
