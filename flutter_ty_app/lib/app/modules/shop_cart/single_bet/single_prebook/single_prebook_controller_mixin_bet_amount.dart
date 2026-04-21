import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../config/app_logger/app_logger.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../../services/api/bet_api.dart';
import '../../../../services/models/req/bet_amount_req.dart';
import '../../../../services/models/req/bet_req.dart';
import '../../../../services/models/res/api_res.dart';
import '../../../../services/models/res/bet_amount_entity.dart';
import '../../../../services/models/res/bet_result_entity.dart';
import '../../../../services/models/res/last_market_entity.dart';
import '../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../utils/toast_util.dart';
import '../../../../utils/utils.dart';
import '../../../match_detail/models/odds_button_enum.dart';
import '../../model/shop_cart_item.dart';
import '../../model/shop_cart_type.dart';
import '../../shop_cart_history.dart';
import '../../shop_cart_util.dart';
import '../single_bet_controller.dart';

mixin SinglePrebookBetControllerMixinBetAmount on SingleBetController{
  final prebookOdd = 0.0.obs;
  final preHandicap = "".obs;
  String prePlayoptionsId = "";
  String preMarketId = "";
  String preOddFinally = "";//当前赔率，可预约最小值

  int maxOdd = 355;

  late TextEditingController prebookAmountController;
  late FocusNode prebookFocusNode;
  late TextEditingController oddsController;
  late FocusNode oddsFocusNode;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注最小值
      】】】
   *
   */
  String get minValueAmount {
    BetAmountBetAmountInfo? betAmountInfo = betMinMaxMoney[prePlayoptionsId];
    if(betAmountInfo == null){
      betAmountInfo = betMinMaxMoney.values.firstOrNull;
    }
    if(betAmountInfo!=null){
        return betAmountInfo.minBet;
    }
    return super.minValue;

  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注最大值
      】】】
   *
   */
  String get maxValueAmount {
    BetAmountBetAmountInfo? betAmountInfo = betMinMaxMoney[prePlayoptionsId];
    if(betAmountInfo == null){
      betAmountInfo = betMinMaxMoney.values.firstOrNull;
    }
    if(betAmountInfo!=null){
      return betAmountInfo.orderMaxPay;
    }
    return super.maxValue;
  }
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 预约投注获取限额
      】】】
   *
   */

  @override
  Future queryBetAmount() async{
    int oddsValue = (prebookOdd.value * 100000 + 0.001).floor();
    if(oddsController.text.isEmpty || oddsValue == 0){
      return;
    }
    BetAmountReq req = BetAmountReq();
    BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
    ShopCartItem item = itemList.first;
    orderMinMaxMoney.sportId = item.sportId;
    orderMinMaxMoney.marketId = preMarketId.isNotEmpty?preMarketId:item.marketId;
    orderMinMaxMoney.deviceType = getDevice();// 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
    orderMinMaxMoney.matchId = item.matchId;
    orderMinMaxMoney.oddsFinally = oddsController.text;
    orderMinMaxMoney.oddsValue = oddsValue.toString();
    orderMinMaxMoney.playId = item.playId;
    orderMinMaxMoney.playOptionId = prePlayoptionsId.isNotEmpty?prePlayoptionsId:item.playOptionsId;
    orderMinMaxMoney.playOptions = item.playOptions;
    orderMinMaxMoney.seriesType = BetSeriesType.single.code;// 串关类型 // 串关类型 1 单关 2串关
    orderMinMaxMoney.matchProcessId = item.matchMmp;
    orderMinMaxMoney.scoreBenchmark = '';
    orderMinMaxMoney.tenantId = 1;//商户id
    orderMinMaxMoney.tournamentLevel = item.tournamentLevel;
    orderMinMaxMoney.tournamentId = item.tournamentId;
    orderMinMaxMoney.dataSource = item.dataSource;
    orderMinMaxMoney.matchType = item.matchType;
    // 冠军没有赛事阶段
    if(item.betType == OddsBetType.guanjun){
      orderMinMaxMoney.matchProcessId = null;
    }
    req.orderMaxBetMoney = [orderMinMaxMoney];

    final res = await BetApi.instance().queryPreBetAmount(req);
    if(res.success){
      latestMarketInfoList = res.data?.latestMarketInfo??[];

      betMinMaxMoney.clear();
      res.data?.betAmountInfo.forEach((element) {
        betMinMaxMoney[element.playOptionsId] = element;
      });

      if((double.tryParse(maxValueAmount)??0) < inputAmount.value){
        prebookAmountController.text = maxValueAmount;
        ShopCartUtil.showBetError("",message: LocaleKeys.bet_message_limit_change.tr);
      }

    }else{
      //设置default值
    }
    update(['input']);
  }


  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 对比赔率，判断是否是预约投注 返回false走正常投注
      】】】
   *
   */
  bool preBetComparison(){
    List<LastMarketCurrentMarket> marketList = latestMarketInfoList.safeFirst?.marketList??[];
    ShopCartItem shopCartItem = itemList.first;
    int prebookOddValue = (prebookOdd.value*100000 + 0.001).floor();
    if(shopCartItem.marketTypeFinally == 'HK') //&& UserController.to.isCurDdds(item.oddsHsw) ) 此处修改了Vue得逻辑，当前是港赔都加1
        {
      prebookOddValue = prebookOddValue + 100000;
    }
    // 判断有没有 直接投注的盘口和投注项
    for(LastMarketCurrentMarket market in marketList){
      //if(market.marketValue == shopCartItem.marketValue){
      if(market.marketValue == preHandicap.value){
        for(var odds in market.marketOddsList){
          if(odds.oddsValue == prebookOddValue){
            return false;
          }
        }
      }
    }

    return true;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 检查 输入是否符合限额
      】】】
   *
   */
  bool checkAmount(){
    final currentController = amountController;
    amountController = prebookAmountController;
    if(!super.checkAmount()){
      amountController = currentController;
      return false;
    }
    amountController = currentController;
    if(preOddFinally.isNotEmpty && prebookOdd.value < (double.tryParse(preOddFinally)??0.0)){
      oddsController.text = itemList.first.oddFinally.value;
      ShopCartUtil.showBetError("",message: LocaleKeys.bet_bet_min_booked_odds.tr);
      return false;
    }else if(prebookOdd.value > maxOdd){
      ShopCartUtil.showBetError("",message: LocaleKeys.bet_bet_max_booked_odds.tr);
      return false;
    }
    return true;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 预约投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 预约投注
      】】】
   *
   */
  @override
  Future<bool> doBet({bool betAgain = false}) async{
    if(!checkAmount()) {
      return false;
    }

    //Vue中，预约投注未走queryLatestMarketInfo

    ToastUtils.showLoading();
    await queryLatestMarketInfo();

    if(!preBetComparison()){
      dismissAllToast();
      // 取消 预约投注
      return super.doBet();
    }

    if(!checkBet()) {
      return false;
    }

    //投注前复位 hasUpdateRiskEvent
    hasUpdateRiskEvent = false;

    // 获取当前币种
    String currency = TYUserController.to.currCurrency();
    if(currency == 'RMB') {
      // 人民币 使用CNY 不使用 RMB
      currency = "CNY";
    }

    BetReq betReq = BetReq();
    betReq.acceptOdds = TYUserController.to.userInfo.value?.userBetPrefer??BetAcceptOdds.acceptAll.code;          // 接受赔率变化情况
    betReq.tenantId = 1;
    betReq.deviceType = getDevice();         // 设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备
    betReq.currencyCode = currency; // 币种
    betReq.deviceImei = '';         // 设备imei码，只有手机有，没有不添加
    betReq.fpId = '';               // 指纹55555555id
    betReq.openMiltSingle = 0;      // 是否为多个单关 0:1个 1:多个
    betReq.preBet = 1;              // 1 预约  0 不预约
    betReq.timeZone = TimeZoneUtils.zoneIndex;

    ShopCartItem item = itemList.first;
    String playOptionName = item.playOptionName;
    if(item.handicap.isNotEmpty){
      //playOptionName = '${item.handicap} ${item.marketValue}';
      //因为现在不预约盘口值，所以直接使用handicapHv。marketValue中缺少+号。placeNum也直接使用原来得
      //playOptionName = '${item.handicap} ${item.handicapHv.value}';
      playOptionName = '${item.handicap} ${preHandicap.value}';
      playOptionName = playOptionName.trim();
    }
    int preOdds = (prebookOdd.value*100000 + 0.001).floor();
    // 支持港赔 并且是港赔
    if(item.marketTypeFinally == 'HK') //&& UserController.to.isCurDdds(item.oddsHsw) ) 此处修改了Vue得逻辑，当前是港赔都加1
        {
      preOdds = preOdds + 100000;
    }

    BetReqSeriesOrdersOrderDetailList orderDetail = BetReqSeriesOrdersOrderDetailList();
    orderDetail.shopCartItemId = item.itemId;
    //orderDetail.handicapHv = item.handicapHv.value;
    orderDetail.handicapHv = preHandicap.value;
    orderDetail.sportId = item.sportId;                             // 赛种id
    orderDetail.matchId = item.matchId;                             // 赛事id
    orderDetail.tournamentId = item.tournamentId;                   // 联赛id
    orderDetail.betAmount = inputAmount.value.toStringAsFixed(2);   //投注金额
    orderDetail.placeNum = item.placeNum?.toString()??'';    //盘口坑位
    orderDetail.marketId = preMarketId;                           //盘口id
    orderDetail.playOptionsId = prePlayoptionsId;                 // 投注项id
    orderDetail.marketTypeFinally = item.marketTypeFinally;         // 欧洲版默认是欧洲盘 HK代表香港盘
    //if(ShopCartUtil.isDiffrentMarket(item)){
    //  orderDetail.marketValue = item.preMarketValue.isNotEmpty?item.preMarketValue:item.marketValue;
    if(item.marketValue != preHandicap.value){
      orderDetail.marketValue = preHandicap.value;
    }else {
      orderDetail.marketValue = item.marketValue;
    }
    orderDetail.odds = preOdds;                                     // 赔率 万位
    orderDetail.oddFinally = prebookOdd.value.toStringAsFixed(2);   //赔率
    orderDetail.playName = item.playName;                           //玩法名称
    orderDetail.sportName = item.sportName;                         // 球种名称
    orderDetail.matchType = item.matchType;                         // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
    orderDetail.matchName = item.matchName;                         //赛事名称
    orderDetail.playOptionName = playOptionName;                    // 投注项名称
    orderDetail.playOptions = item.playOptions;                     // 投注项配置项
    orderDetail.tournamentLevel = item.tournamentLevel;             // 联赛级别
    orderDetail.playId = item.playId;                               // 玩法id
    orderDetail.dataSource = item.dataSource;                       // 数据源

    // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
    if(!TYUserController.to.isCurDdds(item.oddsHsw)){
      orderDetail.marketTypeFinally = 'EU';
    }

    BetReqSeriesOrders betReqSeriesOrders = BetReqSeriesOrders();
    betReqSeriesOrders.seriesSum = 1;
    betReqSeriesOrders.seriesType = BetSeriesType.single.code;
    betReqSeriesOrders.fullBet = 0;
    betReqSeriesOrders.seriesValues = "单关";
    betReqSeriesOrders.orderDetailList = [orderDetail];

    betReq.seriesOrders = [betReqSeriesOrders];

    ApiRes<BetResultEntity> res;
    try {
      res = await BetApi.instance().bet(betReq);
      dismissAllToast();
    }on DioException catch(dioException){
      AppLogger.debug(dioException.toString());
      if(dioException.type == DioExceptionType.sendTimeout
          || dioException.type == DioExceptionType.receiveTimeout){
        ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg13.tr);
      }else{
        ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg02.tr);
      }
      return false;
    }catch(e){
      AppLogger.debug(e.toString());
      ToastUtils.showGrayBackground(LocaleKeys.bet_msg02.tr);
      return false;
    }

    if(res.success){
      betStatus.value = ShopCartBetStatus.Prebooking;
      setOrderDetailRespList(res.data,betReq);
      if(orderRespList.safeFirst?.preOrderDetailStatus == 0 ){
        betStatus.value = ShopCartBetStatus.PrebookSuccess;//预约状态 0:预约中 1: 预约成功 2: 预约取消  此处Vue代码与注释不符
      }else if(orderRespList.safeFirst?.preOrderDetailStatus == 1){
        betStatus.value = ShopCartBetStatus.PrebookSuccess;
      }else if(orderRespList.safeFirst?.preOrderDetailStatus == 2){
        betStatus.value = ShopCartBetStatus.PrebookCancel;
      }

      // if(betStatus.value == ShopCartBetStatus.Prebooking) {
      //   orderCheck();
      // }
      ShopCartHistory().removeHistoryRecord(item);
      TYUserController.to.getBalance();

      return true;
    }else{
      ToastUtils.showGrayBackground(res.msg??res.code??'Error');
      return false;
    }

  }
}