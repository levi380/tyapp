import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';

import '../../login/login_head_import.dart';
import '../utils/betsUtils.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(预约中)修改本金和赔率键盘Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能提供一个自定义数字键盘，用于输入和修改投注金额或赔率，支持多种操作。

    - `ModifyOddsKeyboardView`：接收一个参数：
    - `data`：类型为 `GetH5PreBetOrderlistDataRecordxData`，包含相关数据。
    - 返回一个包含数字键盘的 `Container`，根据主题模式设置背景色。
    - 使用多个行 (`Row`) 来组织键盘按钮：
    - 第一行：数字 1-3 和最大值按钮。
    - 第二行：数字 4-6 和减少按钮。
    - 第三行：小数点、0 和两个 0 的按钮。
    - 每个按钮都通过 `_single` 方法生成，点击时根据 `data.isCutoverAmountodds.value` 决定调用 `computeAmounts` 或 `computeOdds` 方法。
    - `-1`：表示最大值。
    - `-2`：表示删除最后一个输入。
    - `-3`：表示关闭键盘。
    - `computeAmounts` 和 `computeOdds` 方法处理用户输入，确保输入符合规则，包括最大限制和格式。
    - 对于金额，考虑用户余额和当前投注额的总和，确保不超过最大值。
    - 对于赔率，限制最大值为 355。
    】】】
 *
 */

