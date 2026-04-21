import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/result/results_league_filter/results_league_filter_controller.dart';
import 'package:flutter_ty_app/app/modules/result/results_league_filter/results_league_filter_view.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/vr_results_controller.dart';
import 'package:flutter_ty_app/main.dart';


import '../../config/getx_navigation.dart';
import '../../services/api/result_api.dart';
import '../../services/models/res/virtual_menus_entity.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/route_check_util.dart';
import '../login/login_head_import.dart';
import '../setting_menu/league_filter/manager/league_manager.dart';
import 'championship_results/championship_results_controller.dart';
import 'djvr_league_filter/djvr_league_filter_controller.dart';
import 'djvr_league_filter/djvr_league_filter_view.dart';
import 'gaming_results/gaming_results_controller.dart';
import 'normal_results/normal_results_controller.dart';
import 'result_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 控制器 ResultController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 控制器 ResultController
    - ResultController
    ```
    ///VR菜单
    late List<VirtualMenusData> vRMenuListData = [];

    /// 选择联赛的tid
    String tid = '';

    ///赛果头部标题
    List<String> titleList = [
    LocaleKeys.app_h5_match_normal_results.tr,
    LocaleKeys.app_h5_match_game_results.tr,
    LocaleKeys.app_h5_match_vr_results.tr,
    LocaleKeys.app_h5_match_championship_results.tr,
    ];

    ```
    】】】
 *
 */
class ResultController extends GetxController with GetTickerProviderStateMixin {
  final Resultlogic logic = Resultlogic();
  late TabController titleTabController;


  final ScrollController scrollController = ScrollController();


  ///VR菜单
  late List<VirtualMenusData> vRMenuListData = [];



  @override
  void onInit() {
    // TODO: implement onInit
    titleTabController = TabController(length: logic.titleList.length, vsync: this);
    titleTabController.addListener(() {
      logic.titleIndex = titleTabController.index;
      update();
    });
    LeagueManager.type.value = 28;
    LeagueManager.euid = '1';
    LeagueManager.tid.clear();
    LeagueManager.entryName = 'result';

    LeagueManager.sort.value = TyHomeController.to.homeState.matchListReq.sort;
    super.onInit();
    getVirtualMenus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getVirtualMenus() async {
    final res = await ResultApi.instance().getVirtualMenus();
    vRMenuListData = res.data;
    final vrResultsController = VrResultsController();
    vrResultsController.onInit();
    update();
  }

  onTitleIndex(int index) {
    if(index == 2){
      ///判断是否登录
      if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
      vRMenuListData.clear();
      logic.titleIndex = index;
      getVirtualMenus();
    }else {
      logic.titleIndex = index;
    }

    titleTabController.animateTo(index);
    ///点击头部菜单,多语言滚动指定位置,防止显示不全
    String tag = Get.locale!.toLanguageTag();
    if (isIPad == false) {
      if (tag.contains('th-TH')) {
        if (index == 0) {
          scrollController.jumpTo(0);
        } else if (index == 1) {
          scrollController.jumpTo(76);
        } else {
          scrollController.jumpTo(170);
        }
      }
      if (tag.contains('pt-PT')) {
        if (index == 0) {
          scrollController.jumpTo(0);
        } else if (index == 1) {
          scrollController.jumpTo(148);
        } else {
          scrollController.jumpTo(287);
        }
      }
      if (tag.contains('es-ES') || tag.contains('ru-RU')) {
        if (index == 0) {
          scrollController.jumpTo(0);
        } else if (index == 1) {
          scrollController.jumpTo(144);
        } else {
          scrollController.jumpTo(420);
        }
      } else {
        if (index == 0) {
          scrollController.jumpTo(0);
        } else if (index == 1) {
          scrollController.jumpTo(40);
        } else {
          scrollController.jumpTo(180);
        }
      }
    }

    update();
    initData();
  }

  ///初始化数据
  initData({String? tid = ''}) {
    ///初始化数据,联赛选中默认ID, 0 普通赛果, 1 点击赛果
    LeagueManager.euid.isEmpty ? '1' : LeagueManager.euid;
    if (logic.titleIndex == 0) {
      final normalResultsController = Get.find<NormalResultsController>();
      normalResultsController.initData(stid: tid);
      LeagueManager.type.value = 28;
      LeagueManager.euid = '1';
      LeagueManager.tid.clear();
    } else if (logic.titleIndex == 1) {
      final gamingResultsController = Get.find<GamingResultsController>();
      gamingResultsController.initData(stid: tid);
      LeagueManager.type.value = 28;
      LeagueManager.euid = '100';
      LeagueManager.tid.clear();
    } else {
      final championshipResultsController = Get.find<ChampionshipResultsController>();
      championshipResultsController.initData(stid: tid);
      LeagueManager.type.value = 28;
      LeagueManager.euid = '10000';
      LeagueManager.tid.clear();

    }
  }

  ///点击打开联赛筛选
  onSelectLeague() {
    Bus.getInstance().emit(EventType.tyOpenDialog);
    if(logic.titleIndex == 0 ){
      ///普通赛果-联赛筛选
      Get.lazyPut(() => ResultsLeagueFilterController(finishCb: (String tid) {
        initData(tid: tid);
      }));
      final normalResultsController = Get.find<NormalResultsController>();
      normalResultsController.initData(stid: logic.tid);
      Get_TY.bottomSheet(
        ResultsLeagueFilterPage(),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        barrierColor: Colors.black.withValues(alpha:0.2),
      );
    }else if(logic.titleIndex == 1 ){
      ///电竞赛果-联赛筛选
      Get.lazyPut(() => DjVrLeagueFilterController(finishCb: (String tid) {
        initData(tid: tid);
      }));
      final gamingResultsController = Get.find<GamingResultsController>();
      gamingResultsController.initData(stid: logic.tid);
      final djVrLeagueFilterController = Get.find<DjVrLeagueFilterController>();
      djVrLeagueFilterController.onInit();
      Get_TY.bottomSheet(
        DjVrLeagueFilterPage(),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        barrierColor: Colors.black.withValues(alpha:0.2),
      );
    }else {
      ///冠军赛果-联赛筛选
      Get.lazyPut(() => DjVrLeagueFilterController(finishCb: (String tid) {
        initData(tid: tid);
      }));
      final championshipResultsController = Get.find<ChampionshipResultsController>();
      championshipResultsController.initData(stid: logic.tid);
      final djVrLeagueFilterController = Get.find<DjVrLeagueFilterController>();
      djVrLeagueFilterController.onInit();
      Get_TY.bottomSheet(
        DjVrLeagueFilterPage(),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        barrierColor: Colors.black.withValues(alpha:0.2),
      );
    }

  }
}
