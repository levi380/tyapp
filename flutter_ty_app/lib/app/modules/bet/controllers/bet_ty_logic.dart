import 'dart:async';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:flutter_ty_app/app/modules/bet/controllers/bet_ty_logic.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../global/ws/ws_app.dart';
import '../../../services/models/res/get_cashout_max_amount_list_entity.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_pre_settle_order_detail_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/toast_util.dart';
import '../../../utils/utils.dart';
import '../../../utils/vr_rank_icon_utils.dart';
import '../../unsettled_bets/utils/betsUtils.dart';
import '../service/bet_record_service.dart';
import 'bet_record_controller.dart';

export 'bet_ty_logic_extension.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育类型注单控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 体育注单控制类。获取体育注单数据，处理提前结算
    】】】
 *
 */
class BetTyLogic extends GetxController {
  get state => BetRecordController.to.state;
  BetRecordService get service => BetRecordController.to.service;

  List<GetH5OrderListDataRecordxData> get listData => state.tyDataList;

  ///提前结算列表数据
  List<GetCashoutMaxAmountListData> maxAmountListData = [];

  set listData(List<GetH5OrderListDataRecordxData> list) {
    state.tyDataList = list;
  }

  Timer? bet_timer;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  bool settleSwitch = TYUserController.to.isSettleSwitch();
  bool settleSwitchBasket = TYUserController.to.isSettleSwitchBasket();
  bool sysBookedSettleSwitch = TYUserController.to.isSysBookedSettleSwitch();
  bool sysPartSettleSwitch = TYUserController.to.isSysPartSettleSwitch();
  bool bookedSettleSwitchFootball =
      TYUserController.to.isBookedSettleSwitchFootball();
  bool bookedSettleSwitchBasketball =
      TYUserController.to.isBookedSettleSwitchBasketball();



  ///产品要求，4260需求回退，暂时不上线，等待通知......
  //bool partSettleSwitchFootball =
  //    TYUserController.to.isPartSettleSwitchFootball();
  //bool partSettleSwitchBasketball =
  //    TYUserController.to.isPartSettleSwitchBasketball();
  //先写死，4260不让开启
  bool partSettleSwitchFootball = false;
  bool partSettleSwitchBasketball = false;


  @override
  void onClose() {
    bet_timer?.cancel();
    refreshController.dispose();
    Bus.getInstance().off(EventType.orderPreSettle);
    super.onClose();
  }

  orderPreSettleObserve() {
    if (AppWebSocket.channel != null) {
      ///判断 ws是否关闭
      ///注单订阅
      AppWebSocket.instance()
          .sktSendOrder({'cuid': TYUserController.to.getUid()});
    }

    Bus.getInstance().on(EventType.orderPreSettle, (Map<String, dynamic> data) {
      ///注单处理逻辑
      //  print("AwaitBetsLogic----数据返回---" + data.toString());
      String orderNo = (data.get("orderNo") ?? '').toString();
      String orderStatus = (data.get("orderStatus") ?? '').toString();
      if (listData.isNotEmpty && orderNo.isNotEmpty && orderStatus.isNotEmpty) {
        for (int i = 0; i < listData.length; i++) {
          if (listData[i].orderNo == orderNo) {
            ///1.只有是在已经等待提前结算才改状态，2避免bus 的重复通知。
            if (listData[i].earlySettlementSuccessfulType == 1) {
              ///1提前结算成功，2提前结算失败
              if (orderStatus == '1') {
                String preSettleAmount =
                data.get("preSettleAmount")!.toString();
                listData[i].maxCashout = preSettleAmount;
                listData[i].earlySettlementBeingRequested = false;
                listData[i].earlySettlementSuccessfulType = 2;
                listData[i].earlySettlementState = 0;
                BetRecordController.to.update();
              } else if (orderStatus == '2') {
                listData[i].earlySettlementBeingRequested = false;
                listData[i].earlySettlementSuccessfulType = 3;
                int sportId = listData[i].detailList[0].sportId;

                ///如果失败了要重新开启预约提前结算和部分提前结算功能
                if ((sysBookedSettleSwitch && sportId == 1) ||
                    (sysPartSettleSwitch && sportId == 2)) {
                  listData[i].earlySettlementState = 1;
                }
                BetRecordController.to.update();
              }
            }
          }
        }
      }
    });
  }


  /**
   *获取提前结算数据
   */
  checkPollingData() {
    if (listData.isNotEmpty) {
      ///足球或者篮球开启提前结算，才去循环单关提起结算
      if (settleSwitch || settleSwitchBasket) {
        for (GetH5OrderListDataRecordxData element in listData) {
          int matchType = element.matchType ?? 0;

          ///当列表中有单关和串关，轮询请求提前结算接口。matchType:3 是冠军,只要不是冠军，就是单关和串关
          if (matchType != 3) {
            ///开始轮询提前结算接口
            setPollingIntervalRepeats();
            break;
          }
        }
      }
    }
  }

