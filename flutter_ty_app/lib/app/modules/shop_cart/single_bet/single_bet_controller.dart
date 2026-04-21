import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/bet_history_record.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_type.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_history.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_util.dart';

import './single_bet_controller_mixin_bet_amount.dart';
import '../../../../generated/locales.g.dart';
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../home/models/main_menu.dart';
import '../base/base_bet_controller.dart';
import '../model/shop_cart_item.dart';
import '../shop_cart_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 单关投注控制类
      继承自投注基类，处理单关投注相关逻辑
    】】】
 *
 */
class SingleBetController extends BaseBetController with SingleBetControllerMixinBetAmount {

  BetHistoryRecord? betHistoryRecord;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最小值
      从接口返回数据BetAmountBetAmountInfo中获取
      负数赔率需做限额转换
      】】】
   *
   */
  @override
  String get minValue{
    ShopCartItem shopCartItem = itemList.first;
    BetAmountBetAmountInfo? betAmountInfo = betMinMaxMoney[shopCartItem.playOptionsId];
    if(betAmountInfo!=null){

      double oddFinally = double.tryParse(itemList.safeFirst?.oddFinally.value??"0")??0.0;
      //负数赔率需做限额转换
      if(oddFinally < -0.00001){
        if(itemList.safeFirst?.marketTypeFinally == 'MY') {
          double minBet = double.tryParse(betAmountInfo.minBet) ?? 0.0;
          minBet = minBet / (oddFinally * -1);
          //minBet = (minBet*100.0).ceilToDouble()/100.0;
          //取整
          minBet = minBet.ceilToDouble();
          return minBet.toStringAsFixed(2);
        }else{
          //印尼（美国）负数赔率，不需要转化
          //直接使用对应(商户)正常欧洲赔率限额的最小值
          return betAmountInfo.minBet;
        }
      }else {
        return betAmountInfo.minBet;
      }

      //负数赔率不再转换最小值
      //return betAmountInfo!.minBet;
    }
    return super.minValue;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大值
      从接口返回数据BetAmountBetAmountInfo中获取
      负数赔率需做限额转换
      】】】
   *
   */
  @override
  String get maxValue{
    ShopCartItem shopCartItem = itemList.first;
    BetAmountBetAmountInfo? betAmountInfo = betMinMaxMoney[shopCartItem.playOptionsId];
    if(betAmountInfo!=null){
      double oddFinally = double.tryParse(itemList.safeFirst?.oddFinally.value??"0)")??0.0;

      //负数赔率需做限额转换
      if(oddFinally < -0.00001){
        double minAmount = double.tryParse(betAmountInfo.minBet)??0;
        if(itemList.safeFirst?.marketTypeFinally == 'US'){
          //美式赔率需除以100
          oddFinally = oddFinally/100.0;
        }
        if(itemList.safeFirst?.marketTypeFinally != 'MY') {
          //印尼（美国）负数赔率，需要转化'取整"
          double orderMaxPay = double.tryParse(betAmountInfo.orderMaxPay) ??
              0.0;
          orderMaxPay = orderMaxPay / (oddFinally * -1);
          orderMaxPay =
              ShopCartUtil.floorLimitAmount(minAmount, orderMaxPay);
          if(orderMaxPay<minAmount){
            orderMaxPay = minAmount;
          }
          return orderMaxPay.toStringAsFixed(2);
        }else{
          //马来负数赔率，不需要转化（需要'取整"）
          double orderMaxPay = double.tryParse(betAmountInfo.orderMaxPay) ??
              0.0;
          //用欧赔还原成 赔付限额。如果不转换，那会和欧赔限额有差异
          orderMaxPay = betAmountInfo.orderMaxPayRestore;
          //orderMaxPay = ShopCartUtil.floorLimitAmount(minAmount, orderMaxPay);
          //因为业务返回的欧赔限额做过floor，所以这里向上进位。也不能保证100%正确
          orderMaxPay = ShopCartUtil.ceilLimitAmount(minAmount, orderMaxPay);
          minAmount = double.tryParse(minValue)??0;
          if(orderMaxPay<minAmount){
            orderMaxPay = minAmount;
          }
          return orderMaxPay.toStringAsFixed(2);
        }
      }else {
        return betAmountInfo.orderMaxPay;
      }
    }
    return super.maxValue;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 快捷金额
      从userInfo中获取
      】】】
   *
   */
  @override
  List<int> get userCvoMoney{
    return  [
      TYUserController.to.userInfo.value?.cvo?.single?.qon??100,
      TYUserController.to.userInfo.value?.cvo?.single?.qtw??200,
      TYUserController.to.userInfo.value?.cvo?.single?.qth??500,
      TYUserController.to.userInfo.value?.cvo?.single?.qfo??1000,
      TYUserController.to.userInfo.value?.cvo?.single?.qfi??2000,
    ];
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 是否处于不可投注状态： 判断ShopCartItem是否关闭
      】】】
   *
   */
  @override
  bool get isSpecialState{
    var item = itemList.firstWhereOrNull((element) => element.isColsed);

    return item!=null;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 不可投注原因  盘口已关闭
      】】】
   *
   */
  @override
  String get specialStateReason {
    return LocaleKeys.bet_closed.tr;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 可赢金额 根据赔率计算
        负数赔率返回负数金额，表示需投入金额
      】】】
   *
   */
  @override
  double profitAmount(int index){
    double oddFinally = double.tryParse(itemList.safeFirst?.oddFinally.value??"0")??0.0;
    //负数赔率返回负数金额，表示需投入金额
    if(oddFinally < -0.00001){
      if(itemList.safeFirst?.marketTypeFinally == 'US'){
        //美式赔率需除以100
        oddFinally = oddFinally/100.0;
      }
      //负数，表示投注金额。判断inputAmount==0以避免返回-0.0
      return inputAmount.value==0?0.0:inputAmount * oddFinally;
    }

    int odds = (itemList.first.discountOdds > 0)?itemList.first.discountOdds:itemList.first.odds;
    double profitOdd = odds/100000.0 - 1.0;
    return inputAmount * profitOdd;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大投注
      负数赔率需将输入金额转换成可赢金额
      】】】
   *
   */
  @override
  void maxInputText() {
    if(TYUserController.to.balanceAmount.value <= 0){
      //余额不足
      return;
    }
    double balanceAmount = TYUserController.to.balanceAmount.value;
    double oddFinally = double.tryParse(itemList.safeFirst?.oddFinally.value??"0)")??0.0;
    //负数赔率需将输入金额转换成可赢金额
    if(oddFinally < -0.00001){
      if(itemList.safeFirst?.marketTypeFinally == 'US'){
        //美式赔率需除以100
        oddFinally = oddFinally/100.0;
      }
      balanceAmount =  balanceAmount/ (oddFinally * -1);
      balanceAmount = (balanceAmount*100).floorToDouble()/100;

      double maxInput = min((double.tryParse(maxValue) ?? 0),balanceAmount);
      amountController.text = maxInput.toStringAsFixed(2);

      amountFocusNode.requestFocus();

      update(['keyboard']);
    }else{
      super.maxInputText();
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
      - 初始化，监听输入
      】】】
   *
   */
  @override
  void onInit() {
    super.onInit();

    amountController = TextEditingController();
    amountController.addListener(() {
      inputAmount.value = double.tryParse(amountController.text)??0.0;
    });

    amountFocusNode = FocusNode();
    amountFocusNode.addListener(() {
      bool hasFocus = amountFocusNode.hasFocus;
      if(hasFocus){
        keyboardVisiable(true);
      }
    });

    //单关缺省显示键盘
    showKeyBoard = true;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - onClose，释放监听
      】】】
   *
   */
  @override
  void onClose(){
    amountController.dispose();
    amountFocusNode.dispose();

    super.onClose();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 增加投注项
      增加ws订阅
      改变投注框状态
      发送投注项选中刷新事件
      】】】
   *
   */
  @override
  void addShopCartItem(ShopCartItem item){
    itemList.clear();//合并单关的话，判marketId是否相同，相同的替换
    super.addShopCartItem(item);

    betHistoryRecord = ShopCartHistory().getHistoryRecord(item);
    //amountController.text = betHistoryRecord.betAmount??'';
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 关闭投注框 清空数据
      】】】
   *
   */
  @override
  void closeBet(){
    betHistoryRecord?.betAmount = amountController.text;
    clearData();
    super.closeBet();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 显示投注框
      】】】
   *
   */
  void showBet({queryAmount=false}) {
    super.showBet(queryAmount:queryAmount);
    amountFocusNode.requestFocus();
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
  void goPrebook(){
    betStatus.value = ShopCartBetStatus.Prebook;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 跳到串关页面，并且把当前ShopCartItem加入
      】】】
   *
   */
  Future<void> goParlay() async {
    ShopCartItem item = itemList.first;
    closeBet();
    await TyHomeController.to.changeMenu(MainMenu.menuList.firstWhere((element) => element.isMatchBet));
    if(!(Get.currentRoute == Routes.mainTab || state.currentRoute == Routes.matchDetail)) {
      Get.until((route) => Get.currentRoute == Routes.mainTab || state.currentRoute == Routes.mainTab
        || Get.currentRoute == Routes.matchDetail || state.currentRoute == Routes.matchDetail
      );
    }
    //去串関需變成歐洲盤
    item.marketTypeFinally = TYUserController.to.curOdds;
    item.oddFinally.value = TYFormatOddsConversionMixin.computeValueByCurOddType(
        item.odds,
        item.odds2,
        item.playId,
        item.oddsHsw.split(','),
        int.tryParse(item.sportId) ?? 0,
        item.cds
    );
    ShopCartController.to.currentBetController?.addShopCartItem(item);
    ShopCartController.to.currentBetController?.queryBetAmount();
  }
}
