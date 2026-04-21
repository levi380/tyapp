import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_controller.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../services/models/res/bet_result_entity.dart';

import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/req/bet_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/last_market_entity.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../../utils/toast_util.dart';
import '../../../utils/utils.dart';
import '../model/bet_count_model.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_util.dart';
import 'mix_bet_controller_mixin.dart';

mixin MixBetControllerMixinBetAmount on MixBetControllerMixin{
  List<RxDouble> inputAmountList = [];

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取商户配置的 最小串关投注项
      缺省为2
      】】】
   *
   */
  int get minSeriesNum =>
      TYUserController.to.userInfo.value?.configVO?.minSeriesNum ?? 2;
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取商户配置的 最大串关投注项
      缺省为10
      】】】
   *
   */
  int get maxSeriesNum =>
      TYUserController.to.userInfo.value?.configVO?.maxSeriesNum ?? 10;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 串关获取限额
      】】】
   *
   */

  @override
  Future queryBetAmount() async {
    if (itemCount == 0) {
      return;
    }

    BetAmountReq req = BetAmountReq();
    for (ShopCartItem item in itemList) {
      //if(item.isColsed || item.isOddChanging) continue;
      BetAmountReqOrderMaxBetMoney orderMinMaxMoney =
      BetAmountReqOrderMaxBetMoney();
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
                item.cds); //赔率
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
      orderMinMaxMoney.seriesType = itemCount > 1 ? BetSeriesType.parlay.code : BetSeriesType.single.code; // 串关类型 1 单关 2串关
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
    } catch (e) {
      // AppLogger.debug(e.toString());
      res = ApiRes<BetAmountEntity>();
    }
    if (res.success) {
      dealBetAmountData(
          res.data?.betAmountInfo ?? [], res.data?.latestMarketInfo ?? []);

      // betSpecialSeries.forEach((element) {
      //   BetAmountBetAmountInfo? betAmountInfo = res.data?.betAmountInfo?.firstWhereOrNull((info) => info.type == element.id);
      //   element.betAmountInfo.value = betAmountInfo;
      // });
    } else {
      //设置default值
      AppLogger.debug(res.msg ?? res.code ?? 'queryBetAmount error');
    }
  }

  @override
  void dealBetAmountData(List<BetAmountBetAmountInfo> betAmountInfo,
      List<LastMarketEntity> latestMarketInfo) {
    super.dealBetAmountData(betAmountInfo, latestMarketInfo);

    betSpecialSeries.forEach((element) {
      BetAmountBetAmountInfo? betAmountBetAmountInfo =
      betAmountInfo.firstWhereOrNull((info) => info.type == element.id);
      element.betAmountInfo.value = betAmountBetAmountInfo;
    });

    update(['input_total']);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 检查 余额是否足够、检查 输入是否符合限额
      】】】
   *
   */
  bool checkAmount() {
    // 串关 数量不是大于1条投注项 则提示
    if (itemCount < minSeriesNum && itemCount != 1) {
      String errorMsg = LocaleKeys.bet_bet_min_item.tr;
      errorMsg = errorMsg.replaceAll('{num}', minSeriesNum.toString());
      ToastUtils.showGrayBackground(errorMsg);
      return false;
    }
    // 串关 数量不能大于设置的数量
    if (itemCount > maxSeriesNum) {
      String errorMsg = LocaleKeys.bet_match_max2.tr;
      errorMsg = errorMsg + "(${maxSeriesNum.toString()})";
      ToastUtils.showGrayBackground(errorMsg);
      return false;
    }

    //余额不足
    if (TYUserController.to.balanceAmount.value <= 0) {
      ShopCartUtil.showBetError("0402035",
          prefixMsg: betStatus.value == ShopCartBetStatus.OneClickBetting
              ? '${LocaleKeys.bet_bet_err.tr}!'
              : null);
      return false;
    }

    // 请输入投注金额
    if (inputTotal <= 0) {
      ShopCartUtil.showBetError("M400005");
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
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 检查是否可投注
      】】】
   *
   */
  bool checkBet() {
    for (ShopCartItem item in itemList) {
      //if(item.isColsed || item.isOddChanging) continue;

      // 投注项状态 1：开 2：封 3：关 4：锁
      // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
      // 赛事级别盘口状态（0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘,11:锁盘状态）
      if (item.marketChange ||
          item.olOs.value == 4 ||
          item.hlHs.value == 11 ||
          item.midMhs.value == 11) {
        ShopCartUtil.showBetError("400004");
        return false;
      }

      if ([2, 3].contains(item.olOs.value) ||
          [2, 1].contains(item.hlHs.value) ||
          [2, 1].contains(item.midMhs.value)) {
        ShopCartUtil.showBetError("0402001");
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
      【【【 AUTO_PARAGRAPH_TITLE 串关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 投注
      】】】
   *
   */
  @override
  Future<bool> doBet({bool betAgain = false}) async {
    if (itemCount == 1) {
      //变通办法。新建SingleBetController实例，并赋值一些变量，然后调用singleBetController.doBet。以免写重复代码
      SingleBetController singleBetController = SingleBetController();
      singleBetController.itemList.addAll(itemList);
      singleBetController.betStatus = betStatus;
      singleBetController.betMinMaxMoney = betMinMaxMoney;
      singleBetController.inputAmount = inputAmount;
      singleBetController.orderRespList = orderRespList;

      //走单关投注
      return singleBetController.doBet(betAgain: betAgain);
    }

    if (!checkAmount()) return false;

    ToastUtils.showLoading();
    await queryLatestMarketInfo();

    if (!checkBet()) return false;

    for (int i = 0; i < betSpecialSeries.length; i++) {
      // 有金额的情况下 判断限额
      BetCountModel betCountModel = betSpecialSeries[i];
      double inputValue = inputAmountList[i].value;
      // 投注金额 小于最小限额
      if (inputValue > 0 &&
          inputValue <
              (double.tryParse(
                  betCountModel.betAmountInfo.value?.minBet ?? '') ??
                  0.0)) {
        ShopCartUtil.showBetError("M400010");
        return false;
      }
    }

    //投注前复位 hasUpdateRiskEvent
    hasUpdateRiskEvent = false;

    // 获取当前币种
    String currency = TYUserController.to.currCurrency();
    if (currency == 'RMB') {
      // 人民币 使用CNY 不使用 RMB
      currency = "CNY";
    }

    BetReq betReq = BetReq();
    betReq.useAcceptOdds = 2; // 是否自动接受赔率变化 1：自动接收更好的赔率 2：自动接受任何赔率变动 3：不自动接受赔率变动
    betReq.acceptOdds =
        TYUserController.to.userInfo.value?.userBetPrefer ?? BetAcceptOdds.acceptAll.code; // 接受赔率变化情况
    betReq.tenantId = 1;
    betReq.deviceType = getDevice(); // 设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备
    betReq.currencyCode = currency; // 币种
    betReq.deviceImei = ''; // 设备imei码，只有手机有，没有不添加
    betReq.fpId = ''; // 指纹55555555id
    betReq.timeZone = TimeZoneUtils.zoneIndex;

    List<BetReqSeriesOrders> seriesOrders = [];
    for (int i = 0; i < betSpecialSeries.length; i++) {
      BetCountModel betCountModel = betSpecialSeries[i];
      double inputValue = inputAmountList[i].value;
      List<BetReqSeriesOrdersOrderDetailList> orderDetailList = [];
      if (inputValue > 0.0) {
        for (ShopCartItem item in itemList) {
          //if(item.isColsed || item.isOddChanging) continue;

          // BetResultOrderDetailRespList? betResultOrderDetail;
          // if(betAgain){
          //   betResultOrderDetail = orderRespList.firstWhereOrNull((e)=>e.shopCartItemId == item.itemId);
          // }
          BetReqSeriesOrdersOrderDetailList orderDetail =
          BetReqSeriesOrdersOrderDetailList();
          orderDetail.shopCartItemId = item.itemId;
          orderDetail.handicapHv = item.handicapHv.value;
          orderDetail.sportId = item.sportId; // 赛种id
          orderDetail.matchId = item.matchId; // 赛事id
          orderDetail.tournamentId = item.tournamentId; // 联赛id
          orderDetail.betAmount = inputValue.toStringAsFixed(2); //投注金额
          //orderDetail.placeNum = item.placeNum!=0?item.placeNum.toString():'';    //盘口坑位
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
                    item.cds); //赔率
            orderDetail.excellentOddsBet = 1;
            orderDetail.orgOddFinally = item.oddFinally.value; //原始赔率
          } else {
            orderDetail.odds = item.odds; // 赔率 万位
            orderDetail.oddFinally = item.oddFinally.value; //赔率
          }
          orderDetail.playOptionName = item.playOptionName; // 投注项名称
          orderDetail.playName = item.playName; //玩法名称
          orderDetail.sportName = item.sportName; // 球种名称
          orderDetail.matchType =
              item.matchType; // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
          orderDetail.matchName = item.matchName; //赛事名称
          orderDetail.playOptions = item.playOptions; // 投注项配置项
          //orderDetail.tournamentLevel = item.tournamentLevel;             // 联赛级别
          orderDetail.playId = item.playId; // 玩法id
          //orderDetail.dataSource = item.dataSource;                       // 数据源

          // 电竞 vr 投注不需要一下数据
          if (item.betType == OddsBetType.common) {
            orderDetail.scoreBenchmark = '';
            orderDetail.placeNum = item.placeNum?.toString() ?? ''; //盘口坑位
            orderDetail.tournamentLevel = item.tournamentLevel; // 联赛级别
            orderDetail.dataSource = item.dataSource; // 数据源
          }

          // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
          if (!TYUserController.to.isCurDdds(item.oddsHsw)) {
            orderDetail.marketTypeFinally = 'EU';
          }

          orderDetailList.add(orderDetail);
        }

        BetReqSeriesOrders betReqSeriesOrders = BetReqSeriesOrders();
        betReqSeriesOrders.seriesSum = betCountModel.count; // 串关数量
        betReqSeriesOrders.seriesType = int.tryParse(betCountModel.id) ?? 0;
        betReqSeriesOrders.fullBet = 0; // 是否满额投注，1：是，0：否
        betReqSeriesOrders.orderDetailList = orderDetailList;

        seriesOrders.add(betReqSeriesOrders);
      }
    }

    betReq.seriesOrders = seriesOrders;

    ApiRes<BetResultEntity> res;
    try {
      res = await BetApi.instance().bet(betReq);
      dismissAllToast();
    } on DioException catch (dioException) {
      // AppLogger.debug(dioException.toString());
      if (dioException.type == DioExceptionType.sendTimeout ||
          dioException.type == DioExceptionType.receiveTimeout) {
        ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg13.tr);
      } else {
        ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg02.tr);
      }
      return false;
    } catch (e) {
      // AppLogger.debug(e.toString());
      ToastUtils.showGrayBackground(LocaleKeys.bet_msg02.tr);
      return false;
    }

    if (res.success) {
      betStatus.value = ShopCartBetStatus.Betting;
      setOrderDetailRespList(res.data, betReq);
      seriesOrderRespList.clear();
      seriesOrderRespList.addAll(res.data?.seriesOrderRespList ?? []);

      //<!-- 订单状态 0:投注失败 1: 投注成功 2: 订单确认中 -->
      if (seriesOrderRespList.firstWhereOrNull((element) =>
      element.orderStatusCode != 0 && element.orderStatusCode != 1) ==
          null) {
        if (seriesOrderRespList
            .firstWhereOrNull((element) => element.orderStatusCode != 0) ==
            null) {
          betStatus.value = ShopCartBetStatus.Failure;
        } else {
          if (seriesOrderRespList.firstWhereOrNull(
                  (element) => element.orderStatusCode == 0) !=
              null) {
            //有成功的，也有不成功的
            betStatus.value = ShopCartBetStatus.PartSuccess;
          } else {
            betStatus.value = ShopCartBetStatus.Success;
          }
        }
      }

      // if (betStatus.value == ShopCartBetStatus.Betting) {
      //   orderCheck();
      // }
      TYUserController.to.getBalance();

      return true;
    } else {
      ToastUtils.showGrayBackground(res.msg ?? res.code ?? 'Error');
      return false;
    }
  }
}