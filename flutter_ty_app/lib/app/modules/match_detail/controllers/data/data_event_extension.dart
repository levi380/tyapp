import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import '../../../../services/api/analyze_detail_api.dart';
import '../../../../services/api/result_api.dart';
import '../../../../services/models/res/analyze_live_video_live_event_entity_entity.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../utils/sport.dart';
import '../../../login/login_head_import.dart';
import '../match_data_controller.dart';
import '../match_detail_controller.dart';
import 'match_data_event_handler.dart';
import 'match_data_basketball_handler.dart';
import 'match_data_tab_manager.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛事分析】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据-事件主控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全部事件
    - 精彩回放
    】】】
 */
extension DataEventExtension on MatchDataController {
  /// 初始化事件数据
  /// 处理全部事件和精彩回放
  void initEventData() {
    // 处理全部事件
    playbackLiveEventSingle();
    // 处理精彩回放
    requestPlayVideo();
  }

  /// 播放实时事件（足球/篮球）
  /// 获取并处理实时事件数据，根据赛事类型进行不同处理
  Future<void> playbackLiveEventSingle() async {
    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: tag);

    MatchEntity? match = detailController.detailState.match;
    final res = await ResultApi.instance().liveEvents(
        tag,
        "${state.videoIndex}",
        match?.csid == SportData.sportCsid_2.toString()
            ? SportData.sportCsid_2.toString()
            : SportData.sportCsid_1.toString());

    if (match?.csid == SportData.sportCsid_2.toString()) {
      // 篮球事件处理
      if ((res.data?.events ?? []).isEmpty) {}
      state.originLiveVideoEventDataEvents = res.data?.events ?? [];
      // 数据分组：根据比赛阶段（matchPeriodId）将事件分组
      // 13:第一节, 14:第二节, 15:第三节, 16:第四节, 40:加时赛
      for (AnalyzeLiveVideoLiveEventEntityDataEvents item
          in state.originLiveVideoEventDataEvents) {
        item.title = get_basketball_message_event_code_txt(item);
        if (item.matchPeriodId == "13") {
          state.list_event1.add(item);
        }
        if (item.matchPeriodId == "14") {
          state.list_event2.add(item);
        }
        if (item.matchPeriodId == "15") {
          state.list_event3.add(item);
        }
        if (item.matchPeriodId == "16") {
          state.list_event4.add(item);
        }
        if (item.matchPeriodId == "40") {
          state.list_event5.add(item);
        }
      }
      tabsType();
      // 使用Tab管理模块的方法
      setBasketBallTab(0);
    } else {
      if ((res.data?.events ?? []).isEmpty) {
        state.originLiveVideoEventDataEvents.clear();
        state.currentEventDataEvents.clear();
        state.bottomKeyEvent.clear();
        update();
        return;
      }

      addAll((res.data?.events ?? []));
      dealData(state.originLiveVideoEventDataEvents);
    }
  }

  /// 请求回放数据
  /// 获取精彩回放视频数据并排序
  requestPlayVideo() async {
    try {
      var res =
          await AnalyzeDetailApi.instance().playbackVideoUrl(tag, "H5", "0");
      state.analyzeBackVideoInfoEntity = res.data;
      // 按时间倒序排序（时间大的在前），时间相同则按序号倒序排序
      (res.data?.eventList ?? []).sort((a, b) {
        if ((b.secondsFromStart ?? 0) < (a.secondsFromStart ?? 0)) {
          return -1;
        } else if ((b.secondsFromStart ?? 0) > (a.secondsFromStart ?? 0)) {
          return 1;
        }
        // 时间相同时，按序号倒序
        if ((b.firstNum ?? 0) < (a.firstNum ?? 0)) {
          return -1;
        } else if ((b.firstNum ?? 0) > (a.firstNum ?? 0)) {
          return 1;
        }
        return 0;
      });
      // 检查是否存在点球事件（extraInfo包含'5'表示点球）
      if ((res.data?.eventList ?? [])
              .where((element) => element.extraInfo?.contains('5') == true)
              .toList()
              .length >
          0) {
        state.shootout = true;
      } else {
        state.shootout = false;
      }
      state.playbackVideoEventList = res.data?.eventList ?? [];
      update();
    } catch (e) {
      AppLogger.debug("requestPlayVideo : " + e.toString());
    }
  }

  /**
   * 处理数据
   * 篮球处理数据 - 调用事件处理模块的dealEvent方法
   * @param list 事件列表
   */
  void dealData(List<AnalyzeLiveVideoLiveEventEntityDataEvents> list) {
    // 使用事件处理模块的方法
    dealEvent(list);
  }

  /**
   * 处理tabs数据
   * 根据事件列表长度动态移除空的tab
   * 如果某个时间段没有事件，则移除对应的tab
   */
  tabsType() {
    // 处理tabs 数据
    // 如果第一节没有事件，移除tab ID为1的tab
    if (state.list_event1.length == 0) {
      Map? index = findIndex(state.listTabs, 1);
      if (index != null) {
        state.listTabs.remove(index);
      }
    }

    // 如果第二节没有事件，移除tab ID为2的tab
    if (state.list_event2.length == 0) {
      Map? index = findIndex(state.listTabs, 2);
      if (index != null) {
        state.listTabs.remove(index);
      }
    }
    // 如果前两节都没有事件，移除合并tab（ID为1和2）
    if (state.list_event1.length == 0 && state.list_event2.length == 0) {
      Map? index = findIndex(state.listTabs, 1);
      if (index != null) {
        state.listTabs.remove(index);
      }
      Map? index2 = findIndex(state.listTabs, 2);
      if (index2 != null) {
        state.listTabs.remove(index2);
      }
    }
    // 如果第三节没有事件，移除tab ID为4的tab
    if (state.list_event3.length == 0) {
      Map? index = findIndex(state.listTabs, 4);
      if (index != null) {
        state.listTabs.remove(index);
      }
    }

    // 如果第四节没有事件，移除tab ID为5的tab
    if (state.list_event4.length == 0) {
      Map? index = findIndex(state.listTabs, 5);
      if (index != null) {
        state.listTabs.remove(index);
      }
    }
    // 如果后两节都没有事件，移除合并tab（ID为4和5）
    if (state.list_event3.length == 0 && state.list_event4.length == 0) {
      Map? index = findIndex(state.listTabs, 4);
      if (index != null) {
        state.listTabs.remove(index);
      }
      Map? index2 = findIndex(state.listTabs, 5);
      if (index2 != null) {
        state.listTabs.remove(index2);
      }
    }

    // 如果加时赛没有事件，移除tab ID为7的tab
    if (state.list_event5.length == 0) {
      Map? index = findIndex(state.listTabs, 7);
      if (index != null) {
        state.listTabs.remove(index);
      }
    }
    update();
  }

}

