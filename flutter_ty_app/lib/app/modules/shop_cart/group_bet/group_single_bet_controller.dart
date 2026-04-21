import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/base_bet_controller.dart';

class GroupSingleBetController extends BaseBetController {
  final preferenceExpanded = true.obs;
  final betVisiable = 1.obs;//1:无条件公开;2:认购后可查看;3:开奖后公开
  final showVisiable = false.obs;

  final Rx<num> buyMinAmount = 10.obs;
  final Rx<num> brokerage = 10.obs;
  final Rx<num> oddsOffset = 9.99.obs;
  final Rx<num> endMinute = 3.obs;

  final guaranteed = true.obs;

  late TextEditingController groupAmountController;
  late TextEditingController buyAmountController;
  late FocusNode groupAmountFocusNode;
  late FocusNode buyAmountFocusNode;
  final groupInputAmount = 0.0.obs;
  final buyInputAmount = 0.0.obs;

  ScrollController scrollController = ScrollController();

  @override
  Future<void> queryBetAmount() async {
    // TODO: implement queryBetAmount

  }
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 合买投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 初始化，监听输入
      】】】
   *
   */
  @override
  void onInit() {
    super.onInit();

    groupAmountController = TextEditingController();
    groupAmountController.addListener(() {
      groupInputAmount.value = double.tryParse(groupAmountController.text)??0.0;
    });

    buyAmountController = TextEditingController();
    buyAmountController.addListener(() {
      buyInputAmount.value = double.tryParse(buyAmountController.text)??0.0;
    });

    groupAmountFocusNode = FocusNode();
    groupAmountFocusNode.addListener(() {
      bool hasFocus = groupAmountFocusNode.hasFocus;
      if(hasFocus){
        amountController = groupAmountController;
        amountFocusNode = groupAmountFocusNode;
        keyboardVisiable(true);
      }
    });

    buyAmountFocusNode = FocusNode();
    buyAmountFocusNode.addListener(() {
      bool hasFocus = buyAmountFocusNode.hasFocus;
      if(hasFocus){
        amountController = buyAmountController;
        amountFocusNode = buyAmountFocusNode;
        keyboardVisiable(true);
      }
    });

    // 合买缺省不显示键盘
    showKeyBoard = false;
  }


  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 合买投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 关闭投注框 清空数据
      】】】
   *
   */
  @override
  void closeBet(){
    clearData();
    super.closeBet();
  }
}
