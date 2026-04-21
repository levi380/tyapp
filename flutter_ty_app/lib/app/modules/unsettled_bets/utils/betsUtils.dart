import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../utils/format_money_util.dart';
import '../../../utils/utils.dart';
import '../dialog/rule_statement_dialog/toast_dialog.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单工具类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能提供多种与投注相关的工具方法，包括赔率处理、结算金额计算等。
    - `changeOdds`：动态赔率增减的列表。
    - 关键方法
    - setChangesOdds() 根据输入的赔率调整为符合就近原则的赔率，并返回是否有变更：
    - getOdds() 根据输入赔率返回相应的增减值。
    - getAsFixed() 根据输入赔率确定保留的小数位数。
    - setMinusOdds() 减少当前赔率并返回处理后的赔率字符串。
    - setIncreaseOdds() 增加当前赔率并返回处理后的赔率字符串。
    - betRemainingAmount() 计算注单剩余本金。
    - cashoutStake() 计算提前结算的投注额。
    - getExpectedProfit() 计算部分提前结算的预期利润。
    - betPreCount() 计算提前结算的可用次数。
    - betReserveAmountMin() 计算预约的最小金额。：
    - betReserveAmountMax() 计算预约的最大金额。
    - getReserveAmount() 计算预约的提前结算金额。
    】】】
 *
 */
class BetsUtils {
  ///动态赔率增减
  static List<double> changeOdds = [0.01, 0.05, 0.10, 0.5, 1.0, 1];

