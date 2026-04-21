import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../services/models/res/query_market_max_min_pre_bet_money_entity.dart';
import '../../../utils/utils.dart';
import '../../login/login_head_import.dart';
import '../dialog/rule_statement_dialog/cancel_appointment_dialog.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';

import '../utils/betsUtils.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(预约中)控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能管理预约投注页面的状态和数据，包括时间选择、数据请求、赔率修改等功能。
    - 注单预约中-注单单号，注单时间，注单详情，注单投注额，注单预约中状态
    - 注单预约中-单关
    - 注单预约中-全部，今日，昨日，一周，自定义
    - 注单预约中-修改赔率和金额（修改预约中金额和赔率，以及取消注单）
    - `listData`：存储预约投注的数据列表。
    - `scrollController`：控制滚动视图的行为。
    - `loading`：指示当前是否在加载数据。
    - `refreshController`：用于控制下拉刷新和上拉加载。
    - `startTime` 和 `endTime`：用于展示选择的时间。
    - `startTimestamp` 和 `endTimestamp`：用于网络请求的时间戳。
    - `selectType`：当前选择的时间类型（全部、今日、昨日等）。
    - `openSelectTypeTime`：指示是否开启自定义时间选择。
    - `lastSelectType`：记录上一次选择的时间类型。
    - `page`：用于翻页请求的数据页码。
    - `size`：请求数据的条数。
    - setSelectType()设置时间类型，清除旧数据，并请求数据。
    - showTime()显示自定义时间选择器，更新开始和结束时间。
    - getH5PreBetOrderlist()请求预约投注列表，根据选择的时间类型发送不同的请求。
    - onLoadMore()加载更多数据，处理分页请求。
    -setModifyOdds()`int index`，`int type`：注单索引和操作类型 修改赔率，支持增加、减少、取消等操作。
    - upDatePreBetOdds()`String marketType`，`int odds`，`String orderNo`，`int orderAmountTotal`，`int index`发起修改赔率的请求。
    - cancelPreBetOrder()取消预约投注。
    - queryBetAmount()查询最大和最小投注金额。
    】】】
 *
 */
class BookinBetsLogic extends GetxController {
  List<GetH5PreBetOrderlistDataRecordxData> listData = [];
  ScrollController scrollController = ScrollController();

  //加载展示
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// UI界面展示使用
  var startTime = "".obs;

  /// UI界面展示使用
  var endTime = "".obs;

  ///默认获取当天零点时间戳(网络请求使用)
  var startTimestamp = "";

  ///默认获取当前时间戳(网络请求使用)
  var endTimestamp = "";

  /// 0:全部 1:今日 2:昨日 3:近7日 4:近30日,5:自定义(自己定义的不传5，传起始时间戳和结束时间)
  var selectType = 0.obs;

  ///开启自定义时间
  var openSelectTypeTime = false.obs;

  ///记录上一次的（0:全部 1:今日 2:昨日 3:近7日）
  // var lastSelectType = -1;

  ///网络请求翻页
  var page = 1;

  ///未结算注单统计
  var statistics_1 = '0'.obs;
  var statistics_2 = '0.00'.obs;
  var statistics_3 = '0.00'.obs;

  ///请求数据条数
  final int size = 300;

  ///开启提示
  var isOpenTips = false.obs;

  ///提示倒计时关闭
  Timer? _timer;

  setIsOpenTips() {
    ///防止多次点击
    if (isOpenTips.value) {
      return;
    }
    isOpenTips.value = true;
    // 启动定时器
    _timer = Timer(Duration(seconds: 3), () {
      isOpenTips.value = false;
      _timer?.cancel();
    });
  }

  setSelectType(int type) {
    ///防止多次点击
    if (type != 5 && type == selectType.value) {
      return;
    }
    if (type != 5) {
      startTimestamp = "";
      endTimestamp = "";
      startTime.value = "";
      endTime.value = "";
    }
    selectType.value = type;
    openSelectTypeTime.value = false;

    ///切换时间清除就数据
    listData.clear();

    ///重制统计数据
    statistics_1.value = '0';
    statistics_2.value = '0.00';
    statistics_3.value = '0.00';
    loading = true;
    // refreshController.refreshCompleted(resetFooterState: true);
    update();
    getH5PreBetOrderlist();
  }

  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    // lastSelectType = selectType.value;
    selectType.value = type;
    openSelectTypeTime.value = true;

