import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/req/match_list_req.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';

import '../../../global/config_controller_ext.dart';
import '../../home/controllers/pin_controller.dart';
import 'dj_controller.dart';
import 'dj_service.dart';

extension DJControllerExtension on DJController {
  ///获取日期信息，其中包含冠军，与首页不同，电竞的冠军是从这个接口返回的
  Future<void> getDateList({bool isLoading = true}) async {
    DJState.collopList.clear();
    DJState.isLoading = isLoading;
    doudi();
    update();

    var id;
    if (!isCollect()) {
      //收藏特殊處理
      id = (DJState.gameId.toNum()) - 2000;
      DJState.djListReq.csid = id.toString();
    }

    final value =
        await DJService.to.getDateMenuListFetch(DJState.djListReq.csid.toString());
    DJState.djDateEntity = value.data;
    DJState.selectDate = DJState.djDateEntity?.first;
    getDifferentParams(DJState.selectDate!);

    globalRequestSessionKey =
        DJState.djListReq.getRequestSessionKey(isCollect());
    if (isCollect()) {
      //收藏特殊處理
      getCollectList();
    } else {
      await getListData();
    }
    PinController.to?.refreshPin();
    update();
    if (isSearch) {
      search(searchKeyWord);
    }
  }

  /// 电竞冠军关盘逻辑 如果关盘 移除当前玩法
  bool filterMatchByHpsHs(MatchEntity match) {
    if (!isGuanjun()) return true;
    if (match.hps.isEmpty) return false;

    /// 过滤掉关盘玩法
    final List<MatchHps> availableHps =
        match.hps.where((hps) => hps.hs != 2).toList();

    /// 如果没有任何可用玩法，整个赛事丢弃
    if (availableHps.isEmpty) {
      return false;
    }
    match.hps = availableHps;
    return true;
  }

  ///请求单个游戏列表
  Future<void> getListData({bool isLeague = false}) async {
    // String currentRequestSessionKey = DJState.djListReq.getRequestSessionKey(isCollect());
    final res;
    if (isLeague) {
      MatchListReq req = MatchListReq.fromJson({
        "cuid": TYUserController.to.getUid(),
        "euid": DJState.djListReq.euid,
        "type": 3,
        "sort": 1,
        "device": "v2_h5_st",
        "hpsFlag": 0,
        "category": DJState.djListReq.category,
        "etid": DJState.djListReq.etid,
        "tid": ""
      });

      res = await DJService.to.getLeagueMatchesFetch(req);
      // matchtList.addAll(res1.data?.matchs ?? []);
      // DJState.djListEntity.addAll(res.data?.esportMatchs ?? []);
    } else {
      res = await DJService.to.getEsportsMatchesFetch(
          // '1','100','240640629535469568','41002','0','','2','3000'
          category: DJState.djListReq.category.toString(),
          csid: DJState.djListReq.csid,
          cuid: TYUserController.to.getUid(),
          euid: DJState.djListReq.euid,
          hpsFlag: '0',
          md: DJState.djListReq.md.toString(),
          sort: '2',
          type: isLeague ? '3' : '3000');
      // .then((value) {
    }

    DJState.djListEntity.clear();
    List<MatchEntity> sourceList =
        isLeague ? res.data?.esportMatchs ?? [] : res.data ?? [];
    DJState.djListEntity.addAll(
      sourceList.where(filterMatchByHpsHs),
    );
    DJState.tempList.clear();
    DJState.tempList.addAll(DJState.djListEntity);

    ///电竞数据插入前 先锁住
    DataStoreController.to.pageKey = djPageKey;

    DataStoreController.to.injecthowMatchIdListByMatchEntity(
        DJState.djListEntity,
        pageRouteKey: djPageKey);
    DJState.djListEntity.forEach((matchEntity) {
      DataStoreController.to.injectMatch(matchEntity);
      matchEntity.hps.forEach((hps) {
        List<MatchHpsHl> hls = hps.hl;
        for (MatchHpsHl hl in hls) {
          DataStoreController.to.updateHl(hl);
          List<MatchHpsHlOl> ols = hl.ol;
          for (MatchHpsHlOl ol in ols) {
            DataStoreController.to.updateOl(ol);
          }
        }
      });
    });
    DJState.isLoading = false;
    update();

    if (isSearch) {
      search(searchKeyWord);
    }
  }

