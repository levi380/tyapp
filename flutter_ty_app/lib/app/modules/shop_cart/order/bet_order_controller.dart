

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';



import '../../../global/ty_user_controller.dart';
import '../../../global/ws/ws_type.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../services/models/res/order_status_entity.dart';
import '../../../utils/bus/bus.dart';

import '../../login/login_head_import.dart';
import '../../setting_menu/bet_order_notification/bet_order_notification_controller.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_util.dart';

import 'bet_order_queue.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注订单类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    管理投注后生成的订单
      轮询订单状态变化
      接受C201推送
    】】】
 *
 */
class BetOrderController extends GetxController {
  static BetOrderController get to => Get.find<BetOrderController>();

  List<BetResultEntity> betResultList = [];
  Timer? checkTimer;

  StreamSubscription? subscription;

  String _lastCtsp = "";
  String _lastCmd = "";
  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注订单类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 初始化
      创建定时器
      】】】
   *
   */
  @override
  void onInit() {
    super.onInit();
    checkTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      orderCheck();
    });

    // ws 处理
    subscription = Bus.getInstance().wsReceive<WsType>().listen((event) {
      try{
        //过滤重复通知。因为这里只处理C201，ctsp相等认为重复推送过滤掉
        if(event.data['ctsp'] == _lastCtsp && event.type == _lastCmd){
          return;
        }else{
          _lastCtsp = event.data['ctsp']??"";
          _lastCmd = event.type;
        }
        switch (event.type) {

          case WsType.C201:
          // 注单状态
            setBetC201Change(event.data['cd'] as Map);
            break;
        }
      } catch (e) {
        AppLogger.debug(e.toString());
      }
    });
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注订单类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 关闭
      关闭时清除定时器
      】】】
   *
   */
  @override
  void onClose() {
    checkTimer?.cancel();
    subscription?.cancel();

    super.onClose();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注订单类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 清除数据
      】】】
   *
   */
  void clearData() {
    betResultList.clear();
    BetOrderQueue.to.clear();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注订单类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 加入投注结果
      】】】
   *
   */
  void addBetResult(BetResultEntity betResultEntity){
    betResultList.add(betResultEntity);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - C201推送数据
      `orderNo` 订单编号
      `status` 订单状态(1:投注成功 2:投注失败)
      `newTotalMaxWinAmount` 订单最高可赢金额
      `isOddsChange` 赔率是否变更，为true时处理赔率变更集合
      `newProcessOrder` 是否投注新流程订单 1:是 0:否
      `tryNewProcessBet` 是否重试投注新流程订单 1:是 2:投注金额变更 0:否
      `refuseCode` 拒单编码
      `cuid` 用户Id
      `preStatus` 是否提前结算状态：0:原有结算逻辑, 1:是提前结算
      `orderStatus` 专指提前结算状态  1:通过  2:拒绝
      】】】
   *
   */
  void setBetC201Change(Map obj) {
    // 订单id
    // 订单状态 订单状态(1:投注成功 2:投注失败)
    int status = obj['status'] ?? 0;
    int? orderStatusCode;
    if (status == 1) {
      orderStatusCode = OrderStatusCode.success.code;
    }
    if (status == 2) {
      orderStatusCode = OrderStatusCode.failure.code;
    }
    List<String> orderIds = [];
    List<BetResultEntity> orderCheckList = [];

    getOrderCheckList(orderCheckList, orderIds);
    List orderChangeList = [];
    if (orderIds.contains(obj['orderNo'])) {
      // 单关 单注
      orderCheckList.forEach((element) {
        for (BetResultEntity betResultEntity in orderCheckList) {
          if (betResultEntity.seriesOrderRespList.isNotEmpty) {
            //串关
            for (BetResultSeriesOrderRespList respElement in betResultEntity
                .seriesOrderRespList) {
              if (obj['orderNo'] == respElement.orderNo &&
                  respElement.sendWSTime.compareTo(obj['sendWSTime']) < 0) {
                respElement.orderStatusCode =
                    orderStatusCode ?? respElement.orderStatusCode;
                respElement.maxWinAmount = obj['newTotalMaxWinAmount'];
                respElement.sendWSTime = obj['sendWSTime'];

                List orderOddsVos = obj['orderOddsVos'] ?? [];
                Map? orderStatusOddsChange = orderOddsVos.firstWhereOrNull((
                    e) =>
                e is Map && e['riskEvent'] != null && e['riskEvent'] != '');
                if (orderStatusOddsChange != null) {
                  respElement.riskEvent = ShopCartUtil.getRejectOrderReason(
                      orderStatusOddsChange["riskEvent"]);
                }

                orderChangeList.add(respElement);
              }
            }
          } else {
            //单关
            for (BetResultOrderDetailRespList respElement in betResultEntity
                .orderDetailRespList) {
              if (respElement.orderNo == obj['orderNo'] &&
                  respElement.sendWSTime.compareTo(obj['sendWSTime']) < 0) {
                List orderOddsVos = obj['orderOddsVos'] ?? [];
                for (Map orderStatusOddsChange in orderOddsVos) {
                  if (respElement.playOptionsId ==
                      orderStatusOddsChange["oid"]) { //只判断投注项id?
                    if (orderStatusOddsChange["riskEvent"]?.isNotEmpty ??
                        false) {
                      respElement.riskEvent = ShopCartUtil.getRejectOrderReason(
                          orderStatusOddsChange["riskEvent"]);
                    } else if (obj['refuseCode'] == "0400464") {
                      respElement.riskEvent =
                          ShopCartUtil.getRejectOrderReason("over_payout");
                    }

                    respElement.newOddsValues.value =
                    orderStatusOddsChange["ov"];
                    respElement.maxWinMoney = obj['newTotalMaxWinAmount'];
                    respElement.sendWSTime = obj['sendWSTime'];
                    respElement.orderStatusCode =
                        orderStatusCode ?? respElement.orderStatusCode;
                    break;
                  }
                }
                orderChangeList.add(respElement);
              }
            }
          }
        }
      });

      if(orderChangeList.isNotEmpty) {
        List<String> orderChangeIds = orderChangeList.map((element)=>element.orderNo.toString()).toList();
        ShopCartController.to.currentBetController?.updateBetStatus(orderChangeIds);

        for(int i =0;i<orderChangeList.length;i++) {
          var orderDetail= orderChangeList[i];
          if(ShopCartController.to.currentBetController?.hasOrder(orderDetail.orderNo)!=true) {
            if((orderDetail.orderStatusCode == OrderStatusCode.success.code
                && BetOrderNotificationController.sn == '1')
                || (orderDetail.orderStatusCode == OrderStatusCode.failure.code
                    && BetOrderNotificationController.fn == '1')
            ) {
              BetOrderQueue.to.add(orderDetail);
            }
          }
        }
      }
    }else{
      /// 不在列表里面也给予提示
      if(obj['preBetOrder'] == 1 && obj['cuid'] == TYUserController.to.getUid()) {
        //预约注单
        BetResultOrderDetailRespList preBetResultOrderDetail = BetResultOrderDetailRespList();
        preBetResultOrderDetail.preBetOrder = obj['preBetOrder'];
        preBetResultOrderDetail.orderNo = obj['orderNo'];
        preBetResultOrderDetail.orderStatusCode = orderStatusCode??OrderStatusCode.failure.code;
        preBetResultOrderDetail.sendWSTime = obj['sendWSTime'];
        preBetResultOrderDetail.maxWinMoney = obj['newTotalMaxWinAmount'];
        List orderOddsVos = obj['orderOddsVos'] ?? [];
        preBetResultOrderDetail.playOptionsId = orderOddsVos.safeFirst?['oid']??'';
        preBetResultOrderDetail.oddsValues = orderOddsVos.safeFirst?['ov']??'';
        preBetResultOrderDetail.matchInfo = obj['matchInfo']??'';
        preBetResultOrderDetail.matchName = obj['matchName']??'';
        preBetResultOrderDetail.playOptionName = obj['playOptionName']??'';

        if((preBetResultOrderDetail.orderStatusCode == OrderStatusCode.success.code
            && BetOrderNotificationController.rsn == '1')
        || (preBetResultOrderDetail.orderStatusCode == OrderStatusCode.failure.code
                && BetOrderNotificationController.rfn == '1')
        ) {
          BetOrderQueue.to.add(preBetResultOrderDetail);
        }
      }
    }



  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注订单类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 定时请求接口 拉取投注状态
      】】】
   *
   */
  void orderCheck() async{
    List<String> orderIds = [];
    List<BetResultEntity> orderCheckList = [];

    getOrderCheckList(orderCheckList, orderIds);

    if(orderIds.isEmpty){
      return;
    }

    List orderChangeList = [];
    try {
      final res = await BetApi.instance().queryOrderStatus(orderIds.join(","));
      if (res.success) {
        res.data?.forEach((element) {
          int orderStatusCode = OrderStatusCode.uncomplete.code;
          if( element.status == OrderStatus.success0.code || element.status == OrderStatus.success0.code) {
            orderStatusCode = OrderStatusCode.success.code;
          }else if(element.status == OrderStatus.failure2.code || element.status == OrderStatus.failure4.code) {
            orderStatusCode = OrderStatusCode.failure.code;
          }

          for (BetResultEntity betResultEntity in orderCheckList) {
            if(betResultEntity.seriesOrderRespList.isNotEmpty) {
              //串关
              for(BetResultSeriesOrderRespList respElement in betResultEntity.seriesOrderRespList){
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

                  orderChangeList.add(respElement);
                }
              }
            }else{
               //单关
              for(BetResultOrderDetailRespList respElement in betResultEntity.orderDetailRespList) {
                if (element.orderNo == respElement.orderNo && element.sendWSTime.compareTo(respElement.sendWSTime) > 0) { //因为现在毫秒时间戳都是13位，直接字符串比较，不转int了
                  respElement.orderStatusCode = orderStatusCode;
                  List orderOddsVos = element.oddsChangeList;
                  for(OrderStatusOddsChangeList orderStatusOddsChange in orderOddsVos){
                    if(respElement.playOptionsId == orderStatusOddsChange.playOptionsId){
                      if(orderStatusOddsChange.riskEvent.isNotEmpty){
                        respElement.riskEvent = ShopCartUtil.getRejectOrderReason(orderStatusOddsChange.riskEvent);
                      }
                      ///接单过程没有坑位变化？
                      respElement.newOddsValues.value = orderStatusOddsChange.usedOdds;
                      respElement.maxWinMoney = element.newMaxWinAmount.toString();
                      respElement.sendWSTime = element.sendWSTime;
                    }
                  }
                  orderChangeList.add(respElement);
                }

              }
            }

          }


        });

        if(orderChangeList.isNotEmpty) {
          List<String> orderChangeIds = orderChangeList.map((element)=>element.orderNo.toString()).toList();
          ShopCartController.to.currentBetController?.updateBetStatus(orderChangeIds);

          for(int i =0;i<orderChangeList.length;i++) {
            var orderDetail= orderChangeList[i];
            if(ShopCartController.to.currentBetController?.hasOrder(orderDetail.orderNo)!=true) {
              if((orderDetail.orderStatusCode == OrderStatusCode.success.code
                  && BetOrderNotificationController.sn == '1')
                  || (orderDetail.orderStatusCode == OrderStatusCode.failure.code
                      && BetOrderNotificationController.fn == '1')
              ) {
                BetOrderQueue.to.add(orderDetail);
              }
            }
          }
        }
      }
    } catch (e) {
      AppLogger.debug(e.toString());
    }

  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注订单类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取未完成的订单。包括订单类数组和订单号数组
      】】】
   *
   */
  void getOrderCheckList(List<BetResultEntity> orderCheckList,List<String> orderIds){
    for(BetResultEntity betResultEntity in betResultList){
      bool hasUncomplete = false;
      if(betResultEntity.seriesOrderRespList.isNotEmpty){
        //串关
        betResultEntity.seriesOrderRespList.forEach((element) {
          if(element.orderStatusCode == OrderStatusCode.uncomplete.code) {
            orderIds.add(element.orderNo);
            hasUncomplete = true;
          }
        });
      }else{
        //单关
        betResultEntity.orderDetailRespList.forEach((element) {
          // 因为一键投注也更新orderStatusCode,但是没写sendWSTime，所以此处加sendWSTime.isEmpty判断
          // 一键投注的数据也改到 BetOrderController之后，可以去掉element.sendWSTime.isEmpty
          //if(element.orderStatusCode == OrderStatusCode.uncomplete.code || element.sendWSTime.isEmpty) {
          if(element.orderStatusCode == OrderStatusCode.uncomplete.code) {
            orderIds.add(element.orderNo);
            hasUncomplete = true;
          }
        });
      }
      if(hasUncomplete){
        orderCheckList.add(betResultEntity);
      }
    }
  }
}