import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/pin_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/secondary_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/home_controller_logic.dart';
import 'package:flutter_ty_app/app/modules/home/models/hot_league_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_list_type.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import '../../../../generated/locales.g.dart';
import '../../../global/config_controller_ext.dart';
import '../../../services/api/menu_api.dart';
import '../../../config/analytic/analytics_utils.dart';
import '../../../services/models/res/match_entity.dart';
import '../../pip_video/pip_video_controller.dart';
import '../../quick_bet/quick_bet_controller.dart';
import '../models/main_menu.dart';
import '../widgets/menu/league/hotLeagueController.dart';
import 'home_controller.dart';

////////////////          处理交互逻辑      //////////////////
extension TyHomeControllerExtension on TyHomeController {
  //重置
  _resetListState() {
    SecondaryController.index = 0;
    // 切换球种时必须清空旧球种数据，防止逻辑层过滤不彻底或 SWR 缓存回流导致的瞬闪
    homeState.matchtSet.clear();
    homeState.combineList.clear();
    PinController.to?.clearPin(); // 同步清空置顶，防止闪烁旧球种置顶
    // 切换球种时，先设为加载中，SWR 如果有缓存会立即交付并重置此状态
    homeState.refreshStatus = RefreshStatus.isLoading;

    // 联赛列表
    homeState.league = HotLeagueController.to?.hotLeagueList.safeFirst ??
        HotLeagueInfo(SportConfigInfo());
    homeState.matchListReq.tid = homeState.league.tid;
    homeState.matchListReq.etid = homeState.league.eid;
    homeState.matchListReq.euid = homeState.league.sportConfigInfo.mi;
    update();
  }

  //切换时间日期
  Future<void> changeDateTime(int? value) async {
    // 立即销毁旧协调器
    matchCoordinator?.dispose();
    matchCoordinator = null;

    _resetListState();
    homeState.dateTime = value;
    if (value != null) {
      homeState.matchListReq.md = value.toString();
    } else {
      homeState.matchListReq.md = null;
    }
    fetchData();
    PinController.to?.refreshPin();
    // getAddedOddsMatches();
  }

  setLeague() {
    if (homeState.sportId == SportConfig.HotMenuLeague.sportId.toString()) {
      List<SportConfigInfo> sportConfigInfoList =
          ConfigController.to.getHotMenu(homeState.menu.mi);
      HotLeagueController.to?.generateHotLeagueList(
          sportConfigInfoList.map((e) => HotLeagueInfo(e)).toList());
      HotLeagueController.to?.showLeageuFilter.value = false;
    } else {
      HotLeagueController.to?.showLeageuFilter.value = true;
      List<HotLeagueInfo> hotAll = ConfigController.to
          .getLeagues(homeState.menu, homeState.sportId)
          .map((e) => HotLeagueInfo(e))
          .toList();

      /// 滚球全部
      if (homeState.sportId == SportConfig.MatchAllPage.sportId.toString()) {
        HotLeagueInfo all = HotLeagueInfo(SportConfigInfo());
        all.name = LocaleKeys.app_h5_match_all;
        final index = homeSportMenuState.sportMenuList
            .indexWhere((e) => e.euid.contains(','));
        String euids = homeSportMenuState.sportMenuList[index].euid;
        all.sportConfigInfo.mi = euids;
        hotAll.insert(0, all);
      } else {
        HotLeagueInfo all = HotLeagueInfo(SportConfigInfo());
        all.sportConfigInfo.mi = _getEuid();
        all.name = LocaleKeys.app_h5_match_all;
        hotAll.insert(0, all);
      }
      HotLeagueController.to?.generateHotLeagueList(hotAll);
    }
  }

