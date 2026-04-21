import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../../../app/modules/login/login_head_import.dart';
import '../../../states/match_data_state.dart';

/**
 * 篮球事件转换服务类
 * 负责处理篮球事件相关的消息转换逻辑
 */
class MatchDataBasketballEventService {
  /**
   * 篮球事件转换为消息
   * @param state 状态对象
   * @param item 事件项
   * @param defaultValue 默认值
   * @return 转换后的消息字符串
   */
  static String? basketballEventToMsg(
      MatchDataState state,
      AnalyzeLiveVideoLiveEventEntityDataEvents? item,
      {String defaultValue = ''}) {
    if (item == null) {
      return "-";
    }

    String eventCode = item.eventCode ?? "";
    String? eventLang = state.basket_all_map[eventCode];
    if (eventLang != null) {
      return item.title ?? defaultValue;
    }

    if ('time_start' == eventCode) {
      return timeStartToMsg(state, eventLang, item);
    }
    if ('score_miss' == eventCode) {
      return scoreMissToMsg(state, eventLang, item);
    }

    if (['score_change', 'score_delete'].contains(eventCode)) {
      return scoreChangeOrScoreDeleteToMsg(state, eventLang, item);
    }

    if ('match_status' == eventCode) {
      return [
        eventLang,
        // getByPathArray(state.all_match_status_map, [matchPeriodId])
      ].join(': ');
    }
    return eventLang;
  }

  /**
   * 未命中事件转换为消息
   * @param state 状态对象
   * @param eventLang 事件语言
   * @param item 事件项
   * @return 转换后的消息字符串
   */
  static String? scoreMissToMsg(
      MatchDataState state,
      String? eventLang, AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    String? eventCode = item.eventCode;
    String? extraInfo = item.extraInfo;
    String? addition1 = item.addition1;
    String? addition2 = item.addition2;

    String title = '';
    if (addition1 != null && addition2 != null) {
      title = [
        LocaleKeys.analysis_nth.tr,
        LocaleKeys.analysis_a.tr,
        getByPathArray(state.send_ball_extra_info_map, [eventCode ?? "", "1"])
      ].join('');
    } else {
      title = extraInfo != null
          ? getByPathArray(
              state.send_ball_extra_info_map, [eventCode ?? "", extraInfo],
              defaultValue: '-')
          : '-';
    }
    return [eventLang, title].join(': ');
  }

  /**
   * 比分变更或删除事件转换为消息
   * @param state 状态对象
   * @param eventLang 事件语言
   * @param item 事件项
   * @return 转换后的消息字符串
   */
  static String scoreChangeOrScoreDeleteToMsg(
      MatchDataState state,
      String? eventLang, AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    String? eventCode = item.eventCode;
    String? extraInfo = item.extraInfo;
    String? addition1 = item.addition1;
    String? addition2 = item.addition2;
    String? addition3 = item.addition3;
    String? firstT1 = item.firstT1;
    String? firstT2 = item.firstT2;

    String title = '';
    if (addition1 != null) {
      // 罚球文案
      if (addition2 != null) {
        // 单个罚球的文案
        title = [
          LocaleKeys.analysis_nth.tr,
          addition2,
          LocaleKeys.analysis_a.tr,
          getByPathArray(state.send_ball_extra_info_map, [eventCode ?? "", "1"])
        ].join('');
      } else if (addition3 != null) {
        // 输入框送出罚球的文案
        List<String> list = addition3.split(' - ');
        String goal = "";
        String total = "";

        if (list.length >= 2) {
          goal = list[0];
          total = list[1];
        }

        title = [
          LocaleKeys.analysis_free_throw.tr,
          total,
          LocaleKeys.analysis_a.tr,
          LocaleKeys.analysis_f_Hit.tr,
          goal,
          LocaleKeys.analysis_a.tr
        ].join('');
      }
    } else {
      // 加减比分 2分球 3分球 文案
      title = extraInfo != null
          ? getByPathArray(
              state.send_ball_extra_info_map, [eventCode ?? "", extraInfo])
          : "${firstT1}:${firstT2}";
    }

    return [eventLang, title].join(': ');
  }

  /**
   * 开始计时事件转换为消息
   * @param state 状态对象
   * @param eventLang 事件语言
   * @param item 事件项
   * @return 转换后的消息字符串
   */
  static String? timeStartToMsg(
      MatchDataState state,
      String? eventLang, AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    String? addition6 = item.addition6;
    if (addition6 != null) {
      return [
        LocaleKeys.analysis_nth.tr,
        addition6,
        LocaleKeys.analysis_a.tr,
        LocaleKeys.list_match_no_start.tr,
      ].join('');
    }
    return eventLang;
  }

  /**
   * 获取篮球消息事件代码文本
   * @param state 状态对象
   * @param item 事件项
   * @return 事件代码文本
   */
  static String getBasketballMessageEventCodeTxt(
      MatchDataState state,
      AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    String code = item.eventCode ?? "";
    String? extraInfo = item.extraInfo;
    String? firstT1 = item.t1;
    String? firstT2 = item.t2;
    String? matchPeriodId = item.matchPeriodId;
    /**
     * addition1 true 表示罚球
     * addition2 第几个罚球命中
     * addition3 几罚几中
     * extraInfo 罚球进了 1，2，3
     */
    String type = state.basket_all_map[code] ?? "";
    if (code == "time_start") {
      return state.basket_all_map[code] ?? "";
    } else if (code == "score_miss") {
      String txt = "";
      txt = extraInfo != null
          ? state.send_ball_extra_info_map[code]![extraInfo] ?? ""
          : "-";
      return "${type}: ${txt}";
    } else if (['score_change', 'score_delete'].contains(code)) {
      String txt = "";
      txt = (extraInfo != null
              ? ((state.send_ball_extra_info_map[code] ?? {})[extraInfo])
              : "${firstT1}:${firstT2}") ??
          "";
      // 加减比分 2分球 3分球 文案
      return "${type}: ${txt}";
    } else if (code == "match_status") {
      return type + ": " + (state.all_match_status_map[matchPeriodId] ?? "");
    } else {
      return type;
    }
  }

  /**
   * 根据路径数组获取值
   * @param obj 对象Map
   * @param pathArray 路径数组
   * @param defaultValue 默认值
   * @return 获取到的值
   */
  static String getByPathArray(
      Map<String, Map<String, String>> obj, List<String> pathArray,
      {String defaultValue = ''}) {
    return pathArray.join('.');
  }
}

