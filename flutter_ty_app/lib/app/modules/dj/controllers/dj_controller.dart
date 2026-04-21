import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_service.dart';
import 'package:flutter_ty_app/app/modules/dj/states/dj_state.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/menu/hot_league_widget.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/hot_league_info.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/result_api.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../../../../main.dart';
import '../../../global/config_controller_ext.dart';
import '../../../services/models/res/query_league_template_list_entity.dart';
import '../../../utils/easy_debounce_throttle/easy_throttle.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞控制器 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞控制器
    - `进入详情  或者 不是电竞当前页 列表接口需要屏蔽`

    ```
    if (DataStoreController.to.isEnterDatail == true ||
    currentRoute != Routes.DJView) return;
    ```

    # `getDateList`

    `- 获取日期信息，其中包含冠军，与首页不同，电竞的冠军是从这个接口返回的`

    ```
    if (!isCollect()) {
    //收藏特殊處理
    id = (DJState.gameId.toNum() ?? 0) - 2000;
    DJState.djListReq.csid = id.toString();
    }

    DjDataApi.instance()
    .getDateMenuList(DJState.djListReq.csid.toString())
    ```

    ## `getListData`

    `请求单个游戏列表`

    ```
    DjDataApi.instance()
    .esportsMatches(
    DJState.djListReq.category.toString(),
    DJState.djListReq.csid,
    TYUserController.to.getUid(),
    DJState.djListReq.euid,
    '0',
    DJState.djListReq.md.toString(),
    '2',
    '3000')
    ```

    # 插入数据仓库

    ` - 将请求数据插入数据仓库`

    ```
    DataStoreController.to.injecthowMatchIdListByMatchEntity(
    DJState.djListEntity ?? [],
    pageRouteKey: djPageKey);
    ```

    ` - 更新玩法级赔率信息`

    ```
    DataStoreController.to.updateHl(hl);
    ```

    `- 更新单个级赔率信息`

    ```
    DataStoreController.to.updateOl(ol);
    ```

    # `getCollectList`

    ` - 请求收藏列表

 * 请求参数

    ```
    {
    "collect": 1
    "csid": "100,101,103,102",
    "cuid": "509825984426120034",
    "euid": "41002,41001,41003,41004",
    "hpsFlag": 0,
    "md": "0",
    "sort": 1,
    "type": 3000,
    "device": "v2_h5_st"
    }
    ```

    ```
    DjDataApi.instance()
    .collection(
    1,
    csid,
    TYUserController.to.getUid(),
    euid,
    '0',
    DJState.djListReq.md.toString(),
    '1',
    '3000')
    ```

    `- 使用所有游戏的csid, euid组合请求`

    ```
    list.forEach((element) {
    if (csid == '') {
    csid = ((element.mi.toNum() ?? 0) - 2000).toString();
    euid = ConfigController.to.getDjEuid(element.mi).toString();
    } else {
    csid += ',${((element.mi.toNum() ?? 0) - 2000).toString()}';
    euid += ',${ConfigController.to.getDjEuid(element.mi).toString()}';
    }
    });
    ```

    # `isCollop`

    `- 判断是否收起，收起的赛事不显示`

    ```
    isCollop(matchEntity, SectionGroupEnum sectionGroupEnum) {
    String tid = matchEntity.tid;
    return DJState.collopList.contains("${tid}_${sectionGroupEnum.index}");
    }
    ```

    # `clickCollop`

    ` - 收起/展开 同组联赛信息 使用collopList存储收起的联赛tid`

    ```
    clickCollop(clickValue, matchEntity, SectionGroupEnum sectionGroupEnum) {
    matchEntity.isExpand = clickValue;

    ///由于未开赛和进行中可能会有相同的联赛tid，所以增加sectionGroupEnum.index作为可以
    var key = "${matchEntity?.tid}_${sectionGroupEnum.index}";
    if (clickValue) {
    DJState.collopList.remove(key);
    } else {
    if (!DJState.collopList.contains(key)) {
    DJState.collopList.add(key);
    }
    }
    update([key]);
    }
    ```

    # `isCollect`

    `   - 判断是否收藏，gameId=50000，是本地定义的，服务器没有

    ```
    return DJState.gameId == "50000";
    ```

    # `isClose`

    ` - 判断是否关盘，本地根据关盘状态，隐藏item布局`

    ```
    `  bool isClose(MatchEntity match) {
    bool isClose = MatchDataBaseWS.closeMatch(
    mhs: match.mhs, mmp: match.mmp, ms: match.ms);
    var ms = match.ms;

    ///ms 关盘状态
    List closeMsState = [3, 4, 5, 6, 7, 8, 9];
    bool closeForMs = (ms != null && closeMsState.contains(ms));

    return isClose || closeForMs;
    }
    ```

    # `doudi`

    `  - 兜底策略，12秒过后不显示loading`

    ```
    void doudi() {
    12.seconds.delay(() {
    if (DJState.isLoading == true) {
    DJState.isLoading = false;
    update();
    }
    });
    }
    ```

    # `changeGame`

    `- 根据csid，euid切换游戏，需要判断是否收藏，收藏不使用传进来的值，使用所有游戏的csid, euid组合请求`

    ```
    void changeGame(csid, euid) {
    DJState.djListEntity?.clear();
    update();
    if (!isCollect()) {
    DJState.djListReq.csid = csid.toString();
    DJState.djListReq.euid = euid.toString();
    }
    getDateList();
    }
    】】】
 *
 */
