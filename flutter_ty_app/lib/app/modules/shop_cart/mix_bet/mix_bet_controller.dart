import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../base/base_bet_controller.dart';
import '../model/bet_count_model.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import 'mix_bet_controller_mixin.dart';
import 'mix_bet_controller_mixin_bet_amount.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 串关投注控制类
    继承自投注基类，处理串关投注相关逻辑
    】】】
 *
 */
class MixBetController extends BaseBetController with MixBetControllerMixin,MixBetControllerMixinBetAmount{
  List<FocusNode> amountFocusNodeList = [];
  late TextEditingController amountControllerSingle;
  late FocusNode amountFocusNodeSingle;

  //最大注数限制，电竞串关需判断
  int maxBetCount = 0;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最小值
        根据当前的输入框来获取index
      】】】
   *
   */
  @override
  String get minValue {
    if (itemCount == 1) {
      ShopCartItem shopCartItem = itemList.first;
      BetAmountBetAmountInfo? betAmountInfo =
          betMinMaxMoney[shopCartItem.playOptionsId];
      if (betAmountInfo != null) {
        return betAmountInfo.minBet;
      }
      return super.minValue;
    } else {
      int index = amountFocusNodeList.indexOf(amountFocusNode);
      return minValueOfSerie(index);
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大值
      根据当前的输入框来获取index
      】】】
   *
   */
  @override
  String get maxValue {
    if (itemCount == 1) {
      ShopCartItem shopCartItem = itemList.first;
      BetAmountBetAmountInfo? betAmountInfo =
          betMinMaxMoney[shopCartItem.playOptionsId];
      if (betAmountInfo != null) {
        return betAmountInfo.orderMaxPay;
      }
      return super.maxValue;
    } else {
      int index = amountFocusNodeList.indexOf(amountFocusNode);
      return maxValueOfSerie(index);
    }
  }

  /*  关盘做删除处理
  @override
  int get itemCount {
    int shopcartItemCount = 0 ;
    itemList.forEach((element) {
      if(!element.isColsed && !element.isOddChanging){
        shopcartItemCount++;
      }
    });
    return shopcartItemCount;
  }
  */

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 输入金额
        串关投注各项输入总和
      】】】
   *
   */
  @override
  double get inputTotal {
    double amountSum = 0.0;
    for (int i = 0; i < betSpecialSeries.length; i++) {
      BetCountModel betCountModel = betSpecialSeries[i];
      amountSum += inputAmountList[i].value * betCountModel.count;
    }

    return amountSum;
  }

  int get inputBetCount => 0;
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 快捷金额 从userInfo中获取
      】】】
   *
   */
  @override
  List<int> get userCvoMoney {
    return [
      TYUserController.to.userInfo.value?.cvo?.series?.qon ?? 10,
      TYUserController.to.userInfo.value?.cvo?.series?.qtw ?? 50,
      TYUserController.to.userInfo.value?.cvo?.series?.qth ?? 100,
      TYUserController.to.userInfo.value?.cvo?.series?.qfo ?? 200,
      TYUserController.to.userInfo.value?.cvo?.series?.qfi ?? 500,
    ];
  }



  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 是否处于不可投注状态
        判断是否有ShopCartItem关闭
      】】】
   *
   */
  @override
  bool get isSpecialState {
    if (!(minSeriesNum <= itemCount && itemCount <= maxSeriesNum) &&
        itemCount != 1) {
      return true;
    }

    var item = itemList
        .firstWhereOrNull((element) => element.isColsed || !element.canParlay);

    return item != null;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 不可投注原因
        盘口已关闭
        或者未达到最小串关数量
      】】】
   *
   */
  @override
  String get specialStateReason {
    /// 只有一个投注项，可单关投注
    if(itemCount != 1){
      if(itemCount < minSeriesNum){
        String errorMsg = LocaleKeys.bet_bet_min_item.tr;
        errorMsg = errorMsg.replaceAll('{num}', minSeriesNum.toString());
        return errorMsg;
      }
      if(itemCount > maxSeriesNum){
        String errorMsg = LocaleKeys.bet_bet_max_options.tr.replaceAll(
            '{num}', maxSeriesNum.toString());
        return errorMsg;
      }
    }
    if (!(minSeriesNum <= itemCount && itemCount <= maxSeriesNum) && itemCount != 1) {
      String errorMsg = LocaleKeys.bet_bet_min_item.tr;
      errorMsg = errorMsg.replaceAll('{num}', minSeriesNum.toString());
      return errorMsg;
    }

    return LocaleKeys.bet_closed.tr;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最小投注金额 从接口返回数据BetAmountBetAmountInfo中获取
      】】】
   *
   */
  String minValueOfSerie(int index) {
    String defaultValue = super.minValue;
    if (index >= 0 && index < betSpecialSeries.length) {
      BetCountModel betCountModel = betSpecialSeries[index];
      return betCountModel.betAmountInfo.value?.minBet ?? defaultValue;
    }

    return defaultValue;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大投注金额 从接口返回数据BetAmountBetAmountInfo中获取
      】】】
   *
   */
  String maxValueOfSerie(int index) {
    if (index >= 0 && index < betSpecialSeries.length) {
      BetCountModel betCountModel = betSpecialSeries[index];
      return betCountModel.betAmountInfo.value?.orderMaxPay ?? super.maxValue;
    }

    return super.maxValue;
  }

  @override
  double profitAmount(int index) {
    if (itemCount == 1) {
      //引发obs更新
      //String oddFinally = itemList.safeFirst?.oddFinally.value??"0";
      itemList.safeFirst?.oddFinally.value;

      int odds = (itemList.first.discountOdds > 0)
          ? itemList.first.discountOdds
          : itemList.first.odds;
      double profitOdd = odds / 100000.0 - 1.0;
      return inputAmount * profitOdd;
    } else {
      if (index >= 0 && index < betSpecialSeries.length) {
        double profitOdd = (double.tryParse(
                betSpecialSeries[index].betAmountInfo.value?.seriesOdds ??
                    '') ??
            0);
        TextEditingController textEditingController =
            amountControllerList[index];
        double editAmount = double.tryParse(textEditingController.text) ?? 0.0;
        return max(
            0,
            editAmount * profitOdd -
                betSpecialSeries[index].count * editAmount);
      }
    }
    return super.profitAmount(index);
  }

  @override
  void addShopCartItem(ShopCartItem item) {
    for (int i = 0; i < itemList.length; i++) {
      ShopCartItem shopCartItem = itemList[i];
      if (shopCartItem.matchId == item.matchId) {
        itemList.removeAt(i);
        shopCartItem.everListener?.dispose();
        break;
      }
    }

    super.addShopCartItem(item);
    // item.everListener = everAll([item.olOs, item.hlHs, item.midMhs], (values) {
    //   if (betStatus == ShopCartBetStatus.Normal &&
    //       (item.isColsed || item.isLocked)) {
    //     delShopCartItem(item);
    //   }
    //   //getBetSpecialSeries();
    // });

    getBetSpecialSeries(newAdd: true);

    // amountControllerList.forEach((element) {
    //   element.text = '';
    // });
  }

  @override
  void delShopCartItem(ShopCartItem item) {
    super.delShopCartItem(item);
    item.everListener?.dispose();
    getBetSpecialSeries();
    // amountControllerList.forEach((element) {
    //   element.text = '';
    // });
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 初始化，监听输入和滚动
      】】】
   *
   */
  @override
  void onInit() {
    super.onInit();

    for (int i = 0; i < 10; i++) {
      inputAmountList.add(0.0.obs);

      TextEditingController textEditingController = TextEditingController();
      textEditingController.addListener(() {
        double inputValue = double.tryParse(textEditingController.text) ?? 0.0;
        inputAmount.value = inputValue;
        inputAmountList[i].value = inputValue;
        update(['input_total']);
      });
      amountControllerList.add(textEditingController);

      FocusNode focusNode = FocusNode();
      focusNode.addListener(() {
        bool hasFocus = focusNode.hasFocus;
        if (hasFocus) {
          amountController = amountControllerList[i];
          amountFocusNode = focusNode;
          keyboardVisiable(true);
          update(['input_total']);
        }
      });
      amountFocusNodeList.add(focusNode);
    }

    amountControllerSingle = TextEditingController();
    amountControllerSingle.addListener(() {
      inputAmount.value = double.tryParse(amountControllerSingle.text) ?? 0.0;
    });

    amountFocusNodeSingle = FocusNode();
    amountFocusNodeSingle.addListener(() {
      bool hasFocus = amountFocusNodeSingle.hasFocus;
      if (hasFocus) {
        amountController = amountControllerSingle;
        amountFocusNode = amountFocusNodeSingle;
        keyboardVisiable(true);
      }
    });

    scrollController.addListener(() {
      //滚动后隐藏滚动标志
      if (scrollController.offset > 0) {
        showScrollFlag.value = false;
      } else {
        showScrollFlag.value = true;
      }
    });
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - onClose，释放监听
      】】】
   *
   */
  @override
  void onClose() {
    for (TextEditingController textEditingController in amountControllerList) {
      textEditingController.dispose();
    }
    for (FocusNode focusNode in amountFocusNodeList) {
      focusNode.dispose();
    }

    scrollController.dispose();

    super.onClose();
  }

  @override
  void keyboardVisiable(bool show) {
    super.keyboardVisiable(show);
    if (showKeyBoard) {
      double bottomHeight = -20.0;
      if (itemCount < maxSeriesNum) {
        bottomHeight += 46 + 2;
      }
      for (int i = betSpecialSeries.length - 1; i >= 0; i--) {
        TextEditingController textEditingController = amountControllerList[i];
        if (textEditingController != amountController) {
          bottomHeight += 32.h + 20;
          if (textEditingController.text.length > 0 ||
              textEditingController == amountController) {
            bottomHeight += 16.sp + 10;
          }
        } else {
          break;
        }
      }
      //需等待scroll重新布局
      Future.delayed(const Duration(milliseconds: 100), () {
        double currEditOffset =
            max(0, scrollController.position.maxScrollExtent - bottomHeight);
        //scrollController.animateTo(max(currEditOffset,scrollController.offset), duration: const Duration(milliseconds: 100), curve: Curves.ease);
        scrollController.jumpTo(max(currEditOffset, scrollController.offset));
      });
    }
  }

  @override
  void clearData() {
    amountControllerList.forEach((element) {
      element.text = '';
    });
    amountControllerSingle.text = '';
    super.clearData();
  }

  @override
  void closeBet() {
    showKeyBoard = false;
    if (betStatus.value != ShopCartBetStatus.Normal) {
      clearData();
    }
    super.closeBet();
  }

  @override
  void showBet({queryAmount = false}) {
    if (itemCount == 1) {
      showKeyBoard = true;
      amountController = amountControllerSingle;
      amountFocusNode = amountFocusNodeSingle;
    }
    super.showBet(queryAmount: queryAmount);
  }
}
