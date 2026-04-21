import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_menu_tab_bar.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/debounce_util.dart';
import '../../../main.dart';
import '../../global/ty_user_controller.dart';
import '../../services/models/res/query_league_template_list_entity.dart';
import '../../utils/route_check_util.dart';
import 'vr_sport_service.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-331958bb-04a6-43f5-b772-e537b4c59455-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE 首页列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr首页-控制器入口
    - 处理切换语言逻辑
    】】】
 *
 */
class VrTyHomeController extends GetxController
    with GetTickerProviderStateMixin {
  static VrTyHomeController get to => Get.find();

  final GlobalKey<VrSportMenuTabBarState> tabBarKey = GlobalKey();
  List<VrSportsMenuEntity> vrSportsMenus = [];
  final List<VrMatchEntity> matches = [];

  VrSportsMenuEntity? topMenu;
  VrSportsMenuEntity? subMenu;

  bool isAllExpand = true;

  bool isMatchesLoading = false;
  bool isLoadFailed = false;

  bool curMatchFinished = false;

  late AnimationController animationController;
  late Animation animation;

  late bool dailyActivities = false;

  late final DebounceUtil _debounce;

  /// 接口服务封装
  late final VRSportService vrService = VRSportService();

  int _getVirtualMatchesRetry = 3;

  ///篮球足球运营模版接口
  late List<QueryLeagueTemplateListData> queryLeagueTemplateListData = [];
  late List<QueryLeagueTemplateListData> queryLeagueTemplateListDatas = [];
  PageController pageController = PageController();
  Timer? pageTimer;
  int currentPage = 0;
  bool footballBasketballTemplateIsNearEdge = false;

  ///足球篮球 状态变量
  bool isZNearEdge = false;

  ///足球篮球 拖动位置
  Offset footballBasketballTemplatePosition = Offset(0, 0);

  @override
  void onInit() {
    queryLeagueTemplateList();
    footballBasketballTemplatePosition = Offset(
      MediaQuery.of(Get.context!).size.width - 130,
      MediaQuery.of(Get.context!).size.height -
          (bottomHideSwitch == true ? 420 : 160),
    );
    registerBus();
    IconRefresh();
    _debounce = DebounceUtil(milliseconds: 200);
    super.onInit();
    // PerfMonitor().startSection("VR体育模块");
  }

  registerBus() {
    Bus.getInstance().on(EventType.changeLang, (wsObj) {
      ///回到首页
      Get.until((route) => route.settings.name == Routes.mainTab);
    });
    // 盘口设置
    Bus.getInstance().on(EventType.changeOddType, (_) {
      if (Get.isRegistered<TYUserController>()) {
        // 增加赔率类型
        String curOdd = TYUserController.to.curOdds;
        if (!['EU', 'HK'].contains(curOdd)) {
          _fetchVrSportsMenus();
        }
      }

      update();
    });
  }

  ///切换页面索引
  onPageChanged(int page) {
    currentPage = page;
    update();
  }

  ///足球篮球专题页上一页
  onPreviousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  ///足球篮球专题页下一页
  onNextPage() {
    if (currentPage < queryLeagueTemplateListData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  ///足球篮球专题页自动滚动
  startAutoScroll() {
    pageTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPage < queryLeagueTemplateListData.length - 1) {
        currentPage++;
      } else {
        currentPage = 0; // 回到第一页
      }
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  ///足球篮球专题页拖动位置
  onFootballBasketballTemplateDragEnd(DraggableDetails details) {
    /// 计算新的位置
    double newX = details.offset.dx - 25;

    /// 调整偏移量
    double newY = details.offset.dy - 25;

    /// 获取屏幕尺寸
    double screenWidth = MediaQuery.of(Get.context!).size.width;
    double screenHeight = MediaQuery.of(Get.context!).size.height;

    /// 获取安全区边距
    EdgeInsets padding = MediaQuery.of(Get.context!).padding;
    double safeAreaTop = padding.top;
    double safeAreaBottom = padding.bottom;

    /// 限制图标不超出边界
    newX = newX.clamp(0.0, screenWidth - 60 - 10);
    newY = newY.clamp(safeAreaTop, screenHeight - safeAreaBottom - 110);

    /// 检查是否靠近边缘
    isZNearEdge = (newX <= 10 ||
        newX >= screenWidth - 70 ||
        newY <= safeAreaTop + 10 ||
        newY >= screenHeight - safeAreaBottom - 120);
    if (isZNearEdge) {
      footballBasketballTemplateIsNearEdge = true;
    }

    footballBasketballTemplatePosition = Offset(newX, newY);
    update();
  }

  ///足球篮球专题页靠边界拖动按钮
  onPanUpdate(DragUpdateDetails details) {
    onTap();
  }

  ///足球篮球专题页靠边界点击按钮
  onTap() {
    footballBasketballTemplateIsNearEdge = false;
    footballBasketballTemplatePosition = Offset(
      MediaQuery.of(Get.context!).size.width - 130,
      MediaQuery.of(Get.context!).size.height -
          (bottomHideSwitch == true ? 420 : 160),
    );
    update();
  }

  ///去足球篮球运营模版
  toFootballBasketballTemplate() {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
    footballBasketballTemplateSetting = true;
    Get.toNamed(Routes.footballBasketballTemplate, arguments: [
      {"queryLeagueTemplateListData": queryLeagueTemplateListData},
      {"currentPage": currentPage},
      {"isDarkMode": Get.isDarkMode}
    ]);
  }

  ///足球篮球运营模版接口
  Future<void> queryLeagueTemplateList() async {
    footballBasketballTemplate = false;
    footballBasketballTemplateSetting = false;
    final res = await vrService.queryLeagueTemplateListFetch(
      uid: TYUserController.to.getUid(),
    );
    AppLogger.debug('queryLeagueTemplateLis' + res.toString());

    if (res.code == '0000000') {
      queryLeagueTemplateListDatas = res.data;
      if (queryLeagueTemplateListDatas.length > 0) {
        for (int i = 0; i < queryLeagueTemplateListDatas.length; i++) {
          if (queryLeagueTemplateListDatas[i].templateStatus == 1) {
            queryLeagueTemplateListData.add(queryLeagueTemplateListDatas[i]);
          }
        }
      }
      if (queryLeagueTemplateListData.length > 0) {
        currentPage = queryLeagueTemplateListData.length;
        footballBasketballTemplate = true;
        footballBasketballTemplateSetting = true;
      }
    }

    if (footballBasketballTemplate == true) {
      startAutoScroll();
    }
    update();
  }

  @override
  void onReady() {
    _fetchVrSportsMenus();
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    pageController.dispose();
    _debounce.cancel();
    Bus.getInstance().off(EventType.changeOddType);
    super.onClose();
    // PerfMonitor().endSection("VR体育模块");
  }

  void onListSwipe(bool isLeft) {
    final subMenus = topMenu?.subList ?? [];
    if (subMenus.isEmpty) return;
    int currentIndex = subMenus.indexOf(subMenu!);
    int targetIndex = isLeft ? currentIndex + 1 : currentIndex - 1;
    if (targetIndex < 0 || targetIndex >= subMenus.length) return;

    /// 状态更新
    subMenu = subMenus[targetIndex];

    ///调用 TabBar 切换下标
    tabBarKey.currentState?.jumpToSubIndex(targetIndex);

    /// 刷新 UI
    update(['sport_menus', 'match_list']);
  }

  Future<void> _fetchVrSportsMenus() async {
    try {
      isLoadFailed = false;
      final res = await vrService.getVrSportsMenusFetch(
        device: 'V1_H5',
      );
      vrSportsMenus.assignAll(res.data ?? []);
      update();
      topMenu = vrSportsMenus.firstOrNull;
      subMenu = topMenu?.subList.firstOrNull;
    } catch (e) {
      AppLogger.debug('_getVrSportsMenus error: $e');
      if (e is DioException) {
        isMatchesLoading = false;
        isLoadFailed = true;
      } else {
        _debounce.run(() async {
          if (isClosed) return;
          await _fetchVrSportsMenus();
        });
      }
      update();
    }
  }

  Future<void> _fetchVirtualMatches() async {
    try {
      isLoadFailed = false;
      curMatchFinished = false;
      update(['match_list']);
      final res = await vrService.getVirtualMatchesFetch(
        csid: topMenu?.menuId ?? '',
        tid: subMenu?.menuId ?? '',
        device: 'KY_APP',
      );
      if (res.code == '0401038') {
        _getVirtualMatchesRetry = 3;
        _fetchVirtualMatches();
        return;
      }
      matches.assignAll(res.data ?? []);
      if (matches.isNotEmpty) {
        final first = VrMatchEntity.fromJson(matches.first.toJson());
        matches.insert(0, first);
      }
      matches.firstOrNull?.isExpand = true;
      isMatchesLoading = false;
      update(['match_list']);
    } catch (e) {
      AppLogger.debug('_getVirtualMatches error: ${e.runtimeType}');
      if (_getVirtualMatchesRetry > 0) {
        _debounce.run(() async {
          if (isClosed) return;
          _getVirtualMatchesRetry--;
          await _fetchVirtualMatches();
        });
      } else {
        if (e is DioException) {
          isMatchesLoading = false;
          isLoadFailed = true;
          if (_getVirtualMatchesRetry > 0 && !isClosed) {
            await _fetchVirtualMatches();
          }
        } else {
          _debounce.run(() async {
            if (isClosed) return;
            _getVirtualMatchesRetry = 3;
            await _fetchVirtualMatches();
          });
        }
      }
      update(['match_list']);
    }
  }

  Future<VrSportReplayEntity?> _fetchVirtualReplay(
      VrMatchEntity vrMatch) async {
    try {
      final res = await vrService.getVirtualReplayFetch(
        batchNo: vrMatch.batchNo,
        csid: topMenu?.menuId ?? '',
        tid: subMenu?.menuId ?? '',
      );
      return res.data;
    } catch (e) {
      AppLogger.debug('getVirtualReplay error: $e');
      return null;
    }
  }

  Future<void> _fetchMatchScore(String mids) async {
    final res = await vrService.getMatchScoreFetch(
      mids: mids,
    );
    AppLogger.debug('getMatchScore: ${res.data}');
  }
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-331958bb-04a6-43f5-b772-e537b4c59455-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE 首页列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr首页-控制器extension
    - 处理列表展开收起逻辑
    】】】
 *
 */
extension VrTyHomeControllerAction on VrTyHomeController {
  void onAllExpandChanged(bool isExpand) {
    isAllExpand = isExpand;
    // 充值 item 的展开情况
    matches.forEach((element) {
      element.isExpand = isAllExpand;
    });
    update(['match_list']);
  }

  void onItemToggleExpand(bool isExpand, int index) {
    matches[index].isExpand = isExpand;
    isAllExpand = !matches.any((element) => element.isExpand == false);
    update(['match_list', 'all_expand_toggle']);
  }
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-331958bb-04a6-43f5-b772-e537b4c59455-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE 首页列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr首页-控制器extension
    - 处理菜单切换逻辑
    - 监听赛事视频播放结束，倒计时结束
    - 请求赛事分数，请求vr赛事的方法封装
    】】】
 *
 */
extension VrTyHomeControllerPublicApi on VrTyHomeController {
  void onMenuChanged(VrSportsMenuEntity? topMenu, VrSportsMenuEntity? subMenu) {
    this.topMenu = topMenu;
    this.subMenu = subMenu;
    isAllExpand = true;
    update(['all_expand_toggle']);
    isMatchesLoading = true;
    _getVirtualMatchesRetry = 3;
    _fetchVirtualMatches();
  }

  onVideoPlayFinished() {
    if (curMatchFinished) return;
    curMatchFinished = true;
    update(['match_list']);
  }

  onNextMatchCountdownEnd() {
    _getVirtualMatchesRetry = 3;
    _fetchVirtualMatches();
  }

  Future<VrSportReplayEntity?> getVirtualReplay(VrMatchEntity vrMatch) async {
    return _fetchVirtualReplay(vrMatch);
  }

  Future<void> getMatchScore(String mids) async {
    return _fetchMatchScore(mids);
  }
}