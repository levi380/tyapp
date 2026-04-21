import 'package:filbet/src/mine/transactionRecord/transactionRecordDetail/controllers/transaction_record_detail_controller.dart';
import 'package:filbet/src/mine/transactionRecord/transaction_record_model.dart';
import 'package:get/get.dart';

class TransactionRecordDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionRecordDetailController>(
      () => TransactionRecordDetailController(),
    );
  }
}
