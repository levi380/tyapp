import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_api_service.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_home_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/item_disuse_entity.dart';
import '../../../../global/data_store_controller.dart';
import '../../../../services/models/res/match_entity.dart';
import '../vr_sport_detail_state.dart';
import 'vr_sport_detail_service.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情-控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr详情-控制器
    - 请求排行榜数据接口
    - 请求历史数据接口
    # `getData`

    ```
    if(state.topMenu  !=null){
    if(state.topMenu?.menuId == '1001') {
    ///足球数据,包含历史战绩，排行榜数据
    getRankingData();
    }else if(state.topMenu?.menuId != '1004'){
    ///不为足球和篮球，即赛狗类
    getHistory();
    }
    }
    ```

    # `getRankingData`

 * `小组赛接口`

    ```
    VrDetailApi.instance().getVirtualSportXZTeamRanking(tid)
    ```

 * `淘汰赛接口`

    ```
    VrDetailApi.instance().getMatchSorce(tid,
    state.batchNo??'',
    lod,
    mmp,
    "1710434040000")
    ```

 * `将数据按照8强、4强、半决赛、决赛，进行分组`

    ```
    List<String> keyList = ['Q8','Q4','SEMIFINAL',"FINAL"];
    keyList.forEach((key) {
    List<ItemDisuseEntity> temp = [];
    if(value.data?[key]!=null){
    value.data?[key].forEach((element){
    temp.add(ItemDisuseEntity.fromJson(element));
    });
    state.disuseListMap[key] = temp;
    }
    });
    ```

 * `求出当前正在进行的赛事阶段的TAB的下标，从0开始，依次为8强、4强、半决赛、决赛`

    ```
    for (int i = 0; i <  keyList.length; i++) {
    if(keyList[i] == mmp){
    state.disuseIndex.value = i;
    }
    }
    ```

 * `设置当前显示的列表数据`

    ```
    state.disuseList = state.disuseListMap[keyList[state.disuseIndex.value]]!;
    ```

 * `非世界杯类型-常规赛接口`

    ```
    VrDetailApi.instance().getVirtualSportTeamRanking(tid)
    ```

 * `获取历史战绩`

    ```
    VrDetailApi.instance().getVirtualMatchDetailCount(state.match!.mid)
    ```


    】】】
 *
 */
