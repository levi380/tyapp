
import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../generated/locales.g.dart';
import '../../config/analytic/analytics_utils.dart';
import '../../config/app_logger/app_logger.dart';
import '../../core/constant/common/module/play-mapping/play.dart';
import '../../core/format/common/module/format-score.dart';
import '../../global/ty_user_controller.dart';
import '../../global/ws/ws_app.dart';
import '../../global/ws/ws_type.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/route_check_util.dart';
import '../home/logic/other_player_name_to_playid.dart';
import '../home/models/main_menu.dart';
import '../match_detail/models/odds_button_enum.dart';
import '../quick_bet/quick_bet_controller.dart';
import 'combo_courage_bet/combo_courage_bet_controller.dart';
import 'esport_bet/esport_mix_bet_controller.dart';
import 'esport_bet/esport_single_bet_controller.dart';
import 'group_bet/group_single_bet_controller.dart';
import 'mix_bet/mix_bet_controller.dart';
import 'model/shop_cart_item.dart';
import 'model/shop_cart_type.dart';
import 'order/bet_order_controller.dart';
import 'shop_cart_state.dart';
import 'shop_cart_util_headcap.dart';
import 'vr_bet/vr_mix_bet_controller.dart';
import 'vr_bet/vr_single_bet_controller.dart';

part 'shop_cart_controller.part.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注控制类
      提供投注模块和其它模块的投注接口
      内部有6个控制器，分别是
        单关投注控制器、串关投注控制器、电竞单关投注控制器、电竞串关投注控制器、Vr单关投注控制器、Vr串关投注控制器
        根据当前菜单项和其它条件判断当前使用哪个控制器
    】】】
 *
 */
class ShopCartController extends GetxController {
  static ShopCartController get to => Get.put(
        ShopCartController(),
      ); //permanent: true);

  final ShopCartState state = ShopCartState();

  late SingleBetController singleBetController;
  late MixBetController mixBetController;
  late EsportSingleBetController esportSingleBetController;
  late EsportMixBetController esportMixBetController;
  late VrSingleBetController vrSingleBetController;
  late VrMixBetController vrMixBetController;
  //合买投注
  late GroupSingleBetController groupSingleBetController;
  //自选波胆
  late ComboCourageBetController comboCourageBetController;
  final isParlay = false.obs;
  final isEsportParlay = false.obs;
  final isVrParlay = false.obs;
  final isEsportBet = false.obs;
  final isVrBet = false.obs;
  final isGroupBet = false.obs;
  final isComboCourageBet  = false.obs;

  List lastC10Cd = [];
  Timer? refreshTimer;

