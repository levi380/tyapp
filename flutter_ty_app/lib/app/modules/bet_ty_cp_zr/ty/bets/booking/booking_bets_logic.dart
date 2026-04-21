import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/utils/betsUtils.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/ty_user_controller.dart';
import '../../../../../services/api/bet_api.dart';
import '../../../../../services/models/req/bet_amount_req.dart';
import '../../../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../../../../services/models/res/query_market_info_by_match_id_and_play_id_entity.dart';
import '../../../../../services/models/res/query_market_max_min_pre_bet_money_entity.dart';
import '../../../../../utils/bet_appoint_util.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/date_picker/show_time_bottom.dart';
import '../../../../shop_cart/model/shop_cart_type.dart';
import '../../../../unsettled_bets/dialog/rule_statement_dialog/cancel_appointment_dialog.dart';
import 'package:common_utils/common_utils.dart';

import 'booking_bets_State.dart';

class BookingBetsLogic extends GetxController {
  static BookingBetsLogic get to => Get.find();
  final BookingBetsState state = BookingBetsState();

  ///提示倒计时关闭
  Timer? _timer;

  /**
   * 开启预约注单弹框
   */
  setIsOpenTips() {
    ///防止多次点击
    if (state.isOpenTips.value) {
      return;
    }
    state.isOpenTips.value = true;
    // 启动定时器
    _timer = Timer(Duration(seconds: 3), () {
      state.isOpenTips.value = false;
      _timer?.cancel();
    });
  }

  /*
   *切换预约和失效
   */
  setBetsTypes(int type) {
    state.betsTypes = type;

    ///切换时间清除就数据
    state.listData.clear();

    ///重制统计数据
    state.statistics = ['0', '0.00', '0.00'];

    if (state.selectType.value != 5) {
      state.loading = true;
      update();
      getH5PreBetOrderlist();
    } else {
      state.loading = false;
      update();
      showTime(Get.context!, 5);
    }
  }

  /**
   * 切换注单时间
   */
  setSelectType(int type, {String temporaryStartTime = "", String temporaryEndTime = ""}) {
    ///防止多次点击
    if (type != 5 && type == state.selectType.value) {
      return;
    }
    if (type != 5) {
      state.startTimestamp = "";
      state.endTimestamp = "";
      state.startTime.value = "";
      state.endTime.value = "";
    }else {
      if (temporaryStartTime.isNotEmpty && temporaryEndTime.isNotEmpty) {
        ///开始时间
        state.startTime.value = temporaryStartTime;

        ///结束时间
        state.endTime.value = temporaryEndTime;
      }
    }
    state.selectType.value = type;
    state.openSelectTypeTime.value = false;

    ///切换时间清除就数据
    state.listData.clear();

    ///重制统计数据
    state.statistics[0] = '0';
    state.statistics[1] = '0.00';
    state.statistics[2] = '0.00';
    state.loading = true;
    // refreshController.refreshCompleted(resetFooterState: true);
    update();
    getH5PreBetOrderlist();
  }

