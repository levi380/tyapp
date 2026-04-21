import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';
import 'package:filbet/src/mine/transactionRecord/models/trade_record_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/dialog/cancel_deposit_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransactionRecordDetailController extends GetXBaseController {
  TradeRecordModel? item;
  TradeDict? tradeDict;

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments['item'];
    tradeDict = Get.arguments['tradeDict'];
  }

  String replaceStr(String str) {
    if (str.startsWith("-")) {
      return str.replaceFirst("-", "-");
    } else {
      return "+ $str";
    }
  }

  void showCancelDialog() {
    Get.dialog(
      CancelDepositDialog(),
      barrierDismissible: false,
    ).then((value) {
      if (value is String) {
        cancelTransaction(value);
      }
    });
  }

  void cancelTransaction(String reason) async {
    var result = await ApiRequest.cancelTransaction(item?.id ?? '', reason);
    if (result == true) {
      AppUtils.showToast('申请成功');
      Get.back(result: true);
    }
  }
}