  ///赔率就近原则
  static bool setChangesOdds(GetH5PreBetOrderlistDataRecordxData data) {
    /* 例如：
    < 3.00的：如 1.99，2.00，2.01，2.99；
    输入赔率2.12、点击【投注】、可预约成功
    ≥3 且＜5.00的：如 3.00，3.05， 3.55 ，4.95；
    输入赔率3.78、点击【投注】、就近原则、变更为3.80且输入框边框变为红色；
    输入赔率3.76、点击【投注】变更为3.75且输入框边框变为红色
    ≥5 且 ＜10.00的：如5.00，5.10， 6.20 ，7.30，9.90；
    输入赔率5.15、点击【投注】、就近原则、变更为5.20且输入框边框变为红色；
    输入赔率5.14、点击【投注】变更为5.10且输入框边框变为红色
    ≥10 且 ＜20.0的：如10.0，10.5， 11.5 ，18.5，20.0；
    输入赔率18.6时，点击【投注】，相邻两个赔率为19.0和18.5，输入框变更为18.5 且输入框边框变为红色
    输入赔率18.8时，点击【投注】，相邻两个赔率为19.0和18.5，输入框变更为19.0 且输入框边框变为红色
    ≥20 ～无限：如20，21， 22 ，99，100，300，......
    输入99.8、点击【投注】、就近原则、变更为100.0且输入框边框变为红色
    输入99.4、点击【投注】变更为99.0且输入框边框变为红色
    输入101、点击【投注】为101
    输入101.05 (手动输入的 .05)、点击【投注】为101*/
    bool isChangesOdds = false;
    double doubleOddFinallyChange =
        double.parse(data.detailList[0].oddFinallyChange.value);
    if (doubleOddFinallyChange < 3.00) {
      isChangesOdds = false;
    } else if (doubleOddFinallyChange < 5.00) {
      if (doubleOddFinallyChange.toString().contains('.')) {
        List<String> split = doubleOddFinallyChange.toString().split('.');
        if (split[1].isNotEmpty && split[1].length > 1) {
          int parse = int.parse(split[1].substring(1, 2));
          if (parse == 1 || parse == 2) {
            data.detailList[0].oddFinallyChange.value =
                split[0] + '.' + split[1].substring(0, 1) + '0';
            isChangesOdds = true;
          } else if (parse == 3 || parse == 4 || parse == 6 || parse == 7) {
            data.detailList[0].oddFinallyChange.value =
                split[0] + '.' + split[1].substring(0, 1) + '5';
            isChangesOdds = true;
          } else if (parse == 8 || parse == 9) {
            if (split[1].substring(0, 1) == '9') {
              data.detailList[0].oddFinallyChange.value =
                  (int.parse(split[0]) + 1).toString() + '.00';
            } else {
              int parse = int.parse(split[1].substring(0, 1)) + 1;
              data.detailList[0].oddFinallyChange.value =
                  split[0] + '.' + parse.toString() + '0';
            }
            isChangesOdds = true;
          }
        }
      }
    } else if (doubleOddFinallyChange < 10.00) {
      if (doubleOddFinallyChange.toString().contains('.')) {
        List<String> split = doubleOddFinallyChange.toString().split('.');
        if (split[1].isNotEmpty && split[1].length > 1) {
          int parse = int.parse(split[1].substring(1, 2));
          if (parse == 1 || parse == 2 || parse == 3 || parse == 4) {
            data.detailList[0].oddFinallyChange.value =
                split[0] + '.' + split[1].substring(0, 1) + '0';
            isChangesOdds = true;
          } else if (parse == 5 ||
              parse == 6 ||
              parse == 7 ||
              parse == 8 ||
              parse == 9) {
            if (split[1].substring(0, 1) == '9') {
              data.detailList[0].oddFinallyChange.value =
                  (int.parse(split[0]) + 1).toString() + '.00';
            } else {
              int parse = int.parse(split[1].substring(0, 1)) + 1;
              data.detailList[0].oddFinallyChange.value =
                  split[0] + '.' + parse.toString() + '0';
            }
            isChangesOdds = true;
          }
        }
      }
    } else if (doubleOddFinallyChange < 20.00) {
      if (doubleOddFinallyChange.toString().contains('.')) {
        List<String> split = doubleOddFinallyChange.toString().split('.');
        if (split[1].isNotEmpty) {
          int parse = int.parse(split[1].substring(0, 1));
          if (parse == 0 && split[1].length > 1) {
            data.detailList[0].oddFinallyChange.value = split[0] + '.0';
            isChangesOdds = true;
          } else if (parse == 1 || parse == 2) {
            data.detailList[0].oddFinallyChange.value = split[0] + '.0';
            isChangesOdds = true;
          } else if (parse == 5 && split[1].length > 1) {
            data.detailList[0].oddFinallyChange.value = split[0] + '.5';
            isChangesOdds = true;
          } else if (parse == 3 || parse == 4 || parse == 6 || parse == 7) {
            data.detailList[0].oddFinallyChange.value = split[0] + '.5';
            isChangesOdds = true;
          } else if (parse == 8 || parse == 9) {
            data.detailList[0].oddFinallyChange.value =
                (int.parse(split[0]) + 1).toString() + '.0';
            isChangesOdds = true;
          }
        }
      }
    } else if (doubleOddFinallyChange >= 20.00) {
      if (doubleOddFinallyChange.toString().contains('.')) {
        List<String> split = doubleOddFinallyChange.toString().split('.');
        if (split[1].isNotEmpty) {
          int parse = int.parse(split[1].substring(0, 1));
          if (parse == 0 && split[1].length > 1) {
            if (doubleOddFinallyChange < 100) {
              data.detailList[0].oddFinallyChange.value = split[0] + '.0';
            } else {
              data.detailList[0].oddFinallyChange.value = split[0];
            }
            isChangesOdds = true;
          } else if (parse > 0 && parse < 5) {
            if (doubleOddFinallyChange < 100) {
              data.detailList[0].oddFinallyChange.value = split[0] + '.0';
            } else {
              data.detailList[0].oddFinallyChange.value = split[0];
            }
            isChangesOdds = true;
          } else if (parse >= 5) {
            if (doubleOddFinallyChange < 100) {
              data.detailList[0].oddFinallyChange.value =
                  (int.parse(split[0]) + 1).toString() + '.0';
            } else {
              data.detailList[0].oddFinallyChange.value =
                  (int.parse(split[0]) + 1).toString();
            }
            isChangesOdds = true;
          }
        }
      }
    }
    return isChangesOdds;
  }

  ///赔率增减
  static double getOdds(double parse) {
    var index = 0;
    if (parse < 3.00) {
      index = 0;
    } else if (parse < 5.00) {
      index = 1;
    } else if (parse < 10.00) {
      index = 2;
    } else if (parse < 20.00) {
      index = 3;
    } else if (parse < 100.00) {
      index = 4;
    } else if (parse <= 355.00) {
      index = 5;
    }
    return changeOdds[index];
  }

