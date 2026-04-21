import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/app_logger/app_logger.dart';
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../global/ty_user_controller.dart';
import '../../../global/ws/ws_app.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../services/models/res/user_info.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../../utils/toast_util.dart';
import '../../../utils/utils.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../../quick_bet/quick_bet_controller.dart';
import '../base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/services/models/req/bet_amount_req.dart';

import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_util.dart';

mixin SingleBetControllerMixinBetAmount on BaseBetController{
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 单关获取限额
      】】】
   *
   */
  @override
  Future queryBetAmount() async{
    BetAmountReq req = BetAmountReq();
    BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
    ShopCartItem item = itemList.first;
    orderMinMaxMoney.sportId = item.sportId;
    orderMinMaxMoney.marketId = item.marketId;
    orderMinMaxMoney.deviceType = getDevice();// 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
    orderMinMaxMoney.matchId = item.matchId;

    if(item.discountOdds >0){
      orderMinMaxMoney.oddsFinally = TYFormatOddsConversionMixin.computeValueByCurOddType(
          item.discountOdds,
          null,//TODO:马来赔和优惠赔率的互相影响？
          item.playId,
          item.oddsHsw.split(','),
          int.tryParse(item.sportId) ?? 0,
          item.cds
      ); //赔率
      orderMinMaxMoney.oddsValue = item.discountOdds.toString(); // 赔率 万位
      orderMinMaxMoney.excellentOddsBet = 1;
    }else
    {
      orderMinMaxMoney.oddsFinally = item.oddFinally.value;
      orderMinMaxMoney.oddsValue = item.odds.toString();
      orderMinMaxMoney.excellentOddsBet = 0;
    }
    orderMinMaxMoney.playId = item.playId;
    orderMinMaxMoney.playOptionId = item.playOptionsId;
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

    ApiRes<BetAmountEntity> res;
    try {
      res = await BetApi.instance().queryBetAmount(req);
    }catch(e){
      AppLogger.debug(e.toString());
      res = ApiRes<BetAmountEntity>();
    }
    if(res.success){
      dealBetAmountData(res.data?.betAmountInfo??[],res.data?.latestMarketInfo??[]);

      //计算 转换前限额：orderMaxPay*(oddsEU -1)
      // 只有马来赔负数会用到
      double oddsEU = (double.tryParse(orderMinMaxMoney.oddsValue)??0.0)/100000.0;
      BetAmountBetAmountInfo? betAmountInfo = res.data?.betAmountInfo.safeFirst;
      double orderMaxPay = double.tryParse(betAmountInfo?.orderMaxPay??"")??0.0;
      betAmountInfo?.orderMaxPayRestore = orderMaxPay * (oddsEU -1);
      latestMarketInfoList.safeFirst?.currentMarket?.marketOddsList.forEach((marketOdds){
        if(marketOdds.id == orderMinMaxMoney.playOptionId){
          oddsEU = marketOdds.oddsValue/100000.0;
          betAmountInfo?.orderMaxPayRestore = orderMaxPay * (oddsEU -1);
        }
      });

    }else{
      //设置default值
    }

  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 检查 余额是否足够、检查 输入是否符合限额
      】】】
   *
   */
  bool checkAmount(){
    //余额不足
    if(TYUserController.to.balanceAmount.value <= 0){
      ShopCartUtil.showBetError("0402035",prefixMsg: betStatus.value == ShopCartBetStatus.OneClickBetting?'${LocaleKeys.bet_bet_err.tr}!':null);
      return false;
    }

    // 请输入投注金额
    if(inputAmount.value <=0){
      ShopCartUtil.showBetError("M400005",prefixMsg: betStatus.value == ShopCartBetStatus.OneClickBetting?'${LocaleKeys.bet_bet_err.tr}!':null);
      return false;
    }

    // 有金额的情况下 判断限额
    if(inputAmount.value < (double.tryParse(minValue)??0)){
      if(betStatus.value == ShopCartBetStatus.OneClickBetting) {
        ShopCartUtil.showBetError("M400010",
            prefixMsg: betStatus.value == ShopCartBetStatus.OneClickBetting
                ? '${LocaleKeys.bet_bet_err.tr}!'
                : null);
      }else{
        String errMsg = LocaleKeys.bet_err_msg10.tr.replaceAll("{0}", minValue);
        ShopCartUtil.showBetError("",message: errMsg);
        replaceText(minValue);
      }
      return false;
    }
    if(inputAmount.value > (double.tryParse(maxValue)??0)){
      ShopCartUtil.showBetError("M400011");
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
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 检查是否可投注
      】】】
   *
   */
  bool checkBet(){
    for(ShopCartItem item in itemList){
      // 投注项状态 1：开 2：封 3：关 4：锁
      // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
      // 赛事级别盘口状态（0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘,11:锁盘状态）
      if(item.marketChange || item.olOs.value == 4 || item.hlHs.value==11 || item.midMhs.value==11){
        ShopCartUtil.showBetError("400004",prefixMsg: betStatus.value == ShopCartBetStatus.OneClickBetting?'${LocaleKeys.bet_bet_err.tr}!':null);
        return false;
      }

      if( [2,3].contains(item.olOs.value) || [2,1].contains(item.hlHs.value) || [2,1].contains(item.midMhs.value)){
        ShopCartUtil.showBetError("0402001",prefixMsg: betStatus.value == ShopCartBetStatus.OneClickBetting?'${LocaleKeys.bet_bet_err.tr}!':null);
        return false;
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
      - 单关投注
      】】】
   *
   */
  @override
  Future<bool> doBet({bool betAgain = false}) async{
    if(!checkAmount()) {
      return false;
    }

    ToastUtils.showLoading();
    await queryLatestMarketInfo();

    if(!checkBet()) {
      //checkBet中有toast显示错误，所以不必调用dismiss
      return false;
    }

    //投注前复位 hasUpdateRiskEvent
    hasUpdateRiskEvent = false;

    // 投注前获取最新的 投注信息 赔率 坑位 等
    // 投注已经准备好了 拿最新的数据 去投注

    // 获取当前币种
    String currency = TYUserController.to.currCurrency();
    if(currency == 'RMB') {
      // 人民币 使用CNY 不使用 RMB
      currency = "CNY";
    }

    BetReq betReq = BetReq();
    betReq.acceptOdds = TYUserController.to.userInfo.value?.userBetPrefer??BetAcceptOdds.acceptAll.code;          // 接受赔率变化情况
    betReq.tenantId = 1;
    betReq.deviceType = getDevice();        // 设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备
    betReq.currencyCode = currency; // 币种
    betReq.deviceImei = '';         // 设备imei码，只有手机有，没有不添加
    betReq.fpId = '';               // 指纹55555555id
    betReq.openMiltSingle = 0;      // 是否为多个单关 0:1个 1:多个
    betReq.preBet = 0;              // 1 预约  0 不预约
    betReq.timeZone = TimeZoneUtils.zoneIndex;
    if(TYUserController.to.isOneClickBet.value) {
      betReq.fastBet = "one_click_bet";
    }

    ShopCartItem item = itemList.first;
    // BetResultOrderDetailRespList? betResultOrderDetail;
    // if(betAgain){
    //   betResultOrderDetail = orderRespList.firstWhereOrNull((e)=>e.shopCartItemId == item.itemId);
    // }

    BetReqSeriesOrdersOrderDetailList orderDetail = BetReqSeriesOrdersOrderDetailList();
    orderDetail.shopCartItemId = item.itemId;
    orderDetail.handicapHv = item.handicapHv.value;
    orderDetail.sportId = item.sportId;                             // 赛种id
    orderDetail.matchId = item.matchId;                             // 赛事id
    orderDetail.tournamentId = item.tournamentId;                   // 联赛id
    orderDetail.betAmount = inputAmount.value.toStringAsFixed(2);   //投注金额
    orderDetail.placeNum = item.placeNum?.toString()??'';    //盘口坑位
    orderDetail.marketId = item.marketId;                           //盘口id
    orderDetail.playOptionsId = item.playOptionsId;                 // 投注项id
    orderDetail.marketTypeFinally = item.marketTypeFinally;         // 欧洲版默认是欧洲盘 HK代表香港盘
    orderDetail.marketValue = item.marketValue;
    if(item.discountOdds >0){
      orderDetail.odds = item.discountOdds; // 赔率 万位
      orderDetail.oddFinally = TYFormatOddsConversionMixin.computeValueByCurOddType(
          item.discountOdds,
          null,//TODO:马来赔和优惠赔率的互相影响？
          item.playId,
          item.oddsHsw.split(','),
          int.tryParse(item.sportId) ?? 0,
          item.cds
      ); //赔率
      orderDetail.excellentOddsBet = 1;
      orderDetail.orgOddFinally = item.oddFinally.value;//原始赔率
    }else
    {
      orderDetail.odds = item.odds; // 赔率 万位
      orderDetail.oddFinally = item.oddFinally.value; //赔率
      orderDetail.excellentOddsBet = 0;
    }
    orderDetail.playOptionName = item.playOptionName; // 投注项名称
    orderDetail.playName = item.playName;                           //玩法名称
    orderDetail.sportName = item.sportName;                         // 球种名称
    orderDetail.matchType = item.matchType;                         // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
    orderDetail.matchName = item.matchName;                         //赛事名称
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
      betStatus.value = ShopCartBetStatus.Betting;
      setOrderDetailRespList(res.data,betReq);
      QuickBetController.to.push(res.data?.orderDetailRespList ?? [], itemList);

      // 订单状态 0:投注失败 1: 投注成功 2: 订单确认中
      if(orderRespList.safeFirst?.orderStatusCode == 1){
        betStatus.value = ShopCartBetStatus.Success;
        // 判断是否有水差
        if((orderRespList.safeFirst?.oddsChange??0) >0 ){
          //发送C118订阅
          AppWebSocket.instance().skt_send_bat_handicap_odds_c118();
          Bus.getInstance().emit(
            EventType.send_bat_handicap_odds,
          );
        }
      }else if(orderRespList.safeFirst?.orderStatusCode == 0){
        betStatus.value = ShopCartBetStatus.Invalid; //Vue中使用 status = 5 (投注项失效)
      }

      // if(betStatus.value == ShopCartBetStatus.Betting) {
      //   orderCheck();
      // }
      TYUserController.to.getBalance();
      return true;
    }else{
      ToastUtils.showGrayBackground(res.msg ?? res.code ?? 'Error');
      return false;
    }
  }

  bool canChampionPreBet(){
    UserInfo? userInfo = TYUserController.to.userInfo.value;
    return //商户预约投注总开关
      userInfo?.configVO?.bookBet == 1
          //预约冠军系统总开关
          && userInfo?.champResSwitch == "1"
          //商户预约冠军投注开关
          && userInfo?.paramConfigs?["merchantChampResSwitch"] == "1";
  }
}