  ///轮询5秒提前结算
  setPollingIntervalRepeats() {
    getCashoutMaxAmountList();
    bet_timer?.cancel();
    bet_timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (state.orderType == 1 || state.orderType == 0 && listData.isNotEmpty) {
        getCashoutMaxAmountList();
      }
    });
  }

  setTurnOnEarlySettlement(int index) {
    ///正在提前结算中是不能，再发起提前结算的
    if (listData[index].earlySettlementBeingRequested) {
      return;
    }

    ///已经提前结算成功的，和已提前结算等待的，不能再次发起提起结算
    if (listData[index].earlySettlementSuccessfulType != 0) {
      return;
    }

    ///判断是否开始提前结算（点击1次，开启提前结算，点击2次才提前结算）
    if (!listData[index].turnOnEarlySettlement) {
      ///开启提前结算
      listData[index].turnOnEarlySettlement = true;
      BetRecordController.to.update();
    } else {
      ///请求提前结算
      orderPreSettle(index);
    }
  }

  setCancelSubmission(int index) {
    ///取消提前兑现
    listData[index].turnOnEarlySettlement = false;
    for (var element in maxAmountListData) {
      String orderNo = element.orderNo;

      ///判断是不是当前注单
      if (listData[index].orderNo == orderNo) {
        ///更新前结算金额（最新的金额）
        listData[index].maxCashout = element.preSettleMaxWin;
      }
    }
    BetRecordController.to.update();
  }


  orderPreSettle(int index) async {
    int deviceType = getDevice();
    String frontSettleAmount = "";
    String orderNo = listData[index].orderNo;
    double settleAmount = 0.00;

    /// 部分提前结算
    if (listData[index].earlySettlementState == 2 &&
        listData[index].earlySettlementType == 1) {
      ///提前兑现金额
      frontSettleAmount = BetsUtils.getExpectedProfit(listData[index]);
      ///提前兑现本金
      settleAmount = BetsUtils.cashoutStake(listData[index]);
      ///当部分提前兑现金额小于1元的时候不允许发起提前兑现请求
      double calibration = double.parse(frontSettleAmount);
      if (calibration < 1) {
        ///弹框提示最小单笔提前兑现金额不能小于1
        BetsUtils.toastDialog(
            LocaleKeys.app_minimum_settlement_amount.tr
                .replaceAll("{0}", "1" + TYUserController.to.currCurrency()),
            seconds: 2);
        return;
      }

    } else {
      ///全额提前结算
      frontSettleAmount = listData[index].maxCashout.toString();
      settleAmount = listData[index].preSettleBetAmount;
    }
    ///开始请求提前结算
    listData[index].earlySettlementBeingRequested = true;
    BetRecordController.to.update();

    final res = await service
        .orderPreSettle(deviceType, frontSettleAmount, orderNo, settleAmount);
    String code = res.code;
    listData[index].turnOnEarlySettlement = false;
    if (code == "0000000" || code == "200") {
      ///提前结算成功
      listData[index].earlySettlementBeingRequested = false;
      listData[index].earlySettlementSuccessfulType = 2;
      listData[index].earlySettlementState = 0;
    } else if (code == "0400524") {
      ///只有040052提前请求，等待处理，通过ws 来确定状态
      listData[index].earlySettlementSuccessfulType = 1;
      listData[index].earlySettlementState = 0;
    } else {
      ///提前结算，失败。
      listData[index].earlySettlementBeingRequested = false;
      listData[index].earlySettlementSuccessfulType = 3;

      if (res.msg.isNotEmpty) {
        ToastUtils.showGrayBackground(res.msg);
      }
    }
    BetRecordController.to.update();
  }


  setEarlyAppointmentSettlement(int index) {
    int type = listData[index].earlyAppointmentSettlementType.value;
    switch (type) {
      ///预约提前结算金额请求。
      case 0:
        saveReserveCashOut(index);
        break;

      ///1:取消预约提前结算，（点击一次后，变成确认取消）
      case 1:
        listData[index].earlyAppointmentSettlementType.value = 2;
        break;

      ///取消预约提前结算请求。
      case 2:
        cancelReserveCashoutOrder(index);
        break;
    }
  }


  cancelReserveCashoutOrder(int index) async {
    final res = await service
        .cancelReserveCashoutOrder(listData[index].orderNo);
    if (res.code == "0000000") {
      /// 预约提前结算按钮状态
      listData[index].earlyAppointmentSettlementType.value = 0;
    } else {
      ToastUtils.showGrayBackground(res.msg);
    }
  }


  saveReserveCashOut(int index) async {
    int deviceType = getDevice();
    String matchId = listData[index].detailList[0].matchId;
    String orderNo = listData[index].orderNo;
    int playId = listData[index].detailList[0].playId;
    String playOptionsId = listData[index].detailList[0].playOptionsId;
    double settleAmount = listData[index].orderAmountTotal;
    int sportId = listData[index].detailList[0].sportId;
    double reserveAmount = BetsUtils.getReserveAmount(listData[index]);
    final res = await service.saveReserveCashOut(deviceType, matchId,
        orderNo, playId, playOptionsId, reserveAmount, settleAmount, sportId);
    if (res.code == "0400555") {
      /// 预约提前结算金额，键盘输入金额
      listData[index].earlyAppointmentSettlementAmount.value = '';

      /// 预约提前结算,已经预约金额
      listData[index].reserveCashOutAmount.value = reserveAmount;

      /// 预约提前结算按钮状态
      listData[index].earlyAppointmentSettlementType.value = 1;
    } else {
      if (res.msg.isNotEmpty) {
        ToastUtils.showGrayBackground(res.msg);
      }
    }
  }

  setType(int index, int type) {
    if (listData.isNotEmpty) {
      listData[index].earlySettlementType = type;
      BetRecordController.to.update();
    }
  }


  setEarlySettlementState(int index, int state) {
    ///等0的时候是不开启切换预约提前结算和部分提前结算展示按钮的
    if (state == 0) {
      return;

      ///当第一次点击显示预约提前结算和部分提前结算展示按钮，要去获取，预约提前结算状态，部分提前结算不用
    } else if (state == 1 &&
        listData[index].earlySettlementType == 0 &&
        listData[index].earlyAppointmentSettlementType.value == 0) {
      ///获取
      getReserveCashoutList(index);
    }

    if (listData.isNotEmpty) {
      ///不等于1的时候设置未1，等于1的时候等于2
      listData[index].earlySettlementState = (state != 1 ? 1 : 2);
      BetRecordController.to.update();
    }
  }



  getReserveCashoutList(int index) async {
    final res =
        await service.getReserveCashoutList(listData[index].orderNo);
    if (res.code == "0000000") {
      if (res.data.isNotEmpty) {
        listData[index].earlyAppointmentSettlementType.value = 1;
        listData[index].reserveCashOutAmount.value =
            double.parse(res.data[0].reserveCashOutAmount);
      }
    }
  }


  setEarlyProportionSettleRatio(int index, double ratio) {
    listData[index].earlyProportionSettleRatio = ratio;
    BetRecordController.to.update();
  }

  /**
   *注单剩余本金 = 投注额 - 已提前结算金额
   */
  betRemainingAmount(int index) {
    double orderAmountTotal = listData[index].orderAmountTotal;
    double preBetAmount =
        double.tryParse(listData[index].preBetAmount.toString()) ?? 0;
    return subtract(orderAmountTotal, preBetAmount);
  }


  getExpectedProfit(int index) {
    // double percentage = awaitBetsLogic.cashoutStake(index) /
    //         int.tryParse(data.preSettleBetAmount) ?? 1;
    // 四舍五入至小数点第二位

    return ((double.tryParse(listData[index].maxCashout.toString()) ?? 1) *
            listData[index].earlyProportionSettleRatio)
        .toStringAsFixed(2);
  }

  ///vr图标
  List<String> getVrIcon(int sportId,String playOptions) {

    List<String> rankIcons = [];

    ///单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车
    if ([1009, 1010, 1011, 1002].contains(sportId) && playOptions.isNotEmpty) {
      List<String> result = playOptions.split('/');
      if (result.isNotEmpty) {
        for (int i = 0; i < result.length; i++) {
          rankIcons.add(VrRankIconUtils.getRankIcon(sportId, result[i],
              acceptNoValue: true));
        }
      }
    }
    return rankIcons;
  }


  ///提前结算折叠
  onPreSettleExpand(int index) async {
    bool preSettleExpand = listData[index].preSettleExpand.value;

    ///收起折叠
    if (preSettleExpand) {
      listData[index].preSettleExpand.value = false;

      ///打开折叠
    } else {
      GetPreSettleOrderDetailEntity res = await service
          .getPreSettleOrderDetail(listData[index].orderNo);
      if (res.code == "0000000") {
        if (res.data.isNotEmpty) {
          late List<GetPreSettleOrderDetailData> data = res.data;
          listData[index].preSettleExpand.value = true;
          listData[index].data = data;
        }
      }
    }
  }
}
