import 'dart:ui' as ui;
import 'dart:core';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/unsettled/unsettled_bets_state.dart';
import 'package:flutter_ty_app/app/services/models/res/get_pre_settle_order_detail_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../services/api/bet_api.dart';
import '../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/oss_util.dart';
import '../../../../../utils/utils.dart';
import '../../../../login/login_head_import.dart';
import '../../../../unsettled_bets/utils/betsUtils.dart';
import '../../../../unsettled_bets/widgets/slider/image_loader.dart';

class UnsettledBetsLogic extends GetxController {
  static UnsettledBetsLogic get to => Get.find();

  final UnsettledBetsState state = UnsettledBetsState();

  ui.Image? sliderBlockImage;

  @override
  void onInit() {
    ImageLoader.loader
        .loadImageByProvider(NetworkImage(
          OssUtil.getServerPath(
            Get.isDarkMode
                ? 'assets/images/bets/slider_icon_night.png'
                : 'assets/images/bets/slider_icon.png',
          ),
        ))
        .then((value) => sliderBlockImage = value);
    super.onInit();
  }

  ///  提前结算的轮训，赛事比分时间的轮训
  Timer? _timer, _matchLimitInfoByMidsTimer;

  ///赛事
  setChampionshipEventType(int type) {
    state.ChampionshipEventType = type;
    // openSelectTypeTime.value = (selectType.value == 5);
    ///切换时间清除旧数据
    state.listData.clear();
    state.matchInfoList.value = [];

    ///重制统计数据
    state.statistics = ['0', '0.00', '0.00'];

    if (_timer != null) {
      _timer?.cancel();
    }

    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {
      _matchLimitInfoByMidsTimer?.cancel();
    }
    if (state.selectType.value != 5) {
      state.loading = true;
      update();
      getH5OrderList();
    } else {
      state.loading = false;
      update();
      showTime(Get.context!, 5);
    }
  }

  ///时间选择器
  setSelectType(int type,
      {String temporaryStartTime = "", String temporaryEndTime = ""}) {
    ///防止多次点击
    if (type != 5 && type == state.selectType.value) {
      return;
    }
    if (type != 5) {
      state.startTimestamp = "";
      state.endTimestamp = "";
      state.startTime.value = "";
      state.endTime.value = "";
    } else {
      if (temporaryStartTime.isNotEmpty && temporaryEndTime.isNotEmpty) {
        ///开始时间
        state.startTime.value = temporaryStartTime;

        ///结束时间
        state.endTime.value = temporaryEndTime;
      }
    }
    state.selectType.value = type;
    state.openSelectTypeTime.value = false;

    ///切换时间清除旧数据
    state.listData.clear();
    state.matchInfoList.value = [];

    ///重制统计数据
    state.statistics = ['0', '0.00', '0.00'];
    state.loading = true;
    if (_timer != null) {
      _timer?.cancel();
    }

    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {
      _matchLimitInfoByMidsTimer?.cancel();
    }
    update();
    getH5OrderList();
  }

  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    //  lastSelectType = selectType.value;
    //  selectType.value = type;
    state.openSelectTypeTime.value = true;
    String temporaryStartTime = "";
    String temporaryEndTime = "";

