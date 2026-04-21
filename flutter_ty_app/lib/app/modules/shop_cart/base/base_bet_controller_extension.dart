import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:get/get.dart';

import '../../../core/format/common/module/format-score.dart';
import '../../../global/data_store_controller.dart';
import '../../../services/models/res/match_entity.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_util.dart';

import 'base_bet_controller.dart';

extension BaseBetControllerExtensions on BaseBetController {

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 赛事状态
        C101 数据
        `mid` 赛事Id
        `ms` 赛事状态 0:未开赛 1:赛事进行中  2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
      】】】
   *
   */
  void setBetC101Change(Map obj) {
    var ms = obj['ms'].toInt();
    // 赛事状态为 3:结束 4:关闭 5:取消 6:比赛放弃 8:未知 赛事进行关盘处理
    if (![3, 4, 5, 6, 8].contains(ms)) {
      return;
    }

    var mid = obj['mid'];
    setBetListDeactivated(mid);
  }

  /*
  设置赛事关闭
  midMhs = 2
   */
  void setBetListDeactivated(dynamic mid) {
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      itemList.forEach((element) {
        if (element.matchId == mid) {
          element.midMhs.value = 2;
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
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 赛事阶段
        C102 数据
        `mid` 赛事Id
        `mmp` 赛事阶段 999 结束
      】】】
   *
   */
  void setBetC102Change(Map obj) {
    var mmp = obj['mmp'];
    // 赛事阶段 999 结束
    if (mmp != '999') {
      return;
    }
    var mid = obj['mid'];
    setBetListDeactivated(mid);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 赛事比分
      】】】
   *
   */
  void setBetC103Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();
    // 判断赛事级别盘口状态 中是否包含 投注项中的赛事
    if (midList.contains(mid)) {
      itemList.forEach((element) {
        if (element.matchId == mid) {
          // 更新 基准分
          //TODO 此处需要从数据仓库重新获取数据
          // const mid_obj = lodash_.get(query.list_to_obj, `mid_obj.${obj.matchId}_`, {})
          // const ol_obj = lodash_.get(query.list_to_obj, `ol_obj.${obj.matchId}_${obj.playOptionsId}`, {})
          // return calc_bifen(mid_obj.msc,mid_obj.csid,mid_obj.ms,ol_obj._hpid)
          MatchEntity? match = DataStoreController.to.getMatchById(element.matchId);
          element.markScore = ShopCartUtilHandicap.calcBifen(
              match?.msc??[],
              int.tryParse(element.sportId) ?? 0,
              element.matchMs,
              int.tryParse(element.playId) ?? 0);
          //element.scoreHomeAway = `(${get_score(item,'home')}-${get_score(item,'away')})`
          if(match!=null) {
            final score = TYFormatScore.formatTotalScore(match);
            element.scoreHomeAway = score.text.replaceAll(' ', '');
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
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 赛事级别盘口状态
      】】】
   *
   */
  void setBetC104Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      itemList.forEach((element) {
        // 在赛事盘口状态下的 投注项 设置 对应的赛事级别 用于 失效投注项
        if (element.matchId == mid) {
          element.midMhs.value = obj['mhs'];
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
      【【【 AUTO_PARAGRAPH_TITLE 投注基类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 赛事开启
      】】】
   *
   */
  void setBetC109Change(List listObj) {
    List midList = itemList.map((element) => element.matchId).toList();
    bool changed = false;
    listObj.forEach((obj) {
      var mid = obj['mid'];
      if (midList.contains(mid)) {
        changed = true;
        itemList.forEach((element) {
          // 赛事状态为 3:结束 4:关闭 5:取消 6:比赛放弃 8:未知 赛事进行关盘处理
          if (element.matchId == mid && ![3, 4, 5, 6, 8].contains(obj['ms'])) {
            // 更新 赛事状态
            element.midMhs.value = obj['hs'];
          }
        });

      }
      //暂无此设计
      //this.set_bet_oid_list()
      //this.set_options_state()
    });
    if(changed){
      queryLatestMarketInfo(type:'C109');
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
      - C11，需重新刷新赔率
      】】】
   *
   */
  void setBetC11Change(Map obj) {
    List midList = itemList.map((element) => element.matchId).toList();
    bool changed = false;
    var mid = obj['mid'];
    if (midList.contains(mid)) {
      changed = true;
    }

    if(changed){
      queryLatestMarketInfo(type:'C11');
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
      - 玩法集变更
        C112 推送数据
        `mid` 赛事Id
        `mcms` 状态2:开启，3：删除（与上游一致）
        `mcid` 玩法id集合
      】】】
   *
   */
  void setBetC112Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      var mcid = obj['mcid'];
      var mcms = obj['mcms'];
      itemList.forEach((element) {
        // 当前 赛事 和 玩法对应的投注项
        if (element.matchId == mid && mcid.contains(element.playId)) {
          /// 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
          if (mcms == 2) {
            element.hlHs.value = 0;
          }
          if (mcms == 3) {
            element.hlHs.value = 2;
          }
        }
      });
      queryLatestMarketInfo(type:'C112');
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
      - 优惠盘口变更
      C153 推送数据
      `mid` 赛事Id
      `mcms` 状态2:开启，3：删除（与上游一致）
      `mcid` 玩法id集合
      】】】
   *
   */
  void setBetC153Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      queryLatestMarketInfo(type:'C153');
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
      - C201推送数据
        `orderNo` 订单编号
        `status` 订单状态(1:投注成功 2:投注失败)
        `newTotalMaxWinAmount` 订单最高可赢金额
        `isOddsChange` 赔率是否变更，为true时处理赔率变更集合
        `newProcessOrder` 是否投注新流程订单 1:是 0:否
        `tryNewProcessBet` 是否重试投注新流程订单 1:是 2:投注金额变更 0:否
        `refuseCode` 拒单编码
        `cuid` 用户Id
        `preStatus` 是否提前结算状态：0:原有结算逻辑, 1:是提前结算
        `orderStatus` 专指提前结算状态  1:通过  2:拒绝
      】】】
   *
   */
  void setBetC201Change(Map obj) {
    // 订单id
    String orderNo = obj['orderNo']??"";
    // 订单状态 订单状态(1:投注成功 2:投注失败)
    int status = obj['status'] ?? 0;
    List orderNoList = orderRespList.map((element) => element.orderNo).toList();
    if (orderNoList.contains(orderNo)) {
      // 订单已经完成 不需要去设置 用户点击了 保留选项 或者投注的确定
      // 单关 单注
      orderRespList.forEach((element) {
        if (element.orderNo == orderNo && element.sendWSTime.compareTo(obj['sendWSTime']) < 0) {
          if (status == 1) {
            element.orderStatusCode = 1;
          }
          if (status == 2) {
            element.orderStatusCode = 0;
          }

          List orderOddsVos = obj['orderOddsVos']??[];
          for(Map orderStatusOddsChange in orderOddsVos){
            if(element.playOptionsId == orderStatusOddsChange["oid"]) {
              //单关的riskEvent直接写写在orderRespList，串关不写
              if (seriesOrderRespList.isEmpty) {
                if (orderStatusOddsChange["riskEvent"]?.isNotEmpty??false) {
                  element.riskEvent = ShopCartUtil.getRejectOrderReason(
                      orderStatusOddsChange["riskEvent"]);
                } else if(obj['refuseCode']=="0400464"){
                  element.riskEvent = ShopCartUtil.getRejectOrderReason("over_payout");
                }
              }
              element.newOddsValues.value = orderStatusOddsChange["ov"];
              element.maxWinMoney = obj['newTotalMaxWinAmount'];
              element.sendWSTime = obj['sendWSTime'];
              break;
            }

          }

        }
      });
      if (status == 1) {
        betStatus.value = ShopCartBetStatus.Success;
      }
      if (status == 2) {
        betStatus.value = ShopCartBetStatus.Failure;
      }

    }

    List seriesOrderNoList = seriesOrderRespList.map((element) => element.orderNo).toList();
    if (seriesOrderNoList.contains(orderNo)) {
      //串关
      seriesOrderRespList.forEach((element) {
        if (element.orderNo == orderNo && element.sendWSTime.compareTo(obj['sendWSTime']) < 0) {
          //element.orderStatusCode = obj['status'];
          if (status == 1) {
            element.orderStatusCode = 1;
          }
          if (status == 2) {
            element.orderStatusCode = 0;
          }
          element.maxWinAmount = obj['newTotalMaxWinAmount'];
          element.sendWSTime = obj['sendWSTime'];

          List orderOddsVos = obj['orderOddsVos']??[];
          Map? orderStatusOddsChange = orderOddsVos.firstWhereOrNull((e)=>e is Map && e['riskEvent']!=null && e['riskEvent']!='');
          if(orderStatusOddsChange!=null){
            element.riskEvent = ShopCartUtil.getRejectOrderReason(orderStatusOddsChange["riskEvent"]);
          }
        }
      });
      if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0 && element.orderStatusCode != 1)==null){
        if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0)==null){
          betStatus.value = ShopCartBetStatus.Failure;
        }else{
          if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode == 0)!=null){
            //有成功的，也有不成功的
            betStatus.value = ShopCartBetStatus.PartSuccess;
          }else {
            betStatus.value = ShopCartBetStatus.Success;
          }
        }
      }

      update(['series_order_resp']);
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
      - C303推送数据
      刷新lastest_market_info
      】】】
   *
   */
  void setBetC303Change(Map obj) {
    var mid = obj['mid'];
    var csid = obj['csid'];
    var hpid = obj['hpid'];
    // 获取单关下的赛事id 多个（单关合并）
    List midList = itemList.map((element) => element.matchId).toList();
    // 赛种
    List scidList = itemList.map((element) => element.sportId).toList();
    // 玩法
    List hpidList = itemList.map((element) => element.playId).toList();

    // 判断赛事级别盘口状态 中是否包含 投注项中的赛种 赛事 玩法
    if (scidList.contains(csid)) {
      if (midList.contains(mid)) {
        if (hpidList.contains(hpid)) {
          // 303 推送不会推送105 106
          queryLatestMarketInfo(type: 'C303');
        }
      }
    }
  }
}