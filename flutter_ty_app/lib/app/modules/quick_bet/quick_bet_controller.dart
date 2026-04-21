import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:get/get.dart';

import '../../global/ty_user_controller.dart';

import '../../services/api/bet_api.dart';
import '../../services/api/menu_api.dart';
import '../../services/models/res/bet_result_entity.dart';
import '../../services/models/res/order_status_entity.dart';
import '../../utils/toast_util.dart';
import '../home/controllers/home_controller.dart';
import '../main_tab/main_tab_controller.dart';
import '../setting_menu/one_click_betting/one_click_betting_controller.dart';
import '../shop_cart/model/shop_cart_item.dart';
import 'quick_bet_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-0ff385d2-90ba-4fd9-bd7f-068a85286ade 】】】
    【【【 AUTO_DOCUMENT_MENU 一键投注弹窗 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注弹窗-业务逻辑 】】】
    【【【 AUTO_PARAGRAPH_TITLE 主控制器 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 包含组件隐藏显示、全屏状态、临时开关等参数
    ```
    // 全屏
    var fullscreen = false.obs;
    //一键投注列表开关 开启则展示新的一键投注流程  false为旧流程
    var isOpen = true;
    // 控制组件隐藏显示
    var isClose = true.obs;
    // 打开某些页面时 临时关闭
    var isTempClose = false.obs;
    ```
    - 注单状态监听bus，监听购物车传来的数据，更新订单状态信息
    ```
    Bus.getInstance().wsReceive<WsType>().listen((event) {})
    ```
    - 定时器轮训请求，更新注单信息  兜底逻辑 10秒如果订单还在 定时查询订单
    - removeCountdown 设置订单展示时间；remainCountdown 订单目前保留时间
    ```
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    countHandler();
    })
    // 轮训处理器
    countHandler() async {
    for (BetResultOrderDetailRespList item in orderRespList) {
    // 成功、失败移除列表
    if ([0, 1].contains(item.orderStatusCode)) {
    item.removeCountdown--;
    } else {
    item.remainCountdown++;
    }
    // 兜底逻辑 10秒如果订单还在 定时查询订单
    if (item.remainCountdown > 10) {
    _checkOrderThrottle();
    }
    }
    pop();
    }
    ```
    - 从购物车添加订单
    ```
    QuickBetController.to.push(res.data?.orderDetailRespList ?? [], itemList);
    ```
    - 从购物车更新订单状态
    ```
    // 修改一键投注列表订单状态
    QuickBetController.to.updateOrder(element);
    ```
    】】】
 *
 */

class QuickBetController extends GetxController {
  static QuickBetController get to => Get.put(QuickBetController());
  final QuickBetState state = QuickBetState();

  /// 全屏
  var fullscreen = false.obs;

  /// 一键投注列表开关 开启则展示新的一键投注流程  false为旧流程
  var isOpen = true;

  /// 控制组件隐藏显示
  var isClose = true.obs;

  /// 打开某些页面时 临时关闭
  var isTempClose = false.obs;

  /// 是否包含优惠盘口
  bool hasDiscountOdds = false;

  StreamSubscription? _subscription;

  RxList<BetResultOrderDetailRespList> orderRespList =
      <BetResultOrderDetailRespList>[].obs;

  Timer? _timer;

  var _checkOrderThrottle;