class DJController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late String globalRequestSessionKey;

  static DJController get to => Get.put(DJController());
  DjState DJState = DjState();

  late PageController pageController;
  StreamSubscription? subscription;
  bool isSearch = false;
  String searchKeyWord = '';
  ScrollController djScrollController = ScrollController();

  ///篮球足球运营模版接口
  late List<QueryLeagueTemplateListData> queryLeagueTemplateListData = [];
  late List<QueryLeagueTemplateListData> queryLeagueTemplateListDatas = [];
  PageController footballPageController = PageController();
  Timer? pageTimer;
  int currentPage = 0;
  bool footballBasketballTemplateIsNearEdge = false;
  ///足球篮球 状态变量
  bool isZNearEdge = false;

  ///足球篮球 拖动位置
  Offset footballBasketballTemplatePosition = Offset(0, 0);

  @override
  void onInit() {
    Get.put(DJService());
    queryLeagueTemplateList();
    footballBasketballTemplatePosition = Offset(
      MediaQuery.of(Get.context!).size.width - 130,
      MediaQuery.of(Get.context!).size.height -
          (bottomHideSwitch == true ? 420 : 160),
    );
    Get.put(() => DJHotLeagueController(), permanent: true);
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    Bus.getInstance().on(EventType.changeLang, (value) {
      getDateList();
    });
    // 盘口设置
    Bus.getInstance().on(EventType.changeOddType, (_) {
      if (Get.isRegistered<TYUserController>()) {
        // 增加赔率类型
        String curOdd = TYUserController.to.curOdds;
        if (!['EU', 'HK'].contains(curOdd)) {
          getDateList(isLoading: false);
        }
      }
      update();
    });

    /// 删除赛事
    Bus.getInstance().on(EventType.removeMatch, (value) {
      int index =
          DJState.djListEntity.indexWhere((element) => element.mid == value);
      if (index >= 0) {
        DJState.djListEntity.removeAt(index);
        EasyThrottle.throttle('remove_dj_match', Duration(milliseconds: 1000),
            () {
          getDateList(isLoading: false);
        });
      }
    });

    Bus.getInstance().on(EventType.djSearchContent, (value) {});

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // RCMD109

    Bus.getInstance().on(EventType.RCMD_C109, (wsObj) {
      String currentRoute = Get.currentRoute;

      /**
       *
       *
          【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
          【【【 AUTO_DOCUMENT_MENU 电竞 】】】
          【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
          【【【 AUTO_PARAGRAPH_TITLE 电竞控制器 】】】
          【【【 AUTO_PARAGRAPH_CONTENT
          - 进入详情  或者 不是电竞当前页 列表接口需要屏蔽
          】】】
       *
       */
      if (DataStoreController.to.isEnterDatail == true ||
          currentRoute != Routes.DJView) return;
      AppLogger.debug('DJController C109 $currentRoute');
      AppLogger.debug('DJController wsObj[0] ${wsObj[0]}');
      var cd = wsObj;
      AppLogger.debug('DJController    cd $cd');
      if (cd == null || cd.length < 1) {
        return;
      }
      bool isReq = false;
      cd.forEach((element) {
        var csid = element['csid'];
        AppLogger.debug(
            'DJController csid $csid   DJState.djListReq.csid ${DJState.djListReq.csid}');
        if (csid == DJState.djListReq.csid) {
          if (DJState.selectDate?.menuType != 100) {
            //冠军
            isReq = true;
          }
        }
        // isReq = true;
        if (isReq) {
          //赛事新增
          getAddMatch();
        }
      });
    });
    getDateList();
    setLeague();

    ///更新收藏数据
    4000.milliseconds.delay().then((value) {
      CollectionController.to.getDJCollectCount();
      setLeague();
    });
  }

  setLeague() {
    AppLogger.debug("setLeague === DJState.gameId " + DJState.gameId);
    List<HotLeagueInfo> hotAll = ConfigController.to
        .getDJLeagues(DJState.gameId)
        .map((e) => HotLeagueInfo(e))
        .toList();

    AppLogger.debug("setLeague === hotAll " + hotAll.length.toString());

    HotLeagueInfo all = HotLeagueInfo(SportConfigInfo());
    all.name = LocaleKeys.app_h5_match_all.tr;
    hotAll.insert(0, all);
    // AppLogger.debug(" " + hotAll.length.toString());
    DJHotLeagueController.to?.generateHotLeagueList(hotAll);
  }

  void search(String value) {
    if (ObjectUtil.isEmptyString(value)) {
      DJState.djListEntity.clear();
      DJState.djListEntity.addAll(DJState.tempList);
      isSearch = false;
      searchKeyWord = '';
      update();
      return;
    }
    isSearch = true;
    searchKeyWord = value;
    List<MatchEntity> searchMatchList = [];
    List<String> showMatchList = [];
    for (var element in DJState.tempList) {
      if (element.tn.containsFuzzy(value) ||
          element.man.containsFuzzy(value) ||
          element.mhn.containsFuzzy(value)) {
        searchMatchList.add(element);
        showMatchList.add(element.mid);
      }
    }
    DJState.djListEntity.clear();
    DJState.djListEntity.addAll(searchMatchList);
    update();
  }

  ///切换联赛
  void changeLeague(HotLeagueInfo league) {
    DJState.djListEntity.clear();
    update();
    isSearch = false;
    searchKeyWord = '';

    if (league.name == LocaleKeys.app_h5_match_all.tr) {
      DJHotLeagueController.to?.showLeageuFilter.value = true;
      getListData(isLeague: false);
    } else {
      // DJState.league = league;
      // DJState.djListReq.tid = league.sportConfigInfo.tid;
      DJState.djListReq.etid = league.eid;
      DJState.djListReq.euid = league.sportConfigInfo.mi;

      // HotLeagueController.to?.showLeageuFilter.value =
      //     league.sportConfigInfo.tid == null;

      DJHotLeagueController.to?.showLeageuFilter.value = false;

      getListData(isLeague: true);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    footballPageController.dispose();
    DataStoreController.to.pageKey = otherPageKey;
    Bus.getInstance().off(EventType.changeOddType);
    Get.delete<DJHotLeagueController>(force: true);
    super.onClose();
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
    final res = await ResultApi.instance().queryLeagueTemplateLis(
      TYUserController.to.getUid(),
    );
    print('queryLeagueTemplateLis' + res.toString());

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
}
