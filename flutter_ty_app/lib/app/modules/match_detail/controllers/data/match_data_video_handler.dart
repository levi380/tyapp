import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_playback_video_info_entity.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_utils.dart';
import '../match_data_controller.dart';
import '../match_detail_controller.dart';
import 'data_event_extension.dart';

/**
 * 视频处理模块
 * 负责视频播放、视频数据处理和Tab视频切换
 */
extension MatchDataVideoHandler on MatchDataController {
  /**
   * 设置选择播放页面的页签
   * @param index 视频索引
   */
  void setSelectVideo(int index) {
    state.videoIndex = index;
    state.isExpandImport = false;
    state.originLiveVideoEventDataEvents.clear();
    playbackLiveEventSingle();
  }

  /**
   * 处理不同分类的视频数据
   * 根据页面索引处理不同类型的回放视频
   * @param page 页面索引
   */
  void dealTabVideo(int page) {
    MatchPlaybackVideoInfoEntity value =
        state.analyzeBackVideoInfoEntity ?? MatchPlaybackVideoInfoEntity();
    if (page == 0) {
      value.eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.playbackVideoEventList = value.eventList;
    } else if (page == 1) {
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getEventCode("goal", value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.playbackVideoEventList = eventList;
    } else if (page == 2) {
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getEventCode("corner", value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.playbackVideoEventList = eventList;
    } else if (page == 3) {
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getEventCode("yellow_card", value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.playbackVideoEventList = eventList;
    } else if (page == 4) {
      List<MatchPlaybackVideoInfoEntityEventList>? eventList =
          getDianQiuCode(value);
      eventList.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.playbackVideoEventList = eventList;
    }
    state.totalEventDataEvents = state.playbackVideoEventList.map((e) {
      AnalyzeLiveVideoLiveEventEntityDataEvents eventItem =
          AnalyzeLiveVideoLiveEventEntityDataEvents.fromJson(e.toJson());
      eventItem.fragmentPic = e.fragmentPic;

      eventItem.fragmentVideo = e.fragmentVideo;
      eventItem.secondsFromTart = "${e.secondsFromStart ?? 0}";
      eventItem.centerName =
          "${AnalyzeUtils.getMap()['${e.eventCode}'] ?? ""}${e.firstNum}";
      eventItem.centerTopName = "${e.homeAway ?? ""}";
      eventItem.type = 1;
      eventItem.homeAway = e.isHomeOrAway ?? "home";
      return eventItem;
    }).toList();
    state.currentEventDataEvents =
        state.totalEventDataEvents.toList(growable: true);
  }

  /**
   * 获取事件集合
   * 根据事件代码获取匹配的事件列表
   * @param eventCode 事件代码
   * @param value 回放视频信息实体
   * @return 事件列表
   */
  List<MatchPlaybackVideoInfoEntityEventList> getEventCode(
      String eventCode, MatchPlaybackVideoInfoEntity value) {
    List<MatchPlaybackVideoInfoEntityEventList> eventList = [];
    for (MatchPlaybackVideoInfoEntityEventList analyzeBackVideoInfoEntityEventList
        in value.eventList) {
      if (analyzeBackVideoInfoEntityEventList.eventCode == eventCode) {
        eventList.add(analyzeBackVideoInfoEntityEventList);
      }
    }
    return eventList;
  }

  /**
   * 获取点球集合
   * 从回放视频信息中获取点球相关事件
   * @param value 回放视频信息实体
   * @return 点球事件列表
   */
  List<MatchPlaybackVideoInfoEntityEventList> getDianQiuCode(
      MatchPlaybackVideoInfoEntity value) {
    List<MatchPlaybackVideoInfoEntityEventList> eventList = [];
    for (MatchPlaybackVideoInfoEntityEventList analyzeBackVideoInfoEntityEventList
        in value.eventList) {
      if (analyzeBackVideoInfoEntityEventList.extraInfo?.contains('5') ==
          true) {
        eventList.add(analyzeBackVideoInfoEntityEventList);
      }
    }
    return eventList;
  }

  /**
   * 播放事件视频
   * @param eventItem 事件项
   */
  void onPlayVideo(AnalyzeLiveVideoLiveEventEntityDataEvents eventItem) {
    if (ObjectUtil.isNotEmpty(eventItem.videoUrl) &&
        eventItem.fragmentPic?.isNotEmpty == true) {
      final controller = Get.find<MatchDetailController>(tag: tag);
      DateTime startOfDay = DateTime.now();
      String t = startOfDay.millisecondsSinceEpoch.toString();
      String playVideoUrl =
          '${StringKV.liveUrl.get()}/videoReplay.html?src=${eventItem.videoUrl}&lang=&volume=1&t=$t';

      controller.detailState.webViewController
          .loadRequest(WebUri(playVideoUrl));
    }
  }
}

