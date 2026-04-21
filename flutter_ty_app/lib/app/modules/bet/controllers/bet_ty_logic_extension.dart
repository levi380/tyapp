import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/app_logger/app_logger.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../home/models/refresh_status.dart' as HomeRefreshStatus;
import 'bet_record_controller.dart';
import 'bet_ty_logic.dart';

extension BetTyLogicEx on BetTyLogic{
  Future<void> fetchData() async {
    listData = [];
    refreshController.resetNoData();
    GetH5OrderListEntity res;
    try {
      if (state.timeType != 5) {
        res = await service.getH5OrderList('0', '',
            timeType: state.timeType,
            beginTime: state.startTime,
            endTime: state.endTime,
            page: state.page,
            size: state.size);
      } else {
        res = await service.getH5OrderList('0', '',
            beginTime: state.startTime,
            endTime: state.endTime,
            page: state.page,
            size: state.size);
      }
      String code = res.code;
      if (code == "0000000") {
        GetH5OrderListData data = res.data;
        if (data.record != null) {
          ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
          Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};
          List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
          record.entries.toList();
          Map<String, GetH5OrderListDataRecordx?> reversedMap =
          Map.fromEntries(entries);

          ///便利map，把数据全部房在一起。
          reversedMap.forEach((key, value) {
            listData.addAll(value!.data);
          });
        }
        state.refreshStatus = listData.isEmpty
            ? HomeRefreshStatus.RefreshStatus.loadNoData
            : HomeRefreshStatus.RefreshStatus.loadSuccess;

        ///当列表中有单关，轮询请求提前结算接口。
        checkPollingData();
      } else {
        state.errorMsg = res.msg;
        state.refreshStatus = HomeRefreshStatus.RefreshStatus.loadFailed;
      }
    } catch (e) {
      AppLogger.debug('fetchData error: $e');
      listData = [];
      state.errorMsg = LocaleKeys.common_no_network.tr;
      state.refreshStatus = HomeRefreshStatus.RefreshStatus.loadFailed;
    }
    BetRecordController.to.update();
  }

  onLoadMore() async {
    if (listData.isEmpty) {
      refreshController.loadComplete();
      return;
    }
    String searchAfter = listData.last.modifyTimeStr;

    ///传参，目前没有选择，些死，加入选着日期就动态改
    final GetH5OrderListEntity res;
    if (state.timeType != 5) {
      res = await service.getH5OrderList('0', searchAfter,
          timeType: state.timeType,
          beginTime: state.startTime,
          endTime: state.endTime,
          page: state.page,
          size: state.size);
    } else {
      res = await service.getH5OrderList('0', searchAfter,
          beginTime: state.startTime,
          endTime: state.endTime,
          page: state.page,
          size: state.size);
    }

    ///判断code == "0000000"就是成功拿到数据
    String code = res.code;
    if (code == "0000000") {
      GetH5OrderListData data = res.data;
      if (data.record != null) {
        ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
        Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};
        List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
        record.entries.toList();
        Map<String, GetH5OrderListDataRecordx?> reversedMap =
        Map.fromEntries(entries);

        ///便利map，把数据全部房在一起。
        reversedMap.forEach((key, value) {
          listData.addAll(value!.data);
        });
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } else {
      refreshController.loadComplete();
    }
    BetRecordController.to.update();
  }

  getCashoutMaxAmountList() async {
    ///当页面不存在关闭定时器
    if (isClosed) {
      bet_timer?.cancel();
      bet_timer = null;
      return;
    }

    String orderNo = '';
    String splicing = '';

    ///拼接所有单号用 ，号拼接
    //for (GetH5OrderListDataRecordxData element in listData) {
    for(int i=0;i<listData.length;i++){
      //数据太长拉getCashoutMaxAmountList接口会报错
      if(i>=400) break;

      GetH5OrderListDataRecordxData element = listData[i];
      int matchType = element.matchType ?? 0;

      ///当列表中有单关和串关，轮询请求提前结算接口。matchType:3 是冠军,只要不是冠军，就是单关和串关
      if (matchType != 3) {
        ///开始轮询提前结算接口
        orderNo = orderNo + splicing + element.orderNo;
        splicing = ',';
      }
    }

    /// 网络超时情况 异常捕获
    try {
      final res = await service.getCashoutMaxAmountList(orderNo);

      ///判断code == "0000000"就是成功拿到数据
      if (res.code == "0000000") {
        maxAmountListData.clear();
        maxAmountListData = res.data;
        if (maxAmountListData.isNotEmpty) {
          for (int i = 0; i < listData.length; i++) {
            ///更改单关和串关（matchType:3 是冠军,只要不是冠军，就是单关和串关）
            int matchType = listData[i].matchType ?? 0;
            if (matchType != 3) {
              ///提前结算总开关
              int sportId = listData[i].detailList[0].sportId;
              if ((!settleSwitch && sportId == 1) ||

                  ///当是足球，足球开关是关闭的时候
                  (!settleSwitchBasket && sportId == 2)) {
                ///当是篮球，篮球开关是关闭的时候
                continue;
              }

              ///当已经提前结算和，提前结算等待处理中是不更改状态的
              int earlySettlementSuccessfulType =
                  listData[i].earlySettlementSuccessfulType;
              if (earlySettlementSuccessfulType == 0 ||
                  earlySettlementSuccessfulType == 3) {
                ///预约结算和部分结算开关
                if (sysBookedSettleSwitch || sysPartSettleSwitch) {
                  ///如果已经是显示，并且是展开的状态是不需要处理的
                  if (listData[i].earlySettlementState == 0) {
                    listData[i].earlySettlementState = 1;
                  }
                } else {
                  listData[i].earlySettlementState = 0;
                }

                ///预约提前结算开关-足球-篮球-开关
                if ((sysBookedSettleSwitch &&
                    bookedSettleSwitchFootball &&
                    sportId == 1) ||
                    (sysBookedSettleSwitch &&
                        bookedSettleSwitchBasketball &&
                        sportId == 2)) {
                  listData[i].bookedSettleSwitch = true;
                }

                /// 部分提前结算开关-足球-篮球-开关
                if ((sysPartSettleSwitch &&
                    partSettleSwitchFootball &&
                    sportId == 1) ||
                    (sysPartSettleSwitch &&
                        partSettleSwitchBasketball &&
                        sportId == 2)) {
                  listData[i].partSettleSwitch = true;
                }
                bool bookedSettleSwitch = listData[i].bookedSettleSwitch;
                bool partSettleSwitch = listData[i].partSettleSwitch;

                ///当预约提前结算和部分提前结算开关关闭
                if (!bookedSettleSwitch && !partSettleSwitch) {
                  listData[i].earlySettlementState = 0;
                  listData[i].earlySettlementType = 2;

                  ///当只有部分提前结算，没有预约提前结算的时候
                } else if (!bookedSettleSwitch && partSettleSwitch) {
                  listData[i].earlySettlementType = 1;
                }

                ///重新回到没有提前结算状态
                listData[i].earlySettlementSuccessfulType = 0;

                ///预约提前结算如果点击了一次，轮询接口回来就要回到没点击的状态
                if (listData[i].earlyAppointmentSettlementType.value == 2) {
                  listData[i].earlyAppointmentSettlementType.value = 1;
                }

                ///不是准备发起 ，和不是正在发起提起结算请求，才能改状态
                if (!listData[i].turnOnEarlySettlement &&
                    !listData[i].earlySettlementBeingRequested) {
                  /// 提前结算功能页面页全部关闭
                  //  listData[i].turnOnEarlySettlement = false;
                  listData[i].exhibitEarlySettlement = false;
                  for (var element in maxAmountListData) {
                    String orderNo = element.orderNo;

                    ///轮询回来的单号，开启提前结算界面
                    if (listData[i].orderNo == orderNo) {
                      listData[i].exhibitEarlySettlement = true;

                      ///轮询回来的数据，每次轮询请求回来，都要更改提前结算金额
                      listData[i].maxCashout = element.preSettleMaxWin;
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        for (int i = 0; i < listData.length; i++) {
          ///更改单关和串关（matchType:3 是冠军,只要不是冠军，就是单关和串关）
          int matchType = listData[i].matchType ?? 0;
          if (matchType != 3) {
            ///已结提前结算成功了，就不能改状态。
            int earlySettlementSuccessfulType =
                listData[i].earlySettlementSuccessfulType;
            if (earlySettlementSuccessfulType == 0 ||
                earlySettlementSuccessfulType == 3) {
              ///如果轮询回来没有单号，所有提前结算（所有）界面都关闭
              listData[i].exhibitEarlySettlement = false;

              /// 提前结算功能全部关闭
              listData[i].turnOnEarlySettlement = false;

              ///重新回到没有提前结算状态
              listData[i].earlySettlementSuccessfulType = 0;

              ///关闭预约提前结算和部分提前结算
              listData[i].earlySettlementState = 0;
            }
          }
        }
      }
      BetRecordController.to.update();
    } catch (e) {
      AppLogger.debug("getCashoutMaxAmountList error:$e");
    }
  }

}