    showTimeBottom.showModalBottom(
      context,
      onDateTimeChanged: (date) {
        ///开始时间
        startTime.value = DateUtil.formatDateMs(date[0].millisecondsSinceEpoch,
                format: DateFormats.y_mo_d, )
            .toString();
        startTimestamp = date[0].millisecondsSinceEpoch.toString();

        ///结束时间
        endTime.value = DateUtil.formatDateMs(date[1].millisecondsSinceEpoch,
                format: DateFormats.y_mo_d,)
            .toString();

        ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
        if (DateTime.now().difference(date[1]).inDays == 0) {
          endTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
        } else {
          endTimestamp = date[1].millisecondsSinceEpoch.toString();
        }
        setSelectType(type);
      },
      // cancel: (dynamic) {
      //   selectType.value = lastSelectType;
      // },
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getH5PreBetOrderlist();
  }

  @override
  void onClose() {
    _timer?.cancel();
    refreshController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  ///请求列表数据
  Future<void> getH5PreBetOrderlist({int indexs = -1}) async {
    GetH5PreBetOrderlistEntity res;

    ///当使用时间选择的时候不能传timeType这个参数给后台
    if (selectType.value != 5) {
      ///预投注订单状态(0预约中 ;1预约成功;2.风控预约失败;3.风控取消预约注单.4.用户手动取消预约投注) 比如 [0,1,2,3]
      if (selectType.value == 0) {
        res = await BetApi.instance()
            .getH5PreBetOrderlist([0], '', size: size, page: page);
      } else {
        res = await BetApi.instance().getH5PreBetOrderlist([0], '',
            size: size, page: page, timeType: selectType.value);
      }
    } else {
      res = await BetApi.instance().getH5PreBetOrderlist([0], '',
          size: size,
          page: page,
          beginTime: startTimestamp,
          endTime: endTimestamp);
    }
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      if (indexs == -1) {
        listData.clear();
      }
      GetH5PreBetOrderlistData data = res.data;
      statistics_1.value = data.total;
      statistics_2.value = data.betTotalAmount;
      statistics_3.value = data.maxWinTotalAmount;

      if (data.record != null && data.record!.isNotEmpty) {
        ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
        late Map<String, GetH5PreBetOrderlistDataRecordx?> record =
            data.record ?? {};
        List<MapEntry<String, GetH5PreBetOrderlistDataRecordx?>> entries =
            record.entries.toList();
        Map<String, GetH5PreBetOrderlistDataRecordx?> reversedMap =
            Map.fromEntries(entries);

        ///一般情况下都清除数据，只有更改金额和赔率的情况下不去清除数据(只替换数据)
        if (indexs == -1) {
          reversedMap.forEach((key, value) {
            listData.addAll(value!.data);
          });
        } else {
          var listDataChange = listData[indexs];
          reversedMap.forEach((key, value) {
            var latestData = value!.data;
            if (latestData.isNotEmpty) {
              for (GetH5PreBetOrderlistDataRecordxData element in latestData) {
                if (listDataChange.orderNo == element.orderNo) {
                  ///更改修改预约金额的数据
                  listDataChange.detailList[0].oddFinally =
                      element.detailList[0].oddFinally;
                  listDataChange.modifyTimeStr = element.modifyTimeStr;
                  listDataChange.modifyTime = element.modifyTime;
                  listDataChange.orderAmountTotal = element.orderAmountTotal;
                  listDataChange.maxWinAmount = element.maxWinAmount;
                  listDataChange.detailList[0].modifyBetAmount.value = '';
                  listDataChange.canBeModified = false;
                  listDataChange.isOnKeyboard.value = true;
                  break;
                }
              }
            }
          });
          setKeyboardFolding(false, indexs);
        }
      }
    }
    loading = false;
    update();
  }

