import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../utils/utils.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../combo_courage_bet/combo_courage_bet_controller.dart';
import '../model/shop_cart_item.dart';
import 'base_bet_controller_mixin.dart';

//81560需求，要求回退后未正式上线
mixin BaseBetControllerMixinBetAmount on BaseBetControllerMixin{
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 统一的获取限额，包括电竞的限额
      - 获取限额的同时获取最新赔率
      】】】
   *
   */
  Future<void> queryBetAmountAndMarket({String type = 'submit_bet'}) async {
    if (itemCount == 0){
      return;
    }

    BetAmountReq req = BetAmountReq();
    //TODO: queryLatestMarketInfo 有判断 if(element.betType == OddsBetType.common) {
    for(ShopCartItem item in itemList) {
      //if(item.isColsed || item.isOddChanging) continue;
      BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
      orderMinMaxMoney.sportId = item.sportId;
      orderMinMaxMoney.chpid = item.cplayId;
      orderMinMaxMoney.marketId = item.marketId;
      orderMinMaxMoney.deviceType =  getDevice(); // 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
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
      }else {
        orderMinMaxMoney.oddsFinally = item.oddFinally.value;
        orderMinMaxMoney.oddsValue = item.odds.toString();
        orderMinMaxMoney.excellentOddsBet = 0;
      }
      orderMinMaxMoney.playId = item.playId;
      orderMinMaxMoney.playOptionId = item.playOptionsId;
      orderMinMaxMoney.playOptions = item.playOptions;
      orderMinMaxMoney.placeNum = item.placeNum;
      orderMinMaxMoney.seriesType = this is ComboCourageBetController?100:(itemCount>1? 2:1); // 串关类型 1 单关 2串关
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
      // 处理 betAmountInfo
      dealBetAmountData(res.data?.betAmountInfo??[],res.data?.latestMarketInfo??[]);

      // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
      if (! [3].contains(req.orderMaxBetMoney.safeFirst?.matchType)) {
        // 处理 latestMarketInfo
        dealLastMarketInfo(type,res.data?.latestMarketInfo??[]);
      }


    }else{
      //设置default值
      AppLogger.debug(res.msg??res.code??'queryBetAmount error');
    }
  }

}