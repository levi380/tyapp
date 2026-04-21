import 'dart:ui' as ui;
import 'dart:core';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:flutter_ty_app/app/services/models/res/get_pre_settle_order_detail_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../generated/locales.g.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/res/get_cashout_max_amount_list_entity.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_match_limit_info_by_mids_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/utils.dart';
import '../../login/login_head_import.dart';
import '../utils/betsUtils.dart';
import '../widgets/slider/image_loader.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/widgets/date_picker/show_time_bottom.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(未结算)控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - `sliderBlockImage`：用于存储滑块图片。
    - `startTime` 和 `endTime`：用于展示选择的时间。
    - `startTimestamp` 和 `endTimestamp`：用于网络请求的时间戳。
    - `selectType`：当前选择的时间类型（全部、今日、昨日等）。
    - `openSelectTypeTime`：指示是否开启自定义时间选择。
    - `lastSelectType`：记录上一次选择的时间类型。
    - `page`：用于翻页请求的数据页码。
    - `statistics`：用于存储未结算注单的统计信息。
    - `size`：请求数据的条数。
    - `listData`：存储请求到的未结算注单数据。
    - `refreshController`：用于控制下拉刷新和上拉加载。
    - `loading`：指示当前是否在加载数据。
    - 其他与提前结算相关的开关和状态。
    - 关键方法
    - onInit()初始化时加载滑块图片。
    - setSelectType() 参数`int type`：选择的时间类型,设置时间类型，重置时间戳和数据，并请求数据。*：
    - getH5OrderList() 请求未结算注单列表，根据选择的时间类型发送不同的请求。
    - orderPreSettleObserve() 订阅 WebSocket 消息，处理注单提前结算的状态更新。
    - getCashoutMaxAmountList() 请求提前结算的最大金额，并更新状态。
    - setTurnOnEarlySettlement() `int index` 注单索引,切换提前结算状态，发起提前结算请求。
    - setEarlyAppointmentSettlement() `int index` 注单索引,处理预约提前结算的逻辑。
    - getReserveAmount() `int index` 注单索引,计算预约提前结算的金额，确保在最小和最大范围内。
    - betRemainingAmount() `int index` 注单索引,计算注单剩余本金。
    】】】
 *
 */
class AwaitBetsLogic extends GetxController {
  static AwaitBetsLogic get to => Get.find();

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
  ///记录上一次的（0:全部 1:今日 2:昨日 3:近7日 ）
  // var lastSelectType = -1;
  ///冠军赛事类型（ 0:全部赛事 1:冠军赛事）
  var ChampionshipEventType = 0.obs;
  ///网络请求翻页
  var page = 1;
  ///未结算注单统计
  List<String> statistics = ['0', '0.00', '0.00'];
  ///请求数据条数
  final int size = 300;
  ///  排序方式 1投注时间,2 结算时间
  final int orderBy = 1;
  ///  提前结算的轮训，赛事比分时间的轮训
  Timer? _timer, _matchLimitInfoByMidsTimer;
  ///赛事
  setChampionshipEventType(int type) {
    ChampionshipEventType.value = type;
    // openSelectTypeTime.value = (selectType.value == 5);
    ///切换时间清除旧数据
    listData.clear();matchInfoList.value = [];
    ///重制统计数据
    statistics = ['0', '0.00', '0.00'];
    if (_timer != null) {
      _timer?.cancel();
    }
    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {_matchLimitInfoByMidsTimer?.cancel();}
    if (selectType.value != 5) {loading = true;update();getH5OrderList();} else {loading = false;update();showTime(Get.context!, 5);
    }
  }
  ///时间选择器
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

