import 'package:collection/collection.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';

import '../../../utils/bus/event_enum.dart';
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../global/config_controller.dart';
import '../../../global/data_store_controller.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/bus/bus.dart';
import '../combo_courage_bet/combo_courage_bet_controller.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_util.dart';
import 'base_bet_controller.dart';

extension BaseBetControllerExtensionsChangeOdds on BaseBetController {
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注项赔率变动
      】】】
   *
   */
  void setBetC106Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();

    if (midList.contains(mid)) {
      bool isOddsChange = false;
      if(this is! ComboCourageBetController) {
        List hls = [];
        if (obj['hls'] is List) {
          hls = obj['hls'] ?? [];
        } else if (obj['hls2'] is Map) {
          obj['hls2'].forEach((key, value) {
            hls.addAll(value);
          });
        }
        // 投注项中有 推送的数据 那么就会对盘口和投注项id进行比对筛选
        List marketList = itemList.map((element) => element.marketId).toList();
        hls.forEach((hslElement) {
          if (marketList.contains(
              hslElement['hid'])) { //坑位变化时，marketId会变，此处判断有问题？
            // 查询投注项中的 投注项id
            var olObj = itemList.firstWhereOrNull(
                    (element) => element.marketId == hslElement['hid']);
            if (olObj != null) {
              // 有坑位 并且 坑位变更
              if (olObj.placeNum != null) {
                if (olObj.sportId == "1" &&
                    ConfigController.to.accessConfig.value.marketIsOpen) {
                  //只变更盘口。
                  if (hslElement['hpid'] == olObj.playId &&
                      hslElement['chpid'] == olObj.cplayId
                  ) {
                    var wsItemHn = hslElement;
                    List<Map> hslElementOl = [];
                    wsItemHn?['ol']?.forEach((element) {
                      hslElementOl.add(element as Map);
                    });
                    var wsOlObj = hslElementOl.firstWhereOrNull(
                            (element) =>
                        element['oid'] == olObj.playOptionsId
                            || (element['ot'] == olObj.playOptions &&
                            hslElement['hv'] == olObj.marketValue) //判断盘口值
                    );
                    if (wsOlObj != null) {
                      if (wsOlObj['oid'] != olObj.playOptionsId) {
                        //更新赔率
                        wsChangeOddsInfo(
                            hslElement, wsOlObj, olObj, isPlaceNum: true);
                        isOddsChange = isOddsChange || olObj.oddStateType.value == OddStateType.oddUp || olObj.oddStateType.value == OddStateType.oddDown;

                        // 更新投注项内容后 重新发起新的ws订阅
                        ShopCartController.to.subscribeMarket();

                        // 获取最新的盘口值。是为了通知C302
                        Future.delayed(const Duration(milliseconds: 100), () {
                          // 电子赛事更新太快 延迟100毫秒 使用最后一次更新
                          queryLatestMarketInfo(type: 'C106');
                        });
                        return;
                      }
                    } else {
                      /* 不能在这里判断 ，应该找 hlsMap[playId] 里面的全部hls
                        //玩法级更新，推送全部盘口，不包含的话，认为盘口已经被移除（未确认）
                        if (hlsMap.isNotEmpty && olObj.hlHs.value!=2) {
                          //如该盘口或者坑位消失，那么投注栏展示【已失效】
                          olObj.hlHs.value = 2;
                          // 获取最新的盘口值。是为了通知C302
                          Future.delayed(const Duration(milliseconds: 100), () {
                            // 电子赛事更新太快 延迟100毫秒 使用最后一次更新
                            queryLatestMarketInfo(type: 'C106');
                          });
                          return;
                        }
                         */
                    }
                  }
                } else {
                  //固定坑位
                  if (olObj.placeNum == hslElement['hn'] &&
                      olObj.playId == hslElement['hpid'] &&
                      olObj.cplayId == hslElement['chpid']
                  ) {
                    var wsItemHn = hslElement;
                    List<Map> hslElementOl = [];
                    wsItemHn?['ol']?.forEach((element) {
                      hslElementOl.add(element as Map);
                    });
                    var wsOlObj = hslElementOl.firstWhereOrNull(
                            (element) => element['ot'] == olObj.playOptions);
                    if (wsOlObj?['ov'] != null) {
                      if (wsOlObj!['oid'] != olObj.playOptionsId) {
                        //更新赔率
                        wsChangeOddsInfo(
                            hslElement, wsOlObj, olObj, isPlaceNum: true);
                        isOddsChange = isOddsChange || olObj.oddStateType.value == OddStateType.oddUp || olObj.oddStateType.value == OddStateType.oddDown;
                        // 更新投注项内容后 重新发起新的ws订阅
                        ShopCartController.to.subscribeMarket();

                        // 获取最新的盘口值
                        Future.delayed(const Duration(milliseconds: 100), () {
                          // 电子赛事更新太快 延迟100毫秒 使用最后一次更新
                          queryLatestMarketInfo(type: 'C106');
                        });

                        return;
                      }
                    }
                  }
                }
              }
              // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
              if (hslElement['hs'] != 0) {
                // 直接更新状态 设置关盘
                olObj.hlHs.value = hslElement['hs'];
                return;
              }
              // 更新 投注项 数据
              List<Map> hslElementOl = [];
              hslElement['ol'].forEach((element) {
                hslElementOl.add(element as Map);
              });
              var wsOlObj = hslElementOl.firstWhereOrNull(
                //(element) => element['ot'] == olObj.playOptions && hslElement['hpid'] == olObj.playId //玩法级推送的话，需增加判断playId
                      (element) => element['oid'] == olObj.playOptionsId
              );
              if (wsOlObj?['ov'] != null) {
                //更新赔率
                wsChangeOddsInfo(hslElement, wsOlObj!, olObj);
                isOddsChange = isOddsChange || olObj.oddStateType.value == OddStateType.oddUp || olObj.oddStateType.value == OddStateType.oddDown;
              }
            }
          }
        });
        if (isOddsChange) {
          queryBetAmount();
        }
      }else{
        queryLatestMarketInfo(type: 'C106');
      }
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
      - ws变更 带来的 投注项数据的变更
      】】】
   *
   */
  void wsChangeOddsInfo(Map hlsItem, Map oddsItem, ShopCartItem shopCartItem,
      {bool isPlaceNum = false}) {
    if (oddsItem['ov'] != null) {
      // 投注项和状态一致不更新数据
      if (shopCartItem.odds == int.tryParse(oddsItem['ov']) &&
          shopCartItem.discountOdds == (int.tryParse(oddsItem['dov']??"")??0) &&
          shopCartItem.olOs.value == oddsItem['os'] &&
          shopCartItem.hlHs.value == hlsItem['hs']) {
        //目前C106的ov2不正确，这里正好return掉了
        return;
      }
      int newOdds = int.tryParse(oddsItem['ov']) ?? shopCartItem.odds;
      // 重新设置赔率
      shopCartItem.changeOdds(newOdds);
      // 设置 投注项状态  1：开 2：封 3：关 4：锁
      shopCartItem.olOs.value = oddsItem['os'];
      // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
      shopCartItem.hlHs.value = hlsItem['hs'];
      shopCartItem.discountOdds = int.tryParse(oddsItem['dov']??"")??0;
      shopCartItem.odds2 = oddsItem['ov2'];

      // 坑位变化 后找到的新坑位数据
      if (isPlaceNum) {
        shopCartItem.marketId = hlsItem['hid'];
        shopCartItem.playOptionsId = oddsItem['oid'];
      }
      // 获取新的基准分   需同步数据仓库
      MatchEntity? match = DataStoreController.to.getMatchById(shopCartItem.matchId);
      shopCartItem.markScore = ShopCartUtilHandicap.calcBifen(
          match?.msc??[],
          int.tryParse(shopCartItem.sportId) ?? 0,
          shopCartItem.matchMs,
          int.tryParse(shopCartItem.playId) ?? 0);
      // 赔率数据
      shopCartItem.oddFinally.value =
          TYFormatOddsConversionMixin.computeValueByCurOddType(
              shopCartItem.odds,
              shopCartItem.odds2,
              shopCartItem.playId,
              shopCartItem.oddsHsw.split(','),
              int.tryParse(shopCartItem.sportId) ?? 0,
              match?.cds ?? ''
          );

      Bus.getInstance().emit(EventType.oddsButtonUpdate);
    }
  }

}