///注单修改本金键盘
class ModifyOddsKeyboardView extends StatelessWidget {
  const ModifyOddsKeyboardView({
    Key? key,
    required this.data,
  }) : super(key: key);
  final GetH5PreBetOrderlistDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color:
            context.isDarkMode ? Colors.transparent : const Color(0xFFF3FAFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        /**
         * 0-9  ：是数字
         *  00  ：是两个0
         *  -1  ： 是最大值
         *  -2  ： 是删减
         *  -3  ： 是折叠数字键盘
         */

        children: [
          _party('1', '2', '3', "-1", context),
          SizedBox(
            height: 4.h,
          ),
          _partySame('4', '7', '5', '8', '6', '9', '-2', context),
          SizedBox(
            height: 4.h,
          ),
          _party('.', '0', '00', "-3", context),
        ],
      ),
    );
  }

  Widget _party(String keyboard1, String keyboard2, String keyboard3,
      String keyboard4, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _single(keyboard1, context),
        ),
        SizedBox(
          width: 4.h,
        ),
        Expanded(
          flex: 1,
          child: _single(keyboard2, context),
        ),
        SizedBox(
          width: 4.h,
        ),
        Expanded(
          flex: 1,
          child: _single(keyboard3, context),
        ),
        SizedBox(
          width: 4.h,
        ),
        Expanded(
          flex: 1,
          child: _single(keyboard4, context),
        ),
      ],
    );
  }

  Widget _partySame(
      String keyboard1,
      String keyboard2,
      String keyboard3,
      String keyboard4,
      String keyboard5,
      String keyboard6,
      String keyboard7,
      BuildContext context) {
    return Row(
      children: [
        _combination(keyboard1, keyboard2, context),
        SizedBox(
          width: 4.h,
        ),
        _combination(keyboard3, keyboard4, context),
        SizedBox(
          width: 4.h,
        ),
        _combination(keyboard5, keyboard6, context),
        SizedBox(
          width: 4.h,
        ),
        Expanded(
          flex: 1,
          child: _single(keyboard7, context),
        ),
      ],
    );
  }

  Widget _combination(
      String keyboard1, String keyboard2, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _single(keyboard1, context),
          SizedBox(
            height: 4.h,
          ),
          _single(keyboard2, context),
        ],
      ),
    );
  }

  Widget _single(String keyboard, BuildContext context) {
    return InkWell(
      onTap: () => {
        if (data.isCutoverAmountodds.value == 0)
          {
            ///键盘控制预约投注金额
            computeAmounts(keyboard),
          }
        else if (data.isCutoverAmountodds.value == 1)
          {
            ///盘口设置不需要键盘控制
          }
        else if (data.isCutoverAmountodds.value == 2)
          {
            ///键盘控制预约赔率
            computeOdds(keyboard),
          }
      },
      child: Container(
        alignment: Alignment.center,
        height: keyboard == '-2' ? 76.h : 36.h,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 6.h,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.03999999910593033)
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
          ),
        ),
        child: _content(keyboard, context),
      ),
    );
  }

  Widget _content(String keyboard, BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Widget widget = Container();
    if (keyboard == '-2') {
      widget = ImageView(
        'assets/images/bets/system_icon_cancel_night.png',
        width: 40.w,
        height: 28.h,
        color: themeData.shopcartTextColor,
      );
    } else if (keyboard == '-3') {
      widget = ImageView(
        'assets/images/shopcart/collapse1.png',
        width: 40.w,
        height: 28.h,
        color: themeData.shopcartTextColor,
      );
    } else {
      widget = AutoSizeText(
        keyboard == '-1' ? LocaleKeys.bet_max.tr : keyboard,
        maxLines: 1,
        minFontSize: 8,
        style: TextStyle(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha:0.8999999761581421)
              : const Color(0xFF303442),
          fontSize: keyboard == '-1' ? 15.sp : 22.sp,
          fontFamily: keyboard == '-1' ? 'PingFang SC' : 'Akrobat',
          fontWeight: keyboard == '-1' ? FontWeight.w600 : FontWeight.w800,
        ),
      );
    }
    return widget;
  }

  computeAmounts(String keyboard) {
    ///如果限额最大是0，那就不让点击
    var orderMaxPay = data.detailList[0].orderMaxPay.value;

    ///拦截最大限额是0，键盘不给点击
    if (orderMaxPay.isEmpty || orderMaxPay == '0.00') {
      ///过滤收起键盘
      if (keyboard != '-3') {
        return;
      }
    }
    var amount = data.detailList[0].modifyBetAmount.value;
    switch (keyboard) {
      case '.':
        if (amount.isNotEmpty && !amount.contains('.')) {
          amount += keyboard;
        }
        break;

      ///加两个00
      case '00':
        if (amount.isNotEmpty && amount != '0') {
          if (amount.contains('.')) {
            var split = amount.split('.')[1];
            if (split.isEmpty) {
              amount += keyboard;
            } else if (split.length == 1) {
              amount += '0';
            }
          } else {
            amount += keyboard;
          }
        }
        break;

      ///最大
      case '-1':

        ///当前限制最大额度
        double orderMaxPay = double.parse(data.detailList[0].orderMaxPay.value);

        ///当前订单投注额
        double amountTotal = data.orderAmountTotal;

        ///当前用户的余额
        double balanceAmount = TYUserController.to.balanceAmount.value;

        /// 当前订单额度和余额之和
        double sumBalances = amountTotal + balanceAmount;

        ///用户可以修改的最大额度
        double maximumAmountModify =
            (orderMaxPay <= sumBalances) ? orderMaxPay : sumBalances;

        amount = maximumAmountModify.toString();
        data.isChangeAmount.value = false;
        break;

      ///减少
      case '-2':
        if (amount.isNotEmpty && amount.length == 1) {
          amount = '';
        } else if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
        data.isChangeAmount.value = false;
        break;

      ///关闭键盘
      case '-3':
        data.isOnKeyboard.value = false;
        break;

      ///输入数字
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        if (amount.isEmpty || amount.length < 14) {
          if (amount != '0') {
            if (!amount.contains('.')) {
              amount += keyboard;
            } else {
              var split = amount.split('.')[1];
              if (split.isEmpty || split.length < 2) {
                amount += keyboard;
              }
            }
          }
        }
        break;
    }

    ///键盘输入数据超过限额最大值，换成额度最大值
    if (amount.isNotEmpty) {
      ///当前输入的金额
      double parse = double.parse(amount);

      ///当前限制最大额度
      double orderMaxPay = double.parse(data.detailList[0].orderMaxPay.value);

      ///当前订单投注额
      double amountTotal = data.orderAmountTotal;

      ///当前用户的余额
      double balanceAmount = TYUserController.to.balanceAmount.value;

      /// 当前订单额度和余额之和
      double sumBalances = amountTotal + balanceAmount;

      ///修额度限额是不是大于余额

      bool isLimitation = orderMaxPay <= sumBalances;

      ///用户可以修改的最大额度
      double maximumAmountModify = isLimitation ? orderMaxPay : sumBalances;

      if (parse > maximumAmountModify) {
        amount = maximumAmountModify.toString();
        if (isLimitation) {
          ///限额

        } else {
          ///用户最大金额弹框
          BetsUtils.toastDialog(LocaleKeys.app_insufficient_balance);
        }
      }
    }
    data.detailList[0].modifyBetAmount.value = amount;
  }

  computeOdds(String keyboard) {
    var amount = data.detailList[0].oddFinallyChange.value;
    switch (keyboard) {
      case '.':
        if (amount.isNotEmpty && !amount.contains('.')) {
          amount += keyboard;
        }
        break;

      ///加两个00
      case '00':
        if (amount.isNotEmpty && amount != '0') {
          if (amount.contains('.')) {
            var split = amount.split('.')[1];
            if (split.isEmpty) {
              amount += keyboard;
            } else if (split.length == 1) {
              amount += '0';
            }
          } else {
            amount += keyboard;
          }
        }
        break;

      ///最大
      case '-1':
        amount = '355';
        data.isChangeOdds.value = false;
        break;
      case '-2':
        if (amount.isNotEmpty && amount.length == 1) {
          amount = '';
        } else if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
        data.isChangeOdds.value = false;
        break;

      ///关闭键盘
      case '-3':
        data.isOnKeyboard.value = false;
        break;
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        if (amount.isEmpty || amount.length < 14) {
          if (amount != '0') {
            if (!amount.contains('.')) {
              amount += keyboard;
            } else {
              var split = amount.split('.')[1];
              if (split.isEmpty || split.length < 2) {
                amount += keyboard;
                //    data.detailList[0].oddFinallyChange.value += keyboard;
              }
            }
          }
        }
      default:
        break;
    }

    if (amount.isNotEmpty) {
      double parse = double.parse(amount);
      if (parse > 355) {
        amount = "355";
      }
    }
    data.detailList[0].oddFinallyChange.value = amount;
  }
}