    ///切换时间清除旧数据
    listData.clear();
    matchInfoList.value = [];
    ///重制统计数据
    statistics = ['0', '0.00', '0.00'];loading = true;
    if (_timer != null) {_timer?.cancel();}
    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {_matchLimitInfoByMidsTimer?.cancel();}update();getH5OrderList();
  }
  ///自定义时间控件
  void showTime(BuildContext context, int type) {
    //  lastSelectType = selectType.value;
    selectType.value = type;openSelectTypeTime.value = true;
    ///开始时间
    showTimeBottom.showModalBottom(
      context,
      onDateTimeChanged: (date) {
        ///开始时间
        startTime.value = DateUtil.formatDateMs(date[0].millisecondsSinceEpoch, format: DateFormats.y_mo_d, ).toString();
        startTimestamp = date[0].millisecondsSinceEpoch.toString();
        ///结束时间
        endTime.value = DateUtil.formatDateMs(date[1].millisecondsSinceEpoch, format: DateFormats.y_mo_d, ).toString();
        ///如果结束时间是今天 那么取当前时间戳而不是当天的零点
        if (DateTime.now().difference(date[1]).inDays == 0) {endTimestamp = DateTime.now().millisecondsSinceEpoch.toString();} else {endTimestamp = date[1].millisecondsSinceEpoch.toString();}setSelectType(type);
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
  ///数据列表
  List<GetH5OrderListDataRecordxData> listData = [];
  ///提前结算列表数据
  List<GetCashoutMaxAmountListData> maxAmountListData = [];
  /// 赛事阶段比分列表
  RxList<GetMatchLimitInfoByMidsDataData> matchInfoList = <GetMatchLimitInfoByMidsDataData>[].obs;RefreshController refreshController = RefreshController(initialRefresh: false);
  ///加载展示
  bool loading = true;
  /// settleSwitch                    足球提前结算开关
  bool settleSwitch = false;
  /// settleSwitchBasket              篮球提前结算开关
  bool settleSwitchBasket = false;
  /// sysBookedSettleSwitch           系统预约提前结算开关
  bool sysBookedSettleSwitch = false;
  /// sysPartSettleSwitch             系统部分提前结算开关
  bool sysPartSettleSwitch = false;
  /// bookedSettleSwitchFootball      预约提前结算开关-足球
  bool bookedSettleSwitchFootball = false;
  /// bookedSettleSwitchBasketball    预约提前结算开关-篮球
  bool bookedSettleSwitchBasketball = false;
  /// partSettleSwitchFootball        部分提前结算开关-足球
  bool partSettleSwitchFootball = false;
  /// partSettleSwitchBasketball      部分提前结算开关-篮球
  bool partSettleSwitchBasketball = false;
  ///获取用户提前结算开关状态
  getSwitchStatus() {
    settleSwitch = TYUserController.to.isSettleSwitch();settleSwitchBasket = TYUserController.to.isSettleSwitchBasket();
    sysBookedSettleSwitch = TYUserController.to.isSysBookedSettleSwitch();sysPartSettleSwitch = TYUserController.to.isSysPartSettleSwitch();
    bookedSettleSwitchFootball = TYUserController.to.isBookedSettleSwitchFootball();bookedSettleSwitchBasketball = TYUserController.to.isBookedSettleSwitchBasketball();
    partSettleSwitchFootball = TYUserController.to.isPartSettleSwitchFootball();partSettleSwitchBasketball = TYUserController.to.isPartSettleSwitchBasketball();
  }

  @override
  void onClose() {
    /// refreshController.dispose();
    ///提前结算接口轮询
    if (_timer != null) {_timer?.cancel();}
    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {_matchLimitInfoByMidsTimer?.cancel();}
    ///关闭注单ws订阅
    Bus.getInstance().off(EventType.orderPreSettle);super.onClose();
  }

  ///提前结算注单订阅
  orderPreSettleObserve() {
    if (AppWebSocket.channel != null) {
      ///判断 ws是否关闭
      ///注单订阅
      AppWebSocket.instance().sktSendOrder({'cuid': TYUserController.to.getUid()});}
    Bus.getInstance().on(EventType.orderPreSettle, (Map<String, dynamic> data) {
      //  print("AwaitBetsLogic----数据返回---" + data.toString());
      String orderNo = (data.get("orderNo") ?? '').toString();String orderStatus = (data.get("orderStatus") ?? '').toString();
      if (listData.isNotEmpty && orderNo.isNotEmpty && orderStatus.isNotEmpty) {for (int i = 0; i < listData.length; i++) {
        if (listData[i].orderNo == orderNo) {
            ///1.只有是在已经等待提前结算才改状态，2避免bus 的重复通知。
            if (listData[i].earlySettlementSuccessfulType == 1) {
              ///1提前结算成功，2提前结算失败
              if (orderStatus == '1') {
                String preSettleAmount = data.get("preSettleAmount")!.toString();listData[i].maxCashout = preSettleAmount;listData[i].earlySettlementBeingRequested = false;listData[i].earlySettlementSuccessfulType = 2;listData[i].earlySettlementState = 0;
                ///成功后重新拉取数据
                RePullData();
              } else if (orderStatus == '2') {
                listData[i].earlySettlementBeingRequested = false;listData[i].earlySettlementSuccessfulType = 3;int sportId = listData[i].detailList[0].sportId;
                ///如果失败了要重新开启预约提前结算和部分提前结算功能
                if ((sysBookedSettleSwitch && sportId == 1) || (sysPartSettleSwitch && sportId == 2)) {listData[i].earlySettlementState = 1;}update();
              }
            }
          }
        }
      }
    });
  }
  ///成功后重新拉取数据
  RePullData(){
    ///关闭轮训接口
    if (_timer != null) {_timer?.cancel();}
    if (_matchLimitInfoByMidsTimer != null) {_matchLimitInfoByMidsTimer?.cancel();}update();
    ///提前兑现成功，重新3秒后拉取数据
    Future.delayed(Duration(seconds: 3), () {listData.clear();loading =true;update();getH5OrderList();});
  }
  ///请求列表数据
  Future<void> getH5OrderList() async {
    ///当使用时间选择的时候不能传timeType这个参数给后台
    final GetH5OrderListEntity res;if (selectType.value != 5) {if (selectType.value == 0) {res = await BetApi.instance().getH5OrderList('0', '', page: page, size: size, outright: ChampionshipEventType.value);} else {res = await BetApi.instance().getH5OrderList('0', '', timeType: selectType.value, page: page, size: size, outright: ChampionshipEventType.value);}} else {res = await BetApi.instance().getH5OrderList('0', '', beginTime: startTimestamp, endTime: endTimestamp, page: page,size: size, orderBy: orderBy, outright: ChampionshipEventType.value);}String code = res.code;
    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {GetH5OrderListData data = res.data;statistics[0] = data.total;statistics[1] = data.betTotalAmount;statistics[2] = data.maxWinTotalAmount;
      if (data.record != null && data.record!.isNotEmpty) {
        ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
        Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};List<MapEntry<String, GetH5OrderListDataRecordx?>> entries = record.entries.toList();Map<String, GetH5OrderListDataRecordx?> reversedMap = Map.fromEntries(entries);
        ///便利map，把数据全部房在一起。
        reversedMap.forEach((key, value) {listData.addAll(value!.data);});}}loading = false;update();
    if (listData.isNotEmpty) {
      ///足球或者篮球开启提前结算，才去循环单关提起结算
      if (settleSwitch || settleSwitchBasket) {for (GetH5OrderListDataRecordxData element in listData) {int matchType = element.matchType ?? 0;
          ///当列表中有单关和串关，轮询请求提前结算接口。matchType:3 是冠军,只要不是冠军，就是单关和串关
      if (matchType != 3) {
            ///开始轮询提前结算接口
            setPollingIntervalRepeats();break;}}}
      ///当列表中有单关，轮询比赛时间和比分接口。
      for (GetH5OrderListDataRecordxData element in listData) {int sportId = element.detailList[0].sportId;
        ///当列表中有足球和篮球
        if (sportId == 1 || sportId == 2) {String matchPeriodId = element.detailList[0].matchPeriodId;int matchOver = element.detailList[0].matchOver;
          ///当列表中有滚球的
          if (matchPeriodId != "0" && matchPeriodId != "999" && matchOver != 1) {String dataSourceCode = element.detailList[0].dataSourceCode;
            ///当不是电竞赛事
            if (!["C01", "RC", "O01", "OD", "B03", "BE"].contains(dataSourceCode)) {
              ///开始轮询比赛时间和比分接口
              setMatchLimitInfoByMidsNew();break;}}}}}}
  ///轮询5秒提前结算
  setPollingIntervalRepeats() {getCashoutMaxAmountList();
    ///提前结算接口轮询
    if (_timer != null) {_timer?.cancel();}_timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      getCashoutMaxAmountList();});}
  ///轮询5秒比赛时间和玩法比分
  setMatchLimitInfoByMidsNew() {getMatchLimitInfoByMidsNew();
    ///赛事接口轮询
    if (_matchLimitInfoByMidsTimer != null) {_matchLimitInfoByMidsTimer?.cancel();}_matchLimitInfoByMidsTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {getMatchLimitInfoByMidsNew();});}
  ///提前结算请求
  getCashoutMaxAmountList() async {
    ///当页面不存在关闭定时器
    if (isClosed) {_timer?.cancel();_timer = null;return;}String orderNo = '';String splicing = '';
    ///拼接所有单号用 ，号拼接
    for (GetH5OrderListDataRecordxData element in listData) {
      ///当列表中有单关和串关，轮询请求提前结算接口。matchType:3 是冠军,只要不是冠军，就是单关和串关
      int matchType = element.matchType ?? 0;if (matchType != 3 && element.orderNo.isNotEmpty) {orderNo = orderNo + splicing + element.orderNo;splicing = ',';}}
    /// 网络超时情况 异常捕获
    try {final res = await BetApi.instance().getCashoutMaxAmountList(orderNo);
      ///判断code == "0000000"就是成功拿到数据
      if (res.code == "0000000") {
        ///当拿的最新数据就清除旧数据
        maxAmountListData.clear();maxAmountListData = res.data;if (maxAmountListData.isNotEmpty) {for (int i = 0; i < listData.length; i++) {
            ///更改单关和串关（matchType:3 是冠军,只要不是冠军，就是单关和串关）
            int matchType = listData[i].matchType ?? 0;if (matchType != 3) {
              ///提前结算总开关
              int sportId = listData[i].detailList[0].sportId;if ((!settleSwitch && sportId == 1) ||
                  ///当是足球，足球开关是关闭的时候
                  (!settleSwitchBasket && sportId == 2)) {
                ///当是篮球，篮球开关是关闭的时候
                continue;}
              ///当已经提前结算和，提前结算等待处理中是不更改状态的
              int earlySettlementSuccessfulType = listData[i].earlySettlementSuccessfulType;if (earlySettlementSuccessfulType == 0 || earlySettlementSuccessfulType == 3) {
                ///预约结算和部分结算开关
                if (sysBookedSettleSwitch || sysPartSettleSwitch) {
                  ///如果已经是显示，并且是展开的状态是不需要处理的
                  if (listData[i].earlySettlementState == 0) {listData[i].earlySettlementState = 1;}} else {listData[i].earlySettlementState = 0;}
                ///预约提前结算开关-足球-篮球-开关
                if ((sysBookedSettleSwitch && bookedSettleSwitchFootball && sportId == 1) || (sysBookedSettleSwitch && bookedSettleSwitchBasketball && sportId == 2)) {listData[i].bookedSettleSwitch = true;}
                /// 部分提前结算开关-足球-篮球-开关
                if ((sysPartSettleSwitch && partSettleSwitchFootball && sportId == 1) || (sysPartSettleSwitch && partSettleSwitchBasketball && sportId == 2)) {listData[i].partSettleSwitch = true;}bool bookedSettleSwitch = listData[i].bookedSettleSwitch;bool partSettleSwitch = listData[i].partSettleSwitch;
                ///当预约提前结算和部分提前结算开关关闭
                if (!bookedSettleSwitch && !partSettleSwitch) {listData[i].earlySettlementState = 0;listData[i].earlySettlementType = 2;
                  ///当只有部分提前结算，没有预约提前结算的时候
                } else if (!bookedSettleSwitch && partSettleSwitch) {listData[i].earlySettlementType = 1;}
                ///重新回到没有提前结算状态
                listData[i].earlySettlementSuccessfulType = 0;
                ///预约提前结算如果点击了一次，轮询接口回来就要回到没点击的状态
                if (listData[i].earlyAppointmentSettlementType.value == 2) {listData[i].earlyAppointmentSettlementType.value = 1;}
                ///不是准备发起 ，和不是正在发起提起结算请求，才能改状态
                if (!listData[i].turnOnEarlySettlement && !listData[i].earlySettlementBeingRequested) {
                  /// 提前结算功能页面页全部关闭
                  //  listData[i].turnOnEarlySettlement = false;
                  listData[i].exhibitEarlySettlement = false;for (var element in maxAmountListData) {String orderNo = element.orderNo;
                    ///轮询回来的单号，开启提前结算界面
                    if (listData[i].orderNo == orderNo) {listData[i].exhibitEarlySettlement = true;
                      ///轮询回来的数据，每次轮询请求回来，都要更改提前结算金额
                      listData[i].maxCashout = element.preSettleMaxWin;}}}}}}}} else {for (int i = 0; i < listData.length; i++) {
          ///更改单关和串关（matchType:3 是冠军,只要不是冠军，就是单关和串关）
          int matchType = listData[i].matchType ?? 0;if (matchType != 3) {
            ///已结提前结算成功了，就不能改状态。
            int earlySettlementSuccessfulType = listData[i].earlySettlementSuccessfulType;if (earlySettlementSuccessfulType == 0 || earlySettlementSuccessfulType == 3) {
              ///如果轮询回来没有单号，所有提前结算（所有）界面都关闭
              listData[i].exhibitEarlySettlement = false;
              /// 提前结算功能全部关闭
              listData[i].turnOnEarlySettlement = false;
              ///重新回到没有提前结算状态
              listData[i].earlySettlementSuccessfulType = 0;
              ///关闭预约提前结算和部分提前结算
              listData[i].earlySettlementState = 0;}}}}update();} catch (e) {AppLogger.debug("getCashoutMaxAmountList error:$e");}}
  ///比赛时间和玩法比分请求
  getMatchLimitInfoByMidsNew() async {
    ///当页面不存在关闭定时器
    if (isClosed) {_matchLimitInfoByMidsTimer?.cancel();_matchLimitInfoByMidsTimer = null;return;}List<Map> result = [];Map<String, Set<String>> midToPidsMap = {};
    for (GetH5OrderListDataRecordxData element in listData) {if (element.detailList.isNotEmpty) {for (GetH5OrderListDataRecordxDataDetailList item in element.detailList) {String mid = item.matchId;String pids = item.playId.toString();
          /// 如果 mid 已存在，则添加 pids
          if (midToPidsMap.containsKey(mid)) {midToPidsMap[mid]!.add(pids);} else {
            /// 如果 mid 不存在，则创建新条目
            midToPidsMap[mid] = {pids}; // 使用 Set 来存储 pids
          }}}}
    /// 将 midToPidsMap 转换为 List<Map>
    if (midToPidsMap.isNotEmpty){midToPidsMap.forEach((mid, pidsSet) {result.add({"mid": mid.toString(),
          /// 将 Set 转换为字符串，使用 ", " 分隔
          "pids": pidsSet.join(",").toString()});});}
    if (result.isNotEmpty) {final res = await BetApi.instance().getMatchLimitInfoByMidsNew(result);
      ///判断code == "0000000"就是成功拿到数据
      if (res.code == "0000000" && ObjectUtil.isNotEmpty(res.data)) {matchInfoList.value = res.data.data;} else if (res.code == "0401038") {
        /// 限频 直接过滤
      } else {matchInfoList.value = [];}}}
  ///开启提前结算功能
  setTurnOnEarlySettlement(int index) {
    ///正在提前结算中是不能，再发起提前结算的
    if (listData[index].earlySettlementBeingRequested) {return;}
    ///已经提前结算成功的，和已提前结算等待的，不能再次发起提起结算
    if (listData[index].earlySettlementSuccessfulType != 0) {return;}
    ///判断是否开始提前结算（点击1次，开启提前结算，点击2次才提前结算）
    if (!listData[index].turnOnEarlySettlement) {
      ///开启提前结算
      listData[index].turnOnEarlySettlement = true;update();} else {
      ///请求提前结算
      orderPreSettle(index);}}

  ///取消准备提交的提前结算功能
  setCancelSubmission(int index) {
    ///取消提前兑现
    listData[index].turnOnEarlySettlement = false;for (var element in maxAmountListData) {String orderNo = element.orderNo;
      ///判断是不是当前注单
      if (listData[index].orderNo == orderNo) {
        ///更新前结算金额（最新的金额）
        listData[index].maxCashout = element.preSettleMaxWin;}}update();}

  ///请求提前结算
  orderPreSettle(int index) async {int deviceType = getDevice();String frontSettleAmount = "";String orderNo = listData[index].orderNo;double settleAmount = 0.00;
    /// 部分提前结算
    if (listData[index].earlySettlementState == 2 && listData[index].earlySettlementType == 1) {
      ///提前兑现金额
      frontSettleAmount = BetsUtils.getExpectedProfit(listData[index]);
      ///提前兑现本金
      settleAmount = BetsUtils.cashoutStake(listData[index]);
      ///当部分提前兑现金额小于1元的时候不允许发起提前兑现请求
      double calibration = double.parse(frontSettleAmount);if (calibration < 1) {
        ///弹框提示最小单笔提前兑现金额不能小于1
        BetsUtils.toastDialog(LocaleKeys.app_minimum_settlement_amount.tr.replaceAll("{0}", "1" + TYUserController.to.currCurrency()), seconds: 2);return;}} else {
      ///全额提前结算
      frontSettleAmount = listData[index].maxCashout.toString();settleAmount = listData[index].preSettleBetAmount;}
    ///开始请求提前结算
    listData[index].earlySettlementBeingRequested = true;update();
    final res = await BetApi.instance().orderPreSettle(deviceType, frontSettleAmount, orderNo, settleAmount);String code = res.code;listData[index].turnOnEarlySettlement = false;if (res.code == "0000000" || res.code == "200") {
      ///提前结算成功
      listData[index].earlySettlementBeingRequested = false;listData[index].earlySettlementSuccessfulType = 2;listData[index].earlySettlementState = 0;} else if (code == "0400524") {
      ///只有040052提前请求，等待处理，通过ws 来确定状态
      listData[index].earlySettlementSuccessfulType = 1;listData[index].earlySettlementState = 0;} else {
      ///提前结算，失败。
      listData[index].earlySettlementBeingRequested = false;listData[index].earlySettlementSuccessfulType = 3;if (res.msg.isNotEmpty) {BetsUtils.toastDialog(res.msg);}}update();}
  ///预约提前结算
  setEarlyAppointmentSettlement(int index) {
    int type = listData[index].earlyAppointmentSettlementType.value;
    switch (type) {
      ///预约提前结算金额请求。
      case 0:saveReserveCashOut(index);break;
      ///1:取消预约提前结算，（点击一次后，变成确认取消）
      case 1:listData[index].earlyAppointmentSettlementType.value = 2;break;
      ///取消预约提前结算请求。
      case 2:cancelReserveCashoutOrder(index);break;}}
  ///取消预约提前结算请求。
  cancelReserveCashoutOrder(int index) async {
    final res = await BetApi.instance().cancelReserveCashoutOrder(listData[index].orderNo);if (res.code == "0000000") {
      /// 预约提前结算按钮状态
      listData[index].earlyAppointmentSettlementType.value = 0;} else {BetsUtils.toastDialog(res.msg);
      //  ToastUtils.showGrayBackground(res.msg);
    }}

  ///预约提前结算金额请求。
  saveReserveCashOut(int index) async {int deviceType = getDevice();String matchId = listData[index].detailList[0].matchId;String orderNo = listData[index].orderNo;int playId = listData[index].detailList[0].playId;String playOptionsId = listData[index].detailList[0].playOptionsId;double settleAmount = listData[index].orderAmountTotal;int sportId = listData[index].detailList[0].sportId;double reserveAmount = BetsUtils.getReserveAmount(listData[index]);
    final res = await BetApi.instance().saveReserveCashOut(deviceType, matchId, orderNo, playId, playOptionsId, reserveAmount, settleAmount, sportId);if (res.code == "0400555") {
      /// 预约提前结算金额，键盘输入金额
      listData[index].earlyAppointmentSettlementAmount.value = '';
      /// 预约提前结算,已经预约金额
      listData[index].reserveCashOutAmount.value = reserveAmount;
      /// 预约提前结算按钮状态
      listData[index].earlyAppointmentSettlementType.value = 1;} else {if (res.msg.isNotEmpty) {BetsUtils.toastDialog(res.msg);
        // ToastUtils.showGrayBackground(res.msg);
      }}}
  ///切换预约提前结算和部分提前结算
  setType(int index, int type) {if (listData.isNotEmpty) {listData[index].earlySettlementType = type;update();}}
  ///切换预约提前结算和部分提前结算展示按钮
  setEarlySettlementState(int index, int state) {
    ///等0的时候是不开启切换预约提前结算和部分提前结算展示按钮的
    if (state == 0) {return;
      ///当第一次点击显示预约提前结算和部分提前结算展示按钮，要去获取，预约提前结算状态，部分提前结算不用
    } else if (state == 1 && listData[index].earlySettlementType == 0 && listData[index].earlyAppointmentSettlementType.value == 0) {
      ///获取
      getReserveCashoutList(index);}
    if (listData.isNotEmpty) {
      ///不等于1的时候设置未1，等于1的时候等于2
      listData[index].earlySettlementState = (state != 1 ? 1 : 2);update();}}
  ///展示提前结算，金额界面
  getReserveCashoutList(int index) async {
    final res = await BetApi.instance().getReserveCashoutList(listData[index].orderNo);if (res.code == "0000000") {if (res.data.isNotEmpty) {listData[index].earlyAppointmentSettlementType.value = 1;listData[index].reserveCashOutAmount.value = double.parse(res.data[0].reserveCashOutAmount);
    }}}
  ///串关折叠
  onTextExpand(int index) {listData[index].isExpand.value = !listData[index].isExpand.value;}
  /// 部分提前结算滑块设置比例
  setEarlyProportionSettleRatio(int index, double ratio) {listData[index].earlyProportionSettleRatio = ratio;update();}
  ///提前结算折叠
  onPreSettleExpand(int index) async {bool preSettleExpand = listData[index].preSettleExpand.value;
    ///收起折叠
    if (preSettleExpand) {listData[index].preSettleExpand.value = false;
      ///打开折叠
    } else {GetPreSettleOrderDetailEntity res = await BetApi.instance().getPreSettleOrderDetail(listData[index].orderNo);if (res.code == "0000000") {if (res.data.isNotEmpty) {late List<GetPreSettleOrderDetailData> data = res.data;listData[index].preSettleExpand.value = true;listData[index].data = data;}}}
  }
}
