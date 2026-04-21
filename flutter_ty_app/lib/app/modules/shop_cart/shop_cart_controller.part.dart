part of 'shop_cart_controller.dart';

extension ShopCartControllerExtensions on ShopCartController {

  /**
   *
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      -   获取赛事类型
      返回：
      1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
      参数：
      betType  投注类型
      matchMs  赛事阶段
      】】】
   *
   */
  int getMatchType(OddsBetType betType, {int? matchMs}) {
    // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
    int matchType = 1;
    // 冠军
    if (betType == OddsBetType.common) {
      //  ms的值，0:未开赛 1:滚球阶段 2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
      if ([1, 2, 110].contains(matchMs)) {
        matchType = 2;
      }
    }
    // 冠军
    if (betType == OddsBetType.guanjun) {
      matchType = 3;
    }
    // 电竞赛事 电竞冠军的话也为5
    if (betType == OddsBetType.esport ||
        currentBetController == esportSingleBetController ||
        currentBetController == esportMixBetController) {
      matchType = 5;
    }
    // 虚拟赛事
    if (betType == OddsBetType.vr) {
      matchType = 4;
    }

    return matchType;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      -   获取玩法名称
      】】】
   *
   */
  String getPlayName(MatchEntity match, MatchHps place, MatchHpsHl? market,
      MatchHpsHlOl odds, bool isDetail, OddsBetType betType,
      {bool secondaryPaly = false, bool isKemp = false}) {
    // chpid 优先于hpid
    String hpid = place.chpid.isNotEmpty ? place.chpid : place.hpid;
    String playName = ALL_SPORT_PLAY[int.tryParse(hpid) ?? 0] ?? '';

    if (secondaryPaly) {
      // 缺乏play_obj

      playName = place.hpnb.isNotEmpty ? place.hpnb : place.hpn;
    } else {
      if (isDetail) {
        // 详情 并且本地没有配置玩法
        playName = place.hpn;
      } else {
        String hpn = place.hpn;
        //暂无play_obj
        //hpn = lodash_.get(mid_obj.play_obj,`hpid_${hpid}.hpn`,play_name)
        // 冠军玩法 部分玩法hpid相同
        if (betType == OddsBetType.guanjun || isKemp) {
          List<MatchHps> hpnList = [];
          //暂无hpsPns
          //hpnList = match.hpsPns;
          if (hpnList.isEmpty) {
            hpnList = match.hps;
          }
          MatchHps? hpnObj =
          hpnList.firstWhereOrNull((item) => item.hid == place.hid);
          if (hpnObj?.hid != null) {
            hpn = hpnObj!.hpn.isNotEmpty ? hpnObj.hpn : hpnObj.hps;
          } else {
            hpn = LocaleKeys.bet_bet_winner.tr;
          }
        }else{
          hpn = place.hpnb.isNotEmpty ? place.hpnb : place.hpn;
        }
        /*  不明
        // 15分钟玩法 单独处理 3201,3301,3401
        // 下一局 2801,1201,14901
        if ([3201, 3301, 3401, 2801, 1201, 14901, 3202, 3402, 3302].contains(int.tryParse(hpid)??0)) {
          hpn = place.hpn.isNotEmpty ? place.hpn : place.hpnb;
        }
         */
        if (hpn.isNotEmpty) {
          playName = hpn;
        }
      }
    }

    return playName;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      -  菜单切换
      判断当前是否只支持串关。如果是串关、冠军等只支持欧赔的菜单，
      需将当前赔率设置成欧洲盘，并保留原来的赔率类型，
      在菜单切换回去的时候将赔率类型恢复
      】】】
   *
   */
  void changeMenuIndex(MainMenu menu) {
    isParlay.value = menu.isMatchBet &&
        (Get.currentRoute == Routes.mainTab ||
            Get.currentRoute == Routes.matchDetail ||
            state.currentRoute == Routes.mainTab ||
            state.currentRoute == Routes.matchDetail);
    // if(!isParlay.value && mixBetController.itemCount > 0){
    //   mixBetController.clearData();
    // }
    if(!isEsportParlay.value && esportMixBetController.itemCount>0){
      esportMixBetController.clearData();
    }
    if(!isVrParlay.value && vrMixBetController.itemCount>0){
      vrMixBetController.clearData();
    }
    if(!isComboCourageBet.value && comboCourageBetController.itemCount>0){
      comboCourageBetController.clearData();
    }

    bool isDjMenu =
        ShopCartController.to.isEsportBet.value;
    bool isVrMenu =
        ShopCartController.to.isVrBet.value;
    //切换到冠军盘
    if (isEuOnly(menu:menu,isDjMenu: isDjMenu) &&
        !isEuOnly()) {
      TYUserController.to.preOdds = TYUserController.to.curOdds;
      TYUserController.to.curOdds = 'EU';
    } else if (!isEuOnly(menu:menu,isDjMenu: isDjMenu) &&
        isEuOnly()) {
      TYUserController.to.curOdds = TYUserController.to.preOdds;
    }

    if(isVrMenu && !state.isVrMenu){
      TYUserController.to.preOdds = TYUserController.to.curOdds;
      if(TYUserController.to.curOdds!="EU" && TYUserController.to.curOdds!="HK") {
        TYUserController.to.curOdds = 'EU';
      }
    }else if(!isVrMenu && state.isVrMenu){
      TYUserController.to.curOdds = TYUserController.to.preOdds;
    }

    state.menu = menu;
    state.isDjMenu = isDjMenu;
    state.isVrMenu = isVrMenu;

    //Bug 90681,和H5同步，点过串关后就关闭一键投注。这是2B做法，必然会改
    // if(isParlayMode()){
    //   if(TYUserController.to.isOneClickBet.value) {
    //     TYUserController.to.isOneClickBet.value = false;
    //     MenuApi.instance().saveUserCustomizeInfo(
    //       TYUserController.to.seriesList,
    //       TYUserController.to.singleList,
    //       false,
    //       false,
    //       TYUserController.to.oneClickBetAmount.toInt().toString(),
    //     );
    //     var settingMenuController = Get.findOrNull<SettingMenuController>();
    //     if(settingMenuController!=null){
    //       settingMenuController.switchOn = TYUserController.to.isOneClickBet.value;
    //     }
    //   }
    // }
  }

  bool isParlayMode(){
    return  (state.menu.isMatchBet && !isEsportBet.value && !isVrBet.value)
        || (isEsportBet.value && isEsportParlay.value)
        || (isVrBet.value && isVrParlay.value);
  }

  bool isEuOnly({MainMenu? menu,String? sportId,bool? isDjMenu})
  {
    if(menu == null){
      menu = state.menu;
    }
    if(sportId == null){
      sportId = state.sportId;
    }
    if(isDjMenu == null){
      isDjMenu = state.isDjMenu;
    }
    //return (menu.isChampion || menu.isMatchBet) || (sportId=="190" || sportId=="191") || isDjMenu;
    return (menu.isChampion || menu.isMatchBet) || isDjMenu;
  }

  bool isChampion(){
    return state.menu.isChampion;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      -  sportId菜单切换
      现在电子足球电子篮球放开赔率切换，已无需调用此方法
      】】】
   *
   */
  void changeSportId(String sportId) {
    //切换到电子足球电子篮球
    if (isEuOnly(sportId:sportId) &&
        !isEuOnly()) {
      TYUserController.to.preOdds = TYUserController.to.curOdds;
      TYUserController.to.curOdds = 'EU';
    } else if (!isEuOnly(sportId:sportId) &&
        isEuOnly()) {
      TYUserController.to.curOdds = TYUserController.to.preOdds;
    }

    state.sportId = sportId;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 根据当前的投注项 获取对应的赔率变化ws
      】】】
   *
   */
  void subscribeMarket() {
    List itemList = [];
    //订阅需一起订阅
    itemList.addAll(singleBetController.itemList);
    itemList.addAll(mixBetController.itemList);
    itemList.addAll(esportSingleBetController.itemList);
    itemList.addAll(esportMixBetController.itemList);
    itemList.addAll(vrSingleBetController.itemList);
    itemList.addAll(vrMixBetController.itemList);
    if (itemList.isEmpty) {
      //购物车无数据
      return;
    }

    List marketIds = [];
    List matchIds = [];
    itemList.forEach((element) {
      marketIds.add(element.marketId);
      matchIds.add(element.matchId);
    });
    marketIds = marketIds.toSet().toList();
    matchIds = matchIds.toSet().toList();

    Map<String, dynamic> C2Map = {};
    C2Map['hid'] = marketIds.join(',');
    C2Map['mid'] = matchIds.join(',');
    C2Map['marketLevel'] = TYUserController.to.userInfo.value?.marketLevel ?? 0;
    C2Map['esMarketLevel'] =
        TYUserController.to.userInfo.value?.esMarketLevel ?? 0;


    // 取消之前的所有订阅
    C2Map['hid'] = '';
    sendBetC02Message(C2Map);
    C2Map['hid'] = marketIds.join(',');
    // 重新发起
    Future.delayed(Duration(milliseconds: 10), () {
      sendBetC02Message(C2Map);
    });

    //Vue代码没走C10订阅，可能有点问题
    //C10，只发普通投注
    List objCd = [];
    marketIds.clear();
    matchIds.clear();
    itemList.clear();
    itemList.addAll(singleBetController.itemList);
    itemList.addAll(mixBetController.itemList);
    itemList.forEach((element) {
      marketIds.add(element.marketId);
      matchIds.add(element.matchId);
      objCd.add({
        'mid': element.matchId,
        'hpid': element.playId,
        'chpid': element.cplayId,
        'hn': element.placeNum,
      });
    });
    marketIds = marketIds.toSet().toList();
    matchIds = matchIds.toSet().toList();

    Map<String, dynamic> C10Map = {};
    C10Map['hid'] = marketIds.join(',');
    C10Map['mid'] = matchIds.join(',');
    C10Map['marketLevel'] =
        TYUserController.to.userInfo.value?.marketLevel ?? 0;
    C10Map['esMarketLevel'] =
        TYUserController.to.userInfo.value?.esMarketLevel ?? 0;


    C10Map['cd'] = objCd;
    sendBetC10Message(C10Map);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 发送C02 ws
      】】】
   *
   */
  sendBetC02Message(Map obj) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C2;
    cmd_obj['hid'] = obj['hid'];
    cmd_obj['mid'] = obj['mid'];
    cmd_obj['marketLevel'] = obj['marketLevel'];
    cmd_obj['esMarketLevel'] = obj['esMarketLevel'];
    ///早盘分组
    cmd_obj['earlyMarketLevel'] = TYUserController.to.userInfo.value?.earlyMarketLevel ?? 0;
    ///滚球分组
    cmd_obj['rollingMarketLevel'] = TYUserController.to.userInfo.value?.rollingMarketLevel ?? 0;
    if(obj['hid'] == null || obj['hid'].isEmpty) {
      // 取消之前的所有订阅
      cmd_obj['cclose'] = 1;
    }


    if (cmd_obj['mid'] != "") {
      try {
        AppWebSocket.instance().sendMsg(cmd_obj);
      }catch(e){
        AppLogger.debug(e.toString());
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
      - 发送C10订阅
      】】】
   *
   */
  sendBetC10Message(Map obj) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C10;
    cmd_obj['marketLevel'] = obj['marketLevel'];
    cmd_obj['esMarketLevel'] = obj['esMarketLevel'];
    ///早盘分组
    cmd_obj['earlyMarketLevel'] = TYUserController.to.userInfo.value?.earlyMarketLevel ?? 0;
    ///滚球分组
    cmd_obj['rollingMarketLevel'] = TYUserController.to.userInfo.value?.rollingMarketLevel ?? 0;

    // 需要订阅的数据
    cmd_obj['cd'] = obj['cd'];
    // 是否全局取消订阅
    cmd_obj['cws'] = false;
    // 需求取消订阅的数据
    cmd_obj['cn'] = [];

    // 上次订阅的内容 和当前订阅的内容做对比，当前没有订阅的上次内容需要做 取消订阅处理
    lastC10Cd.forEach((element1) {
      bool exists = false;
      for (Map element2 in obj['cd']) {
        if (element1['mid'] == element2['mid'] &&
            element1['hpid'] == element2['hpid'] &&
            element1['chpid'] == element2['chpid'] &&
            element1['hn'] == element2['hn']) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        cmd_obj['cn'].add(element1);
      }
    });

    //记录此次订阅的内容
    lastC10Cd = cmd_obj['cd'];


    try{
      AppWebSocket.instance().sendMsg(cmd_obj);
    }catch(e){
      AppLogger.debug(e.toString());
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
      - 刷新投注项
      】】】
   *
   */
  void refreshData() {
    /*
    if (currentBetController == mixBetController) {
      mixBetController.queryLatestMarketInfo(type: 'set_bet');
      if (refreshTimer == null) {
        //如果有定时器，定时器会刷
        Future.delayed(Duration(milliseconds: 3000), () {
          singleBetController.queryLatestMarketInfo(type: 'set_bet');
        });
      }
    } else {
      singleBetController.queryLatestMarketInfo(type: 'set_bet');
      if (refreshTimer == null) {
        //如果有定时器，定时器会刷
        Future.delayed(Duration(milliseconds: 3000), () {
          mixBetController.queryLatestMarketInfo(type: 'set_bet');
        });
      }
    }
     */
    currentBetController?.queryLatestMarketInfo(type: 'set_bet');
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 清除数据
      】】】
   *
   */
  void clearData() {
    singleBetController.clearData();
    mixBetController.clearData();
    esportSingleBetController.clearData();
    esportMixBetController.clearData();
    vrSingleBetController.clearData();
    vrMixBetController.clearData();
    groupSingleBetController.clearData();
    comboCourageBetController.clearData();
    betOrderController.clearData();
  }
}