  Future<void> changeMenu(MainMenu menu,{bool clearMatchDiscount=true}) async {
    //防抖
    if (homeState.menu == menu) {
      return;
    }

    // 立即销毁旧协调器以防止竞态条件
    matchCoordinator?.dispose();
    matchCoordinator = null;

    // 上传埋点
    AppLogger.debug(
        "==========>菜单埋点  ${menu.mi} result  ${homeState.sportMenuMap[menu.mi]}");


    if(clearMatchDiscount){
      // 删除增值赔率缓存
      homeState.matchtDiscount.clear();
      homeState.discountMidStringList.clear();
    }
    if (homeState.sportMenuMap[menu.mi] != null) {
      Analytics.track(homeState.sportMenuMap[menu.mi]!,
          pagePath: '',
          clickTarget: homeState.sportMenuMap[menu.mi].toString());
    }

    /// 切换菜单时，需要重置选择状态
    ///冠军
    if (menu.mi == 400) {
      //切换冠军
      homeState.listType = MatchListType.champion;
    } else {
      ///切换菜单 非冠军列表 清空冠军赛事展开收起缓存
      homeState.expandStateCache.clear();
      //切换主页
      homeState.listType = MatchListType.home;
    }

    /// 一级菜单数据切换清理搜索的数据
    homeState.isSearch = false;
    homeState.searchText = '';
    homeState.dateTime = null;
    if (menu.isMatchBet) {
      //串关
      homeState.matchListReq.md = '0';

      // 串关隐藏一键投注列表
      QuickBetController.to.isTempClose.value = true;
    } else {
      homeState.matchListReq.md = null;
      QuickBetController.to.isTempClose.value = false;
    }
    if (menu.isChampion) {
      homeState.matchListReq.category = null;
      homeState.matchListReq.hpsFlag = null;
    } else {
      homeState.matchListReq.category = 1;
      homeState.matchListReq.hpsFlag = 0;
    }
    List<SportMenu> sportMenuList =
        ConfigController.to.getSportMenuListByMenuMi(menu);
    homeSportMenuState.sportMenuList.value = sportMenuList;
    //球类id
    // const mi = `${常规球类csid}${一级菜单id}`;
    String mi = homeState.sportId;
    String targetMi = homeState.sportId;

    /// 当前是冠军
    if (homeState.menu.isChampion) {
      targetMi = ((mi.toInt() - 400) + 100).toString();
    } else if (!homeState.menu.isChampion && menu.isChampion) {
      targetMi = ((mi.toInt() - 100) + 400).toString();
    }

    int index = sportMenuList.indexWhere((element) => element.mi == targetMi);
    if (index >= 0) {
      homeState.sportId = targetMi;
    } else {
      homeState.sportId = ConfigController.to.getFirstSportId(menu);
    }

    homeState.menu = menu;
    setLeague();
    _resetListState();
    Bus.getInstance().emit(
      EventType.leagueReset,
    );

    ///修复：串关下的热门，强制保持
    homeState.matchListReq.euid = _getEuid();
    homeState.matchListReq.type = menu.type;
    homeState.matchListReq.tid = homeState.league.tid;

    /// 获取收藏的数据
    CollectionController.to.fetchCollectionCount();
    homeSportMenuState.leftShow.value = false;
    homeSportMenuState.rightShow.value = false;
    update();
    fetchData();
    // getAddedOddsMatches();
    PinController.to?.refreshPin();

    ///底部菜单刷新
    MainTabController.to.update();

    ShopCartController.to.changeMenuIndex(homeState.menu);
  }

  ///锚点 临时写死拼配
  String _getEuid() {
    String euid =
    ConfigController.to.getOldSportId(homeState.sportId, homeState.menu.mi);
    if (homeState.sportId == SportConfig.FavoritesPage.sportId.toString()) {
      List<SportMenu> sportMenus =
          ConfigController.to.getSportMenuListByMenuMi(homeState.menu);
      euid = sportMenus.first.euid;
    }

    ///串关获取的euid问题  根据sportid 强制指定euid 为6004
    /// 滚球6001   今日6002  早盘6003  串关6004  PC全部6005
    if (homeState.sportId == '600') {
      euid = '6004';
    }
    return euid;
  }

  /**
   * 新手版和专业版切换
   */
  Future<void> changeNew(bool value) async {
    // 玩法埋点上传
    AppLogger.debug("==========>新手版和专业版切换埋点  value ${value}  ");
    Analytics.track(value ? AnalyticsEvent.btn_pro : AnalyticsEvent.btn_rookie,
        pagePath: '',
        clickTarget:
            (value ? AnalyticsEvent.btn_pro : AnalyticsEvent.btn_rookie)
                .toString());
    homeState.isProfess = value;
    if (!isClosed) {
      update();
    }
    if (!RouteCheckUtil.checkIsLogin()) return;
    final res =
        await MenuApi.instance().setUserPersonaliseT(value == true ? 0 : 1);
    if (res.code.contains('0000000')) {
      BoolKV.userVersion.save(value);
    } else {
      ToastUtils.show(res.msg);
    }
  }