  ///公共的赛事收藏
  void collectMatch(MatchEntity matchEntity) {
    DJService.to
        .addOrCancelMatchFetch(TYUserController.to.getUid(), matchEntity.mid,
            matchEntity.mf ? 0 : 1)
        .then((value) {
      matchEntity.mf = !matchEntity.mf;
      if (matchEntity.mf == false) {
        if (isCollect()) {
          DJController.to.DJState.djListEntity
              .removeWhere((element) => element.mid == matchEntity.mid);
        }
      }
      DJController.to.update();
    });
  }

  void removeMatchs(String tid) {
    if (isCollect()) {
      DJController.to.DJState.djListEntity
          .removeWhere((element) => element.tid == tid);
      update();
    }
  }

  void removeMatch(String mid) {
    if (isCollect()) {
      DJController.to.DJState.djListEntity
          .removeWhere((element) => element.mid == mid);
      update();
    }
  }

  ///公共的联赛收藏
  // void collectTournament(MatchEntity matchEntity) {
  //   MatchApi.instance()
  //       .addOrCancelTournament(TYUserController.to.getUid(), matchEntity.tid,
  //           matchEntity.mf ? 0 : 1)
  //       .then((value) {
  //     matchEntity.mf = !matchEntity.mf;
  //     if (matchEntity.mf == false) {
  //       AppLogger.debug(
  //           "DJController.to.DJState.djListEntity = before ${DJController.to.DJState.djListEntity}");
  //       if (isCollect()) {
  //         DJController.to.DJState.djListEntity
  //             .removeWhere((element) => element.mid == matchEntity.mid);
  //       }
  //       AppLogger.debug(
  //           "DJController.to.DJState.djListEntity = ${DJController.to.DJState.djListEntity}");
  //     }
  //     DJController.to.update();
  //   });
  // }

  ///请求收藏列表
  void getCollectList() {
    String currentRequestSessionKey =
        DJState.djListReq.getRequestSessionKey(isCollect());
    List<SportConfigInfo> list = ConfigController.to.gameMenuList;
    var csid = '';
    var euid = '';

    list.forEach((element) {
      if (csid == '') {
        csid = ((element.mi.toNum()) - 2000).toString();
        euid = ConfigController.to.getDjEuid(element.mi).toString();
      } else {
        csid += ',${((element.mi.toNum()) - 2000).toString()}';
        euid += ',${ConfigController.to.getDjEuid(element.mi).toString()}';
      }
    });
    DJService.to
        .getCollectionListFetch(
            //{
            //   "collect": 1
            //   "csid": "100,101,103,102",
            //   "cuid": "509825984426120034",
            //   "euid": "41002,41001,41003,41004",
            //   "hpsFlag": 0,
            //   "md": "0",
            //   "sort": 1,
            //   "type": 3000,
            //   "device": "v2_h5_st",//
            // }
            csid: csid,
            cuid: TYUserController.to.getUid(),
            euid: euid,
            md: DJState.djListReq.md.toString())
        .then((value) {
      AppLogger.debug(
          "${globalRequestSessionKey == currentRequestSessionKey} globalRequestSessionKey =2  $globalRequestSessionKey   currentRequestSessionKey = $currentRequestSessionKey");
      if (globalRequestSessionKey != currentRequestSessionKey) {
        return;
      }
      DJState.djListEntity = value.data ?? [];

      DJState.isLoading = false;
      update();
    });
  }

  ///获取新增赛事
  void getAddMatch() {
    // AppLogger.debug("DJ = matchesPB getAddMatch");
    DJService.to
        .getAddedMatchesFetch(
      category: DJState.djListReq.category.toString(),
      cuid: DJState.djListReq.cuid,
      euid: DJState.djListReq.euid,
      hpsFlag: DJState.djListReq.hpsFlag.toString(),
      md: DJState.djListReq.md.toString(),
      sort: DJState.djListReq.sort.toString(),
      type: DJState.djListReq.type.toString(),
    )
        .then((value) {
      // AppLogger.debug("DJ = matchesPB getAddMatch $value");
      if (value.data == null) {
        return;
      }
      DJState.djListEntity.addAll(value.data as Iterable<MatchEntity>);
      // AppLogger.debug("DJ = matchesPB callback = $value");
    });
  }