  ///保留小数位数
  static int getAsFixed(double parse) {
    int asFixed = 2;
    if (parse < 10) {
      asFixed = 2;
    } else if (parse < 100) {
      asFixed = 1;
    } else if (parse > 100) {
      asFixed = 0;
    }
    return asFixed;
  }

  ///减少赔率
  static String setMinusOdds(String odds) {
    if (odds.isEmpty) {
      return "0.00";
    }
    double parse = double.parse(odds);
    double changeOdd = getOdds(parse);
    if (parse != 0.00) {
      parse = parse - changeOdd;
    } else {
      parse = 0.00;
    }
    return parse.toStringAsFixed(getAsFixed(parse));
  }

  ///增加赔率
  static setIncreaseOdds(String odds) {
    if (odds.isEmpty) {
      return "0.01";
    }
    double parse = double.parse(odds);
    double changeOdd = getOdds(parse);
    parse = parse + changeOdd;
    if (parse > 355.00) {
      parse = 355.00;
    }
    return parse.toStringAsFixed(getAsFixed(parse));
  }

  /// 注单剩余本金 = 投注额 - 已提前结算金额
  static double betRemainingAmount(GetH5OrderListDataRecordxData data) {
    double orderAmountTotal = data.orderAmountTotal;
    double preBetAmount = double.tryParse(data.preBetAmount.toString()) ?? 0;
    return subtract(orderAmountTotal, preBetAmount);
  }

  /// 提前结算投注额,四舍五入取整
  static double cashoutStake(GetH5OrderListDataRecordxData data) {
    double pba = data.preSettleBetAmount;
    double money = (pba * data.earlyProportionSettleRatio).roundToDouble();

    ///当滑条0的时候
    if (data.earlyProportionSettleRatio == 0) {
      ///当滑条0的时候提前结算本金就是1
      return 1;
    }
    if (data.earlyProportionSettleRatio == 1) {
      money = pba;
    }

    /// 单关最低投注金额
    int minBetMoney =
        TYUserController.to.userInfo.value?.cvo?.single?.min ?? 10;
    if (pba > minBetMoney) {
      money = money < minBetMoney ? minBetMoney.toDouble() : money;
    }

    ///提前结算本金是不能小于1的
    return money < 1 ? 1 : money;
  }

  /// 部分提前结算计算兑现金额
  static String getExpectedProfit(GetH5OrderListDataRecordxData data) {
    ///当滑条0的时候
    if (data.earlyProportionSettleRatio == 0) {
      double a = ((double.tryParse(data.maxCashout.toString()) ?? 1) /
          data.preSettleBetAmount);
      return a.toStringAsFixed(2);
    }

    ///当滑条1的时候
    if (data.earlyProportionSettleRatio == 1) {
      return (double.tryParse(data.maxCashout.toString()) ?? 1)
          .toStringAsFixed(2);
    } else {
      ///四舍五入至小数点第二位
      return ((double.tryParse(data.maxCashout.toString()) ?? 1) *
              cashoutStake(data) /
              data.preSettleBetAmount)
          .toStringAsFixed(2);
    }
  }

  /// 提前结算可用次数
  static String betPreCount(GetH5OrderListDataRecordxData data) {
    data.preSettleBetAmount = data.preSettleBetAmount;
    if (data.preSettle == 1) {
      return "1";
    }
    if (data.preSettle == null) {
      return "2";
    }
    if (data.preSettle != null && data.preSettle > 2) {
      return "0";
    }
    return "0";
  }

  /// 最小值 = 注单本金+最小可投注金额（按币种）
  static betReserveAmountMin(GetH5OrderListDataRecordxData data) {
    ///当max大于（本金+1），预约范围为，本金+1到max范围，
    ///如果max小于等于（本金+1），预约范围为本金到max
    // double orderAmountTotal = data.orderAmountTotal;
    double orderAmountTotal = data.preSettleBetAmount;
    double oddFinally = double.tryParse(data.detailList[0].oddFinally) ?? 0;
    double maximumWin = multiplication(orderAmountTotal, oddFinally);
    double betAmount = addition(orderAmountTotal, 1);
    String marketType = data.marketType;
    if (marketType == 'HK') {
      maximumWin = addition(orderAmountTotal, maximumWin);
    }
    if (maximumWin > betAmount) {
      return betAmount;
    }
    if (maximumWin <= betAmount) {
      return orderAmountTotal;
    }
  }

