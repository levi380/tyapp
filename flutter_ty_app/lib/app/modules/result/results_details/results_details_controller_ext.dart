import 'package:common_utils/common_utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-date.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_controller.dart';
import 'package:flutter_ty_app/app/services/api/match_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../global/data_store_controller.dart';
import '../../../routes/route_manager.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/get_match_result_entity.dart';
import '../../../services/models/res/playback_video_url_entity.dart';

import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../match_detail/controllers/match_detail_controller.dart';

import 'package:intl/intl.dart';

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

extension ResultsDetailsControllerExt on ResultsDetailsController {

  /// 设置头部参数
  setHeaderMap(data) {
    /// 获取比分
    headerMap.score = TYFormatScore.formatTotalScore(data).text;

    /// 获取时间
    String time = TYFormatDate.formatTime(
        TimeZoneUtils.convertTimeToTimestamp(data.mgt,
            isMilliseconds: true, returnMilliseconds: true)
            .toString(),
        'mm/dd HH:MM') +
        " (" +
        TimeZoneUtils.getTimeZoneString() +
        ")";
    headerMap.time = time;

    String status = '';
    Map detailDataMmpMap = {
      '90': 'mmp.3.90',
      '61': 'mmp.5.61',
      '80': 'mmp.5.80',
      '100': 'mmp.2.100',
      // '999': 'mmp.3.999',
      '999': 'mmp.3.999_app_h5',
    };

    /// 只在足球详情页面 显示

    /// 赛事中断 单独判断
    if (data.ms == 10) {
      status = 'ms.10';
    } else if (detailDataMmpMap.containsKey(data.mmp)) {
      status = detailDataMmpMap[data.mmp];
    } else {
      status = '';
    }
    headerMap.status = status;
    update();
  }

  ///精彩回放接口
  Future<void> playbackVideoUrl(int eventCode) async {
    final res = await ResultApi.instance().playbackVideoUrl(
      'H5',
      eventCode.toString(),
      logic.mid,
    );
    if (res.data?.eventList.isNotEmpty == true) {
      eventList = res.data?.eventList ?? [];
      eventList = originEventList = List.from(eventList.reversed);

      /// extraInfo = 5 点球大战数据
      if (originEventList
          .where((element) => element.extraInfo.contains('5'))
          .toList()
          .length >
          0) {
        logic.shootout = true;
      } else {
        logic.shootout = false;
      }

      logic.playback = true;
      update();
    }
  }

  onIsExpand(GetMatchResultData data) {
    data.isExpand = !data.isExpand;
    update();
  }

  onExpandAll() {
    if (eventHeadIndex == 0) {
      bool res = !logic.allExpand;

      /// 一键展开折叠
      detailController.changeBtn();
      logic.allExpand = res;
      // update();
    }
  }



  ///刷新数据初始化动画
  void iconRefresh() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  onHeadMenu() {
    logic.headMenu = !logic.headMenu;

    /// 显示
    if (logic.headMenu) {
      /// 走接口获取列表
      fetchMatchListData();
    } else {
      update();
    }
  }

  /// 联赛下拉选择组件展开时的联赛列表获取
  fetchMatchListData() async {
    /// 从参数中获取赛事 ID
    String tId = match.tid;

    /// 将 detailData 中的 mgt 字符串解析为整数
    int mgt = int.parse(detailData!.mgt);

    /// 将 mgt 转换为 DateTime 对象
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(mgt);

    /// 将 DateTime 转换为本地时间并格式化为 ISO 8601 字符串，提取日期部分
    String date_ = dateTime.toLocal().toIso8601String().split('T')[0];

    /// 解析日期字符串为 DateTime 对象
    DateTime parsedDate = DateTime.parse(date_);

    /// 获取解析后日期的毫秒时间戳
    int time_ = parsedDate.millisecondsSinceEpoch;

    /// 调用 MatchDetailApi 获取比赛详情
    MatchDetailApi.instance()
        .getMatchDetailByTournamentId(
      tId,
      1,
      time_.toString(),
      titleIndex == 0 ? '' : '1',
    )
        .then((value) {
      if (value.success && ObjectUtil.isNotEmpty(value.data)) {
        headMatchList = value.data!;
        update();
      }
    });
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }

  formatDateTimes(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }

  ///精彩回放数据筛选
  onSelectVideo(int index) {
    videoIndex = index;
    print(videoIndex);

    /// 全部
    if (index == 0) {
      eventList = originEventList;
    }

    /// 进球
    else if (index == 1) {
      eventList = originEventList
          .where((element) => element.eventCode == 'goal')
          .toList();
    }

    /// 角球
    else if (index == 2) {
      eventList = originEventList
          .where((element) => element.eventCode == 'corner')
          .toList();
    }

    /// 罚牌
    else if (index == 3) {
      eventList = originEventList
          .where((element) => element.eventCode.contains('card'))
          .toList();
    }

    /// 点球大战
    else {
      eventList = originEventList
          .where((element) => element.extraInfo.contains('5'))
          .toList();
    }

    update();
  }

  /// 点击头部 切换联赛
  onHeadMatch(MatchEntity matchItem) {
    currentMatch = matchItem;
    logic.mid = matchItem.mid;

    /// 变更联赛 初始化对应tag的MatchDetailController
    // if (Get.isRegistered<MatchDetailController>(tag: mid)) {
    //   detailController = Get.find<MatchDetailController>(tag: mid);
    // } else {
    //   detailController = Get.put(MatchDetailController(), tag: mid);
    // }
    detailController = Get.put(MatchDetailController(tag: logic.mid), tag: logic.mid);
    eventHeadIndex = 0;
    getResultMatchDetail();
    logic.headMenu = !logic.headMenu;

    if (logic.mid != detailController.detailState.mId) {
      /// 赛事变更重置玩法集tab 投注数据
      detailController.detailState.curCategoryTabId = "0";
      detailController.detailState.mId = logic.mid;

      /// 投注数据拉取
      detailController.refreshOddsInfoData(refresh: true);
    }
  }

  onGoToDetails(MatchEntity item) {
    DataStoreController.to.injectMatch(item);

    /// 跳转不同mid详情 不与当前赛果的默认详情冲突
    RouteManager.goMatchDetail(mid: item.mid, csid: item.csid);
  }

  ///精彩回放 视频播放
  onPlayVideo(PlaybackVideoUrlDataEventList eventItem) {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    String t = startOfDay.millisecondsSinceEpoch.toString();
    logic.playVideoUrl =
    '${StringKV.liveUrl.get()}/videoReplay.html?src=${eventItem.fragmentVideo}&lang=&volume=1&t=$t';

    webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(logic.playVideoUrl)));
    logic.playVideo = true;
    update();
  }

  ///视频播放关闭
  onClosVideo() {
    // webViewController.canGoBack();
    logic.playVideo = false;
    webViewController?.evaluateJavascript(
        source: "that.player.video.setAttribute('muted','muted');");
    webViewController?.evaluateJavascript(source: "that.player.pause();");
    update();
  }



  onBetIsExpand(betIsExpand, index) {
    miApuestaData[index].betIsExpand = !betIsExpand;
    update();
  }

}

