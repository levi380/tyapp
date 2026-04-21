import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_record_model.dart';
import 'package:filbet/src/mine/accountChangeRecord/controllers/account_change_record_controller.dart'
    show AccountChangeType;
import 'package:get/get.dart';

class AccountChangeRecordDetailController extends GetXBaseController {
  final Rx<AccountChangeRecordDetail> _detail;

  AccountChangeRecordDetail get detail => _detail.value;

  AccountChangeRecordDetailController({
    required AccountChangeRecordDetail detail,
  }) : _detail = detail.obs;
}

// 仅用于显示的Model
class AccountChangeRecordDetail<T extends AccountChangeRecordBaseItem> {
  final T item;
  AccountChangeRecordDetail({required this.item});

  /// 获取交易类型名称
  AccountChangeType get accountChangeType {
    if (item is AccountChangeRecordDepositItem) {
      return AccountChangeType.deposit;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return AccountChangeType.withdraw;
    }
    return AccountChangeType.deposit;
  }


  String get topAmountWithSymbol {
    if (item is AccountChangeRecordDepositItem) {
      return item.orderStatus == AccountChangeOrderStatus.success
          ? (item as AccountChangeRecordDepositItem).actualAmountWithCurrenySymbol:
          
           (item as AccountChangeRecordDepositItem).order_amountWithUSDTSymbol;
         

          
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).amountWithSymbol;
    }
    return '';
  }

  String get amountWithSymbol {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem)
          .actualAmountWithCurrenySymbol;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).actualAmount;
    }
    return '';
  }

  String get order_amounWithUSDTSymbol {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem)
          .order_amountWithUSDTSymbol;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).actualAmount;
    }
    return '';
  }

  //实付金额
  String get amounWithUSDTSymbol {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem).amountWithUSDTSymbol;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).actualAmount;
    }
    return '';
  }

  String get actualAmountWithSymbol {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem)
          .actualAmountWithCurrenySymbol;
    } else if (item is AccountChangeRecordWithdrawItem) {
      // return (item as AccountChangeRecordWithdrawItem).actualAmountWithSymbol;
    }
    return '';
  }

  AccountChangeOrderStatus get orderStatus {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem).orderStatus;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).orderStatus;
    }
    return AccountChangeOrderStatus.failed;
  }

  String get orderId {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem).id;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).id;
    }
    return '';
  }



  String get fee {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem).feeString;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).feeString;
    }
    return '';
  }

  String get rateString {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem).ratefourString;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).rateString;
    }
    return '';
  }

  String get remark {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem).remark;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).remark;
    }
    return '';
  }

  String get createdAtFormatted {
    if (item is AccountChangeRecordDepositItem) {
      return (item as AccountChangeRecordDepositItem).createdAtFormatted;
    } else if (item is AccountChangeRecordWithdrawItem) {
      return (item as AccountChangeRecordWithdrawItem).createdAtFormatted;
    }
    return '';
  }
}
