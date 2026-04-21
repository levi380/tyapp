
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../mix_bet/mix_bet_controller.dart';
import '../../../utils/utils.dart';
import '../model/bet_count_model.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞串关投注控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞串关投注控制类
      继承自串关投注控制类
      电竞限额获取、单串关切换和串关投注控制类有所不同
    】】】
 *
 */
class EsportMixBetController extends MixBetController{
  @override
  void onInit() {
    super.onInit();
    maxBetCount = 66;
  }
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 电竞串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 切换到单关投注模式
      】】】
   *
   */
  @override
  Future<void> goSingle() async {
    clearData();
    ShopCartController.to.isEsportParlay.value = false;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 电竞串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 显示投注框
      】】】
   *
   */
  @override
  void showBet({queryAmount=false}) {
    if(itemCount >=6){
      ToastUtils.show(LocaleKeys.bet_message_bet_is_esports.tr);
    }
    super.showBet(queryAmount: queryAmount);
  }


  /*
  判断投注项状态
   */
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 判断投注项状态
      新加入的投注项金额置空，删除投注项导致当前输入消失的，关闭键盘
      重新获取限额
      】】】
   *
   */
  void getBetSpecialSeries({bool newAdd=false}){
    super.getBetSpecialSeries(newAdd:newAdd);


    //输入金额置空
    for (int i = 0; i < betSpecialSeries.length; i++) {
      TextEditingController element = amountControllerList[i];
      element.text = '';
    }

    //删除大于66的项目
    betSpecialSeries.removeWhere((e)=>e.count>maxBetCount || e.id == '60057');
  }

  int get inputBetCount{
    int betCount = 0;
    for(int i=0;i<betSpecialSeries.length;i++){
      if(inputAmountList[i].value > 0) {
        BetCountModel betCountModel = betSpecialSeries[i];
        betCount += betCountModel.count;
      }
    }
    return betCount;
  }
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 电竞串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 电竞串关获取限额
      】】】
   *
   */

  @override
  Future queryBetAmount() async {
    if (itemCount < minSeriesNum){
      betSpecialSeries.clear();
      return;
    }

    BetAmountReq req = BetAmountReq();
    for(ShopCartItem item in itemList) {
      //if(item.isColsed || item.isOddChanging) continue;
      BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
      orderMinMaxMoney.sportId = item.sportId;
      orderMinMaxMoney.marketId = item.marketId;
      orderMinMaxMoney.deviceType = getDevice();// 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
      orderMinMaxMoney.matchId = item.matchId;
      if(item.discountOdds >0){
        orderMinMaxMoney.oddsFinally = TYFormatOddsConversionMixin.computeValueByCurOddType(
            item.discountOdds,
            null,
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
      orderMinMaxMoney.seriesType = 2; // 串关类型 1 单关 2串关
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

    ApiRes<List<BetAmountBetAmountInfo>> res;
    try{
      res = await BetApi.instance().queryMarketMaxMinBetMoney(req);
    }catch(e){
      AppLogger.debug(e.toString());
      res = ApiRes<List<BetAmountBetAmountInfo>>();
    }
    if(res.success){
      betSpecialSeries.forEach((element) {
        BetAmountBetAmountInfo? betAmountInfo = res.data?.firstWhereOrNull((info) => info.type == element.id);
        element.betAmountInfo.value = betAmountInfo;
      });
    }else{
      //设置default值
    }
    update(['input','input_total']);
  }


}