import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_history.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_prebook/single_prebook_controller_mixin_bet_amount.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../core/constant/common/module/csid.dart';
import '../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../../services/models/res/bet_result_entity.dart';
import '../../../../services/models/res/last_market_entity.dart';
import '../../../../utils/bet_appoint_util.dart';
import '../../../../utils/toast_util.dart';
import '../../model/shop_cart_item.dart';
import '../../model/shop_cart_type.dart';
import '../single_bet_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 预约投注控制类
    继承自单关投注类，处理预约投注相关逻辑
    】】】
 *
 */
class SinglePrebookController extends SingleBetController with SinglePrebookBetControllerMixinBetAmount {

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 构造函数
      共用单关投注的投注项、投注状态、投注结果，只是投注界面与单关投注不同
      】】】
   *
   */
  SinglePrebookController(ShopCartItem shopCartItem,Rx<ShopCartBetStatus> shopCartBetStatus,List<BetResultOrderDetailRespList> orderResp){




    itemList.add(shopCartItem);//共用SingleBetController中的shopCartItem
    betStatus = shopCartBetStatus;//共用SingleBetController中的betStatus
    orderRespList = orderResp;//共用SingleBetController中的orderRespList

    if(shopCartItem.matchType == 3){
      maxOdd = 1500;
    }



  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最小值，根据当前输入框判断
      】】】
   *
   */
  String get minValue {
    if(amountController == oddsController){
      //return itemList.first.oddFinally.value;
      return preOddFinally;
    }else{
      return super.minValue;
    }

  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大值，根据当前输入框判断
      】】】
   *
   */
  String get maxValue {
    if(amountController == oddsController){
      return maxOdd.toString();
    }else{
      return super.maxValue;
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 可赢金额 根据预约赔率计算
      】】】
   *
   */
  @override
  double profitAmount(int index) {
    double extraOdd = 1.0;
    if(itemList.first.oddsHsw.contains(Csid.odds_table[TYUserController.to.curOdds]??'') && TYUserController.to.curOdds == 'HK'){
      extraOdd = 0.0;
    }

    double profitOdd = prebookOdd.value - extraOdd;
    return inputAmount * profitOdd;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大投注
      负数赔率需将输入金额转换成可赢金额
      】】】
   *
   */
  @override
  void maxInputText() {
    if(amountController == oddsController){
      //编辑赔率的时候不反应
      return;
    }else{
      return super.maxInputText();
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 初始化，记录和恢复预约投注的输入金额
      】】】
   *
   */
  @override
  void onInit() {
    super.onInit();

    preHandicap.value = itemList.first.handicapHv.value;
    preMarketId = itemList.first.marketId;
    prePlayoptionsId = itemList.first.playOptionsId;
    preOddFinally = itemList.first.oddFinally.value;

    prebookAmountController = amountController;
    prebookFocusNode = amountFocusNode;

    prebookAmountController.text = betHistoryRecord?.prebookAmount??'';
    prebookAmountController.selection = TextSelection(baseOffset:prebookAmountController.text.length ,extentOffset:prebookAmountController.text.length );
    inputAmount.value = double.tryParse(prebookAmountController.text)??0.0;

    prebookAmountController.addListener(() {
      inputAmount.value = double.tryParse(prebookAmountController.text)??0.0;
      betHistoryRecord?.prebookAmount = prebookAmountController.text;
    });
    prebookFocusNode.addListener(() {
      bool hasFocus = prebookFocusNode.hasFocus;
      if (hasFocus) {
        amountController = prebookAmountController;
        amountFocusNode = prebookFocusNode;
        update(['keyboard']);
      }
    });

    oddsController = TextEditingController();
    oddsController.addListener(() {
      double oddValue = double.tryParse(oddsController.text)??0.0;
      if(oddValue != prebookOdd.value) {
        prebookOdd.value = oddValue;
        //预约赔率变化，重新获取限额
        queryBetAmount();
      }
    });

    oddsFocusNode = FocusNode();
    oddsFocusNode.addListener(() {
      bool hasFocus = oddsFocusNode.hasFocus;
      if(hasFocus){
        amountController = oddsController;
        amountFocusNode = oddsFocusNode;
        keyboardVisiable(true);
      }
    });

    betHistoryRecord = ShopCartHistory().getHistoryRecord(itemList.first);
    oddsController.text = betHistoryRecord?.prebookOdd??itemList.first.oddFinally.value;
    //prebookOdd.value = double.tryParse(oddsController.text)??0.0;

  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - onClose，释放监听
      】】】
   *
   */
  @override
  void onClose(){
    amountController = prebookAmountController;
    amountFocusNode = prebookFocusNode;
    oddsController.dispose();
    oddsFocusNode.dispose();

    super.onClose();
  }
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 取消预约投注，返回正常投注
      】】】
   *
   */
  void cancelPrebook(){
    betStatus.value = ShopCartBetStatus.Normal;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 预约赔率 减
      】】】
   *
   */
  void reduceOdd(){
    double odd = double.tryParse(oddsController.text)??0.0;
    double originalOdd = double.tryParse(preOddFinally)??0.0;
    if(odd <= originalOdd){
      // 已经是最小赔率 不做处理
      ToastUtils.showGrayBackground(LocaleKeys.app_book_bet_1.tr);
      return;
    }else {
      odd -= odds_change_val(odd);
      oddsController.text = odd.toStringAsFixed(2);

      betHistoryRecord?.prebookOdd = oddsController.text;
    }
    // if(!oddsFocusNode.hasFocus) {
    //   oddsFocusNode.requestFocus();
    // }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 预约 赔率 加
      】】】
   *
   */
  void addOdd(){
    double odd = double.parse(oddsController.text);
    if(odd >= maxOdd){
      // 最大赔率 不做处理
      ToastUtils.showGrayBackground(LocaleKeys.bet_bet_max_booked_odds.tr);
      return;
    }else {
      odd += odds_change_val(odd);
      oddsController.text = odd.toStringAsFixed(2);

      betHistoryRecord?.prebookOdd = oddsController.text;
    }
    // if(!oddsFocusNode.hasFocus) {
    //   oddsFocusNode.requestFocus();
    // }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 预约盘口 减
      】】】
   *
   */
  void reduceHandicap(){
    if(BetAppointUtil.canSubtract(itemList.first.sportId.toInt(), itemList.first.playId, preHandicap.value, itemList.first.scoreHomeAway.replaceAll("-", ":"))){
      preHandicap.value = BetAppointUtil.calcNextValue(itemList.first.sportId.toInt(), itemList.first.playId, preHandicap.value, false);

      List<LastMarketCurrentMarket> marketList = latestMarketInfoList.safeFirst?.marketList??[];
      ShopCartItem shopCartItem = itemList.first;
      // int prebookOddValue = (prebookOdd.value*100000 + 0.001).floor();
      // if(shopCartItem.marketTypeFinally == 'HK') //&& UserController.to.isCurDdds(item.oddsHsw) ) 此处修改了Vue得逻辑，当前是港赔都加1
      //     {
      //   prebookOddValue = prebookOddValue + 100000;
      // }
      // 判断有没有 直接投注的盘口和投注项
      preMarketId = "";
      prePlayoptionsId = "";
      for(LastMarketCurrentMarket market in marketList){
        //if(market.marketValue == shopCartItem.marketValue){
        if(market.marketValue == preHandicap.value){
          for(var odds in market.marketOddsList){
            if(odds.oddsType == shopCartItem.playOptions){
              preMarketId = market.id;
              prePlayoptionsId = odds.id;
              if(odds.oddsValue!=0) {
                preOddFinally =
                    TYFormatOddsConversionMixin.computeValueByCurOddType(
                        odds.oddsValue,
                        null,
                        shopCartItem.playId,
                        shopCartItem.oddsHsw.split(','),
                        int.tryParse(shopCartItem.sportId) ?? 0,
                        shopCartItem.dataSource
                    );
                oddsController.text = preOddFinally;
              }

              break;
            }
          }
        }
      }

      queryBetAmount();
    }else{
      ToastUtils.showGrayBackground(LocaleKeys.app_book_bet_3.tr);
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 预约 盘口 加
      】】】
   *
   */
  void addHandicap(){
    if(BetAppointUtil.canAdd(itemList.first.sportId.toInt(), itemList.first.playId, preHandicap.value, itemList.first.scoreHomeAway.replaceAll("-", ":"))){
      preHandicap.value = BetAppointUtil.calcNextValue(itemList.first.sportId.toInt(), itemList.first.playId, preHandicap.value, true);

      List<LastMarketCurrentMarket> marketList = latestMarketInfoList.safeFirst?.marketList??[];
      ShopCartItem shopCartItem = itemList.first;
      // int prebookOddValue = (prebookOdd.value*100000 + 0.001).floor();
      // if(shopCartItem.marketTypeFinally == 'HK') //&& UserController.to.isCurDdds(item.oddsHsw) ) 此处修改了Vue得逻辑，当前是港赔都加1
      //     {
      //   prebookOddValue = prebookOddValue + 100000;
      // }
      // 判断有没有 直接投注的盘口和投注项
      preMarketId = "";
      prePlayoptionsId = "";
      for(LastMarketCurrentMarket market in marketList){
        //if(market.marketValue == shopCartItem.marketValue){
        if(market.marketValue == preHandicap.value){
          for(var odds in market.marketOddsList){
            if(odds.oddsType == shopCartItem.playOptions){
              preMarketId = market.id;
              prePlayoptionsId = odds.id;
              if(odds.oddsValue!=0) {
                preOddFinally =
                    TYFormatOddsConversionMixin.computeValueByCurOddType(
                        odds.oddsValue,
                        null,
                        shopCartItem.playId,
                        shopCartItem.oddsHsw.split(','),
                        int.tryParse(shopCartItem.sportId) ?? 0,
                        shopCartItem.dataSource
                    );
                oddsController.text = preOddFinally;
              }

              break;
            }
          }
        }
      }

      queryBetAmount();
    }else{
      ToastUtils.showGrayBackground(LocaleKeys.app_book_bet_4.tr);
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 赔率修改梯度
      例如：
      < 3.00的：如 1.99，2.00，2.01，2.99；
      ≥3 且＜5.00的：如 3.00，3.05， 3.55 ，4.95；
      ≥5 且 ＜10.00的：如5.00，5.10， 6.20 ，7.30，9.90；
      ≥10 且 ＜20.0的：如10.0，10.5， 11.5 ，18.5，20.0；
      ≥20 ～355：如20，21， 22 ，99，100，300，......

      场景举例：
      赔率18.5时，连续点击三次，为19.0，19.5，20
      赔率19.0时，连续点击三次，为19.5，20, 21
      】】】
   *
   */
  double odds_change_val (double odds) {
    double num = 0.01;
    if(odds >= 3 && odds < 5){
      num = 0.05;
    }else if( odds >= 5 && odds < 10 ){
      num = 0.1;
    }else if ( odds >= 10 && odds < 20 ){
      num = 0.5;
    }else if (odds >= 20){
      num = 1;
    }
    return num;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 判断是否可以预约盘口，3个条件：
      1、商户有没有打开预约
      2、是否打开足球、篮球预约开关
      3、是否可预约盘口的玩法
      】】】
   *
   */
  bool canBookHandicap(){
    int bookBet = TYUserController.to.userInfo.value?.configVO?.bookBet??0;
    int bookMarketSwitch = TYUserController.to.userInfo.value?.configVO?.bookMarketSwitch??0;
    int bookMarketSwitchBasketball = TYUserController.to.userInfo.value?.configVO?.bookMarketSwitchBasketball??0;
    int sportId = itemList.first.sportId.toInt();
    int playId = itemList.first.playId.toInt();
    return bookBet == 1 //商户是否支持
        && ((sportId == 1 && bookMarketSwitch ==1)
            || (sportId == 2 && bookMarketSwitchBasketball ==1)) //盘口开关
        && BetAppointUtil.canChangeHandicap(sportId,playId) //是否可预约盘口的玩法
        ;
  }

}
