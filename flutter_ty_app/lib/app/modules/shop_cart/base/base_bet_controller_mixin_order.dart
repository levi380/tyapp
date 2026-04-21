import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:get/get.dart';



import '../../../services/models/req/bet_req.dart';
import '../../../services/models/res/bet_result_entity.dart';


import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_util.dart';
import 'base_bet_controller_mixin.dart';

mixin BaseBetControllerMixinOrder on BaseBetControllerMixin{

  //orderCheck 逻辑现在已经移到BetOrderController
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注确认中 循环请求接口 拉取投注状态
      - 现使用BetOrderController，此方法废弃
      】】】
   *

  void orderCheck(){
    Future.delayed(const Duration(seconds: 2),() async{
      if(!(betStatus.value == ShopCartBetStatus.Betting || betStatus.value == ShopCartBetStatus.Prebooking)){
        return;
      }
      List orderIds = [];
      List orderList;
      if(seriesOrderRespList.isNotEmpty) {
        orderList = seriesOrderRespList;
      }else{
        orderList = orderRespList;
      }
      orderList.forEach((element) {
        //一键投注可能修改orderStatusCode，所以增加sendWSTime判断。
        // 4341需求已将orderCheck统一处理，QuickBetController不再更新注单状态
        if(element.orderStatusCode == OrderStatusCode.uncomplete.code || element.sendWSTime.isEmpty) {
          orderIds.add(element.orderNo);
        }
      });
      if(orderIds.isEmpty){
        return;
      }

      try {
        final res = await BetApi.instance().queryOrderStatus(orderIds.join(","));
        if (res.success) {
          res.data?.forEach((element) {

            // data.status（4:拒单、0:接单、3:待确认、2:取消、1:已处理)
            // 4,2 失败
            // 0,1 成功
            // 3 继续拉单
            if( element.status != OrderStatus.uncomplete3.code){
              int orderStatusCode = OrderStatusCode.uncomplete.code;
              if( element.status == OrderStatus.success0.code || element.status == OrderStatus.success0.code) {
                orderStatusCode = OrderStatusCode.success.code;
              }else if(element.status == OrderStatus.failure2.code || element.status == OrderStatus.failure4.code) {
                orderStatusCode = OrderStatusCode.failure.code;
              }
              for (BetResultOrderDetailRespList respElement in orderRespList) {
                if (element.orderNo == respElement.orderNo && element.sendWSTime.compareTo(respElement.sendWSTime) > 0) { //因为现在毫秒时间戳都是13位，直接字符串比较，不转int了
                  respElement.orderStatusCode = orderStatusCode;
                  List orderOddsVos = element.oddsChangeList;
                  for(OrderStatusOddsChangeList orderStatusOddsChange in orderOddsVos){
                    if(respElement.playOptionsId == orderStatusOddsChange.playOptionsId){
                      if(seriesOrderRespList.isEmpty && orderStatusOddsChange.riskEvent.isNotEmpty){
                        //单关的riskEvent直接写写在orderRespList，串关不写
                        respElement.riskEvent = ShopCartUtil.getRejectOrderReason(orderStatusOddsChange.riskEvent);
                      }
                      ///接单过程没有坑位变化？
                      respElement.newOddsValues.value = orderStatusOddsChange.usedOdds;
                      respElement.maxWinMoney = element.newMaxWinAmount.toString();
                      respElement.sendWSTime = element.sendWSTime;
                      break;
                    }
                  }
                }
              }
              //串关需记录到seriesOrderRespList
              for(BetResultSeriesOrderRespList respElement in seriesOrderRespList){
                if (element.orderNo == respElement.orderNo && element.sendWSTime.compareTo(respElement.sendWSTime) > 0) {
                  respElement.orderStatusCode = orderStatusCode;
                  respElement.maxWinAmount = element.newMaxWinAmount.toString();
                  respElement.sendWSTime = element.sendWSTime;

                  List orderOddsVos = element.oddsChangeList;
                  //串关取第一个非空riskEvent
                  OrderStatusOddsChangeList? riskEvent = orderOddsVos.firstWhereOrNull((e)=>e.riskEvent!=null && e.riskEvent.isNotEmpty);
                  if(riskEvent!=null){
                    respElement.riskEvent = ShopCartUtil.getRejectOrderReason(riskEvent.riskEvent);
                  }

                }
              }
            }

            /*
            for (var respElement in orderList) {
              if (element.orderNo == respElement.orderNo) {
                // data.status（4:拒单、0:接单、3:待确认、2:取消、1:已处理)
                // 4,2 失败
                // 0,1 成功
                // 3 继续拉单
                if( element.status == 0 || element.status == 1) {
                  respElement.orderStatusCode = 1;
                }else if(element.status == 2 || element.status == 4){
                  respElement.orderStatusCode = 0;

                  List orderOddsVos = element.oddsChangeList;
                  // OrderStatusOddsChangeList? riskEvent = orderOddsVos.firstWhereOrNull((e)=>e.riskEvent!=null && e.riskEvent.isNotEmpty);
                  // if(riskEvent!=null){
                  //   respElement.riskEvent = ShopCartUtil.getRejectOrderReason(riskEvent.riskEvent);
                  //   if(ShopCartUtil.showBetAgain(respElement.riskEvent! )) {
                  //     hasUpdateRiskEvent = true;
                  //   }
                  // }
                  for(OrderStatusOddsChangeList orderStatusOddsChange in orderOddsVos){
                    if(respElement.playOptionsId == orderStatusOddsChange.playOptionsId){
                      if(orderStatusOddsChange.riskEvent.isNotEmpty){
                        respElement.riskEvent = ShopCartUtil.getRejectOrderReason(orderStatusOddsChange.riskEvent);
                      }
                      respElement.oddsValues = orderStatusOddsChange.usedOdds;
                      break;
                    }
                  }

                }
                break;
              }
            }
            if(hasUpdateRiskEvent){
              updateRiskEventData();
            }
            */

            // 修改一键投注列表订单状态
            QuickBetController.to.updateOrder(element);
          });
          if(betStatus.value == ShopCartBetStatus.Betting || betStatus.value == ShopCartBetStatus.Prebooking) {
            var item = orderList.firstWhereOrNull((element) => element.orderStatusCode == OrderStatusCode.uncomplete.code);
            if(item == null) {

              var successItem = orderList.firstWhereOrNull((
                  element) =>  element.orderStatusCode == OrderStatusCode.success.code );
              var failureItem = orderList.firstWhereOrNull((
                  element) =>  element.orderStatusCode == OrderStatusCode.failure.code );
              if (successItem != null) {
                if(failureItem != null){
                  //有成功的，也有不成功的
                  betStatus.value =  ShopCartBetStatus.PartSuccess;
                }else{
                  betStatus.value = betStatus.value == ShopCartBetStatus.Prebooking?ShopCartBetStatus.PrebookSuccess:ShopCartBetStatus.Success;
                }
              } else {
                betStatus.value = betStatus.value == ShopCartBetStatus.Prebooking?ShopCartBetStatus.PrebookCancel:ShopCartBetStatus.Failure;
              }
            }else{
              orderCheck();
            }
          }

        } else {
          orderCheck();
        }
      } catch (e) {
        AppLogger.debug(e.toString());
        orderCheck();
      }

    });
  }
*/

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - orderRespList添加结果
      - 并根据投注请求数据填充 投注前数据，用于比较赔率、盘口变化
      】】】
   *
   */

  void setOrderDetailRespList(BetResultEntity? betResultEntity,BetReq betReq ){
    orderRespList.clear();
    //orderRespList.addAll(res.data?.orderDetailRespList??[]);
    (betResultEntity?.orderDetailRespList??[]).forEach((element) {
      for(BetReqSeriesOrdersOrderDetailList orderDetail in betReq.seriesOrders.safeFirst?.orderDetailList??[]){
        if(orderDetail.playOptionsId == element.playOptionsId){
          element.shopCartItemId = orderDetail.shopCartItemId;
          element.oldHandicapHv = orderDetail.handicapHv;
          element.oldOddsValues = orderDetail.oddFinally;
          element.newOddsValues.value = element.oddsValues;
          element.orgOddFinally = orderDetail.orgOddFinally;
          element.vrNo = orderDetail.vrNo;
          break;
        }
      }
      orderRespList.add(element);
    });

    //数据加入到betOrderController
    if(betResultEntity!=null) {
      ShopCartController.to.betOrderController.addBetResult(betResultEntity);
    }
  }

  /*
  投注失败后，点继续投注
  跳转回投注页面，现已废弃
   */
  void acceptBetAgain(){
    betStatus.value = ShopCartBetStatus.Normal;
    bool isMarketChange = false;
    orderRespList.forEach((element){
      for(ShopCartItem item in itemList){
        if(item.itemId == element.shopCartItemId){
          if(item.playOptionsId != element.playOptionsId){
            isMarketChange = true;
            break;
          }
        }
      }
    });
    if(isMarketChange){
      ShopCartUtil.showBetError('0402009');
    }
    orderRespList.clear();
    seriesOrderRespList.clear();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注失败后，拉取最新赔率数据
      】】】
   *
   */
  void updateRiskEventData() async{
    await queryLatestMarketInfo(type:'risk_event');
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 订单状态更新后，判断当前controller投注状态是否要转变成注单成功或者注单失败
      】】】
   *
   */
  void updateBetStatus(List<String> orderChangeIds){
    List orderList;
    if(seriesOrderRespList.isNotEmpty) {
      orderList = seriesOrderRespList;
    }else{
      orderList = orderRespList;
    }

    List changedOrderList = orderList.where((e) => orderChangeIds.contains(e.orderNo)).toList();

    if(changedOrderList.isNotEmpty) {
      if (betStatus.value == ShopCartBetStatus.Betting ||
          betStatus.value == ShopCartBetStatus.Prebooking) {
        var item = orderList.firstWhereOrNull((element) =>
        element.orderStatusCode == OrderStatusCode.uncomplete.code);
        if (item == null) {
          var successItem = orderList.firstWhereOrNull((element) =>
          element.orderStatusCode == OrderStatusCode.success.code);
          var failureItem = orderList.firstWhereOrNull((element) =>
          element.orderStatusCode == OrderStatusCode.failure.code);
          if (successItem != null) {
            if (failureItem != null) {
              //有成功的，也有不成功的
              betStatus.value = ShopCartBetStatus.PartSuccess;
            } else {
              betStatus.value =
              betStatus.value == ShopCartBetStatus.Prebooking
                  ? ShopCartBetStatus
                  .PrebookSuccess
                  : ShopCartBetStatus.Success;
            }
          } else {
            betStatus.value =
            betStatus.value == ShopCartBetStatus.Prebooking ? ShopCartBetStatus
                .PrebookCancel : ShopCartBetStatus.Failure;
          }
        }
      }
    }

    update(['series_order_resp']);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 判断是否包含注单号
      如果当前controller包含状态变化的注单，说明该注单正显示在 注单确认中 界面，不必弹出通知toast
      】】】
   *
   */
  bool hasOrder(String orderId){
    List orderList;
    if(seriesOrderRespList.isNotEmpty) {
      orderList = seriesOrderRespList;
    }else{
      orderList = orderRespList;
    }

    List changedOrderList = orderList.where((e) => orderId == e.orderNo).toList();
    return changedOrderList.isNotEmpty;
  }
}