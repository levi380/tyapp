import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../utils/utils.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../model/shop_cart_item.dart';
import '../shop_cart_controller.dart';
import '../single_bet/single_bet_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞单关投注控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞单关投注控制类
      继承自单关投注控制类
      电竞限额获取、单串关切换和单关投注控制类有所不同
    】】】
 *
 */
class EsportSingleBetController extends SingleBetController{
  @override
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 电竞单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 切换到串关模式，并且把当前ShopCartItem加入
      】】】
   *
   */
  Future<void> goParlay() async {
    ShopCartItem item = itemList.first;
    closeBet();
    ShopCartController.to.isEsportParlay.value = true;
    ShopCartController.to.currentBetController?.addShopCartItem(item);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 电竞单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 电竞单关获取限额
      】】】
   *
   */

  @override
  Future queryBetAmount() async{
    BetAmountReq req = BetAmountReq();
    ///多个地方一样模型赋值
    /// 限额模型直接可以定一个BetAmountReqOrderMaxBetMoney init方法 建议直接初始化赋值 在属性里面备注
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
    orderMinMaxMoney.seriesType = 1;// 串关类型 // 串关类型 1 单关 2串关
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

    ApiRes<List<BetAmountBetAmountInfo>> res;
    try{
      res = await BetApi.instance().queryMarketMaxMinBetMoney(req);
    }catch(e){
      AppLogger.debug(e.toString());
      res = ApiRes<List<BetAmountBetAmountInfo>>();
    }
    if(res.success){
      betMinMaxMoney.clear();
      res.data?.forEach((element) {
        betMinMaxMoney[element.playOptionsId] = element;
      });
    }else{
      //设置default值
    }
    update(['input']);
  }


}