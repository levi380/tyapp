
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/quick_bet/quick_bet_controller.dart';


import '../../../../generated/locales.g.dart';
import '../../../services/models/res/bet_result_entity.dart';

import '../shop_cart_controller.dart';
import '../widgets/bet_toast_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注通知队列】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 维护一个队列，里面是需要显示的投注结果
    队列有数据的时候，会依次显示投注结果Toast，直到数据取完
    】】】
 *
 */
class BetOrderQueue {
  /// 私有构造函数
  BetOrderQueue._internal();

  /// 单例实例
  static final BetOrderQueue _instance = BetOrderQueue._internal();

  /// 获取单例
  static BetOrderQueue get to => _instance;

  /// 队列（存放待显示的 Toast Widget）
  final List _queue = [];

  /// 当前是否正在显示 Toast
  bool _isShowing = false;

  /// 当前正在展示的 Toast Widget（用于页面内 Obx 层渲染）
  final Rx<Widget?> currentToast = Rx<Widget?>(null);
  //当前显示order，也要参与排重
  var currentOrder;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注通知队列】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 加入一个 order 到队列
      】】】
   *
   */
  void add(var order) {
    final orderIndex = _queue.indexWhere((e) => e.orderNo == order.orderNo);
    if (orderIndex >= 0 || order.orderNo == currentOrder?.orderNo) {
      //重复注单，不加
      return;
    }
    if(order.preBetOrder != 1) {
      //非预约注单加在预约注单前面
      final index = _queue.indexWhere((e) => e.preBetOrder == 1);
      if (index >= 0) {
        //有预约注单，插到预约注单前面
        _queue.insert(index, order);
      }else {
        //无预约注单，加最后
        _queue.add(order);
      }
    }else{
      //预约注单加最后
      _queue.add(order);
    }
    _tryShowNext();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注通知队列】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 内部方法：尝试显示下一个 Toast
      Toast有三处消失：1、Toast定时器到了，隐藏toast 2、手指上滑，隐藏toast 3、点击toast，显示未结算注单界面，并且当前toast隐藏
      】】】
   *
   */
  void _tryShowNext() {
    if(!QuickBetController.to.checkHide()){
      // 一键投注窗口显示时，不显示注单通知。但是显示预约通知
      _queue.removeWhere((e)=> !(e is BetResultOrderDetailRespList && e.preBetOrder == 1));
    }
    if (_isShowing || _queue.isEmpty) return;

    _isShowing = true;
    currentOrder = _queue.removeAt(0);

    bool isPrebet = currentOrder is BetResultOrderDetailRespList && currentOrder.preBetOrder == 1;
    String betString = isPrebet?LocaleKeys.bet_bet_book_confirm.tr:LocaleKeys.app_betting.tr;
    if(currentOrder is BetResultSeriesOrderRespList){
      betString = "$betString ${currentOrder.seriesValue}";
    }else{
      betString = "$betString ${currentOrder.matchName} ${currentOrder
          .matchInfo} ${currentOrder.playOptionName} @${currentOrder
          .oddsValues}";
    }
    currentToast.value = Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.up,
      onDismissed: (_) {
        next();
      },
      child: GestureDetector(
        // 点击打开未结注单
        onTap: () {
          if(!MainTabController.to.isOngoingBetsOpen ){
            ShopCartController.to.currentBetController?.closeBet();
            MainTabController.to.openOngoingBetsPage();
            next();
          }
        },
        child: BetToastWidget(
          orderStatusCode: currentOrder.orderStatusCode,
          betString: betString,
          isPrebook: isPrebet,
          onFinish: () {
            next();
          },
        ),
      ),
    );
    // ToastUtils.showTopToast(
    //     currentToast.value
    // );
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注通知队列】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 当前 Toast 消失后调用这个方法，继续下一个
      】】】
   *
   */
  void next() {
    currentToast.value = null;
    currentOrder = null;
    _isShowing = false;
    _tryShowNext();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注通知队列】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 清空队列
      】】】
   *
   */

  void clear() {
    _queue.clear();
    _isShowing = false;
  }
}