  /**
   * 热门时间排序
   */
  Future<void> changeHot(bool value) async {
    // Dispose old coordinator immediatelyold coordinator immediately
    matchCoordinator?.dispose();
    matchCoordinator = null;

    // 玩法埋点上传
    AppLogger.debug("==========>热门时间排序埋点  value ${value}  ");
    Analytics.track(value ? AnalyticsEvent.btn_hot : AnalyticsEvent.btn_time,
        pagePath: '',
        clickTarget: (value ? AnalyticsEvent.btn_hot : AnalyticsEvent.btn_time)
            .toString());
    SecondaryController.index = 0;
    homeState.combineList.clear();
    homeState.matchtSet.clear();
    homeState.isHot = value;
    BoolKV.sort.save(value);
    homeState.matchListReq.sort = value ? 1 : 2;
    fetchData(isSortChange: true);

    String? token = StringKV.token.get();
    if (token?.isNotEmpty ?? false) {
      final res =
          await MenuApi.instance().rememberSelect(value == true ? 1 : 2);
      if (res.code.contains('0000000')) {
      } else {
        ///接口错误 会返回乱码
        // ToastUtils.show(res.msg);
        ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg02.tr);
      }
    }
  }

  Future<void> changeSport(String sportId, String euid) async {
    AppLogger.debug("changeSport sportId = $sportId euid = $euid");

    // 玩法埋点上传
    Analytics.track(AnalyticsEvent.menu_sport_xxx,
        replaceEventName: "menu_sport_$sportId",
        pagePath: '',
        clickTarget: "menu_sport_$sportId");
    if (homeState.listType != MatchListType.home ||
        homeState.listType == MatchListType.champion) {
      if (homeState.listType == MatchListType.champion) {
        homeState.listType = MatchListType.champion;
      } else {
        homeState.listType = MatchListType.home;
      }
      update();
    } else {
      // 防止重复点击
      if (sportId == homeState.sportId) {
        if (homeState.isSearch) {
          search(homeState.searchText);
        }
        return;
      }
    }
    if (sportId != homeState.sportId) {
      homeState.matchtDiscount.clear();
      homeState.discountMidStringList.clear();
    }

    // 立即销毁旧协调器
    matchCoordinator?.dispose();
    matchCoordinator = null;

    AppLogger.debug('timer 1-- ${DateTime.now()}');
    CollectionController.to.fetchCollectionCount();
    homeState.sportId = sportId;

    /// 真人娱乐，彩票投注，注单
    if ([
      SportConfig.ZRPage.sportId.toString(),
      SportConfig.CPPage.sportId.toString(),
      SportConfig.BettingPage.sportId.toString()
    ].contains(sportId)) {
      update();
      return;
    }
    setLeague();
    _resetListState();
    homeState.matchListReq.euid = euid;
    fetchData();
    // getAddedOddsMatches();
    PinController.to?.refreshPin();

    ///底部菜单刷新
    MainTabController.to.update();
  }

  ///切换联赛
  void changeLeague(HotLeagueInfo league) {
    // 立即销毁旧协调器
    matchCoordinator?.dispose();
    matchCoordinator = null;

    homeState.isSearch = false;
    homeState.searchText = '';
    SecondaryController.index = 0;
    homeState.matchtSet.clear();
    homeState.combineList.clear();
    update();
    homeState.league = league;
    homeState.matchListReq.tid = league.tid;
    homeState.matchListReq.etid = league.eid;
    homeState.matchListReq.euid = league.sportConfigInfo.mi;
    if (homeState.sportId == SportConfig.HotMenuLeague.sportId.toString()) {
      HotLeagueController.to?.showLeageuFilter.value = false;
    } else {
      HotLeagueController.to?.showLeageuFilter.value = league.tid.isEmpty;
    }
    fetchData(isLeague: true);
    PinController.to?.refreshPin();
  }

  ///切换联赛
  void changeLanguage() {
    fetchData();
    PinController.to?.refreshPin();
    // getAddedOddsMatches();
  }

  /// 更新可视化的数据
  Future<void> refreshData() async {
    //List<String> list = List.from(DataStoreController.to.showMatchIdList);
    List<String> list = TyHomeControllerLogic.getNextMatchIds(
      homeState.combineList,
      homeState.visiableFirstIndex,
      homeState.visiableLastIndex,
    );
    TyHomeControllerLogic.preLoadNextMatchBaseInfoList(
      list,
    );
  }

  /// 画中画交互
  changePipVideo({String type = "video", MatchEntity? matchEntity}) async {
    if (matchEntity == null) {
      homeState.isShowPipVideo = false;
      return;
    }

    if (!homeState.isShowPipVideo) {
      final pipVideoController =
          Get.put<PipVideoController>(PipVideoController());
      await pipVideoController.initializeWebView();
      pipVideoController.initMatch(matchEntity);
      homeState.isShowPipVideo = true;
    } else {
      final pipVideoController = Get.find<PipVideoController>();
      pipVideoController.initMatch(matchEntity);
      pipVideoController.play(type);
    }

    update();
  }

  closePipVideo() {
    homeState.isShowPipVideo = false;
    update();
  }
}