  late BetOrderController betOrderController;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 初始化
        创建内部使用的各个投注控制器
      】】】
   *
   */
  @override
  void onInit() {
    super.onInit();

    singleBetController = Get.put(SingleBetController());
    mixBetController = Get.put(MixBetController());
    esportSingleBetController = Get.put(EsportSingleBetController());
    esportMixBetController = Get.put(EsportMixBetController());
    vrSingleBetController = Get.put(VrSingleBetController());
    vrMixBetController = Get.put(VrMixBetController());
    groupSingleBetController = Get.put(GroupSingleBetController());
    comboCourageBetController = Get.put(ComboCourageBetController());

    betOrderController = Get.put(BetOrderController());

    refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      //详情页面走EventType.matchTimerFetch
      if(Get.currentRoute != Routes.matchDetail) {
        refreshData();
      }
    });
    Bus.getInstance().on(EventType.matchTimerFetch, (_) {
      refreshData();
    });
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 关闭
        关闭时清除内部投注控制器
      】】】
   *
   */
  @override
  void onClose() {
    refreshTimer?.cancel();
    Bus.getInstance().off(EventType.matchTimerFetch);
    clearData();
    //clearData();
    Get.delete<SingleBetController>();
    Get.delete<MixBetController>();
    Get.delete<EsportSingleBetController>();
    Get.delete<EsportMixBetController>();
    Get.delete<VrSingleBetController>();
    Get.delete<VrMixBetController>();
    Get.delete<GroupSingleBetController>();
    Get.delete<ComboCourageBetController>();

    Get.delete<BetOrderController>();

    super.onClose();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 获取当前投注控制器
        根据串关、电竞、VR等各个维度判断出当前的数据容器
      】】】
   *
   */
  BaseBetController? get currentBetController {
    if( isGroupBet.value){
      return groupSingleBetController;
    } else if (isVrBet.value) {
      if (isVrParlay.value &&
          (Get.context != null &&
              MediaQuery.of(Get.context!).orientation !=
                  Orientation.landscape)) {
        return vrMixBetController;
      } else {
        return vrSingleBetController;
      }
    } else if (isEsportBet.value &&
        (Get.context != null &&
            MediaQuery.of(Get.context!).orientation != Orientation.landscape)) {
      if (isEsportParlay.value) {
        return esportMixBetController;
      } else {
        return esportSingleBetController;
      }
    } else {
      if (isParlay.value &&
          (Get.context != null &&
              MediaQuery.of(Get.context!).orientation !=
                  Orientation.landscape)) {
        //全屏模式下面为单关
        return mixBetController;
      } else {
        if(isComboCourageBet.value){
          return comboCourageBetController;
        }else {
          return singleBetController;
        }
      }
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 选择投注项，增加购物车条目
      可选参数：
        isDetail 是否详情页面发起投注。详情页面投注项数据和列表页面的有所不同
        betType 根据赛事纬度判断当前赛事属于 那种投注类型
        secondaryPaly 是否次要玩法
        matchDataType 遗留数据，已废弃
        playName  遗留数据，已废弃
        tipTitle  遗留数据，已废弃
      】】】
   *
   */
  void addBet(
      MatchEntity match, MatchHps place, MatchHpsHl? market, MatchHpsHlOl odds,
      {bool isDetail = false,
      OddsBetType betType = OddsBetType.common,
      bool secondaryPaly = false,
      String? matchDataType,
      String? playName,
      String? tipTitle,
      String? vrNo,
      }) {
    ///未登录时 点击赔率直接跳转登录
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;

    bool oddsIsDetail = odds.isDetail ?? false;
    if (currentBetController?.betStatus.value ==
        ShopCartBetStatus.OneClickBetting) {
      //正在一键投注，不接受其它投注项
      return;
    }

    final isComboCourageBetValue = isComboCourageBet.value;
    if(playIdConfig.customGallbladder.contains(place.hpid)){
      isComboCourageBet.value = true;
    }else{
      isComboCourageBet.value = false;
    }
    if(isComboCourageBetValue!=isComboCourageBet.value){
      comboCourageBetController.clearData();
    }

    // 有数据的再次点击 为取消投注项
    int itemIndex = currentBetController?.itemList
            .indexWhere((item) => item.playOptionsId == odds.oid) ??
        -1;
    if (itemIndex >= 0) {
      currentBetController
          ?.delShopCartItem(currentBetController!.itemList[itemIndex]);
      return;
    }

    if (currentBetController is MixBetController ){
       if(betType == OddsBetType.guanjun || (betType == OddsBetType.esport && (match.ispo == 0 || (market?.hipo??0)==0))
            || [ "O01"].contains(odds.cds)
            //|| ([2, 4].contains(match.mbmty)  && sportId != '1')
            || (betType == OddsBetType.common && place.hids!=1 )
       ) {
         //<!-- 不支持串关 -->
         ToastUtils.showMessageBox(title: LocaleKeys.no_crosstalk_title.tr,
             content: LocaleKeys.no_crosstalk_text.tr,
             button: LocaleKeys.no_crosstalk_button.tr);
         return;
       }
       var item = currentBetController?.itemList.firstWhereOrNull((element)=>element.betType != betType);
      if(item != null){
        //目前只有电竞赛事可能和常规赛事合串
        ToastUtils.showMessageBox(title: LocaleKeys.no_crosstalk_title.tr,
            content: LocaleKeys.bet_invalidation3.tr,
            button: LocaleKeys.no_crosstalk_button.tr);
        return;
      }
    }

    if (currentBetController is MixBetController &&
        (4 == odds.os.obs || 11 == market?.hs  || 11 == match.mhs )) {
      //<!-- 锁盘状态下 提示 赔率已变更  -->
      ToastUtils.showMessageBox(title:LocaleKeys.no_crosstalk_title.tr,content:LocaleKeys.bet_record_bet_suopan_info.tr,button:LocaleKeys.no_crosstalk_button.tr);
      return;
    }

    if (currentBetController is MixBetController ) {
      if(currentBetController!.itemCount >
          (currentBetController as MixBetController).maxSeriesNum) {
        ToastUtils.showGrayBackground(LocaleKeys.bet_bet_max_options.tr.replaceAll(
            '{num}',
            (currentBetController as MixBetController).maxSeriesNum.toString()));
        return;
      }else if(currentBetController!.itemCount ==
          (currentBetController as MixBetController).maxSeriesNum){
        ShopCartItem? shopCartItem = currentBetController?.itemList.firstWhereOrNull((elment)=>elment.matchId == match.mid);
        //如果存在同一赛事的shopCartItem，可以继续，因为是替换。否则报错
        if(shopCartItem == null){
          ToastUtils.showGrayBackground(LocaleKeys.bet_bet_max_options.tr.replaceAll(
              '{num}',
              (currentBetController as MixBetController).maxSeriesNum.toString()));
          return;
        }
      }
    }

    if(currentBetController is ComboCourageBetController){
      if(currentBetController!.itemCount >=4 && currentBetController!.itemList.safeFirst?.playId == place.hpid){
        ToastUtils.showGrayBackground(LocaleKeys.bet_bet_max_item_four.tr);
        return;
      }
    }

    //埋点
    AnalyticsEvent? hpidTrack = hpidTrackMap[place.hpid];
    if(hpidTrack!=null){
      Analytics.track(hpidTrack,
          pagePath: '', clickTarget: hpidTrack.name);
    }

    int matchType = getMatchType(betType, matchMs: match.ms);
    List handicapList = ShopCartUtilHandicap.getHandicap(
        match, place, market, odds, oddsIsDetail, betType,
        secondaryPaly: secondaryPaly);
    String playOptionName;
    // 详情投注项
    if (oddsIsDetail) {
      playOptionName = odds.otv.isNotEmpty ? odds.otv : odds.on;
    } else {
      playOptionName = odds.on.isNotEmpty ? odds.on : odds.otv;
    }

    ShopCartItem item = ShopCartItem();
    item.cds = odds.cds;
    item.sportId = match.csid;
    item.matchId = match.mid;
    item.tournamentId = match.tid;
    item.scoreBenchmark = match.msc.safeFirst ?? '';
    item.marketId = market?.hid ?? place.hid;
    item.marketValue = market?.hv ?? '';
    item.playOptionsId = odds.oid;
    item.marketTypeFinally = TYUserController.to.curOdds;
    item.odds = odds.ov;
    item.discountOdds= odds.dov;
    item.odds2 = odds.ov2;
    item.oddFinally = TYFormatOddsConversionMixin.computeValueByCurOddType(
            odds.ov,
            odds.ov2,
            place.hpid,
            betType == OddsBetType.guanjun?['1']:place.hsw.split(','),// 冠军只有欧赔
            int.tryParse(match.csid) ?? 0,
            odds.cds
    )
        .obs; //hsw?
    item.sportName = match.csna;
    item.matchType = matchType;
    item.matchName = match.tn;
    item.playOptionName = playOptionName;
    item.playOptions = odds.ot;
    item.tournamentLevel = match.tlev;
    item.playId =  place.hpid;
    item.cplayId = place.chpid;
    item.playName = getPlayName(
        match, place, market, odds, oddsIsDetail, betType,
        secondaryPaly: secondaryPaly);
    item.dataSource = odds.cds;
    item.home = match.mhn.length > 0
        ? match.mhn
        : (match.teams.length > 0 ? match.teams[0] : '');
    item.away = match.man.length > 0
        ? match.man
        : (match.teams.length > 1 ? match.teams[1] : '');
    //item.ot = odds.ot;  //playOptions
    item.placeNum = market?.hn;
    item.betAmount = '';
    item.betType = betType;
    item.tidName = match.tn;
    item.matchMs = match.ms;
    item.matchMmp = match.mmp;
    item.matchTime = match.mgt;
    item.handicap = handicapList.firstOrNull ?? '';
    item.handicapHv = ''.obs;
    if (handicapList.length > 1) {
      item.handicapHv.value = handicapList[1];
    }
    item.markScore = ShopCartUtilHandicap.calcBifen(match.msc,
        int.tryParse(match.csid) ?? 0, match.ms, int.tryParse(place.hpid) ?? 0);
    item.mbmty = match.mbmty;
    item.olOs = odds.os.obs;
    item.hlHs = (market?.hs ?? 0).obs;
    item.midMhs = match.mhs.obs;
    //matchCtr
    //deviceType
    item.oddsHsw = betType == OddsBetType.guanjun?'1':place.hsw;//冠军只有欧赔
    item.ispo = match.ispo;
    item.hipo = market?.hipo??0;
    item.hpsHids = place.hids;
    //有新添加的属性
    final score = TYFormatScore.formatTotalScore(match);
    item.scoreHome = score.home;
    item.scoreAway = score.away;
    item.scoreHomeAway = score.text.replaceAll(' ', '');
    item.preMarketValue = item.handicapHv.value;//预约用，使用lastMarketInfo里面对应的playOptions，这里先赋个值
    item.vrNo = vrNo??"";

    currentBetController?.addShopCartItem(item);

    // 一键投注
    if(currentBetController is SingleBetController && TYUserController.to.isOneClickBet.value){
      // 用户账户余额小于 设置的一键投注额，提示失败
      if(TYUserController.to.balanceAmount.value < TYUserController.to.oneClickBetAmount){
        // ShopCartUtil.showBetError('0400455',prefixMsg: '${LocaleKeys.bet_bet_err.tr}!');
        ///改为提示用户设置默认金额
        final settingMenuController = SettingMenuController();
        settingMenuController.onMaxOK();
        currentBetController?.clearData();
        return;
      }

      currentBetController!.betStatus.value = ShopCartBetStatus.OneClickBetting;
      currentBetController!.queryBetAmount().then((voidValue) {
        final betAmount = TYUserController.to.oneClickBetAmount;
        currentBetController!.amountController.text = betAmount.toString();

        currentBetController!.doBet().then((value) {
          if (!value) {
            //报错的话，进入正常流程
            currentBetController!.betStatus.value = ShopCartBetStatus.Normal;
            //报错的话，修改为只提示错误，不再展示投注框
            currentBetController!.closeBet();
          } else {
            if (QuickBetController.to.isOpen) {
              // 新流程 不展示投注框
              currentBetController!.closeBet();
            } else {
              currentBetController!.showBet();
            }
          }
        });
      });
    } else {
      //currentBetController?.queryBetAmount();
      currentBetController?.queryLatestMarketInfo(type: 'add_item');
      if ((currentBetController is VrMixBetController && isVrParlay.value) ||
          (currentBetController is EsportMixBetController &&
              isEsportParlay.value) ||
          (currentBetController is MixBetController && isParlay.value)
      ) {
        //串关显示收拢界面
        state.showShopCart.value = false;
      }else if(currentBetController is ComboCourageBetController){
        if(currentBetController!.itemCount==4){
          currentBetController?.showBet(queryAmount: true);
        }else{
          state.showShopCart.value = false;
        }
      } else {
        //单关显示投注界面
        //state.showShopCart.value = true;
        currentBetController?.showBet(queryAmount: true);
      }
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      -   投注项是否选中
      参数：
      oid 投注项ID
      】】】
   *
   */
  bool isCheck(String? oid) {
    if (oid == null || oid.isEmpty) {
      return false;
    }
    var shopCartItem = currentBetController?.itemList
        .firstWhereOrNull((item) => item.playOptionsId == oid);

    return shopCartItem != null;
  }
}
