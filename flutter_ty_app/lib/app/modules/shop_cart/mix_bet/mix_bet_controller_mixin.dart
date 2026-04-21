import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:get/get.dart';

import '../../../services/models/res/bet_result_entity.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/models/main_menu.dart';
import '../base/base_bet_controller.dart';
import '../model/bet_count_model.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_util.dart';

mixin MixBetControllerMixin on BaseBetController{
  final RxList<BetCountModel> betSpecialSeries =
      List<BetCountModel>.empty().obs;
  List<TextEditingController> amountControllerList = [];
  ScrollController scrollController = ScrollController();
  // 是否显示向下滚动标识，默认不显示
  final showScrollFlag = false.obs;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 订单金额
      】】】
   *
   */
  double get orderTotal {
    double amountSum = 0.0;
    seriesOrderRespList.forEach((element) {
      amountSum += double.tryParse(element.seriesBetAmount) ?? 0.0;
    });
    return amountSum;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取串关投注项
      新加入的投注项金额置空，删除投注项导致当前输入消失的，关闭键盘
      重新获取限额
      】】】
   *
   */
  void getBetSpecialSeries({bool newAdd = false}) {
    int oldCount = betSpecialSeries.length;
    betSpecialSeries.clear();
    betSpecialSeries.addAll(ShopCartUtil.getBetCountJoint(itemCount));
    if (newAdd) {
      //如果是新增加item，输入金额置空
      if (oldCount < betSpecialSeries.length) {
        for (int i = oldCount; i < betSpecialSeries.length; i++) {
          TextEditingController element = amountControllerList[i];
          element.text = '';
        }
      }
    } else {
      if (oldCount != betSpecialSeries.length) {
        //有变化，需要重新取限额
        queryBetAmount();
      }
      if (showKeyBoard) {
        int index = amountControllerList.indexOf(amountController);
        if (betSpecialSeries.length <= index) {
          keyboardVisiable(false);
        }
      }
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
      - 判断是否显示滚动标志
      】】】
   *
   */
  void postFrameCallback() {
    if (scrollController.positions.isNotEmpty) {
      if (scrollController.position.maxScrollExtent > 0 &&
          scrollController.offset == 0) {
        showScrollFlag.value = true;
      } else {
        showScrollFlag.value = false;
      }
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 进入预约界面
      】】】
   *
   */
  void goPrebook() {
    betStatus.value = ShopCartBetStatus.Prebook;
  }



  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 跳到单关今日页面
      】】】
   *
   */
  Future<void> goSingle() async {
    closeBet();
    clearData();
    await TyHomeController.to.changeMenu(MainMenu.menuList[0]);
    // Get.until((route) =>
    //     Get.currentRoute == Routes.mainTab ||
    //     state.currentRoute == Routes.mainTab);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 保留选项继续投注
      】】】
   *
   */
  void keepBet() {
    betStatus.value = ShopCartBetStatus.Normal;
    showKeyBoard = false;
    orderRespList.clear();
    seriesOrderRespList.clear();
    itemList.removeWhere((element) => element.isColsed);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 是否显示重新投注按钮
      如果所有投注订单是可以再次投注的，则返回成功
      否则返回失败
      】】】
   *
   */
  bool showBetAgain() {
    bool ret = false;
    for (BetResultSeriesOrderRespList seriesOrder in seriesOrderRespList) {
      if (seriesOrder.riskEvent != null) {
        if (ShopCartUtil.showBetAgain(seriesOrder.riskEvent!)) {
          ret = true;
        } else {
          ret = false;
          break;
        }
      }
    }
    return ret;
  }

}