import 'package:common_utils/common_utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_controller_ext.dart';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:rxdart/rxdart.dart';

import '../../../global/data_store_controller.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';

import '../../../services/models/res/playback_video_url_entity.dart';
import '../../../utils/systemchrome.dart';

import '../../match_detail/controllers/match_detail_controller.dart';
import '../widgets/HeaderModel.dart';
import 'results_details_logic.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9176c2a2-fe19-41b2-9ee1-2cf24db8b7c1-xq 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 控制器  ResultsDetailsController】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  赛果详情 控制器  ResultsDetailsController
    - ResultsDetailsController
    ```
    ///赛事
    bool event = false;

    ///bet
    bool bet = false;

    ///回放
    bool playback = false;

    ///精彩回放title
    List<String> videoHead = [
    ///全部
    LocaleKeys.highlights_type_all.tr,

    ///进球
    LocaleKeys.highlights_type_goal.tr,

    ///角球
    LocaleKeys.highlights_type_corner.tr,

    ///罚牌
    LocaleKeys.highlights_type_penalty.tr,
    ];

    ///精彩回放title 多了点球大战
    List<String> videoHead1 = [
    ///全部
    LocaleKeys.highlights_type_all.tr,

    ///进球
    LocaleKeys.highlights_type_goal.tr,

    ///角球
    LocaleKeys.highlights_type_corner.tr,

    ///罚牌
    LocaleKeys.highlights_type_penalty.tr,

    ///点球大战
    LocaleKeys.football_playing_way_penalty_shootout.tr,
    ];


    /// 头部渲染 对象
    HeaderModel headerMap = HeaderModel();

    /// 头部选择联赛列表
    List<MatchEntity> headMatchList = [];

    /// 当前联赛
    late MatchEntity currentMatch;

    /// 使用默认详情
    late MatchDetailController detailController;

    /// 记录请求次数
    int requestCount = 0;
    ```
    】】】
 *
 */