  ///修改赔率
  ///index 是你哪个一条
  ///type 0:减赔率，1:加赔率，2: 取消预约（走取消赔率接口），3：修改，4: 取消，5：确认(走更改赔率接口)
  setModifyOdds(int index, int type) {
    switch (type) {
      ///减赔率
      case 0:
        listData[index].detailList[0].oddFinallyChange.value =
            BetsUtils.setMinusOdds(
                listData[index].detailList[0].oddFinallyChange.value);
        break;

      ///加赔率
      case 1:
        listData[index].detailList[0].oddFinallyChange.value =
            BetsUtils.setIncreaseOdds(
                listData[index].detailList[0].oddFinallyChange.value);
        break;

      ///取消预约赔率
      case 2:
        Get.dialog(
          CancelAppointmentDialogPage(
            index: index,
          ),
          barrierColor: Colors.black.withValues(alpha: 0.8),
        );
        break;

      ///修改赔率
      case 3:
        listData[index].canBeModified = true;
        listData[index].isOnKeyboard.value = true;
        String orderAmountTotal =
            setAmount(listData[index].orderAmountTotal.toString());

        ///去除金额后面的.00
        if (orderAmountTotal.contains('.')) {
          String split = orderAmountTotal.split('.')[1];
          if (split == '00') {
            orderAmountTotal = orderAmountTotal.split('.')[0];
          }
        }

        ///开启修改赔率默认成预约的赔率
        listData[index].detailList[0].modifyBetAmount.value = orderAmountTotal;
        setKeyboardFolding(true, index);
        update();
        queryBetAmount(listData[index]);
        break;

      ///取消
      case 4:
        listData[index].canBeModified = false;
        listData[index].isChangeAmount.value = false;
        listData[index].isChangeOdds.value = false;
        setKeyboardFolding(false, index);
        update();
        break;

      ///确认修改赔率
      case 5:

        ///组合参数开始发，筛选参数，不正确的拦截掉，正确的发起请求
        setBeforeUpDatePreBetOdds(index);
        break;
    }
  }

  setBeforeUpDatePreBetOdds(int index) {
    ///当修改金额小于限额最小额度，修改金额变成最小额度
    var detailList = listData[index].detailList[0];
    var modifyBetAmount = detailList.modifyBetAmount.value;

    ///拦截金额框或是空，没数据不去请求。
    if (modifyBetAmount.isEmpty ||
        ['0', '0.0', '0.00'].contains(modifyBetAmount)) {
      BetsUtils.toastDialog(LocaleKeys.bet_err_msg04.tr);
      // ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg04.tr);
      return;
    }

    ///拦截金额框或者赔率框是空，没数据不去请求。
    if (detailList.oddFinallyChange.value.isEmpty) {
      BetsUtils.toastDialog(LocaleKeys.app_please_enter_the_odds.tr);
      // ToastUtils.showGrayBackground(LocaleKeys.app_please_enter_the_odds.tr);
      return;
    }

    ///拦截赔率框是0，没数据不去请求。
    if (['0', '0.0', '0.00'].contains(detailList.oddFinallyChange.value)) {
      BetsUtils.toastDialog(LocaleKeys.app_please_confirm_odds.tr);
      // ToastUtils.showGrayBackground(LocaleKeys.app_please_confirm_odds.tr);
      return;
    }

    ///预约投注金额小于最低限额的最低额度，金额强制改成最低限额
    double parse = double.parse(modifyBetAmount);
    double orderLeastPay = double.parse(detailList.orderLeastPay.value);
    if (parse < orderLeastPay) {
      String orderLeastPay = detailList.orderLeastPay.value;
      detailList.modifyBetAmount.value = orderLeastPay;
      listData[index].isChangeAmount.value = true;
      var toast = LocaleKeys.app_minimum_amount_of_bet.tr
          .replaceAll('{0}', orderLeastPay);
      BetsUtils.toastDialog(toast);
      // ToastUtils.showGrayBackground(toast);
      return;
    }

    ///预约投注额（要乘以100，单位是分）
    var orderAmountTotal =
        (double.parse(detailList.modifyBetAmount.value) * 100).toInt();

    ///赔率如果走就近原则，先不请求更改赔率，先变跟赔率。
    if (BetsUtils.setChangesOdds(listData[index])) {
      listData[index].isChangeOdds.value = true;
      return;
    }

    ///赔率
    int odds =
        (double.parse(detailList.oddFinallyChange.value) * 100000).toInt();
    String marketType = detailList.marketType;

    ///当是香港盘的时候，更改赔率要加100000
    if (marketType == 'HK') {
      odds = odds + 100000;
    }

    ///发起修改金额和赔率请求
    upDatePreBetOdds(detailList.marketType, odds, listData[index].orderNo,
        orderAmountTotal, index);
  }