  ///判断是否收起，收起的赛事不显示
  isCollop(matchEntity, SectionGroupEnum sectionGroupEnum) {
    String tid = matchEntity.tid;
    return DJState.collopList.contains("${tid}_${sectionGroupEnum.index}");
  }

  ///收起/展开 同组联赛信息 使用collopList存储收起的联赛tid
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

  ///判断是否收藏，gameId=50000，是本地定义的，服务器没有
  bool isCollect() {
    return DJState.gameId == SportConfig.FavoritesPage.sportId.toString();
  }

  ///判断是否冠军模块，menuType=100
  bool isGuanjun() {
    return DJState.selectDate?.menuType == 100;
  }

  ///判断是否关盘，本地根据关盘状态，隐藏item布局
  bool isClose(MatchEntity match) {
    bool isClose = MatchDataBaseWS.closeMatch(
        mhs: match.mhs, mmp: match.mmp, ms: match.ms);
    var ms = match.ms;

    ///ms 关盘状态
    List closeMsState = [3, 4, 5, 6, 7, 8, 9];
    bool closeForMs = (closeMsState.contains(ms));

    return isClose || closeForMs;
  }

  List<SportConfigInfo> getMenuData() {
    return isGuanjun()
        ? ConfigController.to.gameMenuList
        : ConfigController.to.getGameMenuListByMenuId();
  }

  ///兜底策略，12秒过后不显示loading
  void doudi() {
    12.seconds.delay(() {
      if (DJState.isLoading == true) {
        DJState.isLoading = false;
        update();
      }
    });
  }

  ///点击日期，请求列表
  void changeTime(DjDateEntityEntity date) {
    DJState.collopList.clear();
    DJState.selectDate = date;
    DJState.isLoading = true;
    doudi();
    update();
    getDifferentParams(date);

    globalRequestSessionKey =
        DJState.djListReq.getRequestSessionKey(isCollect());
    if (isCollect() && !isGuanjun()) {
      //收藏特殊處理
      getCollectList();
    } else {
      getListData();
    }
  }

  /// 根据 csid、euid 切换球种
  /// 避免重复请求
  /// 收藏态下使用全量 csid + euid
  /// 触发数据刷新 和 联赛重置
  Future<void> changeGame(dynamic csid, dynamic euid) async {
    final String newCsid = csid.toString();
    final String newEuid = euid.toString();

    /// ===== 避免重复请求 防抖=====
    if (_isSameGame(newCsid, newEuid)) {
      if (isSearch) {
        search(searchKeyWord);
      }
      return;
    }

    /// ===== 重置状态 =====
    DJState.gameId = newCsid;
    DJState.djListEntity.clear();

    /// ===== 非收藏，使用传入参数 =====
    if (!isCollect()) {
      DJState.djListReq
        ..csid = newCsid
        ..euid = newEuid;
    }

    await getDateList();
    setLeague();
    update();
  }

  /// 判断是否为相同游戏
  bool _isSameGame(String csid, String euid) {
    return csid == DJState.gameId && euid == DJState.djListReq.euid;
  }

  /// 组装请求参数
  /// 冠军模式 & 普通模式参数不同
  void getDifferentParams(DjDateEntityEntity date) {
    final bool isChampion = isGuanjun();

    DJState.djListReq
      ..md = isChampion ? '' : date.field1
      ..category = isChampion ? 2 : 1;
  }

  /// 收藏态下获取所有游戏 csid（由 gameMenuList 组装）
  String getCsid() {
    final List<SportConfigInfo> list = ConfigController.to.gameMenuList;
    return list.map((e) => (e.mi.toNum() - 2000).toString()).join(',');
  }

  ///切换页面索引
  onPageChanged(int page) {
    currentPage = page;
    update();
  }

  ///足球篮球专题页上一页
  onPreviousPage() {
    if (currentPage > 0) {
      footballPageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  ///足球篮球专题页下一页
  onNextPage() {
    if (currentPage < queryLeagueTemplateListData.length - 1) {
      footballPageController.nextPage(
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
      footballPageController.animateToPage(
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
}