class VrSportDetailLogic extends GetxController
    with GetTickerProviderStateMixin {
  static VrSportDetailLogic get to => Get.find();
  final VrSportDetailState state = VrSportDetailState();

  /// 接口服务封装
  late final VrSportDetailService vrDetailService = VrSportDetailService();

  @override
  void onInit() {
    // 列表进入
    if (Get.arguments is Map) {
      Map<String, dynamic>? arguments = Get.arguments;

      // AppLogger.debug("VrMatchEntity =   arguments $arguments");
      state.vrMatch = arguments?['vrMatch'] ?? '';
      state.match = arguments?['match'] ?? '';
      state.isBalls = arguments?['isBalls'] ?? false;
      if (state.match != null) {
        ///足球类历史战绩从msc中取
        state.historyScore = state.match!.msc;
        state.lod = state.match!.lod;
        state.batchNo = state.match?.batchNo;

        ///赛事详情 跳转先注册tag 避免数据穿透混乱
        Get.lazyPut(() => MatchDetailController(tag: state.match?.mid ?? ''),
            tag: state.match?.mid);

        /// 加载vr详情投注列表
        var detailController =
            Get.find<MatchDetailController>(tag: state.match?.mid);
        detailController.detailState.mId = state.match!.mid;
        detailController.detailState.csid = state.match!.csid;
        detailController.detailState.match = state.match;
        detailController.fetchCategoryList();
        DataStoreController.to.updateMatch(state.match!);
      }

      var vrTyHomeController = Get.find<VrTyHomeController>();
      state.topMenu = vrTyHomeController.topMenu;
    }

    registTabController();
    super.onInit();
  }

  @override
  void onReady() {
    getData();
  }

  getData() {
    if (state.topMenu != null) {
      if (state.topMenu?.menuId == '1001') {
        ///足球数据,包含历史战绩，排行榜数据
        getRankingData();
      } else if (state.topMenu?.menuId != '1004') {
        ///不为足球和篮球，即赛狗类
        getHistory();
      }
    }
  }

  ///========================== 逻辑 ========================///
  registTabController() {
    int initIndex = 0;
    if (state.topMenu != null) {
      if (state.topMenu?.menuId == '1001') {
        //足球
        state.matchDetailList = [
          LocaleKeys.virtual_sports_match_detail_historical_results.tr,
          LocaleKeys.virtual_sports_match_detail_bet.tr,
          LocaleKeys.virtual_sports_match_detail_leaderboard.tr,
        ];
        initIndex = 1;
      } else if (state.topMenu?.menuId == '1004') {
        //篮球
        state.matchDetailList = [];
      } else {
        state.matchDetailList = [
          LocaleKeys.virtual_sports_match_detail_bet.tr,
          LocaleKeys.virtual_sports_match_detail_historical_results.tr,
        ];
        initIndex = 0;
      }
    }
    state.matchTabController = TabController(
        initialIndex: initIndex,
        vsync: this,
        length: state.matchDetailList.length);
    state.matchTabController?.addListener(() {
      if (state.matchTabController?.index ==
          state.matchTabController?.animation?.value) {
        // matchDetailList.refresh();
        update();
      }
    });
    state.matchTabController?.animateTo(initIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  ///没数据 弱提示 名称拼接
  String getdisuseRowName(int index) {
    String name = LocaleKeys.virtual_sports_quarter_finals.tr;
    // String name = LocaleKeys.virtual_sports_Q4.tr;
    if (state.disuseIndex.value == 1) {
      name = LocaleKeys.virtual_sports_SEMIFINAL.tr;
    } else if (state.disuseIndex.value == 2) {
      name = LocaleKeys.virtual_sports_FINAL.tr;
    }
    name =
        '$name\n${VrSportDetailState.replaceEnglishNumber(index.toString())}';
    return name;
  }

  String replaceEnglishNumber(String input) {
    const arabic = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25'
    ];
    const english = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  ///格式化 赛事比分（迁移至 State 工具方法）

  ///小组赛 淘汰赛tab点击
  clickGroupIndex(int index) {
    state.groudIndex.value = index;
    state.groudIndex.refresh();

    if (state.groudIndex.value == 1) {
      ///请求接口
      // getdisuseScore();
    }
  }

  ///点击淘汰赛 类型
  void clickDisuse(int index) {
    // reloadDisuse(index);
  }

  @override
  void onClose() {
    state.scrollController.dispose();
    state.matchTabController?.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  void getRankingData() {
    if (state.vrMatch!.mmp.isEmpty) {
      state.isCup.value = false;
    } else {
      state.isCup.value = true;
      if (state.vrMatch!.mmp == "GROUPS") {
        state.groudIndex.value = 0;
      }
    }
    var tid = Get.find<VrTyHomeController>().subMenu?.menuId ?? '';
    if (state.isCup.value) {
      if (state.groudIndex.value == 0) {
        ///小组赛接口
        vrDetailService
            .getVirtualSportXZTeamRankingFetch(tid: tid /*'86945115832995842'*/)
            .then((value) {
          state.groupList = value.data!;
          update();
        });
      } else {
        ///淘汰赛接口
        // tid: 86945115832995842
        // batchNo: 457652
        // lod: 2
        // mmp: SEMIFINAL
        // beginTime: 1710419160000
        // t: 1710419105589
        //https://api.jlsdfj012.com/yewu11/v1/w/virtual/getMatchSorce?tid=86945115832995842&batchNo=457704&lod=1&mmp=Q8&beginTime=1710428520000&t=1710428466015

        // https://api.0yeex2e.com/yewu11/v1/w/virtual/getMatchSorce?tid=367673662706831362&batchNo=87529&lod=1&mmp=Q4&beginTime=1710430979717&t=1710431390172
        // https://api-c.sportxxx1zx.com/yewu11/v1/w/virtual/getMatchSorce?tid=86945115832995842&batchNo=457725&lod=1&mmp=Q4&beginTime=1710432300000&t=1710432257002
        // https://api.jlsdfj012.com/yewu11/v1/w/virtual/getMatchSorce?tid=367673662706831362&batchNo=87546&lod=1&mmp=Q8&beginTime=1710434040000&t=1710433988043
        String mmp = state.vrMatch?.mmp ?? 'Q8';
        String lod = state.lod ?? '1';

        vrDetailService
            .getMatchSorceFetch(
          tid: tid,
          batchNo: state.batchNo ?? '',
          lod: lod,
          mmp: mmp,
          beginTime: "1710434040000",
        )
            .then((value) {
          if (value.data != null) {
            // String key = 'Q8';
            // if(disuseIndex.value == 0){
            //   key = 'Q8';
            // }else if(disuseIndex.value == 2){
            //   value.data?['Q4'].forEach((element){
            //     disuseList.add(ItemDisuseEntity.fromJson(element));
            //   });
            // }else if(disuseIndex.value == 3){
            //   value.data?['SEMIFINAL'].forEach((element){
            //     disuseList.add(ItemDisuseEntity.fromJson(element));
            //   });
            // }
            List<String> keyList = ['Q8', 'Q4', 'SEMIFINAL', "FINAL"];

            ///将数据按照8强、4强、半决赛、决赛，进行分组
            keyList.forEach((key) {
              List<ItemDisuseEntity> temp = [];
              if (value.data?[key] != null) {
                value.data?[key].forEach((element) {
                  temp.add(ItemDisuseEntity.fromJson(element));
                });
                state.disuseListMap[key] = temp;
              }
            });

            ///求出当前正在进行的赛事阶段的TAB的下标，从0开始，依次为8强、4强、半决赛、决赛
            for (int i = 0; i < keyList.length; i++) {
              if (keyList[i] == mmp) {
                state.disuseIndex.value = i;
              }
            }

            ///设置当前显示的列表数据
            state.disuseList =
                state.disuseListMap[keyList[state.disuseIndex.value]]!;
          }
          update();
        });
      }
    } else {
      ///非世界杯类型-常规赛接口
      vrDetailService
          .getVirtualSportTeamRankingFetch(tid: tid /*'23622704727740417'*/)
          .then((value) {
        // ！报错
        if (value.success && ObjectUtil.isNotEmpty(value.data)) {
          state.rankList = value.data!;
          update();
        }
      });
    }
  }

  ///获取历史战绩
  void getHistory() {
    vrDetailService
        .getVirtualMatchDetailCountFetch(mid: state.match!.mid)
        .then((value) {
      state.historyScoreDog = value.data!;
      update();
    });
  }

  // 赛事切换
  void onMatchSelect(MatchEntity match) {
    // 上一个详情id
    String lastMid = state.match?.mid ?? "";
    if (match.mid == state.match?.mid || lastMid == "") {
      return;
    }

    Get.back();

    state.match = match;

    ///足球类历史战绩从msc中取
    state.historyScore = state.match?.msc ?? [];
    state.lod = state.match?.lod;
    state.batchNo = state.match?.batchNo;

    ///赛事详情 跳转先注册tag 避免数据穿透混乱
    Get.lazyPut(() => MatchDetailController(tag: state.match?.mid ?? ''),
        tag: state.match?.mid);

    /// 加载vr详情投注列表
    var detailController =
        Get.find<MatchDetailController>(tag: state.match?.mid);
    detailController.detailState.mId = state.match!.mid;
    detailController.detailState.csid = state.match!.csid;
    detailController.detailState.match = state.match;
    detailController.fetchCategoryList();
    detailController.refreshOddsInfoData(refresh: true);
    DataStoreController.to.updateMatch(state.match!);
    getData();
    update();
    // 注销上一个详情
    Get.delete<MatchDetailController>(tag: lastMid);

    // Navigator.of(Get.context!)
    //     .pushReplacement(
    //       GetPageRoute(
    //         page: () => VrSportDetailPage(),
    //         binding: VrSportDetailBinding(),
    //         settings: RouteSettings(
    //           name: Routes.vrSportDetail,
    //           arguments: {
    //             'vrMatch': state.vrMatch,
    //             'match': match,
    //             'isBalls': state.isBalls,
    //           },
    //         ),
    //         transitionDuration: Duration.zero,
    //         transition: Transition.noTransition,
    //         popGesture: true,
    //       ),
    //     )
    //     .then(
    //       (value) {},
    //     );
  }
}