  ///键盘折叠
  setKeyboardFolding(bool isOpen, int index) {
    var difference = 0.h;
    if (index == 0) {
      difference = isOpen ? 180.h : -180.h;
    } else {
      difference = isOpen ? 275.h : -275.h;
    }
    var offset = scrollController.offset + difference;
    scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 450), curve: Curves.easeInOut);
  }

  ///修改赔率请求
  upDatePreBetOdds(String marketType, int odds, String orderNo,
      int orderAmountTotal, int index) async {

    // ToastUtils.showGrayBackground(toast);
  }

  ///未结注单-预约中-取消预约
  cancelPreBetOrder(int index) async {
    int orderNo = int.parse(listData[index].orderNo);
    final res = await BetApi.instance().cancelPreBetOrder(orderNo);
    if (res.code == "0000000") {
      TYUserController.to.getBalance();
      getH5PreBetOrderlist();
    } else {
      BetsUtils.toastDialog(res.msg);
      ToastUtils.showGrayBackground(res.msg);
    }
  }

  Future queryBetAmount(GetH5PreBetOrderlistDataRecordxData recordxData) async {
    BetAmountReq req = BetAmountReq();
    BetAmountReqOrderMaxBetMoney orderMinMaxMoney =
        BetAmountReqOrderMaxBetMoney();GetH5PreBetOrderlistDataRecordxDataDetailList item = recordxData.detailList[0];orderMinMaxMoney.sportId = item.sportId.toString();orderMinMaxMoney.marketId = item.marketId;orderMinMaxMoney.deviceType = getDevice(); // 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"orderMinMaxMoney.matchId = item.matchId;orderMinMaxMoney.oddsFinally = item.oddFinally;orderMinMaxMoney.oddsValue = item.oddsValue.toString();orderMinMaxMoney.playId = item.playId.toString();orderMinMaxMoney.playOptionId = item.playOptionsId;orderMinMaxMoney.playOptions = item.playOptions;orderMinMaxMoney.seriesType = 1; // 串关类型 // 串关类型 1 单关 2串关
    /// orderMinMaxMoney.matchProcessId = item.matchMmp;
    orderMinMaxMoney.scoreBenchmark = '';orderMinMaxMoney.tenantId = 1; //商户id
    /// orderMinMaxMoney.tournamentLevel = item.tournamentLevel;
    orderMinMaxMoney.tournamentId = item.tournamentId;
    /// orderMinMaxMoney.dataSource = item.dataSource;
    orderMinMaxMoney.matchType = item.matchType;

    req.orderMaxBetMoney = [orderMinMaxMoney];

    final res = await BetApi.instance().queryMarketMaxMinPreBetMoney(req);
    GetH5PreBetOrderlistDataRecordxDataDetailList detailList =
        recordxData.detailList[0];
    setDefault(res, detailList);
  }

  setDefault(QueryMarketMaxMinPreBetMoneyEntity res,
      GetH5PreBetOrderlistDataRecordxDataDetailList detailList) {
    ///限额默认最小额度
    String defaultMinimum = '10.00';

    ///限额默认最大额度
    String defaultMax = '8888.00';

    if (res.code == "0000000") {
      var minBet = res.data[0].minBet;
      var orderMaxPay = res.data[0].orderMaxPay;
      if (minBet.isNotEmpty) {
        ///2位小数
        detailList.orderLeastPay.value = setAmount(minBet);
      } else {
        detailList.orderLeastPay.value = defaultMinimum;
      }
      if (orderMaxPay.isNotEmpty) {
        detailList.orderMaxPay.value = setAmount(orderMaxPay);
      } else {
        detailList.orderMaxPay.value = defaultMax;
      }
    } else {
      detailList.orderLeastPay.value = defaultMinimum;
      detailList.orderMaxPay.value = defaultMax;
    }
  }
}