  /// 最大值 = 注单本金*注单赔率
  static double betReserveAmountMax(GetH5OrderListDataRecordxData data) {
    // double orderAmountTotal = data.orderAmountTotal;
    double orderAmountTotal = data.preSettleBetAmount;
    double oddFinally = double.tryParse(data.detailList[0].oddFinally) ?? 0;
    double maximumWin = multiplication(orderAmountTotal, oddFinally);
    String marketType = data.marketType;
    if (marketType == 'HK') {
      maximumWin = addition(orderAmountTotal, maximumWin);
    }
    return maximumWin;
  }

  ///预约提前结算金额
  static double getReserveAmount(GetH5OrderListDataRecordxData data) {
    ///最小值
    double AmountMin = double.parse(
        FormatMoney.formatMoney2(BetsUtils.betReserveAmountMin(data))
            .replaceAll(',', ''));

    ///最大值
    double AmountMax = double.parse(
        FormatMoney.formatMoney2(BetsUtils.betReserveAmountMax(data))
            .replaceAll(',', ''));
    if (data.earlyAppointmentSettlementAmount.value.isEmpty) {
      ///金额框更新金额
      data.earlyAppointmentSettlementAmount.value = AmountMin.toString();
      return AmountMin;
    }

    ///输入框值
    double settlementAmount =
        double.parse(data.earlyAppointmentSettlementAmount.value);

    if (settlementAmount >= AmountMin && settlementAmount <= AmountMax) {
      return settlementAmount;
    } else if (settlementAmount < AmountMin) {
      ///金额框更新金额
      data.earlyAppointmentSettlementAmount.value = AmountMin.toString();
      return AmountMin;
    } else {
      ///金额框更新金额
      data.earlyAppointmentSettlementAmount.value = AmountMax.toString();
      return AmountMax;
    }
  }

  /**
   * 添加颜色样式，统一调取，便于后面颜色样式修改
   */
  static Color getColor(bool isDarkMode) {
    return Color(isDarkMode ? 0xFF127DCC : 0xff179CFF);
  }

  /**s
   * 注单统一弹框（提示框）
   */

  static toastDialog(String tips, {int seconds = 1}) {
    Get.dialog(
      ToastDialogPage(
        information: tips,
        seconds: seconds,
      ),
      barrierColor: Colors.transparent,
    );
  }

  /*
   *判断赛事开赛有没有超过15天，用于赛事详情跳转
   */
  static bool isOver15Days(String beginTime) {
    // 将时间戳转换为 DateTime 对象
    DateTime startDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(beginTime));

    // 获取当前日期
    DateTime now = DateTime.now();

    // 计算开始日期加上 15 天后的日期
    DateTime endDate = startDate.add(Duration(days: 15));

    // 判断当前日期是否超过结束日期
    return now.isAfter(endDate);
  }

  /**s
   * 注单结果图标
   */
  static String getBetResultIcon(int betResult) {
    // 输 assets/images/bets/n1_record_lose_icon  3
    // 赢 assets/images/bets/n1_record_win_icon   4
    // 半输 assets/images/bets/n1_record_lose_half_icon  6
    // 半赢 assets/images/bets/n1_record_win_half_icon   5
    // 平局  assets/images/bets/n1_record_flat_icon    0
    // 默认  assets/images/bets/n1_record_current_icon   2和其他

    String getBetResultIconUrl = "current";
    switch (betResult) {
      case 3:
        getBetResultIconUrl = "lose";
        break;
      case 4:
        getBetResultIconUrl = "win";
        break;
      case 6:
        getBetResultIconUrl = "lose_half";
        break;
      case 5:
        getBetResultIconUrl = "win_half";
        break;
      case 0:
        getBetResultIconUrl = "flat";
        break;
    }
    return "assets/images/icon/n1_record_" + getBetResultIconUrl + "_icon.png";
  }
}
