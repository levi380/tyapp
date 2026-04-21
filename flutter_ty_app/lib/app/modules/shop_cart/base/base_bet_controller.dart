import 'dart:core';

import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller_extension_change_odds.dart';


import '../../../../main.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_state.dart';
import 'base_bet_controller_mixin.dart';
import 'base_bet_controller_mixin_bet_amount.dart';
import 'base_bet_controller_mixin_keyboard.dart';
import 'base_bet_controller_mixin_order.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 单关、串关基类。定义投注通用接口
    - 主要包括：
      1.投注数据、投注结果数据存放
      2.键盘处理逻辑
      3.推送处理逻辑
      4.queryLatestMarketInfo 投注数据刷新通用接口
    】】】
 *
 */

abstract class BaseBetController extends GetxController with BaseBetControllerMixinKeyboard,BaseBetControllerMixin,BaseBetControllerMixinOrder,BaseBetControllerMixinBetAmount {

  RxDouble inputAmount = 0.0.obs;


  RxDouble offsetBottom = (bottomHideSwitch ? 260.h:290.h).obs;
  RxDouble offsetRight = 10.0.obs;


  StreamSubscription? subscription;

  //不能与ShopCartController互相嵌套初始化 final state = Get.find<ShopCartController>().state;
  ShopCartState? _state;

  ShopCartState get state {
    _state ??= ShopCartController.to.state;

    return _state!;
  }



  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注键盘快捷金额，缺省为 100, 200, 500, 1000, 2000
      】】】
   *
   */
  List<int> get userCvoMoney {
    return [100, 200, 500, 1000, 2000];
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 输入金额，缺省为输入框输入金额
      】】】
   *
   */
  double get inputTotal {
    return inputAmount.value;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 可赢金额
      】】】
   *
   */
  double profitAmount(int index) {
    return 0.0;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 是否处于不可投注状态，不可投注状态将投注按钮置灰
      】】】
   *
   */
  bool get isSpecialState {
    return false;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 不可投注原因，不可投注的时候在投注按钮上显示
      】】】
   *
   */
  String get specialStateReason {
    return '';
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 倒计时
      •  今日列表下 - 进行中的赛事倒计时是5秒， 4～0， 循环模式

      •  今日列表下 - 未开赛的赛事，倒计时是7秒，6～0， 循环模式

      •  早盘倒计时是30秒，29～0， 循环模式

      •  冠军列表，倒计时30秒，29～0，循环模式
      】】】
   *
   */
  int countDownSeconds(ShopCartItem shopCartItem){
    bool inPlay = shopCartItem.matchType == 2;
    if(state.menu.isPlay ) {
      return 5;
    }else if(state.menu.isEarly || state.menu.isChampion){
      return 30;
    }else{
      if (!inPlay) {
        return 7;
      } else {
        return 5;
      }
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 初始化，监听相关事件
      】】】
   *
   */
  @override
  void onInit() {
    super.onInit();

// ws 处理
    subscription = Bus.getInstance().wsReceive<WsType>().listen((event) {
      switch (event.type) {
        case WsType.C101:
        case WsType.C901:
        // 赛事状态
          setBetC101Change(event.data['cd'] as Map);
          break;
        case WsType.C102:
        // 赛事阶段
          setBetC102Change(event.data['cd'] as Map);
          break;
        case WsType.C103:
        // 赛事比分
          setBetC103Change(event.data['cd'] as Map);
          break;
        case WsType.C104:
        // 赛事级别盘口状态
          setBetC104Change(event.data['cd'] as Map);
          break;
        case WsType.C105:
        case WsType.C106:
        // 赛事订阅盘口赔率变更 修改投注项变更
        // 投注项变更
        // 电竞 Vr因为不能走queryLastMrketInfo，还是需要开推送
        //if(Get.currentRoute != Routes.matchDetail || ShopCartController.to.isEsportBet.value || ShopCartController.to.isVrBet.value ) {
        //重新打开106推送
          setBetC106Change(event.data['cd'] as Map);
          //}
          break;
        case WsType.C109:
        // 赛事开启
          setBetC109Change(event.data['cd'] as List);
          break;
        case WsType.C11:
        //需重新刷新赔率
          setBetC11Change(event.data['cd'] as Map);
          break;
        case WsType.C112:
        //玩法移除或开启
          setBetC112Change(event.data['cd'] as Map);
          break;
      /*
        case WsType.C152://C152的event.data['cd']是String
        case WsType.C153:
        //优惠盘口变动
          setBetC153Change(event.data['cd'] is Map?event.data['cd']:{});
          break;
           */
      // case WsType.C201:
      //   // 注单状态
      //   setBetC201Change(event.data['cd'] as Map);
      //   break;
      // case WsType.C203:
      //   //刷新余额:统一刷新
      //
      //   break;
        case WsType.C302:
        case WsType.C303:
        //赛事盘口变化
          setBetC303Change(event.data['cd'] as Map);
          break;
        default:
          break;
      }
    });

    // 单枪单边水差刷新赔率列表
    Bus.getInstance().on(EventType.send_bat_handicap_odds, (value) {
      queryLatestMarketInfo(type:'C118');
    });
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - dispose，释放监听
      】】】
   *
   */
  @override
  void dispose() {
    subscription?.cancel();
    Bus.getInstance().off(EventType.send_bat_handicap_odds);
    super.dispose();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 增加投注项
        增加ws订阅
        改变投注框状态
        发送投注项选中刷新事件
      】】】
   *
   */
  void addShopCartItem(ShopCartItem item) {
    itemList.add(item);
    ShopCartController.to.subscribeMarket();
    //发起订阅可以放在UserController里
    //AppWebSocket.instance()
    //    .skt_send_order({'cuid': UserController.to.getUid()});
    betStatus.value = ShopCartBetStatus.Normal;
    Bus.getInstance().emit(EventType.oddsButtonUpdate);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 删除投注项
        发送投注项选中刷新事件
      】】】
   *
   */
  void delShopCartItem(ShopCartItem item) {
    itemList.remove(item);
    Bus.getInstance().emit(EventType.oddsButtonUpdate);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 关闭投注框
      】】】
   *
   */
  void closeBet() {
    state.showShopCart.value = false;
    Bus.getInstance().emit(EventType.tyCloseDialog);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 显示投注框
      】】】
   *
   */
  void showBet({queryAmount=false}) {
    state.showShopCart.value = true;
    Bus.getInstance().emit(EventType.tyOpenDialog);
    TYUserController.to.getBalance();

    if(queryAmount){
      queryBetAmount();
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 清除数据
      】】】
   *
   */
  void clearData() {
    //清理数据
    itemList.clear();
    orderRespList.clear();
    seriesOrderRespList.clear();
    try {
      amountController.text = '';
    } catch (e) {
      //late未初始化，忽略
    }
    inputAmount.value = 0.0;
    Bus.getInstance().emit(EventType.oddsButtonUpdate);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注，在子类实现
      】】】
   *
   */
  Future<bool> doBet({bool betAgain = false}) async {
    clearData();

    return true;
  }

}