  // 展开项订单号 只有一项能展开
  RxString expandOrderNo = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // 注单状态ws监听
    // _subscription = Bus.getInstance().wsReceive<WsType>().listen((event) {
    //   switch (event.type) {
    //     case WsType.C201:
    //       // 注单状态
    //       wsHandlerOrder(event.data['cd'] as Map);
    //       break;
    //     default:
    //       break;
    //   }
    // });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      countHandler();
    });

    // 订单状态定时器
    // _checkOrderThrottle = throttle(() {
    //   checkOrder();
    // }, const Duration(milliseconds: 3000));
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  /// 往订单列表推送
  push(List<BetResultOrderDetailRespList> orderDetailRespList,
      List<ShopCartItem> items) {
    orderDetailRespList.forEach((e) {
      items.forEach((item) {
        if (e.playOptionsId == item.playOptionsId) {
          e.handicap = item.handicap;
          e.playId = item.playId;
          e.sportId = item.sportId;
          e.oldPlayOptionName = item.playOptionName;
          e.oldMarketValue = item.marketValue;
          e.oldHandicapHv = item.handicapHv.value;
        }
      });
    });
    if (isOpen && orderDetailRespList.isNotEmpty) {
      orderRespList.insertAll(0, orderDetailRespList);
      checkOrderList();
      isClose.value = false;
      isTempClose.value = false;
    }
  }

  /// 订单列表溢出 成功和失败的订单 removeCountdown 秒后移除
  pop() {
    //放在数组remove前面，因为orderRespList变化会引起Obx更新
    checkOrderList();
    //removeWhere会引发刷新
    orderRespList.removeWhere((value) {
      if (value.removeCountdown <= 0) {
        if (value.orderNo == expandOrderNo.value) {
          expandOrderNo.value = "";
        }
        return true;
      }
      return false;
    });
  }

  void checkOrderList() {
    hasDiscountOdds = false;
    for (BetResultOrderDetailRespList orderResp in orderRespList) {
      if (orderResp.removeCountdown > 0 && orderResp.orgOddFinally.isNotEmpty) {
        hasDiscountOdds = true;
        break;
      }
    }
  }

  /// 设置全屏状态
  setFullScreen(bool value) {
    WidgetsBinding.instance.endOfFrame.then((e) {
      fullscreen.value = value;
    });
  }

  /// 关闭一键投注
  closeOneClickBetting() async {
    try {
      final res = await MenuApi.instance().saveUserCustomizeInfo(
        TYUserController.to.seriesList,
        TYUserController.to.singleList,
        false,
        false,
        TYUserController.to.oneClickBetAmount.toInt().toString(),
      );
      if (res.code == '0000000') {
        // if (switchOn == false) {
        //   ToastUtils.customizedBetAmountSuccessful(
        //       '${'${LocaleKeys.bet_one_click_bet_change.tr} '}${toAmountSplit(int.parse(textEditingController.text.isEmpty ? fastBetAmount.toString() : textEditingController.text).toStringAsFixed(2))}');
        // }
        orderRespList.clear();
        if (Get.isRegistered<OneClickBettingController>()) {
          await OneClickBettingController.to.initData();
        } else {
          await initData();
        }
      } else {
        ToastUtils.show(res.msg);
      }
    } catch (e) {}
  }

  /// 初始化用户配置信息
  Future<void> initData() async {
    final res = await MenuApi.instance().getUserCustomizeInfo();
    if (res.code == '0000000') {
      TYUserController.to.getUserCustomizeInfoBetAmount(infoRes: res);
    } else {
      ToastUtils.show(res.msg);
    }
  }

  /// 处理ws推送订单
  void wsHandlerOrder(Map obj) {
    // orderNo 订单号
    // 订单状态 0:投注失败 1: 投注成功 2: 订单确认中
    List orderNoList = orderRespList.map((element) => element.orderNo).toList();
    if (orderNoList.contains(obj['orderNo'])) {
      // 单关 单注
      orderRespList.asMap().forEach((index, item) {
        if (item.orderNo == obj['orderNo']) {
          orderRespList[index].orderStatusCode = obj['status'];
        }
      });
    }
  }

  /// 更新订单状态
  updateOrder(OrderStatusEntity order) {
    orderRespList.asMap().forEach((index, item) {
      if (item.orderNo == order.orderNo) {
        if ([4, 2].contains(order.status)) {
          orderRespList[index].orderStatusCode = 0;
        } else if ([0, 1].contains(order.status)) {
          orderRespList[index].orderStatusCode = 1;
        } else {
          orderRespList[index].orderStatusCode = 2;
        }
      }
    });
  }

  /// http查询订单状态
  checkOrder() async {
    List orderIds = [];
    orderRespList.forEach((element) {
      if (![0, 1].contains(element.orderStatusCode)) {
        orderIds.add(element.orderNo);
      }
    });
    if (orderIds.isEmpty) {
      return;
    }
    try {
      final res = await BetApi.instance().queryOrderStatus(orderIds.join(","));
      if (res.success) {
        res.data?.forEach((element) {
          for (var respElement in orderRespList) {
            if (element.orderNo == respElement.orderNo) {
              // data.status（4:拒单、0:接单、3:待确认、2:取消、1:已处理)
              // 4,2 失败
              // 0,1 成功
              // 3 继续拉单
              if ([4, 2].contains(element.status)) {
                respElement.orderStatusCode = 0;
              } else if ([0, 1].contains(element.status)) {
                respElement.orderStatusCode = 1;
              } else {
                respElement.orderStatusCode = 2;
              }
            }
          }
        });
      }
    } catch (e) {
      AppLogger.debug(e.toString());
    }
  }

  /// 轮训处理器
  Future<void> countHandler() async {
    for (BetResultOrderDetailRespList item in orderRespList) {
      // 成功、失败移除列表
      if ([0, 1].contains(item.orderStatusCode)) {
        item.removeCountdown--;
      } else {
        item.remainCountdown++;
      }

      // 兜底逻辑 10秒如果订单还在 定时查询订单
      // if (item.remainCountdown > 10) {
      //   _checkOrderThrottle();
      // }
    }
    pop();
  }

  bool checkHide() {
    bool topMenuCheck = false;
    if (Get.isRegistered<MainTabController>() &&
        Get.isRegistered<TyHomeController>(tag: MainTabController.to.uuid)) {
      if (TyHomeController.to.homeState.menu.isMatchBet) {
        // 串关页面不显示一键投注弹窗
        topMenuCheck = true;
      }
    }

    return !TYUserController.to.isOneClickBet.value ||
        !isOpen ||
        isClose.value ||
        isTempClose.value ||
        orderRespList.isEmpty ||
        topMenuCheck;
  }

  void expandItem(BetResultOrderDetailRespList item) {
    // 测试更新需求全部彩种都要点击支持展开
    AppLogger.debug("========>sportId  ${item.sportId}  ${(['1001', '1002', '1004', '1007', '1008', '1009', '1010', '1011', '1012']
        .contains(item.sportId))}");
    if (expandOrderNo.value == item.orderNo) {
      expandOrderNo.value = '';
    } else {
      expandOrderNo.value = item.orderNo;
    }
    // 只有vr可以查看详情
    // if (['1001', '1002', '1004', '1007', '1008', '1009', '1010', '1011', '1012',"1","2"]
    //     .contains(item.sportId)) {
    //   if (expandOrderNo.value == item.orderNo) {
    //     expandOrderNo.value = '';
    //   } else {
    //     expandOrderNo.value = item.orderNo;
    //   }
    // }
  }
}
