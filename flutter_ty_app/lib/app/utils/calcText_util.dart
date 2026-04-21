import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../generated/locales.g.dart';
import '../modules/result/widgets/mi_apuesta_widget.dart';
import '../services/models/res/get_h5_order_list_entity.dart';


String calcText(GetH5OrderListDataRecordxData miApues, GetH5OrderListDataRecordxDataOrderVOS vos) {
  String orderStatus = miApues.orderStatus;
  String seriesType = miApues.seriesType;
  int betStatus = vos.betStatus;
  int betResult = vos.betResult;
  int cancelType = vos.cancelType;

  String res = '';
  switch (orderStatus) {
    case '3':
    case '4':
      res = '';
      break;
    case '0':
      if (seriesType == '1') {
        res = '';
      } else {
        if (betStatus == 3 || betStatus == 4) {
          res = betResult3[cancelType] ?? LocaleKeys.bet_record_invalid;
        } else if (betStatus == 1) {
          if (betResult == 13 || betResult == 16) {
            res = LocaleKeys.bet_record_invalid;
          } else {
            res = betResultValue[betResult] ?? '';
          }
        } else {
          res = '';
        }
      }
      break;
    case '1':
      if (seriesType == '1') {
        res = '';
      } else {
        if (betStatus == 3 || betStatus == 4) {
          res = betResult3[cancelType] ?? LocaleKeys.bet_record_invalid;
        } else if (betStatus == 1) {
          if (betResult == 13 || betResult == 16) {
            res = LocaleKeys.bet_record_invalid;
          } else {
            if (seriesType == '3' && [2, 3, 4, 5, 6].contains(betResult)) {
              res = '';
              break;
            }
            res = betResultValue[betResult] ?? '';
          }
        } else {
          res = '';
        }
      }
      break;
    case '2':
      if (seriesType == '1') {
        res = '';
      } else {
        if (betStatus == 3 || betStatus == 4) {
          res = betResult3[cancelType] ?? LocaleKeys.bet_record_invalid;
        } else if (betStatus == 1) {
          res = betResult1[betResult] ?? LocaleKeys.bet_record_invalid;
        } else {
          res = '';
        }
      }
      break;
    default:
      break;
  }
  return res;
}

// 底部 订单状态 数
String getFooterText(GetH5OrderListDataRecordxData data) {
  String res = '';
  switch (data.orderStatus) {
    case '0':
    // classFooter.value = 'green';
      res = LocaleKeys.bet_record_successful_betting.tr;
      break;
    case '1':
    // classFooter.value = 'black';
      bool flag = data.seriesType == '1' &&
          data.orderVOS.isNotEmpty;
      if (flag) {
        /* if (data.preBetAmount != null && int.parse(data.preBetAmount) > 0) {
            double difference = data.backAmount - data.orderAmountTotal;
            if (difference > 0) {
              // classFooter.value = 'red';
              // isWin.value = true;
              res = footBetResult[4] ?? '';
            } else if (difference < 0) {
              res = footBetResult[3] ?? '';
            } else {
              res = footBetResult[2] ?? '';
            }
            break;
          }*/
        int betResultValue = data.orderVOS[0].betResult;
        if (betResultValue == 13 || betResultValue == 16) {
          res = LocaleKeys.bet_record_invalid.tr;
        } else {
          if (betResultValue == 4 || betResultValue == 5) {
            // classFooter.value = 'red';
            // isWin.value = true;
          }
          res = footBetResult[betResultValue] ?? '';
        }
      } else {
        if (data.outcome == 4 || data.outcome == 5) {
          // classFooter.value = 'red';
          // isWin.value = true;
        }
        res = footOutcome[data.outcome] ??
            LocaleKeys.bet_record_successful_betting.tr;
      }
      break;
    case '2':
    // classFooter.value = 'black';
      res = LocaleKeys.bet_record_invalid_bet.tr;
      break;
    case '3':
    // classFooter.value = 'orange';
      res = LocaleKeys.bet_record_confirming.tr;
      break;
    case '4':
    // classFooter.value = 'red';
      res = LocaleKeys.bet_bet_err.tr;
      break;
    default:
      res = '';
      break;
  }
  return res;
}

String getFooterScore(GetH5OrderListDataRecordxData data) {
  if (data.seriesType == '1' &&
      data.orderVOS.isNotEmpty) {
    if (data.orderStatus == '1') {
      return data.orderVOS[0].settleScore;
    } else if (data.orderStatus == '2') {
      int betStatus = data.orderVOS[0].betStatus;
      int betResult = data.orderVOS[0].betResult;
      int cancelType = data.orderVOS[0].cancelType;
      if (betStatus == 1) {
        return betResult1[betResult] ?? '';
      } else if (betStatus == 3 || betStatus == 4) {
        return betResult3[cancelType] ?? '';
      } else {
        return '';
      }
    } else {
      return '';
    }
  } else {
    return '';
  }
}