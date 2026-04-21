import 'package:common_utils/common_utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/header_type_enum.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';

/// 事件视频播放服务
/// 负责处理比赛事件的视频播放逻辑
class EventVideoService {
  /// 播放事件视频
  /// 
  /// [eventItem] 事件数据
  /// [controllerTag] 控制器标签
  /// [state] 比赛数据状态
  static void playEventVideo(
    AnalyzeLiveVideoLiveEventEntityDataEvents eventItem,
    String controllerTag,
    MatchDataState state,
  ) {
    // 全部事件播放动画和事件
    if (state.currentGeneralEventIndex < 2) {
      _playGeneralEventVideo(eventItem, controllerTag);
    } else {
      // 回放事件播放动画和视频
      _playReplayEventVideo(eventItem, controllerTag, state);
    }
  }

  /// 播放全部事件视频
  static void _playGeneralEventVideo(
    AnalyzeLiveVideoLiveEventEntityDataEvents eventItem,
    String controllerTag,
  ) {
    if (eventItem.fragmentPic?.isNotEmpty != true) return;
    if (ObjectUtil.isEmpty(eventItem.videoUrl)) return;

    final detailController = Get.find<MatchDetailController>(tag: controllerTag);
    final startOfDay = DateTime.now();
    final t = startOfDay.millisecondsSinceEpoch.toString();
    final playVideoUrl =
        '${StringKV.liveUrl.get()}/videoReplay.html?src=${eventItem.videoUrl}&lang=&volume=1&t=$t';

    detailController.detailState.webViewController
        .loadRequest(WebUri(playVideoUrl));
  }

  /// 播放回放事件视频
  static void _playReplayEventVideo(
    AnalyzeLiveVideoLiveEventEntityDataEvents eventItem,
    String controllerTag,
    MatchDataState state,
  ) {
    if (ObjectUtil.isEmpty(eventItem.fragmentVideo)) return;

    final detailController = Get.find<MatchDetailController>(tag: controllerTag);
    detailController.detailState.headerType.value = HeaderType.replay;
    
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final t = startOfDay.millisecondsSinceEpoch.toString();
    
    final domain = StringKV.liveUrl.get() ??
        state.analyzeBackVideoInfoEntity?.referUrl ??
        "";
    final url =
        '$domain/videoReplay.html?src=${eventItem.fragmentVideo}&lang=${Get.locale?.languageCode ?? "zh"}&volume=1&c_f_s=1&t=$t';

    detailController.detailState.replayUrl = url;
    detailController.detailState.webViewController
        .loadRequest(Uri.parse(url));
    detailController.detailState.videoTopShow.value = true;
  }
}

