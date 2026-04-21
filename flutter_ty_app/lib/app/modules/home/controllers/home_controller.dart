import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_discount_odd_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_event_bus.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_sport_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/pin_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/home_controller_logic.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/home/states/home_state.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/services/models/res/get_odd_count_bean_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/config/swr/refresh_coordinator.dart';
import 'package:flutter_ty_app/app/config/swr/swr_mixins.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/easy_debounce_throttle/easy_debounce.dart';
import '../../../config/getx_navigation.dart';
import '../../../global/ty_user_controller.dart';
import '../../beginners_guide/beginners_guide_controller.dart';
import '../../beginners_guide/beginners_guide_view.dart';
import '../logic/other_player_name_to_playid.dart';
import '../models/play_info.dart';
import '../states/home_sport_menu_state.dart';
import '../widgets/menu/league/hotLeagueController.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-2bb81bd0-39de-4ec2-bb5c-ea27b888e48c-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 体育首页赛事功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  体育首页控制器 】】】
    【【【 AUTO_PARAGRAPH_TITLE 首页接口数据处理 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 球种列表获取
    - 滑动监听推送
    - 切换时间日期
    - 更新收藏数据
    - 顶级菜单切换显示逻辑
    - 更新可视化的数据
    - 处理交互逻辑
    】】】
 *
 */

enum ScrollDirectionType {
  up, ///向上滚动
  down, ///向下滚动
  idle
}

