
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/utils/StringUtils.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../states/match_data_state.dart';

/**
 * 事件处理服务类
 * 负责处理事件相关的业务逻辑
 */
class MatchDataEventService {
  /**
   * 根据eventcode判断是否包含事件
   * @param state 状态对象
   * @param eventCode 事件代码
   * @return 是否包含该事件
   */
  static bool isContainerEvent(MatchDataState state, String eventCode) {
    bool result = false;
    for (var item in state.allKeyEvents) {
      if (item["eventCode"] == eventCode) {
        result = true;
        break;
      }
    }
    return result;
  }

  /**
   * 根据eventcode 查找 事件Map
   * @param state 状态对象
   * @param eventCode 事件代码
   * @return 事件Map，如果未找到返回null
   */
  static Map<String, dynamic>? findContainerEvent(
      MatchDataState state, String eventCode) {
    Map<String, dynamic>? result;
    for (var item in state.allKeyEvents) {
      if (item["eventCode"] == eventCode) {
        result = item;
        break;
      }
    }
    return result;
  }

  /**
   * 处理足球事件
   * 过滤并处理事件列表，生成分析数据
   * @param state 状态对象
   * @param list 事件列表
   * @return 处理后的事件列表
   */
  static List<AnalyzeLiveVideoLiveEventEntityDataEvents> dealEvent(
      MatchDataState state,
      List<AnalyzeLiveVideoLiveEventEntityDataEvents> list) {
    List<AnalyzeLiveVideoLiveEventEntityDataEvents>
        analyzeTotalLiveVideoEventDataEvents = [];
    for (AnalyzeLiveVideoLiveEventEntityDataEvents item in (list)) {
      if (isContainerEvent(state, item.eventCode ?? "") && item.canceled == 0) {
        Map<String, dynamic>? map = findContainerEvent(state, item.eventCode ?? "");
        if (map != null) {
          if (item.eventCode == "goal") {
            item.player1Name = _filterGoalExtraInfo(item.extraInfo ?? "");
            item.player2Name = _filterGoalExtraInfo(item.extraInfo ?? "");
          } else {
            item.player1Name = map["i18n"];
            item.player2Name = map["i18n"];
          }
        }
        analyzeTotalLiveVideoEventDataEvents.add(item);
      }
    }
    return analyzeTotalLiveVideoEventDataEvents;
  }

  /**
   * 过滤事件代码
   * 底部控件，接口中返回的所有事件
   * @param state 状态对象
   * @param analyzeTotalLiveVideoEventDataEvents 事件列表
   * @return 过滤后的事件列表
   */
  static List filterEventCodes(
      MatchDataState state,
      List<AnalyzeLiveVideoLiveEventEntityDataEvents>
          analyzeTotalLiveVideoEventDataEvents) {
    if (analyzeTotalLiveVideoEventDataEvents.isEmpty) {
      return [];
    }
    state.bottomKeyEvent.clear();

    List<String> codes = [];
    analyzeTotalLiveVideoEventDataEvents.sort((a, b) {
      return (int.tryParse(a.secondsFromTart ?? "0") ?? 0) -
          (int.tryParse(b.secondsFromTart ?? "0") ?? 0);
    });
    for (AnalyzeLiveVideoLiveEventEntityDataEvents item
        in analyzeTotalLiveVideoEventDataEvents) {
      if (item.canceled == 0) {
        if (!codes.contains(item.eventCode)) {
          codes.add(item.eventCode ?? "");
        }
      }
    }

    List tempsList = [];
    for (var item in state.allKeyEvents) {
      for (String code in codes) {
        if (item["eventCode"] == code) {
          tempsList.add(item);
          break;
        }
      }
    }
    state.bottomKeyEvent.addAll(tempsList);
    return tempsList;
  }

  /**
   * 创建事件对象
   * @param map 事件数据Map
   * @return 创建的事件对象
   */
  static AnalyzeLiveVideoLiveEventEntityDataEvents createEventFromMap(
      Map<String, dynamic> map) {
    AnalyzeLiveVideoLiveEventEntityDataEvents
        analyzeLiveVideoLiveEventEntityDataEvents =
        AnalyzeLiveVideoLiveEventEntityDataEvents();
    analyzeLiveVideoLiveEventEntityDataEvents.homeAway = map["hn"] ?? "";
    analyzeLiveVideoLiveEventEntityDataEvents.eventTime = "${map["et"] ?? 0}";
    analyzeLiveVideoLiveEventEntityDataEvents.eventCode = "${map["cmec"] ?? 0}";
    analyzeLiveVideoLiveEventEntityDataEvents.canceled = map["cmes"] ?? 0;
    analyzeLiveVideoLiveEventEntityDataEvents.secondsFromTart =
        "${map["mst"] ?? 0}";
    analyzeLiveVideoLiveEventEntityDataEvents.t1 = "${map["t1"] ?? 0}";
    analyzeLiveVideoLiveEventEntityDataEvents.t2 = "${map["t2"] ?? 0}";
    analyzeLiveVideoLiveEventEntityDataEvents.matchPeriodId = "${map["mmp"] ?? 0}";
    analyzeLiveVideoLiveEventEntityDataEvents.standardMatchId =
        "${map["mid"] ?? 0}";
    analyzeLiveVideoLiveEventEntityDataEvents.sportId =
        int.tryParse("${map["csid"]}") ?? 0;
    return analyzeLiveVideoLiveEventEntityDataEvents;
  }

  /**
   * 添加所有事件到原始事件列表
   * @param state 状态对象
   * @param tempEventDataEvents 临时事件数据列表
   * 根据eventTime去重，避免重复添加相同时间的事件
   */
  static void addAll(
      MatchDataState state,
      List<AnalyzeLiveVideoLiveEventEntityDataEvents> tempEventDataEvents) {
    for (AnalyzeLiveVideoLiveEventEntityDataEvents item
        in tempEventDataEvents) {
      // 检查是否已存在相同eventTime的事件
      AnalyzeLiveVideoLiveEventEntityDataEvents? tempItem =
          state.originLiveVideoEventDataEvents.firstWhereOrNull((e) =>
              item.eventTime == e.eventTime &&
              (StringUtils.isNotNullAndNotEmpty(e.eventTime)));
      if (tempItem == null) {
        // 不存在则添加
        state.originLiveVideoEventDataEvents.add(item);
      }
    }
  }

  /**
   * 过滤进球额外信息
   * @param key 额外信息key
   * @return 过滤后的信息
   */
  static String _filterGoalExtraInfo(String key) {
    Map<String, String> extraInfoMap = {
      "2": LocaleKeys.match_result_own_goals.tr,
    };
    return extraInfoMap[key] ?? LocaleKeys.match_result_goal.tr;
  }
}