class ResultsDetailsController extends GetxController
    with GetTickerProviderStateMixin {
  final ResultsDetailslogic logic = ResultsDetailslogic();
  late AnimationController animationController;
  late Animation animation;
  InAppWebViewController? webViewController;




  List<PlaybackVideoUrlDataEventList> originEventList = [];

  MatchEntity match = Get.arguments[0]['item'];
  String typePicture = Get.arguments[1]['typePicture'];
  int eventHeadIndex = 0;
  int videoIndex = 0;
  int titleIndex = Get.arguments[2]['titleIndex'];

  List<MatchHps> data = [];
  MatchEntity? detailData;

  late List<MatchEntity> matcheHandpickData = [];
  late List<PlaybackVideoUrlDataEventList> eventList = [];
  List<GetH5OrderListDataRecordxData> miApuestaData = [];

  /// 头部渲染 对象
  HeaderModel headerMap = HeaderModel();

  /// 头部选择联赛列表
  List<MatchEntity> headMatchList = [];

  /// 当前联赛
  late MatchEntity currentMatch;

  /// 使用默认详情
  late MatchDetailController detailController;

  final _refreshSubject = BehaviorSubject<Function>();



  @override
  void onInit() {
    SystemUtils.isDarkMode(true);
    logic.mid = match.mid;
    // if (Get.isRegistered<MatchDetailController>(tag: mid)) {
    //   detailController = Get.find<MatchDetailController>(tag: mid);
    // } else {
    //   detailController = Get.put(MatchDetailController(tag: mid), tag: mid);
    // }
    detailController = Get.put(MatchDetailController(tag: logic.mid), tag: logic.mid);
    initData();

    iconRefresh();

    // 初始化赛果详情投注数据
    detailController.initResultDetailOddsInfo(match);

    initSubject();

    super.onInit();
  }

  void initData() async {
    await getResultMatchDetail();

    matcheHandpick();
    getResultGetH5OrderList();

    ///精彩回放接口
    playbackVideoUrl(0);

    Bus.getInstance().on(EventType.send_bat_handicap_odds, (value) {
      matcheHandpick();
    });
  }

  @override
  void onClose() {
    _refreshSubject.close();
    try {
      webViewController?.dispose();
    } catch (e) {}

    super.onClose();
  }

  ///点击菜单,请求对应接口
  onEventHeadIndex(int index) {
    eventHeadIndex = index;
    if (eventHeadIndex == 0) {
      detailController.refreshOddsInfoData(refresh: true);
    } else if (eventHeadIndex == 1) {
      /// 对应vue match-container-main-template7.vue
      matcheHandpick();
    } else if (eventHeadIndex == 2) {
      getResultGetH5OrderList();

      ///避免 update 刷两次的问题
      return;
    } else if (eventHeadIndex == 3) {
      playbackVideoUrl(0);
    }
    update();
  }

  ///赛果列表接口
  Future<void> getResultMatchDetail() async {
    logic.loading.value = true;
    try {
      logic.requestCount++;
      final res = await ResultApi.instance().getResultMatchDetail(
        logic.mid,
        1,
        TYUserController.to.getUid(),
        titleIndex == 0 ? '' : '1',
        isNew: 1
      );
      if (res.success && ObjectUtil.isNotEmpty(res.data)) {
        detailData = res.data;

        /// 按照h5进行特殊处理
        // 61-比赛延迟,80-比赛中断,90-比赛放弃
        if (!(['90', '80', '61'].contains(detailData?.mmp))) {
          detailData?.mmp = '999';
        }
        // TODO js 空字符串是false？
        // if("" && data.mo == 1){
        //   // 61-比赛延迟,80-比赛中断,90-比赛放弃
        //   if(!(['90','80','61'].includes(data.mmp+''))){
        //     data.mmp = '999'
        //   }
        // }

        detailData?.mhs = 0;
        // 更新数据仓库
        setHeaderMap(detailData);
        DataStoreController.to.updateMatch(detailData!);

        update();
      }
      logic.loading.value = false;
    } catch (e) {
      /// 请求超过五次，退到上一页面
      if (logic.requestCount >= 5) {
        Get.back();
        return;
      }
      1100.milliseconds.delay(() {
        if (isClosed) return;
        getResultMatchDetail();
      });
    }
  }

  ///我的注单接口
  Future<void> getResultGetH5OrderList() async {
    try {
      final res = await ResultApi.instance().resultGetH5OrderList(
        logic.mid,
        2,
        '1',
        3,
      );
      if (res.code == '0000000') {
        if (res.data.record != null && res.data.record!.isNotEmpty) {
          ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
          Map<String, GetH5OrderListDataRecordx?> record =
              res.data.record ?? {};
          List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
              record.entries.toList();
          Map<String, GetH5OrderListDataRecordx?> reversedMap =
              Map.fromEntries(entries);

          miApuestaData.clear();

          ///便利map，把数据全部房在一起。
          reversedMap.forEach((key, value) {
            miApuestaData.addAll(value!.data);
          });

          ///当注单列表有数据的时候，才展示出来
          logic.bet = (miApuestaData.isNotEmpty && miApuestaData.length > 0);
        }
        update();
      }
      logic.loading.value = false;
    } catch (e) {
      // 请求超过五次，退到上一页面
      if (logic.requestCount >= 5) {
        Get.back();
        return;
      }
      1100.milliseconds.delay(() {
        if (isClosed) return;
        getResultGetH5OrderList();
      });
    }
  }

  ///精选赛事接口
  Future<void> matcheHandpick() async {
    logic.loading.value = true;
    try {
      final res = await ResultApi.instance().matcheHandpick(
        TYUserController.to.getUid(),
        detailData?.csid ?? "",
      );
      if (res.success && ObjectUtil.isNotEmpty(res.data)) {
        matcheHandpickData = res.data!;

        /// 补齐半场玩法
        // var theMatch = matcheHandpickData.firstWhereOrNull((page)=>page.hps.length>3);
        // if(theMatch!=null){
        //   for(var match in matcheHandpickData){
        //     int length = match.hps.length;
        //     for(int i=length;i<6;i++){
        //       match.hps.add(MatchHps());
        //     }
        //   }
        // }
        /// 只留前3个元素
        for (var match in matcheHandpickData) {
          match.hps = match.hps.take(3).toList();

          // 存数据仓库
          DataStoreController.to.updateMatch(match);
        }
        logic.event = true;
        update();
      }
    } catch (e) {
      AppLogger.debug("赛果精选赛事：$e");
    } finally {
      logic.loading.value = false;
    }
  }

  ///头部数据刷新
  onRefresh() {
    animationController.forward();
    getResultMatchDetail();

    /// 赔率列表数据拉取
    _refreshSubject.add(() => detailController.refreshOddsInfoData(refresh: true));
  }

  void initSubject() {
    _refreshSubject
        .debounceTime(const Duration(milliseconds: 1100))
        .listen((callback) {
      /// 点击防抖
      callback();
    });
  }
}

class FLagModel {
  /// 图标
  late String icon = '';

  /// 进球 角球
  late String name = '';
}