    ///开始时间
    showTimeBottom.showModalBottom(
      context,
      onDateTimeChanged: (date) {
        ///开始时间
        temporaryStartTime = DateUtil.formatDateMs(
                date[0].millisecondsSinceEpoch,
                format: DateFormats.y_mo_d,)
            .toString();

        ///结束时间
        temporaryEndTime = DateUtil.formatDateMs(date[1].millisecondsSinceEpoch,
                format: DateFormats.y_mo_d,)
            .toString();

        state.startTimestamp = date[0].millisecondsSinceEpoch.toString();

        ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
        if (DateTime.now().difference(date[1]).inDays == 0) {
          state.endTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
        } else {
          state.endTimestamp = date[1].millisecondsSinceEpoch.toString();
        }
        setSelectType(type,
            temporaryStartTime: temporaryStartTime,
            temporaryEndTime: temporaryEndTime);
      },
      // cancel: (dynamic) {
      //   selectType.value = lastSelectType;
      // },
    );
  }

  @override
  void onReady() {
    super.onReady();

    ///获取用户提前结算开关状态
    getSwitchStatus();

    ///订阅ws
    orderPreSettleObserve();

    ///列表接口请求
    getH5OrderList();
  }

  ///获取用户提前结算开关状态
  getSwitchStatus() {
    state.settleSwitch = TYUserController.to.isSettleSwitch();
    state.settleSwitchBasket = TYUserController.to.isSettleSwitchBasket();
    state.sysBookedSettleSwitch = TYUserController.to.isSysBookedSettleSwitch();
    state.sysPartSettleSwitch = TYUserController.to.isSysPartSettleSwitch();
    state.bookedSettleSwitchFootball =
        TYUserController.to.isBookedSettleSwitchFootball();
    state.bookedSettleSwitchBasketball =
        TYUserController.to.isBookedSettleSwitchBasketball();

    ///产品要求，4260需求回退，暂时不上线，等待通知......
    // partSettleSwitchFootball = TYUserController.to.isPartSettleSwitchFootball();
    // partSettleSwitchBasketball = TYUserController.to.isPartSettleSwitchBasketball();
  }

  @override
  void onClose() {
    /// refreshController.dispose();
    ///提前结算接口轮询
    if (_timer != null) {
      _timer?.cancel();
    }

    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {
      _matchLimitInfoByMidsTimer?.cancel();
    }

    ///关闭注单ws订阅
    Bus.getInstance().off(EventType.orderPreSettle);
    super.onClose();
  }

  ///提前结算注单订阅
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
      if (state.listData.isNotEmpty &&
          orderNo.isNotEmpty &&
          orderStatus.isNotEmpty) {
        for (int i = 0; i < state.listData.length; i++) {
          if (state.listData[i].orderNo == orderNo) {
            ///1.只有是在已经等待提前结算才改状态，2避免bus 的重复通知。
            if (state.listData[i].earlySettlementSuccessfulType == 1) {
              ///1提前结算成功，2提前结算失败
              if (orderStatus == '1') {
                String preSettleAmount =
                    data.get("preSettleAmount")!.toString();
                state.listData[i].maxCashout = preSettleAmount;
                state.listData[i].earlySettlementBeingRequested = false;
                state.listData[i].earlySettlementSuccessfulType = 2;
                state.listData[i].earlySettlementState = 0;

                ///成功后重新拉取数据
                RePullData();
              } else if (orderStatus == '2') {
                state.listData[i].earlySettlementBeingRequested = false;
                state.listData[i].earlySettlementSuccessfulType = 3;
                int sportId = state.listData[i].detailList[0].sportId;

                ///如果失败了要重新开启预约提前结算和部分提前结算功能
                if ((state.sysBookedSettleSwitch && sportId == 1) ||
                    (state.sysPartSettleSwitch && sportId == 2)) {
                  state.listData[i].earlySettlementState = 1;
                }
                update();
              }
            }
          }
        }
      }
    });
  }

  ///成功后重新拉取数据
  RePullData() {
    ///关闭轮训接口
    if (_timer != null) {
      _timer?.cancel();
    }
    if (_matchLimitInfoByMidsTimer != null) {
      _matchLimitInfoByMidsTimer?.cancel();
    }
    update();

    ///提前兑现成功，重新3秒后拉取数据
    Future.delayed(Duration(seconds: 3), () {
      state.listData.clear();
      state.loading = true;
      update();
      getH5OrderList();
    });
  }

  ///请求列表数据
  Future<void> getH5OrderList() async {
    ///当使用时间选择的时候不能传timeType这个参数给后台
    final GetH5OrderListEntity res;
    if (state.selectType.value != 5) {
      if (state.selectType.value == 0) {
        res = await BetApi.instance().getH5OrderList('0', '',
            page: state.page,
            size: state.size,
            outright: state.ChampionshipEventType);
      } else {
        res = await BetApi.instance().getH5OrderList('0', '',
            timeType: state.selectType.value,
            page: state.page,
            size: state.size,
            outright: state.ChampionshipEventType);
      }
    } else {
      res = await BetApi.instance().getH5OrderList('0', '',
          beginTime: state.startTimestamp,
          endTime: state.endTimestamp,
          page: state.page,
          size: state.size,
          orderBy: state.orderBy,
          outright: state.ChampionshipEventType);
    }
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5OrderListData data = res.data;
      state.statistics[0] = data.total;
      state.statistics[1] = data.betTotalAmount;
      state.statistics[2] = data.maxWinTotalAmount;
      if (data.record != null && data.record!.isNotEmpty) {
        ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
        Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};
        List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
            record.entries.toList();
        Map<String, GetH5OrderListDataRecordx?> reversedMap =
            Map.fromEntries(entries);

        ///便利map，把数据全部房在一起。
        reversedMap.forEach((key, value) {
          state.listData.addAll(value!.data);
        });
      }
    }
    state.loading = false;
    update();
    if (state.listData.isNotEmpty) {
      ///足球或者篮球开启提前结算，才去循环单关提起结算
      if (state.settleSwitch || state.settleSwitchBasket) {
        for (GetH5OrderListDataRecordxData element in state.listData) {
          int matchType = element.matchType ?? 0;

          ///当列表中有单关和串关，轮询请求提前结算接口。matchType:3 是冠军,只要不是冠军，就是单关和串关
          if (matchType != 3) {
            ///开始轮询提前结算接口
            setPollingIntervalRepeats();
            break;
          }
        }
      }

      ///当列表中有单关，轮询比赛时间和比分接口。
      for (GetH5OrderListDataRecordxData element in state.listData) {
        int sportId = element.detailList[0].sportId;

        ///当列表中有足球和篮球
        if (sportId == 1 || sportId == 2) {
          String matchPeriodId = element.detailList[0].matchPeriodId;
          int matchOver = element.detailList[0].matchOver;

          ///当列表中有滚球的
          if (matchPeriodId != "0" &&
              matchPeriodId != "999" &&
              matchOver != 1) {
            String dataSourceCode = element.detailList[0].dataSourceCode;

            ///当不是电竞赛事
            if (!["C01", "RC", "O01", "OD", "B03", "BE"]
                .contains(dataSourceCode)) {
              ///开始轮询比赛时间和比分接口
              setMatchLimitInfoByMidsNew();
              break;
            }
          }
        }
      }
    }
  }

  ///轮询5秒提前结算
  setPollingIntervalRepeats() {
    getCashoutMaxAmountList();

    ///提前结算接口轮询
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      getCashoutMaxAmountList();
    });
  }

  ///轮询5秒比赛时间和玩法比分
  setMatchLimitInfoByMidsNew() {
    getMatchLimitInfoByMidsNew();

    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {
      _matchLimitInfoByMidsTimer?.cancel();
    }
    _matchLimitInfoByMidsTimer =
        Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      getMatchLimitInfoByMidsNew();
    });
  }

  ///提前结算请求
  getCashoutMaxAmountList() async {
    ///当页面不存在关闭定时器
    if (isClosed) {
      _timer?.cancel();
      _timer = null;
      return;
    }
    String orderNo = '';
    String splicing = '';

    ///拼接所有单号用 ，号拼接
    for (GetH5OrderListDataRecordxData element in state.listData) {
      ///当列表中有单关和串关，轮询请求提前结算接口。matchType:3 是冠军,只要不是冠军，就是单关和串关
      int matchType = element.matchType ?? 0;
      if (matchType != 3 && element.orderNo.isNotEmpty) {
        orderNo = orderNo + splicing + element.orderNo;
        splicing = ',';
      }
    }

    /// 网络超时情况 异常捕获
    try {
      final res = await BetApi.instance().getCashoutMaxAmountList(orderNo);

      ///判断code == "0000000"就是成功拿到数据
      if (res.code == "0000000") {
        ///当拿的最新数据就清除旧数据
        state.maxAmountListData.clear();
        state.maxAmountListData = res.data;
        if (state.maxAmountListData.isNotEmpty) {
          for (int i = 0; i < state.listData.length; i++) {
            ///更改单关和串关（matchType:3 是冠军,只要不是冠军，就是单关和串关）
            int matchType = state.listData[i].matchType ?? 0;
            if (matchType != 3) {
              ///提前结算总开关
              int sportId = state.listData[i].detailList[0].sportId;
              if ((!state.settleSwitch && sportId == 1) ||

                  ///当是足球，足球开关是关闭的时候
                  (!state.settleSwitchBasket && sportId == 2)) {
                ///当是篮球，篮球开关是关闭的时候
                continue;
              }

              ///当已经提前结算和，提前结算等待处理中是不更改状态的
              int earlySettlementSuccessfulType =
                  state.listData[i].earlySettlementSuccessfulType;
              if (earlySettlementSuccessfulType == 0 ||
                  earlySettlementSuccessfulType == 3) {
                ///预约结算和部分结算开关
                if (state.sysBookedSettleSwitch || state.sysPartSettleSwitch) {
                  ///如果已经是显示，并且是展开的状态是不需要处理的
                  if (state.listData[i].earlySettlementState == 0) {
                    state.listData[i].earlySettlementState = 1;
                  }
                } else {
                  state.listData[i].earlySettlementState = 0;
                }

                ///预约提前结算开关-足球-篮球-开关
                if ((state.sysBookedSettleSwitch &&
                        state.bookedSettleSwitchFootball &&
                        sportId == 1) ||
                    (state.sysBookedSettleSwitch &&
                        state.bookedSettleSwitchBasketball &&
                        sportId == 2)) {
                  state.listData[i].bookedSettleSwitch = true;
                }

                /// 部分提前结算开关-足球-篮球-开关
                if ((state.sysPartSettleSwitch &&
                        state.partSettleSwitchFootball &&
                        sportId == 1) ||
                    (state.sysPartSettleSwitch &&
                        state.partSettleSwitchBasketball &&
                        sportId == 2)) {
                  state.listData[i].partSettleSwitch = true;
                }
                bool bookedSettleSwitch = state.listData[i].bookedSettleSwitch;
                bool partSettleSwitch = state.listData[i].partSettleSwitch;

                ///当预约提前结算和部分提前结算开关关闭
                if (!bookedSettleSwitch && !partSettleSwitch) {
                  state.listData[i].earlySettlementState = 0;
                  state.listData[i].earlySettlementType = 2;

                  ///当只有部分提前结算，没有预约提前结算的时候
                } else if (!bookedSettleSwitch && partSettleSwitch) {
                  state.listData[i].earlySettlementType = 1;
                }

                ///重新回到没有提前结算状态
                state.listData[i].earlySettlementSuccessfulType = 0;

                ///预约提前结算如果点击了一次，轮询接口回来就要回到没点击的状态
                if (state.listData[i].earlyAppointmentSettlementType.value ==
                    2) {
                  state.listData[i].earlyAppointmentSettlementType.value = 1;
                }

                ///不是准备发起 ，和不是正在发起提起结算请求，才能改状态
                if (!state.listData[i].turnOnEarlySettlement &&
                    !state.listData[i].earlySettlementBeingRequested) {
                  /// 提前结算功能页面页全部关闭
                  //  listData[i].turnOnEarlySettlement = false;
                  state.listData[i].exhibitEarlySettlement = false;
                  for (var element in state.maxAmountListData) {
                    String orderNo = element.orderNo;

                    ///轮询回来的单号，开启提前结算界面
                    if (state.listData[i].orderNo == orderNo) {
                      state.listData[i].exhibitEarlySettlement = true;

                      ///轮询回来的数据，每次轮询请求回来，都要更改提前结算金额
                      state.listData[i].maxCashout = element.preSettleMaxWin;
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        for (int i = 0; i < state.listData.length; i++) {
          ///更改单关和串关（matchType:3 是冠军,只要不是冠军，就是单关和串关）
          int matchType = state.listData[i].matchType ?? 0;
          if (matchType != 3) {
            ///已结提前结算成功了，就不能改状态。
            int earlySettlementSuccessfulType =
                state.listData[i].earlySettlementSuccessfulType;
            if (earlySettlementSuccessfulType == 0 ||
                earlySettlementSuccessfulType == 3) {
              ///如果轮询回来没有单号，所有提前结算（所有）界面都关闭
              state.listData[i].exhibitEarlySettlement = false;

              /// 提前结算功能全部关闭
              state.listData[i].turnOnEarlySettlement = false;

              ///重新回到没有提前结算状态
              state.listData[i].earlySettlementSuccessfulType = 0;

              ///关闭预约提前结算和部分提前结算
              state.listData[i].earlySettlementState = 0;
            }
          }
        }
      }
      update();
    } catch (e) {
      AppLogger.debug("getCashoutMaxAmountList error:$e");
    }
  }

  ///比赛时间和玩法比分请求
  getMatchLimitInfoByMidsNew() async {
    ///当页面不存在关闭定时器
    if (isClosed) {
      _matchLimitInfoByMidsTimer?.cancel();
      _matchLimitInfoByMidsTimer = null;
      return;
    }
    List<Map> result = [];
    Map<String, Set<String>> midToPidsMap = {};

    for (GetH5OrderListDataRecordxData element in state.listData) {
      if (element.detailList.isNotEmpty) {
        for (GetH5OrderListDataRecordxDataDetailList item
            in element.detailList) {
          String mid = item.matchId;
          String pids = item.playId.toString();

          /// 如果 mid 已存在，则添加 pids
          if (midToPidsMap.containsKey(mid)) {
            midToPidsMap[mid]!.add(pids);
          } else {
            /// 如果 mid 不存在，则创建新条目
            midToPidsMap[mid] = {pids}; // 使用 Set 来存储 pids
          }
        }
      }
    }

    /// 将 midToPidsMap 转换为 List<Map>
    if (midToPidsMap.isNotEmpty) {
      midToPidsMap.forEach((mid, pidsSet) {
        result.add({
          "mid": mid.toString(),

          /// 将 Set 转换为字符串，使用 ", " 分隔
          "pids": pidsSet.join(",").toString()
        });
      });
    }

    if (result.isNotEmpty) {
      final res = await BetApi.instance().getMatchLimitInfoByMidsNew(result);

      ///判断code == "0000000"就是成功拿到数据
      if (res.code == "0000000" && ObjectUtil.isNotEmpty(res.data)) {
        state.matchInfoList.value = res.data.data;
      } else if (res.code == "0401038") {
        /// 限频 直接过滤
      } else {
        state.matchInfoList.value = [];
      }
    }
  }

  ///开启提前结算功能
  setTurnOnEarlySettlement(int index) {
    ///正在提前结算中是不能，再发起提前结算的
    if (state.listData[index].earlySettlementBeingRequested) {
      return;
    }

    ///已经提前结算成功的，和已提前结算等待的，不能再次发起提起结算
    if (state.listData[index].earlySettlementSuccessfulType != 0) {
      return;
    }

    ///判断是否开始提前结算（点击1次，开启提前结算，点击2次才提前结算）
    if (!state.listData[index].turnOnEarlySettlement) {
      ///开启提前结算
      state.listData[index].turnOnEarlySettlement = true;
      update();
    } else {
      ///请求提前结算
      orderPreSettle(index);
    }
  }

  ///取消准备提交的提前结算功能
  setCancelSubmission(int index) {
    ///取消提前兑现
    state.listData[index].turnOnEarlySettlement = false;
    for (var element in state.maxAmountListData) {
      String orderNo = element.orderNo;

      ///判断是不是当前注单
      if (state.listData[index].orderNo == orderNo) {
        ///更新前结算金额（最新的金额）
        state.listData[index].maxCashout = element.preSettleMaxWin;
      }
    }
    update();
  }

  ///请求提前结算
  orderPreSettle(int index) async {
    int deviceType = getDevice();
    String frontSettleAmount = "";
    String orderNo = state.listData[index].orderNo;
    double settleAmount = 0.00;

    /// 部分提前结算
    if (state.listData[index].earlySettlementState == 2 &&
        state.listData[index].earlySettlementType == 1) {
      ///提前兑现金额
      frontSettleAmount = BetsUtils.getExpectedProfit(state.listData[index]);

      ///提前兑现本金
      settleAmount = BetsUtils.cashoutStake(state.listData[index]);

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
      frontSettleAmount = state.listData[index].maxCashout.toString();
      settleAmount = state.listData[index].preSettleBetAmount;
    }

    ///开始请求提前结算
    state.listData[index].earlySettlementBeingRequested = true;
    update();

    final res = await BetApi.instance()
        .orderPreSettle(deviceType, frontSettleAmount, orderNo, settleAmount);
    String code = res.code;
    state.listData[index].turnOnEarlySettlement = false;
    if (res.code == "0000000" || res.code == "200") {
      ///提前结算成功
      state.listData[index].earlySettlementBeingRequested = false;
      state.listData[index].earlySettlementSuccessfulType = 2;
      state.listData[index].earlySettlementState = 0;
    } else if (code == "0400524") {
      ///只有040052提前请求，等待处理，通过ws 来确定状态
      state.listData[index].earlySettlementSuccessfulType = 1;
      state.listData[index].earlySettlementState = 0;
    } else {
      ///提前结算，失败。
      state.listData[index].earlySettlementBeingRequested = false;
      state.listData[index].earlySettlementSuccessfulType = 3;
      if (res.msg.isNotEmpty) {
        BetsUtils.toastDialog(res.msg);
      }
    }
    update();
  }

  ///预约提前结算
  setEarlyAppointmentSettlement(int index) {
    int type = state.listData[index].earlyAppointmentSettlementType.value;
    switch (type) {
      ///预约提前结算金额请求。
      case 0:
        saveReserveCashOut(index);
        break;

      ///1:取消预约提前结算，（点击一次后，变成确认取消）
      case 1:
        state.listData[index].earlyAppointmentSettlementType.value = 2;
        break;

      ///取消预约提前结算请求。
      case 2:
        cancelReserveCashoutOrder(index);
        break;
    }
  }

  ///取消预约提前结算请求。
  cancelReserveCashoutOrder(int index) async {
    final res = await BetApi.instance()
        .cancelReserveCashoutOrder(state.listData[index].orderNo);
    if (res.code == "0000000") {
      /// 预约提前结算按钮状态
      state.listData[index].earlyAppointmentSettlementType.value = 0;
    } else {
      BetsUtils.toastDialog(res.msg);
      //  ToastUtils.showGrayBackground(res.msg);
    }
  }

  ///预约提前结算金额请求。
  saveReserveCashOut(int index) async {
    int deviceType = getDevice();
    String matchId = state.listData[index].detailList[0].matchId;
    String orderNo = state.listData[index].orderNo;
    int playId = state.listData[index].detailList[0].playId;
    String playOptionsId = state.listData[index].detailList[0].playOptionsId;
    double settleAmount = state.listData[index].orderAmountTotal;
    int sportId = state.listData[index].detailList[0].sportId;
    double reserveAmount = BetsUtils.getReserveAmount(state.listData[index]);
    final res = await BetApi.instance().saveReserveCashOut(deviceType, matchId,
        orderNo, playId, playOptionsId, reserveAmount, settleAmount, sportId);
    if (res.code == "0400555") {
      /// 预约提前结算金额，键盘输入金额
      state.listData[index].earlyAppointmentSettlementAmount.value = '';

      /// 预约提前结算,已经预约金额
      state.listData[index].reserveCashOutAmount.value = reserveAmount;

      /// 预约提前结算按钮状态
      state.listData[index].earlyAppointmentSettlementType.value = 1;
    } else {
      if (res.msg.isNotEmpty) {
        BetsUtils.toastDialog(res.msg);
        // ToastUtils.showGrayBackground(res.msg);
      }
    }
  }

  ///切换预约提前结算和部分提前结算
  setType(int index, int type) {
    if (state.listData.isNotEmpty) {
      state.listData[index].earlySettlementType = type;
      update();
    }
  }

  ///切换预约提前结算和部分提前结算展示按钮
  setEarlySettlementState(int index, int states) {
    ///等0的时候是不开启切换预约提前结算和部分提前结算展示按钮的
    if (states == 0) {
      return;

      ///当第一次点击显示预约提前结算和部分提前结算展示按钮，要去获取，预约提前结算状态，部分提前结算不用
    } else if (states == 1 &&
        state.listData[index].earlySettlementType == 0 &&
        state.listData[index].earlyAppointmentSettlementType.value == 0) {
      ///获取
      getReserveCashoutList(index);
    }

    if (state.listData.isNotEmpty) {
      ///不等于1的时候设置未1，等于1的时候等于2
      state.listData[index].earlySettlementState = (states != 1 ? 1 : 2);
      update();
    }
  }

  ///展示提前结算，金额界面
  getReserveCashoutList(int index) async {
    final res = await BetApi.instance()
        .getReserveCashoutList(state.listData[index].orderNo);
    if (res.code == "0000000") {
      if (res.data.isNotEmpty) {
        state.listData[index].earlyAppointmentSettlementType.value = 1;
        state.listData[index].reserveCashOutAmount.value =
            double.parse(res.data[0].reserveCashOutAmount);
      }
    }
  }

  ///串关折叠
  onTextExpand(int index) {
    state.listData[index].isExpand.value =
        !state.listData[index].isExpand.value;
  }

  /// 部分提前结算滑块设置比例
  setEarlyProportionSettleRatio(int index, double ratio) {
    state.listData[index].earlyProportionSettleRatio = ratio;
    update();
  }

  ///提前结算折叠
  onPreSettleExpand(int index) async {
    bool preSettleExpand = state.listData[index].preSettleExpand.value;

    ///收起折叠
    if (preSettleExpand) {
      state.listData[index].preSettleExpand.value = false;

      ///打开折叠
    } else {
      GetPreSettleOrderDetailEntity res = await BetApi.instance()
          .getPreSettleOrderDetail(state.listData[index].orderNo);
      if (res.code == "0000000") {
        if (res.data.isNotEmpty) {
          late List<GetPreSettleOrderDetailData> data = res.data;
          state.listData[index].preSettleExpand.value = true;
          state.listData[index].data = data;
        }
      }
    }
  }
}
