import 'dart:core';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_util.dart';

import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../global/data_store_controller.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/latest_market_req.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../services/models/res/last_market_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/utils.dart';
import '../combo_courage_bet/combo_courage_bet_controller.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';

//queryLatestMarketInfo较大，从BaseBetController中拆分。因为要用到变量，所用用mixin
mixin BaseBetControllerMixin on GetxController
{
  final RxList<ShopCartItem> itemList = RxList.empty(growable: true);

  int get itemCount => itemList.length;

  Rx<ShopCartBetStatus> betStatus = ShopCartBetStatus.Normal.obs;
  List<LastMarketEntity> latestMarketInfoList = [];
  Map<String,BetAmountBetAmountInfo> betMinMaxMoney = {};
  List<BetResultOrderDetailRespList> orderRespList = [];
  List<BetResultSeriesOrderRespList> seriesOrderRespList = [];

  bool hasUpdateRiskEvent = false;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 查询最新的盘口数据
      - @param {String} type :用于区分调用场景
      】】】
   *
   */
  Future queryLatestMarketInfo({String type = 'submit_bet'}) async {
    //return queryBetAmount(type:type);

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

    if(betMarketList.isEmpty){
      return;
    }

    LatestMarketReq req = LatestMarketReq();
    req.idList = betMarketList;
    req.deviceType = getDevice();

    // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
    if ([ 4, 5].contains(req.idList.safeFirst?.matchType)) {
      return;
    }

    try {
      final res = await BetApi.instance().queryLatestMarketInfo(req);
      if (res.success) {
        dealLastMarketInfo(type,res.data??[],isQueryLatestMarketInfo: true);
      }
    } catch (e) {
      AppLogger.debug(e.toString());
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取限额，子类中实现
      】】】
   *
   */
  Future<void> queryBetAmount() ;
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 根据接口拉到的latestMarketInfo更新赔率数据
      - 区分固定盘口还是固定坑位。固定盘口根据投注项id来比较；固定坑位根据坑位id来比较
      】】】
   *
   */
  void dealLastMarketInfo(String type,List<LastMarketEntity> latestMarketInfo,{bool isQueryLatestMarketInfo = false}){

    List<String> midsList = [];

    bool isMarketChange = false;
    bool showMarketChange = false;
    bool isOddsChange = false;
    //坑位是否变更
    itemList.forEach((item) {
      latestMarketInfo.forEach((element) {
        ConfigController.to.accessConfig.value.marketIsOpen = element.isHandicapMode;

        if(item.sportId == "1" && ConfigController.to.accessConfig.value.marketIsOpen) {
          //只更新盘口。
          if (element.matchInfoId == item.matchId &&
              element.playId == item.playId &&
              (element.currentMarket?.chpid??item.cplayId) == item.cplayId
          //不判断坑位
          ) {
            // 当前返回的数据坑位
            LastMarketCurrentMarket? market = element.currentMarket;
            if(market == null){
              market = element.marketList.firstWhereOrNull((page)=>page.marketValue == item.marketValue && page.chpid == item.cplayId);
            }
            if (market == null || market.id.isEmpty) {
              //如该盘口或者坑位消失，那么投注栏展示【已失效】
              item.hlHs.value = 2;
              //跳过该 element
              return;

            }

            List<LastMarketCurrentMarketMarketOddsList> marketOddsList =
                market.marketOddsList;
            LastMarketCurrentMarketMarketOddsList? odds =
            marketOddsList.firstWhereOrNull(
              //oddsId可能会变
              //(page) => page.id == item.playOptionsId);
                    (page) => page.oddsType == item.playOptions);
            if (odds?.id.isNotEmpty ?? false) {
              // 赛事状态
              item.midMhs.value = element.matchHandicapStatus;
              // 投注项状态
              item.olOs.value = odds!.oddsStatus;
              // 盘口状态
              item.hlHs.value = market.status;

              // ws断连后 需要对比数据 进行投注
              // 坑位变更
              if (market.placeNum != item.placeNum ||
                  item.playOptionsId != odds.id) {
                item.placeNum = market.placeNum;

                isMarketChange = true;

                midsList.add(item.matchId);
              }

              if (this is! ComboCourageBetController && (type == 'submit_bet' || type == 'add_item' ||
                  type == 'set_bet')) { //投注框主动发起的
                //更新数据仓库、因ws推送不及时导致数据有差异。临时代码
                MatchHpsHlOl? olEntity = DataStoreController.to.getOlById(
                    odds.id);
                if (olEntity != null && (olEntity.ov != odds.oddsValue ||
                    olEntity.os != odds.oddsStatus)) {
                  olEntity.ov = odds.oddsValue;
                  olEntity.os = odds.oddsStatus;
                  DataStoreController.to.updateOl(olEntity);
                }
                MatchEntity? match = DataStoreController.to.getMatchById(
                    element.matchInfoId);
                if (match != null &&
                    match.mhs != element.matchHandicapStatus) {
                  match.mhs = element.matchHandicapStatus;
                  DataStoreController.to.updateMatch(match);
                }
                MatchHpsHl? hlEntity = DataStoreController.to.getHlById(
                    market.id);
                if (hlEntity != null && hlEntity.hs != market.status) {
                  hlEntity.hs = market.status;
                  DataStoreController.to.updateHl(hlEntity);
                }
              }

              // 替换新id
              item.playOptionsId = odds.id;
              // 盘口id
              item.marketId = market.id;
              //赔率 10W位
              item.odds2 = odds.malayOddsValue;

              item.preMarketValue = odds.playOptions;

              item.changeOdds(odds.oddsValue,odds.ds == 1?odds.dov:0);
              isOddsChange = isOddsChange || item.oddStateType.value == OddStateType.oddUp || item.oddStateType.value == OddStateType.oddDown;

              //最终赔率
              item.oddFinally.value =
                  TYFormatOddsConversionMixin.computeValueByCurOddType(
                      item.odds,
                      item.odds2,
                      item.playId,
                      item.oddsHsw.split(','),
                      int.tryParse(item.sportId) ?? 0,
                      item.cds
                  );

              // 如果是早盘赛事 则设置当前的 赛事状态
              if (item.matchType == 1) {
                // 赛事状态：0未开赛，1 进行中 4 结束 (对应:ms)
                if (element.matchStatus == 0) {
                  item.matchType = 1;
                }
                // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
                if (element.matchStatus == 1) {
                  item.matchType = 2;
                }
              }

              if (isMarketChange) {
                Bus.getInstance().emit(EventType.oddsButtonUpdate);
              }
            }
          }
        }else
        {//固定坑位
          // 当前返回的数据坑位
          LastMarketCurrentMarket? market = element.currentMarket;
          if (market == null || market.id.isEmpty) {
            if(element.matchInfoId == item.matchId &&
                element.playId == item.playId ){
              //如该盘口或者坑位消失，那么投注栏展示【已失效】
              item.hlHs.value = 2;
            }

            //跳过该 element
            return;
          }

          if (element.matchInfoId == item.matchId &&
              element.playId == item.playId &&
              element.currentMarket?.chpid == item.cplayId &&
              market.placeNum == item.placeNum) {
            List<LastMarketCurrentMarketMarketOddsList> marketOddsList =
                element.currentMarket?.marketOddsList ?? [];
            LastMarketCurrentMarketMarketOddsList? odds =
            marketOddsList.firstWhereOrNull(
                    (page) => page.oddsType == item.playOptions);
            if (odds?.id.isNotEmpty ?? false) {
              // 赛事状态
              item.midMhs.value = element.matchHandicapStatus;
              // 投注项状态
              item.olOs.value = odds!.oddsStatus;
              // 盘口状态
              item.hlHs.value = market.status;

              // ws断连后 需要对比数据 进行投注

              item.marketChange = false;
              // 坑位变更
              if (item.playOptionsId != odds.id &&
                  item.marketId != market.id) {
                isMarketChange = true;
                showMarketChange = true;
                item.marketChange = true;

                midsList.add(item.matchId);
              }
              else if (this is! ComboCourageBetController && (type == 'submit_bet' || type == 'add_item' ||
                  type == 'set_bet')) { //投注框主动发起的
                //更新数据仓库、因ws推送不及时导致数据有差异。临时代码
                MatchHpsHlOl? olEntity = DataStoreController.to.getOlById(
                    odds.id);
                if (olEntity != null && (olEntity.ov != odds.oddsValue ||
                    olEntity.os != odds.oddsStatus)) {
                  olEntity.ov = odds.oddsValue;
                  olEntity.os = odds.oddsStatus;
                  DataStoreController.to.updateOl(olEntity);
                }
                MatchEntity? match = DataStoreController.to.getMatchById(
                    element.matchInfoId);
                if (match != null &&
                    match.mhs != element.matchHandicapStatus) {
                  match.mhs = element.matchHandicapStatus;
                  DataStoreController.to.updateMatch(match);
                }
                MatchHpsHl? hlEntity = DataStoreController.to.getHlById(
                    market.id);
                if (hlEntity != null && hlEntity.hs != market.status) {
                  hlEntity.hs = market.status;
                  DataStoreController.to.updateHl(hlEntity);
                }
              }

              // 替换新id
              item.playOptionsId = odds.id;
              // 盘口id
              item.marketId = market.id;
              //赔率 10W位
              item.odds2 = odds.malayOddsValue;

              item.preMarketValue = odds.playOptions;

              item.changeOdds(odds.oddsValue,odds.ds == 1?odds.dov:0);
              isOddsChange = isOddsChange || item.oddStateType.value == OddStateType.oddUp || item.oddStateType.value == OddStateType.oddDown;

              //最终赔率
              item.oddFinally.value =
                  TYFormatOddsConversionMixin.computeValueByCurOddType(
                      item.odds,
                      item.odds2,
                      item.playId,
                      item.oddsHsw.split(','),
                      int.tryParse(item.sportId) ?? 0,
                      item.cds
                  );

              // 投注项类型
              item.playOptions = odds.oddsType;
              // 盘口值
              item.marketValue = market.marketValue;
              // 球头
              if (item.handicapHv.value.isNotEmpty) {
                // 篮球 让分/总分 足球 让球/大小
                if (market_flag_basketball_list.contains(item.playId) ||
                    market_flag_list.contains(item.playId)) {
                  item.handicapHv.value = odds.playOptions.isNotEmpty
                      ? odds.playOptions
                      : (market.marketValue.isNotEmpty
                      ? market.marketValue
                      : item.handicapHv.value);
                } else {
                  item.handicapHv.value = odds.playOptions.isNotEmpty
                      ? odds.playOptions
                      : (item.handicapHv.value.isNotEmpty
                      ? item.handicapHv.value
                      : market.marketValue);
                }
              }
              // let play_option_name = ''
              // // 主队 客队
              // if( odds.oddsType == 1 ){
              //   play_option_name = element.home ;
              // }else{
              //   play_option_name = element.away  ;
              // }
              item.playOptionName =
              '${item.handicap} ${odds.playOptions.isNotEmpty
                  ? odds.playOptions
                  : market.marketValue}';
              item.playOptions = odds.oddsType;

              //TODO 作用不明
              //item.placeNum = 'place_num';

              // 如果是早盘赛事 则设置当前的 赛事状态
              if (item.matchType == 1) {
                // 赛事状态：0未开赛，1 进行中 4 结束 (对应:ms)
                if (element.matchStatus == 0) {
                  item.matchType = 1;
                }
                // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
                if (element.matchStatus == 1) {
                  item.matchType = 2;
                }
              }

              if(isMarketChange) {
                Bus.getInstance().emit(EventType.oddsButtonUpdate);
              }
            }
          }
        }
      });
    });

    //坑位变化 预约状态flutter无需特殊处理

    //坑位变化
    if (isMarketChange && ShopCartController.to.currentBetController == this
        && (betStatus.value == ShopCartBetStatus.Normal || (betStatus.value == ShopCartBetStatus.Failure && hasUpdateRiskEvent))) {

      //固定盘口不用提示
      if(showMarketChange) {
        if(betStatus.value == ShopCartBetStatus.Normal) {
          // 提示 您所选投注项的赔率，盘口及有效性产生变化
          ShopCartUtil.showBetError('0402009');
        }

        // 坑位变化 重新获取限额
        if(isQueryLatestMarketInfo) {
          queryBetAmount();
        }
      }
      //数据仓库处理C106，未处理坑位变化，暂时在这里加上
      if(type=='C106') {
        Bus.getInstance().emit(EventType.init302, midsList);
      }
    }else if(isOddsChange){
      if (isQueryLatestMarketInfo) {
        queryBetAmount();
      }
    }

    // 现在不需要了？
    // set_market_id_to_ws()
    //不重新queryBetAmount的话，需要设置新的latestMarketInfoList
    //latestMarketInfoList = res.data?.latestMarketInfo ?? latestMarketInfoList;

    if(betStatus.value == ShopCartBetStatus.Failure && hasUpdateRiskEvent){
      //如果可以重新投注，更新重新投注数据
      orderRespList.forEach((element) {
        for(ShopCartItem item in itemList){
          if(element.shopCartItemId == item.itemId){
            element.handicap = item.handicap;
            element.newHandicapHv.value = item.handicapHv.value;
            element.newOddsValues.value = item.oddFinally.value;
            element.newOdds = item.odds;
            break;
          }
        }
      });
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
      - 处理限额数据
      】】】
   *
   */
  void dealBetAmountData(List<BetAmountBetAmountInfo> betAmountInfo,List<LastMarketEntity> latestMarketInfo){
    latestMarketInfoList = latestMarketInfo;
    _setBetPreList(latestMarketInfoList);
    betMinMaxMoney.clear();
    betAmountInfo.forEach((element) {
      betMinMaxMoney[element.playOptionsId] = element;
    });


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
      - 设置预约投注显示状态 篮球足球显示预约投注
      】】】
   *
   */
  void _setBetPreList(List<LastMarketEntity> betAmountLatestMarketInfoList){
    betAmountLatestMarketInfoList.forEach((element) {
      String? oid = element.currentMarket?.marketOddsList.safeFirst?.id;
      if(oid!=null) {
        if (element.pendingOrderStatus != 0) {
          ShopCartController.to.state.prebookOidList.add(oid);
        } else {
          ShopCartController.to.state.prebookOidList.remove(oid);
        }
      }
    });
  }
}