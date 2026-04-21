
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/req/bet_req.dart';
import '../../../services/models/req/latest_market_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../services/models/res/last_market_entity.dart';
import '../../../utils/utils.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';

class BetService {

  Future<ApiRes<BetAmountEntity>> queryBetAmount(
      List<ShopCartItem> itemList,
      {bool isComboCourageBetController = false}
      ){
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
      orderMinMaxMoney.seriesType = isComboCourageBetController?100:(itemList.length>1? 2:1); // 串关类型 1 单关 2串关
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
    return BetApi.instance().queryBetAmount(
        req
    );
  }

  Future<ApiRes<List<BetAmountBetAmountInfo>>> queryMarketMaxMinBetMoney(
      List<ShopCartItem> itemList
  ){
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
    return BetApi.instance().queryMarketMaxMinBetMoney(
        req
    );
  }

  Future<ApiRes<List<LastMarketEntity>>> queryLatestMarketInfo(
      List<ShopCartItem> itemList){
    List<LatestMarketReqIdList> betMarketList = [];
    itemList.forEach((element) {
      if(element.betType == OddsBetType.common || element.betType == OddsBetType.guanjun) {
        LatestMarketReqIdList latestMarketReqId = LatestMarketReqIdList();
        latestMarketReqId.chpid = element.cplayId;
        latestMarketReqId.marketId = element.marketId;
        latestMarketReqId.matchInfoId = element.matchId;
        latestMarketReqId.oddsId = element.playOptionsId;
        latestMarketReqId.oddsType = element.playOptions;
        latestMarketReqId.playId = element.playId;
        latestMarketReqId.placeNum = element.placeNum;
        latestMarketReqId.matchType = element.matchType;
        latestMarketReqId.sportId = element.sportId;

        betMarketList.add(latestMarketReqId);
      }
    });

    // if(betMarketList.isEmpty){
    //   return;
    // }

    LatestMarketReq req = LatestMarketReq();
    req.idList = betMarketList;
    req.deviceType = getDevice();

    // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
    // if ([ 4, 5].contains(req.idList.safeFirst?.matchType)) {
    //   return;
    // }
    return BetApi.instance().queryLatestMarketInfo(
        req
    );
  }

  Future<ApiRes<BetAmountEntity>> queryPreBetAmount(
      List<ShopCartItem> itemList,
      String preMarketId,
      String oddsText,
      double prebookOdd,
      String prePlayoptionsId
      ){
    int oddsValue = (prebookOdd * 100000 + 0.001).floor();
    BetAmountReq req = BetAmountReq();
    BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
    ShopCartItem item = itemList.first;
    orderMinMaxMoney.sportId = item.sportId;
    orderMinMaxMoney.marketId = preMarketId.isNotEmpty?preMarketId:item.marketId;
    orderMinMaxMoney.deviceType = getDevice();// 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
    orderMinMaxMoney.matchId = item.matchId;
    orderMinMaxMoney.oddsFinally = oddsText;
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
    return BetApi.instance().queryPreBetAmount(
        req
    );
  }

  Future<ApiRes<BetResultEntity>> bet(
      BetReq betReq){
    return BetApi.instance().bet(
        betReq
    );
  }


}