  /*
   *自定义时间控件
   */
  void showTime(BuildContext context, int type) {
    // lastSelectType = selectType.value;
   // selectType.value = type;
    state.openSelectTypeTime.value = true;
    String temporaryStartTime ="";
    String temporaryEndTime ="";
    showTimeBottom.showModalBottom(
      context,
      onDateTimeChanged: (date) {
        ///开始时间
        temporaryStartTime = DateUtil.formatDateMs(date[0].millisecondsSinceEpoch,
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
        setSelectType(type, temporaryStartTime: temporaryStartTime,
            temporaryEndTime: temporaryEndTime);
      },
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
    state.refreshController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  /*
   *请求列表数据
   */
  Future<void> getH5PreBetOrderlist({int indexs = -1}) async {
    GetH5PreBetOrderlistEntity res;

    ///区分预约和失效注单
    List<int> preOrderStatusList = state.betsTypes == 0 ? [0] : [2, 3, 4];

    ///当使用时间选择的时候不能传timeType这个参数给后台
    if (state.selectType.value != 5) {
      ///预投注订单状态(0预约中 ;1预约成功;2.风控预约失败;3.风控取消预约注单.4.用户手动取消预约投注) 比如 [0,1,2,3]
      if (state.selectType.value == 0) {
        res = await BetApi.instance().getH5PreBetOrderlist(
            preOrderStatusList, '',
            size: state.size, page: state.page);
      } else {
        res = await BetApi.instance().getH5PreBetOrderlist(
            preOrderStatusList, '',
            size: state.size, page: state.page, timeType: state.selectType.value);
      }
    } else {
      res = await BetApi.instance().getH5PreBetOrderlist(preOrderStatusList, '',
          size: state.size,
          page: state.page,
          beginTime: state.startTimestamp,
          endTime: state.endTimestamp);
    }
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      if (indexs == -1) {
        state.listData.clear();
      }
      GetH5PreBetOrderlistData data = res.data;
      state.statistics[0] = data.total;
      state.statistics[1] = data.betTotalAmount;

      ///预约中，才有这个数据
      if (state.betsTypes == 0) {
        state.statistics[2] = data.maxWinTotalAmount;
      }

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
            state.listData.addAll(value!.data);
          });
        } else {
          var listDataChange = state.listData[indexs];
          reversedMap.forEach((key, value) {
            var latestData = value!.data;
            if (latestData.isNotEmpty) {
              for (GetH5PreBetOrderlistDataRecordxData element in latestData) {
                if (listDataChange.orderNo == element.orderNo) {
                  ///更改修改预约金额的数据
                  listDataChange.detailList[0].originalMarketValue=element.detailList[0].originalMarketValue;
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
    state.loading = false;
    update();
  }

  ///修改赔率
  ///index 是你哪个一条
  ///type 0:减赔率，1:加赔率，2: 取消预约（走取消赔率接口），3：修改，4: 取消，5：确认(走更改赔率接口)
  setModifyOdds(int index, int type) {
    switch (type) {
      ///减赔率
      case 0:
        ///赔率最小
        double parse = double.parse(state.listData[index].detailList[0].oddFinallyChange.value);
        if ( parse<= state.listData[index].detailList[0].RealTimeOddsValue){
          state.listData[index].detailList[0].oddFinallyChange.value = state.listData[index].detailList[0].RealTimeOddsValue.toString();
          BetsUtils.toastDialog(LocaleKeys.app_book_bet_1.tr);
          return;
        }

        state.listData[index].detailList[0].oddFinallyChange.value =
            BetsUtils.setMinusOdds(
                state.listData[index].detailList[0].oddFinallyChange.value);
        break;

      ///加赔率
      case 1:
        state.listData[index].detailList[0].oddFinallyChange.value =
            BetsUtils.setIncreaseOdds(
                state.listData[index].detailList[0].oddFinallyChange.value);
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
      ///锚点 4455需求屏蔽，预约注单修改盘口，暂时不上.......屏蔽就注释(284-306)
        // 当前时间的毫秒数,用来拦截1分钟以内的修改
     /*  int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
       String orderNo = state.listData[index].orderNo;
       List betListsHasModified = ListKV.betListsHasModified.get();

       // 检查 betListsHasModified 列表
       if (betListsHasModified.isNotEmpty) {
         for (String element in betListsHasModified) {
           // 拆分出 orderNo 和时间戳
           List<String> parts = element.split('_');
           String existingOrderNo = parts[0];
           int existingTimestamp = int.parse(parts[1]);

           // 判断是否以 orderNo 开头
           if (existingOrderNo == orderNo) {
             // 判断时间戳是否超过一分钟（60000 毫秒）
             if (currentTimestamp - existingTimestamp < 60000) {
               // 没有超过一分钟，返回
               BetsUtils.toastDialog(LocaleKeys.app_book_bet_2.tr);
               return;
             }
           }
         }
       }*/
        ///获取比分和赔率
        queryPreBetAmount(state.listData[index], index);
        if (isWhetherRulesChanged(state.listData[index].detailList[0].sportId,
            state.listData[index].detailList[0].playId)) {

          String replaceAll = state.listData[index].detailList[0].originalMarketValue;


          state.listData[index].detailList[0].marketValueChange.value =replaceAll ;
          ///获取可调的盘口列表
          getQueryMarketInfoByMatchIdAndPlayId(state.listData[index], index);
        }

       state.listData[index].canBeModified = true;
       state.listData[index].isOnKeyboard.value = true;
        String orderAmountTotal =
            setAmount(state.listData[index].orderAmountTotal.toString());

        ///去除金额后面的.00
        if (orderAmountTotal.contains('.')) {
          String split = orderAmountTotal.split('.')[1];
          if (split == '00') {
            orderAmountTotal = orderAmountTotal.split('.')[0];
          }
        }

        ///开启修改赔率默认成预约的赔率
       state.listData[index].detailList[0].modifyBetAmount.value = orderAmountTotal;
        setKeyboardFolding(true, index);
        update();
        queryBetAmount(state.listData[index]);
        break;

      ///取消
      case 4:
        state.listData[index].canBeModified = false;
        state.listData[index].isChangeAmount.value = false;
        state.listData[index].isChangeOdds.value = false;
        setKeyboardFolding(false, index);
        update();
        break;

      ///确认修改赔率
      case 5:

        ///组合参数开始发，筛选参数，不正确的拦截掉，正确的发起请求
        setBeforeUpDatePreBetOdds(index);
        break;

      ///盘口减
      case 6:
        var sportId = state.listData[index].detailList[0].sportId;
        var playId = state.listData[index].detailList[0].playId.toString();
        var current = state.listData[index].detailList[0].marketValueChange.value;
        String score = state.listData[index].detailList[0].score;
        if (BetAppointUtil.canSubtract(sportId, playId, current, score)) {
          var calcNextValue =
              BetAppointUtil.calcNextValue(sportId, playId, current, false);
          state.listData[index].detailList[0].marketValueChange.value = calcNextValue;
          String oddsType = state.listData[index].detailList[0].playOptions;
          setAdjustOdds(calcNextValue, oddsType, index);

        } else {
          BetsUtils.toastDialog(LocaleKeys.app_book_bet_3.tr);
          //提示错误
        }

        break;

      ///盘口加
      case 7:
        var sportId = state.listData[index].detailList[0].sportId;
        var playId = state.listData[index].detailList[0].playId.toString();
        var current = state.listData[index].detailList[0].marketValueChange.value;
        String score = state.listData[index].detailList[0].score;
        if (BetAppointUtil.canAdd(sportId, playId, current, score)) {
          var calcNextValue =
              BetAppointUtil.calcNextValue(sportId, playId, current, true);
          state.listData[index].detailList[0].marketValueChange.value = calcNextValue;
          String oddsType = state.listData[index].detailList[0].playOptions;
          setAdjustOdds(calcNextValue, oddsType, index);

        } else {
          BetsUtils.toastDialog(LocaleKeys.app_book_bet_4.tr);
          //提示错误
        }
        break;
    }
  }

  ///修改盘口调整赔率
  setAdjustOdds(String calcNextValue, String oddsType, int index) {
    bool isChange = false;
    QueryMarketInfoByMatchIdAndPlayIdData
        queryMarketInfoByMatchIdAndPlayIdData =
        state.listData[index].queryMarketInfoByMatchIdAndPlayIdData;
    List<QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO> data =
        queryMarketInfoByMatchIdAndPlayIdData.queryMarketDetailVO;
    if (data.isNotEmpty) {
      for (QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO element in data) {
        if (calcNextValue == element.marketValue) {
          List<QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList>
              marketOddsVOList = element.queryMarketOddsVOList;
          if (marketOddsVOList.isNotEmpty) {
            for (QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList elementlst in marketOddsVOList) {
              if (elementlst.oddsType == oddsType) {
                state.listData[index].detailList[0].RealTimeOddsValue=elementlst.oddsValue / 100000;
                state.listData[index].detailList[0].oddFinallyChange.value = (elementlst.oddsValue / 100000).toString();
                isChange=true;
                break;
              }
            }
          }
        }
      }
    }
    if (isChange){

    }
  }

  /*
   *是否可以修改盘口
   */
  bool isWhetherRulesChanged(int sportId, int playId) {
    //足球
    if (sportId == 1) {
      return [4, 19, 143, 2, 18, 26, 10, 11, 87, 88, 97, 98].contains(playId);
    } else if (sportId == 2) {
      //篮球
      return [39, 19, 143, 46, 52, 58, 64, 38, 18, 26, 45, 51, 57, 63]
          .contains(playId);
    }

    return false;
  }

  /*
   *获取主单赔率盘口列表
   */
  getQueryMarketInfoByMatchIdAndPlayId(
      GetH5PreBetOrderlistDataRecordxData recordxData, int index) async {
    int matchId = int.parse(recordxData.detailList[0].matchId);
    int playId = recordxData.detailList[0].playId;
    final res = await BetApi.instance()
        .queryMarketInfoByMatchIdAndPlayId(matchId, playId);
    if (res.code == "0000000") {
      state.listData[index].queryMarketInfoByMatchIdAndPlayIdData = res.data;
    }
  }

  /**
   * 获取赛事注单信息（比分，赔率）
   */
  queryPreBetAmount(GetH5PreBetOrderlistDataRecordxData recordxData,int index) async {
    BetAmountReq req = BetAmountReq();
    GetH5PreBetOrderlistDataRecordxDataDetailList firstdetailList = recordxData.detailList[0];
    BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
    orderMinMaxMoney.sportId = firstdetailList.sportId.toString();
    orderMinMaxMoney.marketId = firstdetailList.marketId;
    orderMinMaxMoney.deviceType = getDevice();// 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
    orderMinMaxMoney.matchId = firstdetailList.matchId;
    orderMinMaxMoney.oddsFinally = firstdetailList.oddFinally.toString();
    orderMinMaxMoney.oddsValue =firstdetailList.oddsValue.toString();
    orderMinMaxMoney.playId = firstdetailList.playId.toString();
    orderMinMaxMoney.playOptionId = firstdetailList.playOptionsId;
    orderMinMaxMoney.playOptions = firstdetailList.playOptions;
    orderMinMaxMoney.seriesType = BetSeriesType.single.code;// 串关类型 // 串关类型 1 单关 2串关
   // orderMinMaxMoney.matchProcessId = item.matchMmp;
    orderMinMaxMoney.scoreBenchmark = '';
    orderMinMaxMoney.tenantId = 1;//商户id
   // orderMinMaxMoney.tournamentLevel = item.tournamentLevel;
    orderMinMaxMoney.tournamentId = firstdetailList.tournamentId;
   // orderMinMaxMoney.dataSource = item.dataSource;
    orderMinMaxMoney.matchType = firstdetailList.matchType;

    req.orderMaxBetMoney = [orderMinMaxMoney];
    final res = await BetApi.instance().queryPreBetAmount(req);
    if (res.code == "0000000") {
      ///实时比分
      state.listData[index].detailList[0].RealTimeScore =res.data?.latestMarketInfo[0].currentMarket?.score ?? "";
      ///实时赔率
      int oddsValue = res.data?.latestMarketInfo[0].currentMarket?.marketOddsList[0].oddsValue ?? 0;
      double odds = oddsValue / 100000;
      state.listData[index].detailList[0].RealTimeOddsValue = odds;
    }
  }

  setBeforeUpDatePreBetOdds(int index) {
    ///当修改金额小于限额最小额度，修改金额变成最小额度
    var detailList = state.listData[index].detailList[0];
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
      state.listData[index].isChangeAmount.value = true;
      var toast = LocaleKeys.app_minimum_amount_of_bet.tr.replaceAll('{0}', orderLeastPay);
      BetsUtils.toastDialog(toast);
      return;
    }

    ///预约投注额（要乘以100，单位是分）
    var orderAmountTotal = (double.parse(detailList.modifyBetAmount.value) * 100).toInt();

    ///赔率如果走就近原则，先不请求更改赔率，先变跟赔率。
    if (BetsUtils.setChangesOdds(state.listData[index])) {
      state.listData[index].isChangeOdds.value = true;
      return;
    }

    ///是不是需要修改盘口，若需要传参不一样
    bool whetherRulesChanged = isWhetherRulesChanged(detailList.sportId,detailList.playId);

    String marketValue = detailList.marketValueChange.value;
    String oddsType = whetherRulesChanged ? detailList.playOptions : "";
    String playId =whetherRulesChanged? detailList.playId.toString():"";
    String playOptionName = whetherRulesChanged ? detailList.playOptionName : "";
    if (playOptionName.isNotEmpty && playOptionName.contains(" ")) {
      playOptionName = playOptionName.split(" ")[0] +"  " +marketValue;
    }
    String sportId =detailList.sportId.toString();

    ///锚点 4455需求屏蔽，预约注单修改盘口，暂时不上.......屏蔽就注释(打开556行，557行，注释掉559,560,561)
     String marketId = detailList.marketId;
     String playOptionsId = detailList.playOptionsId;
    ///这两个参数是接口获取，有就给接口数据，没有就“”；
   // List<String> marketIdPlayOptionsId = getMarketIdPlayOptionsId(state.listData[index], marketValue, oddsType);
   // String marketId = marketIdPlayOptionsId[0];
   // String playOptionsId = marketIdPlayOptionsId[1];

    ///赔率
    int odds = (double.parse(detailList.oddFinallyChange.value) * 100000).toInt();
    String marketType = detailList.marketType;

    ///当是香港盘的时候，更改赔率要加100000
    if (marketType == 'HK') {
      odds = odds + 100000;
    }

    ///发起修改金额和赔率请求
    upDatePreBetOdds(marketId, detailList.marketType, marketValue, odds, oddsType, state.listData[index].orderNo, orderAmountTotal, playId, playOptionName, playOptionsId, sportId, index,);
  }

  /**
   * 获取MarketId和PlayOptionsId
   * 两个参数是接口获取，有就给接口数据，没有就“”；
   */
  List<String> getMarketIdPlayOptionsId(GetH5PreBetOrderlistDataRecordxData dataList, String marketValue, String oddsType) {
    List<String> MarketIdPlayOptionsId = ["", ""];
    //看看是不是开启预约盘口功能，没有修改盘口，拿不到marketId和playOptionsId
    if (isWhetherRulesChanged(dataList.detailList[0].sportId, dataList.detailList[0].playId)) {
      QueryMarketInfoByMatchIdAndPlayIdData queryMarketInfoByMatchIdAndPlayIdData = dataList.queryMarketInfoByMatchIdAndPlayIdData;
      List<QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO> data = queryMarketInfoByMatchIdAndPlayIdData.queryMarketDetailVO;
      if (data.isNotEmpty) {
        for (QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVO element in data) {
          if (marketValue == element.marketValue) {
            ///获取marketId
            MarketIdPlayOptionsId[0] = element.id;
            List<QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList>marketOddsVOList = element.queryMarketOddsVOList;
            if (marketOddsVOList.isNotEmpty) {
              for (QueryMarketInfoByMatchIdAndPlayIdDataQueryMarketDetailVOQueryMarketOddsVOList elementlst in marketOddsVOList) {
                if (elementlst.oddsType == oddsType) {
                  ///获取playOptionsId
                  MarketIdPlayOptionsId[1] = elementlst.id;
                  break;
                }
              }
            }
          }
        }
      }
    }
    return MarketIdPlayOptionsId;
  }

  ///键盘折叠
  setKeyboardFolding(bool isOpen, int index) {
    var difference = 0.h;
    if (index == 0) {
      difference = isOpen ? 180.h : -180.h;
    } else {
      difference = isOpen ? 275.h : -275.h;
    }
    var offset = state.scrollController.offset + difference;
    state.scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 450), curve: Curves.easeInOut);
  }


  ///修改赔率请求
  upDatePreBetOdds(String marketId, String marketType, String marketValue, int odds, String oddsType, String orderNo, int orderAmountTotal, String playId, String playOptionName, String playOptionsId, String sportId, int index) async {
    final res = await BetApi.instance().updatePreBetOdds(marketId, marketType, marketValue, odds, oddsType, orderNo, orderAmountTotal, playId, playOptionName, playOptionsId, sportId);
    String toast = '';
    if (res.code == "0000000") {
      state.listData[index].isChangeAmount.value = false;
      state.listData[index].isChangeOdds.value = false;
      toast = LocaleKeys.app_edit_success.tr;

      ///更改成功再去请求列表数据
      TYUserController.to.getBalance();
      getH5PreBetOrderlist(indexs: index);

      ///锚点 4455需求屏蔽，预约注单修改盘口，暂时不上.......屏蔽就注释(637--666)
      // 当前时间的毫秒数
    /*  int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      String orderNo = state.listData[index].orderNo;
      List betListsHasModified = ListKV.betListsHasModified.get();

      // 检查 betListsHasModified 列表
      if (betListsHasModified.isEmpty) {
        // 如果列表为空，添加新的元素
        betListsHasModified.add(orderNo + "_" + currentTimestamp.toString());
      } else {
        bool found = false;

        for (String element in betListsHasModified) {
          // 拆分出 orderNo 和时间戳
          List<String> parts = element.split('_');
          String existingOrderNo = parts[0];

          // 判断是否以 orderNo 开头
          if (existingOrderNo == orderNo) {
            found = true;
            betListsHasModified[betListsHasModified.indexOf(element)] = orderNo + "_" + currentTimestamp.toString();
          }
        }

        // 如果没有找到相应的 orderNo，添加新的元素
        if (!found) {
          betListsHasModified.add(orderNo + "_" + currentTimestamp.toString());
        }
      }
      ///存起来
      ListKV.betListsHasModified.save(betListsHasModified);*/

      // } else if (res.code == "0401038") {
      //   toast = LocaleKeys.msg_msg_nodata_22.tr;
    } else {
      if (res.msg.isNotEmpty) {
        toast = res.msg;
      } else {
        toast = LocaleKeys.app_edit_fail.tr;
      }
    }
    BetsUtils.toastDialog(toast);
  }

  ///未结注单-预约中-取消预约
  cancelPreBetOrder(int index) async {
    int orderNo = int.parse(state.listData[index].orderNo);
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
        BetAmountReqOrderMaxBetMoney();
    GetH5PreBetOrderlistDataRecordxDataDetailList item =
        recordxData.detailList[0];
    orderMinMaxMoney.sportId = item.sportId.toString();
    orderMinMaxMoney.marketId = item.marketId;
    orderMinMaxMoney.deviceType =
        getDevice(); // 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
    orderMinMaxMoney.matchId = item.matchId;
    orderMinMaxMoney.oddsFinally = item.oddFinally;
    orderMinMaxMoney.oddsValue = item.oddsValue.toString();
    orderMinMaxMoney.playId = item.playId.toString();
    orderMinMaxMoney.playOptionId = item.playOptionsId;
    orderMinMaxMoney.playOptions = item.playOptions;
    orderMinMaxMoney.seriesType = 1; // 串关类型 // 串关类型 1 单关 2串关
    /// orderMinMaxMoney.matchProcessId = item.matchMmp;
    orderMinMaxMoney.scoreBenchmark = '';
    orderMinMaxMoney.tenantId = 1; //商户id
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
