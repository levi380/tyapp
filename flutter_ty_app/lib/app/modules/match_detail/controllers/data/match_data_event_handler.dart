import 'package:collection/collection.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/services/match_data_event_service.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/StringUtils.dart';
import '../match_data_controller.dart';

/**
 * 事件处理模块
 * 负责WebSocket事件监听和事件数据处理
 */
extension MatchDataEventHandler on MatchDataController {
  /**
   * 初始化事件总线监听
   * 监听赛事详情数据更新事件 (C102)
   */
  void initBus() {
    //C101, C102, C103, C104, C107
    Bus.getInstance().on(EventType.updata_detail_data, (data) {
      Map<String, dynamic> allMap =
          (data as List).first as Map<String, dynamic>;
      String cmd = allMap['cmd'];
      switch (cmd) {
        case WsType.C102:
          _handleC102Event(allMap);
          break;
      }
    });
  }

  /**
   * 处理C102事件
   * @param allMap 事件数据Map
   */
  void _handleC102Event(Map<String, dynamic> allMap) {
    Map<String, dynamic> map = allMap["cd"];
    // 不接收非本赛事的事件
    if ((map["mid"] ?? 0).toString() != tag) {
      return;
    }
    if ("${map["cmec"] ?? ""}".isNotEmpty == true &&
        MatchDataEventService.isContainerEvent(state, map["cmec"] ?? "")) {
      AnalyzeLiveVideoLiveEventEntityDataEvents
          analyzeLiveVideoLiveEventEntityDataEvents =
          MatchDataEventService.createEventFromMap(map);

      AnalyzeLiveVideoLiveEventEntityDataEvents? tempItem =
          state.originLiveVideoEventDataEvents.firstWhereOrNull((e) =>
              analyzeLiveVideoLiveEventEntityDataEvents.eventTime ==
                  e.eventTime &&
              (StringUtils.isNotNullAndNotEmpty(e.eventTime)));
      if (tempItem == null) {
        state.originLiveVideoEventDataEvents
            .add(analyzeLiveVideoLiveEventEntityDataEvents);
      }
      dealEvent(state.originLiveVideoEventDataEvents);
    }
  }

  /**
   * 处理足球事件
   * 过滤并处理事件列表，生成分析数据
   * @param list 事件列表
   */
  void dealEvent(List<AnalyzeLiveVideoLiveEventEntityDataEvents> list) {
    List<AnalyzeLiveVideoLiveEventEntityDataEvents>
        analyzeTotalLiveVideoEventDataEvents =
        MatchDataEventService.dealEvent(state, list);
    if (analyzeTotalLiveVideoEventDataEvents.isEmpty) {
      return;
    }

    MatchDataEventService.filterEventCodes(state, analyzeTotalLiveVideoEventDataEvents);
    state.analyzeTotalLiveVideoEventDataEvents =
        analyzeTotalLiveVideoEventDataEvents.reversed.toList();
    setExpandImportNotValue();
    update();
  }

  /**
   * 事件代码映射
   * 点球阶段的进球也用 进球 的icon
   * @param event 事件对象
   * @return 图片ID
   */
  getImgId(AnalyzeLiveVideoLiveEventEntityDataEvents event) {
    String? eventCode = event.eventCode;
    if (eventCode == "goal") {
      // 点球进球
      eventCode = "goal" + (event.matchPeriodId == "50" ? "50" : "");
    }
    var event_items = state.allKeyEvents
        .where((item) => item["eventCode"] == eventCode)
        .toList();
    if (event_items.isNotEmpty) {
      var event_item = event_items.first;
      return event_item["id"] as String;
    }
    return "";
  }

  /**
   * 添加所有事件到原始事件列表
   * [tempEventDataEvents] 临时事件数据列表
   * 根据eventTime去重，避免重复添加相同时间的事件
   */
  void addAll(List<AnalyzeLiveVideoLiveEventEntityDataEvents> tempEventDataEvents) {
    MatchDataEventService.addAll(state, tempEventDataEvents);
  }
}