class TyHomeController extends GetxController
    with GetSingleTickerProviderStateMixin, SwrMixin {

  RefreshCoordinator<List<MatchEntity>>? matchCoordinator;

  ///子玩法
  Map SecondaryNameMap = {};

  ScrollController championScrollController = ScrollController();
  ScrollController commonScrollController = ScrollController();
  MatchHpsHlOl? firstMap;
  HomeSportMenuState homeSportMenuState = HomeSportMenuState();
  HomeState homeState = HomeState();
  bool isInited = false;
  MatchHpsHlOl? lastMap;
  late PageController pageController;
  double previousOffset = 0;

  ///子玩法名称
  String secondaryName = '';

  bool showTop = false;
  // 默认隐藏
  bool showVrSportMenu = true;

  ScrollController sportMenuController = ScrollController();
  GlobalKey? sportSelectKey = GlobalKey();
  bool visiable = true;

  Timer? championTimer;

  ///  新手版/专业版弹窗  0是开启1是不开启
  String popUps = '1';

  //KySwitch作为全局配置，存放在TYHomeController
  KySwitch? kySwitch;

  @override
  void onClose() {
    removeBus();
    removeListenerC301();
    removeListenerDiscountOdd();
    pageController.dispose();
    commonScrollController.dispose();
    championScrollController.dispose();
    cancelTimerUpdate();
    championTimer?.cancel();
    EasyDebounce.cancel('home_search_debounce');
    matchCoordinator?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    commonScrollController = ScrollController();
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    handleEventBus();
    Get.put(HotLeagueController(), permanent: true);

    ///菜单栏目球种数量变化时触发wS
    addListenerC301();
    addListenerDiscountOdd();
    super.onInit();
    isInited = true;
    commonScrollController.addListener(_scrollListener);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    PinController.to?.refreshPin();
    getSport();

    fetchData();

    ///更新收藏数据
    4000.milliseconds.delay().then((value) {
      CollectionController.to.fetchCollectionCount();
      CollectionController.to.updateCollection();
    });

    ///冠军定时器7s刷新
    // championTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
    //   ///冠军页面自动刷新
    //   if (homeState.menu.isChampion) {
    //     fetchData(isWsFetch: true);
    //   }
    // });
    getUserPersonalise();
  }

  /// 新手版/专业版弹窗 开关
  Future<void> getUserPersonalise() async {
    final personaliseRes = await AccountApi.instance().getUserPersonalise(1);
    if (personaliseRes.success && personaliseRes.data != null) {
      ///  新手版/专业版弹窗  0是开启1是不开启
      if (personaliseRes.data!.popUps.contains('0')) {
        beginnersGuide();
      }
      update();
    }
  }

  beginnersGuide() {
    Get.lazyPut(() => BeginnersGuideController());
    Get_TY.bottomSheet(
      const BeginnersGuidePage(),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.2),
    );
  }

  static TyHomeController get to {
    if (Get.isRegistered<MainTabController>() &&
        Get.isRegistered<TyHomeController>(tag: MainTabController.to.uuid)) {
      return Get.find(tag: MainTabController.to.uuid);
    } else {
      ///为避免外层做isRegistered判断，或者在TyHomeController销毁后调用TyHomeController.to导致Get.find抛异常
      ///返回一个临时的TyHomeController实例
      ///由于该实例没有经过Get框架的onInit生命周期，可以用TyHomeController.to.isInited来判断是否时临时实例（TyHomeController.to返回可Null为更好方案）
      // AppLogger.debug("==============TyHomeController not found!!!===========");
      //AppLogger.debug('Current stack trace: \n${StackTrace.current}');
      //暂时PinController调用不打印
      final stackTrace = StackTrace.current.toString();
      final topThreeLines = stackTrace.split('\n').take(3).join('\n');
      if (!topThreeLines.contains('PinController')) {
        // AppLogger.debug('Current stack trace: \n${topThreeLines}');
      }
      return TyHomeController();
    }
  }

  void setSecondaryName(String secondary, String mid) {
    SecondaryNameMap.addAll({mid: secondary});
  }

  String getSecondaryName(String mid) {
    secondaryName = SecondaryNameMap[mid] ?? "";
    return secondaryName;
  }

  MatchHpsHlOl? setFirstMap(MatchHpsHlOl? firstMap) {
    this.firstMap = firstMap;
    return this.firstMap;
  }

  MatchHpsHlOl? setLastMap(MatchHpsHlOl? lastMap) {
    this.lastMap = lastMap;
    return this.lastMap;
  }

  ///球种列表
  getSport() {
    List<SportMenu> sportMenuList =
        ConfigController.to.getSportMenuListByMenuMi(homeState.menu);
    homeSportMenuState.sportMenuList.value = sportMenuList;
    setLeague();
  }

  //getMatchBaseInfoByMidsPB 子玩法接口
  getMatchBaseInfo(MatchEntity match, PlayInfo _playInfo) async {
    if([playIdConfig.hpsSection1,playIdConfig.hpsSection2,playIdConfig.hpsSection3,playIdConfig.hpsSection4,playIdConfig.hpsFirstHalf,playIdConfig.hpsSecondHalf].contains(_playInfo.playId)) {
      //篮球玩法先清老数据
      match.hpsSectionPlay = [];
    }
    try {
      final res = await MatchApi.instance().getMatchBaseInfo(
          match.mid,
          TYUserController.to.getUid(),
          1,
          null,
          'v2_h5_st',
          _playInfo.pids,
          'is-user',
          _playInfo.playId.toInt(),
          /* "0",
              null,
              0,*/
          null,
          [
            {"mid": match.mid, "playId": _playInfo.playId.toInt()}
          ]
      );
      if (res.success && res.data != null && res.data!.isNotEmpty) {
        DataStoreController.to.updateMatch(res.data!.first, keepSecondary: true, ishomebyMyId: true);
      }

    } catch (e) {
      AppLogger.error(e);
    }
  }

  void search(String value) {
    ///首页输入防抖
    EasyDebounce.debounce(
      'home_search_debounce',
      const Duration(milliseconds: 300),
          () {
        _doSearch(value);
      },
    );
  }

  void _doSearch(String value) {
    if (ObjectUtil.isEmptyString(value)) {
      homeState.isSearch = false;
      homeState.searchText = '';
      homeState.combineList.clear();
      homeState.combineList =
          TyHomeControllerLogic.getMatchHandle(homeState.matchtSet);
      update();
      return;
    }
    homeState.isSearch = true;
    homeState.searchText = value;
    List<MatchEntity> searchMatchList = [];
    List<String> showMatchList = [];
    String lowerStr = value.toLowerCase();
    for (var element in homeState.matchtSet) {
      /// 模糊搜索
      if (element.tn.containsFuzzy(lowerStr) ||
          element.man.containsFuzzy(lowerStr) ||
          element.mhn.containsFuzzy(lowerStr)) {
        searchMatchList.add(element);
        showMatchList.add(element.mid);
      }
    }
    homeState.combineList.clear();
    homeState.combineList =
        TyHomeControllerLogic.getMatchHandle(searchMatchList);
    update();

    ///搜索出联赛结果 需要重新请求相关的联赛
    TyHomeControllerLogic.preLoadNextMatchBaseInfoList(showMatchList);
  }

  void removeMatch(String mid) {
    if (homeState.sportId == SportConfig.FavoritesPage.sportId.toString()) {
      homeState.matchtSet.removeWhere((element) => element.mid == mid);
      if (listIsNotEmpty()) {
        handleData();
      }
    }
  }

  void removeMatchs(String tid) {
    if (homeState.sportId == SportConfig.FavoritesPage.sportId.toString()) {
      homeState.matchtSet.removeWhere((element) => element.tid == tid);
      if (listIsNotEmpty()) {
        handleData();
      }
    }
  }

  bool listIsNotEmpty() {
    if (homeState.matchtSet.isEmpty) {
      homeState.refreshStatus = RefreshStatus.loadNoData;
      update();
      return false;
    } else {
      return true;
    }
  }

  void _scrollListener() {
    ///先把状态去重
    if (!commonScrollController.hasClients) return;
    /// 超过一屏显示返回顶部按钮
    final offset = commonScrollController.offset;
    final screenHeight = Get.context!.mediaQuerySize.height;
    final bool shouldShowTop = offset > screenHeight;
    if (shouldShowTop == showTop) {
      _handleScrollDirection(offset);
      return;
    }
    ///有变化才更新
    showTop = shouldShowTop;
    update(['showTop']);

    ///只在显示时触发
    if (showTop) {
      EasyDebounce.debounce(
        'showTop_auto_hide',
        const Duration(seconds: 5),
            () {
          if (showTop) {
            showTop = false;
            update(['showTop']);
          }
        },
      );
    }
    _handleScrollDirection(offset);
  }

  ///最后状态
  ScrollDirectionType _lastDirection = ScrollDirectionType.idle;
  /**
   * 确定滚动方向
   */
  void _handleScrollDirection(double offset) {
    ScrollDirectionType current;

    if (offset > previousOffset) {
      current = ScrollDirectionType.down;
    } else if (offset < previousOffset) {
      current = ScrollDirectionType.up;
    } else {
      current = _lastDirection;
    }

    /// 方向没变，千万不要去发全局的事件通知!!!
    if (current == _lastDirection) {
      previousOffset = offset;
      return;
    }

    _lastDirection = current;

    switch (current) {
      case ScrollDirectionType.down:
        Bus.getInstance().emit(EventType.listScrollingDown);
        break;
      case ScrollDirectionType.up:
        Bus.getInstance().emit(EventType.listScrollingUp);
        break;
      default:
        break;
    }

    previousOffset = offset;
  }

  /**
   * 根据Item获取热门人数
   */
  GetOddCountBeanStatInfoList? getOddCountBeanEntity(String oid){
    for(GetOddCountBeanStatInfoList getOddCountBeanStatInfoItem in (homeState.oddCountBeanEntity?.statInfoList??[])) {
      if(getOddCountBeanStatInfoItem.playOptionId==oid){
        getOddCountBeanStatInfoItem.orderCountAlias="${(((getOddCountBeanStatInfoItem.orderCount??0))/1000).toStringAsFixed(1)}";
        return getOddCountBeanStatInfoItem;
      }
    }
    return null;
  }
}
