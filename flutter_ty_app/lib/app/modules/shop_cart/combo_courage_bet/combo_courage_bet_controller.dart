
import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../global/config_controller.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/req/bet_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../../utils/toast_util.dart';
import '../../../utils/utils.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../single_bet/single_bet_controller.dart';

class ComboCourageBetController extends SingleBetController {

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最小值
      从接口返回数据BetAmountBetAmountInfo中获取
      负数赔率需做限额转换
      】】】
   *
   */
  @override
  String get minValue{
    if(isOddsTooLow()){
      return "0.00";
    }else{
      return super.minValue;
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 最大值
      从接口返回数据BetAmountBetAmountInfo中获取
      负数赔率需做限额转换
      】】】
   *
   */
  @override
  String get maxValue{
    if(isOddsTooLow()){
      return "0.00";
    }else{
      return super.maxValue;
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 是否处于不可投注状态： 判断赔率是否低于赔率下限
      】】】
   *
   */
  @override
  bool get isSpecialState{
    if(isOddsTooLow()){
      return true;
    }else{
      return super.isSpecialState;
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 不可投注原因  投注项组合赔率过低
      】】】
   *
   */
  @override
  String get specialStateReason {
    if(isOddsTooLow()){
      return LocaleKeys.bet_bet_odds_too_low.tr;
    }else{
      return super.specialStateReason;
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 显示投注框
      】】】
   *
   */
  @override
  void showBet({queryAmount=false}) {
    super.showBet(queryAmount:false);

    if(queryAmount){
      queryBetAmount().then((value){
        if(isOddsTooLow()){
          ToastUtils.showGrayBackground(LocaleKeys.bet_bet_odds_too_low.tr);
        }
      });
    }
  }

  bool isOddsTooLow() {
    String boldRate = ConfigController.to.accessConfig.value.boldRate;
    String oddFinally = itemList.safeFirst?.oddFinally.value??"";
    if(oddFinally.isNotEmpty && (double.tryParse(oddFinally)??0) < (double.tryParse(boldRate)??0)){
      return true;
    }else{
      return false;
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 增加投注项
      只增加相同玩法的投注项
      添加之后判断投注项状态
      】】】
   *
   */
  @override
  void addShopCartItem(ShopCartItem item){
    ShopCartItem? firstItem = itemList.safeFirst;
    if(firstItem!=null && firstItem.playId!= item.playId){
      itemList.clear();
    }
    //super.super.addShopCartItem(item);
    itemList.add(item);
    ShopCartController.to.subscribeMarket();
    betStatus.value = ShopCartBetStatus.Normal;
    Bus.getInstance().emit(EventType.oddsButtonUpdate);

    if(itemCount>=3){
      itemList.first.oddFinally.value = "";
      queryLatestMarketInfo();
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 删除投注项
      发送投注项选中刷新事件
      】】】
   *
   */
  void delShopCartItem(ShopCartItem item) {
    super.delShopCartItem(item);

    if(itemCount>=3){
      itemList.first.oddFinally.value = "";
      queryLatestMarketInfo();
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 关闭投注框
      】】】
   *
   */
  @override
  void closeBet(){
    if(betStatus.value != ShopCartBetStatus.Normal){
      clearData();
    }

    //BaseBetController.closeBet
    state.showShopCart.value = false;
    Bus.getInstance().emit(EventType.tyCloseDialog);
  }



  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 自选波胆投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 自选波胆获取限额
      】】】
   *
   */

  @override
  Future<void> queryBetAmount() async {
    BetAmountReq req = BetAmountReq();
    for(ShopCartItem item in itemList) {
      BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
      orderMinMaxMoney.sportId = item.sportId;
      orderMinMaxMoney.marketId = item.marketId;
      orderMinMaxMoney.deviceType =
          getDevice(); // 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
      orderMinMaxMoney.matchId = item.matchId;

      if (item.discountOdds > 0) {
        orderMinMaxMoney.oddsFinally =
            TYFormatOddsConversionMixin.computeValueByCurOddType(
                item.discountOdds,
                null, //TODO:马来赔和优惠赔率的互相影响？
                item.playId,
                item.oddsHsw.split(','),
                int.tryParse(item.sportId) ?? 0,
                item.cds
            ); //赔率
        orderMinMaxMoney.oddsValue = item.discountOdds.toString(); // 赔率 万位
        orderMinMaxMoney.excellentOddsBet = 1;
      } else {
        orderMinMaxMoney.oddsFinally = item.oddFinally.value;
        orderMinMaxMoney.oddsValue = item.odds.toString();
        orderMinMaxMoney.excellentOddsBet = 0;
      }
      orderMinMaxMoney.playId = item.playId;
      orderMinMaxMoney.playOptionId = item.playOptionsId;
      orderMinMaxMoney.playOptions = item.playOptions;
      orderMinMaxMoney.seriesType = BetSeriesType.combo.code; // 串关类型 // 串关类型 1 单关 2串关   100 自选波胆
      orderMinMaxMoney.matchProcessId = item.matchMmp;
      orderMinMaxMoney.scoreBenchmark = '';
      orderMinMaxMoney.tenantId = 1; //商户id
      orderMinMaxMoney.tournamentLevel = item.tournamentLevel;
      orderMinMaxMoney.tournamentId = item.tournamentId;
      orderMinMaxMoney.dataSource = item.dataSource;
      orderMinMaxMoney.matchType = item.matchType;
      // 冠军没有赛事阶段
      if (item.betType == OddsBetType.guanjun) {
        orderMinMaxMoney.matchProcessId = null;
      }
      req.orderMaxBetMoney.add(orderMinMaxMoney);
    }
    ApiRes<BetAmountEntity> res;
    try {
      res = await BetApi.instance().queryBetAmount(req);
    }catch(e){
      AppLogger.debug(e.toString());
      res = ApiRes<BetAmountEntity>();
    }
    if(res.success){
      latestMarketInfoList = res.data?.latestMarketInfo??[];

      betMinMaxMoney.clear();
      res.data?.betAmountInfo.forEach((element) {
        betMinMaxMoney[element.playOptionsId] = element;
      });
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
      【【【 AUTO_PARAGRAPH_TITLE 单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 自选波胆投注
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

    // BetResultOrderDetailRespList? betResultOrderDetail;
    // if(betAgain){
    //   betResultOrderDetail = orderRespList.firstWhereOrNull((e)=>e.shopCartItemId == item.itemId);
    // }
    BetReqSeriesOrders betReqSeriesOrders = BetReqSeriesOrders();
    betReqSeriesOrders.seriesSum = 1;
    betReqSeriesOrders.seriesType = BetSeriesType.combo.code;
    betReqSeriesOrders.fullBet = 0;
    //betReqSeriesOrders.seriesValues = "单关";

    for(ShopCartItem item in itemList) {
      BetReqSeriesOrdersOrderDetailList orderDetail = BetReqSeriesOrdersOrderDetailList();
      orderDetail.shopCartItemId = item.itemId;
      orderDetail.handicapHv = item.handicapHv.value;
      orderDetail.sportId = item.sportId; // 赛种id
      orderDetail.matchId = item.matchId; // 赛事id
      orderDetail.tournamentId = item.tournamentId; // 联赛id
      orderDetail.betAmount = inputAmount.value.toStringAsFixed(2); //投注金额
      orderDetail.placeNum = item.placeNum?.toString() ?? ''; //盘口坑位
      orderDetail.marketId = item.marketId; //盘口id
      orderDetail.playOptionsId = item.playOptionsId; // 投注项id
      orderDetail.marketTypeFinally =
          item.marketTypeFinally; // 欧洲版默认是欧洲盘 HK代表香港盘
      orderDetail.marketValue = item.marketValue;
      if (item.discountOdds > 0) {
        orderDetail.odds = item.discountOdds; // 赔率 万位
        orderDetail.oddFinally =
            TYFormatOddsConversionMixin.computeValueByCurOddType(
                item.discountOdds,
                null, //TODO:马来赔和优惠赔率的互相影响？
                item.playId,
                item.oddsHsw.split(','),
                int.tryParse(item.sportId) ?? 0,
                item.cds
            ); //赔率
        orderDetail.excellentOddsBet = 1;
        orderDetail.orgOddFinally = item.oddFinally.value;//原始赔率
      } else {
        orderDetail.odds = item.odds; // 赔率 万位
        orderDetail.oddFinally = item.oddFinally.value; //赔率
        orderDetail.excellentOddsBet = 0;
      }
      orderDetail.playOptionName = item.playOptionName; // 投注项名称
      orderDetail.playName = item.playName; //玩法名称
      orderDetail.sportName = item.sportName; // 球种名称
      orderDetail.matchType =
          item.matchType; // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
      orderDetail.matchName = item.matchName; //赛事名称
      orderDetail.playOptions = item.playOptions; // 投注项配置项
      orderDetail.tournamentLevel = item.tournamentLevel; // 联赛级别
      orderDetail.playId = item.playId; // 玩法id
      orderDetail.dataSource = item.dataSource; // 数据源

      // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
      if (!TYUserController.to.isCurDdds(item.oddsHsw)) {
        orderDetail.marketTypeFinally = 'EU';
      }

      betReqSeriesOrders.orderDetailList.add(orderDetail);
    }
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
      seriesOrderRespList.clear();
      seriesOrderRespList.addAll(res.data?.seriesOrderRespList??[]);

      //<!-- 订单状态 0:投注失败 1: 投注成功 2: 订单确认中 -->
      if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0 && element.orderStatusCode != 1)==null){
        if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0)==null){
          betStatus.value = ShopCartBetStatus.Failure;
        }else{
          betStatus.value = ShopCartBetStatus.Success;
        }
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
}
