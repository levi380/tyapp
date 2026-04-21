import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/ty_user_controller.dart';

mixin BaseBetControllerMixinKeyboard on GetxController{
  late TextEditingController amountController;

  late FocusNode amountFocusNode;

  bool showKeyBoard = false;
  Random random = Random();
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最小值，缺省为2
      】】】
   *
   */
  String get minValue {
    return '2';
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大值，缺省为8000-9000之间得随机数
      】】】
   *
   */
  String get maxValue {
    int randomNumber = 8000 + random.nextInt(1000);
    return randomNumber.toString();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 显示隐藏键盘
      】】】
   *
   */
  void keyboardVisiable(bool show) {
    showKeyBoard = show;
    if (!showKeyBoard) {
      amountFocusNode.unfocus();
    }
    update(['keyboard', 'input']);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 数字键
      】】】
   *
   */
  void insertText(String myText) {
    final text = amountController.text;
    TextSelection textSelection = amountController.selection;
    if (textSelection.start < 0) {
      //未focus
      textSelection = const TextSelection(baseOffset: 0, extentOffset: 0);
    }

    String newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );

    if(TYUserController.to.balanceAmount.value <= 0){
      //余额不足
      return;
    }
    if(newText.substring(0,1) == '0' && newText.length>1 && newText.substring(1,2) != '.'){
      //0后面只能输入小数点
      return;
    }
    final newTextArray = newText.split('.');
    if (newTextArray.length > 1 && newTextArray[1].length > 2) {
      //小数点后只输入2位
      return;
    }
    if(newTextArray.length > 2) {
      //已有小数点
      return;
    }
    double maxInput = min((double.tryParse(maxValue) ?? 0),
        TYUserController.to.balanceAmount.value);
    if ((double.tryParse(newText) ?? 0) > maxInput) {
      newText = maxInput.toStringAsFixed(2);
      amountController.text = newText;
    } else {
      final myTextLength = myText.length;
      amountController.text = newText;
      amountController.selection = textSelection.copyWith(
        baseOffset: textSelection.start + myTextLength,
        extentOffset: textSelection.start + myTextLength,
      );
    }
    amountFocusNode.requestFocus();

    update(['keyboard']);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 数字替换键
      】】】
   *
   */
  void replaceText(String myText) {
    if(TYUserController.to.balanceAmount.value <= 0){
      //余额不足
      return;
    }

    double maxInput = min((double.tryParse(maxValue) ?? 0),
        TYUserController.to.balanceAmount.value);
    if ((double.tryParse(myText) ?? 0) > maxInput) {
      myText = maxInput.toStringAsFixed(2);
    }

    amountController.text = myText;

    amountFocusNode.requestFocus();

    update(['keyboard']);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大投注
      】】】
   *
   */
  void maxInputText() {
    if(TYUserController.to.balanceAmount.value <= 0){
      //余额不足
      return;
    }
    double maxInput = min((double.tryParse(maxValue) ?? 0),
        TYUserController.to.balanceAmount.value);
    amountController.text = maxInput.toStringAsFixed(2);

    amountFocusNode.requestFocus();

    update(['keyboard']);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 删除键
      】】】
   *
   */
  void backspace() {
    amountFocusNode.requestFocus();
    final text = amountController.text;
    final textSelection = amountController.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      amountController.text = newText;
      amountController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    amountController.text = newText;
    amountController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );

    update(['keyboard']);
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }
}