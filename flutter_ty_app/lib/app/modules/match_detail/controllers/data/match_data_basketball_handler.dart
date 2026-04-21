import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/analysis/analysis_data_model.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../match_data_controller.dart';
import 'services/match_data_processor_service.dart';
import 'services/match_data_basketball_event_service.dart';

/**
 * 篮球处理模块
 * 负责篮球赛事相关的数据处理和消息转换
 */
extension MatchDataBasketballHandler on MatchDataController {
  /**
   * 获取篮球比赛数据
   * 包括三分球、罚球、投篮等统计数据
   * @param match 赛事实体
   * @return 分析结果项列表
   */
  List<NewAnalyzeMatchResultItem> getBasketBallMatch(MatchEntity? match) {
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemList = [];

    // 三分球
    newAnalyzeMatchResultItemList.add(NewAnalyzeMatchResultItem(
        "S108", LocaleKeys.match_result_Three_pointer.tr, ""));
    // 罚球数
    newAnalyzeMatchResultItemList.add(NewAnalyzeMatchResultItem(
        "S110", LocaleKeys.match_result_Free_throw.tr, ""));

    List<NewAnalyzeMatchResultItem> list = [];

    NewAnalyzeMatchResultItem? s1082Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S1082", match);
    NewAnalyzeMatchResultItem? s108Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S108", match);
    NewAnalyzeMatchResultItem? s107Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S107", match);
    NewAnalyzeMatchResultItem? s1072Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S1072", match);
    NewAnalyzeMatchResultItem? s190Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S190", match);
    NewAnalyzeMatchResultItem? s110Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S110", match);
    NewAnalyzeMatchResultItem? s1235Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S1235", match);
    NewAnalyzeMatchResultItem? s1088Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S1088", match);
    NewAnalyzeMatchResultItem? s111Item =
        MatchDataProcessorService.findNewResultItemByScoreType("S111", match);

    // 投篮数据：S107表示两分球命中，S1072表示两分球总数
    NewAnalyzeMatchResultItem news107 =
        NewAnalyzeMatchResultItem("S107", "投篮", "");
    if (s107Item != null && s1072Item != null) {
      news107.home = s107Item.home;
      news107.away = s107Item.away;
      // 设置投篮命中数/总投篮数的显示文本
      news107.homeAlias =
          "${(s107Item.home + (s108Item?.home ?? 0)).toInt()}/${(s1072Item.home + (s1082Item?.home ?? 0)).toInt()}";
      news107.awayAlias =
          "${(s107Item.away + (s108Item?.away ?? 0)).toInt()}/${(s1072Item.away + (s1082Item?.away ?? 0)).toInt()}";

      // 计算投篮命中率（命中数/总投篮数）
      news107.homeAliasValue =
          ((s107Item.home + (s108Item?.home ?? 0)) / s1072Item.home +
              (s1082Item?.home ?? 0));
      news107.awayAliasValue =
          ((s107Item.away + (s108Item?.away ?? 0)) / s1072Item.away +
              (s1082Item?.away ?? 0));
    }
    // 投篮
    list.add(news107);

    // 投篮命中率：S1235表示投篮命中率百分比
    NewAnalyzeMatchResultItem news1235 = NewAnalyzeMatchResultItem(
        "S1235", LocaleKeys.match_result_Field_goal_percentage.tr, "");
    if (s1072Item != null) {
      news1235.homeAlias = "${s1235Item?.home ?? 0}%";
      news1235.awayAlias = "${s1235Item?.away ?? 0}%";
      news1235.homeAliasValue = s1235Item?.home.toDouble() ?? 0;
      news1235.awayAliasValue = s1235Item?.away.toDouble() ?? 0;
    }
    // 投篮命中率
    list.add(news1235);

    // 三分球命中：S108表示三分球命中数，S1082表示三分球总数
    NewAnalyzeMatchResultItem news108 = NewAnalyzeMatchResultItem(
        "S108", LocaleKeys.match_result_three_point_shooting.tr, "");
    if (s1082Item != null && s108Item != null) {
      news108.home = s108Item.home;
      news108.away = s108Item.away;
      news108.homeAlias = "${s108Item.home.toInt()}/${s1082Item.home.toInt()}";
      news108.awayAlias = "${s108Item.away.toInt()}/${s1082Item.away.toInt()}";
      news108.homeAliasValue =
          (s108Item.home / (s1082Item.home == 0 ? 1 : s1082Item.home));
      news108.awayAliasValue =
          (s108Item.away / (s1082Item.away == 0 ? 1 : s1082Item.away));
    }
    // 三分球命中
    list.add(news108);

    // 三分球命中率：S1088表示三分球命中率百分比
    NewAnalyzeMatchResultItem news1088 = NewAnalyzeMatchResultItem(
        "S1088", LocaleKeys.match_result_three_point_shooting.tr, "");
    if (s1072Item != null) {
      news1088.homeAlias = "${s1088Item?.home}%";
      news1088.awayAlias = "${s1088Item?.away}%";
      news1088.homeAliasValue = s1088Item?.home.toDouble() ?? 0;
      news1088.awayAliasValue = s1088Item?.away.toDouble() ?? 0;
    }
    // 三分球命中率
    list.add(news1088);

    // 罚球命中：S190表示罚球总数，S110表示罚球命中数
    NewAnalyzeMatchResultItem news190 = NewAnalyzeMatchResultItem(
        "S190", LocaleKeys.match_result_Free_throw_percentage.tr, "");
    if (s190Item != null && s110Item != null) {
      news190.home = s190Item.home;
      news190.away = s190Item.away;
      // 设置罚球命中数/总罚球数的显示文本
      news190.homeAlias = "${s110Item.home.toInt()}/${s190Item.home.toInt()}";
      news190.awayAlias = "${s110Item.away.toInt()}/${s190Item.away.toInt()}";
      // 计算罚球命中率（命中数/总罚球数）
      news190.homeAliasValue = ((s110Item.home) / s190Item.home);
      news190.awayAliasValue = ((s110Item.away) / s190Item.away);
    }
    // 罚球命中
    list.add(news190);

    // 罚球命中率：S111表示罚球命中率百分比
    NewAnalyzeMatchResultItem news111 = NewAnalyzeMatchResultItem(
        "S111", LocaleKeys.match_result_Free_throw_percentage.tr, "");
    if (s111Item != null) {
      news111.homeAlias = "${s111Item.home}%";
      news111.awayAlias = "${s111Item.away}%";
      news111.homeAliasValue = s111Item.home.toDouble();
      news111.awayAliasValue = s111Item.away.toDouble();
    }
    // 投篮命中率
    list.add(news111);
    return list;
  }

  /**
   * 篮球事件转换为消息
   * @param item 事件项
   * @param defaultValue 默认值
   * @return 转换后的消息字符串
   */
  String? basketball_event_to_msg(
      AnalyzeLiveVideoLiveEventEntityDataEvents? item,
      {String defaultValue = ''}) {
    return MatchDataBasketballEventService.basketballEventToMsg(
        state, item, defaultValue: defaultValue);
  }

  /**
   * 未命中事件转换为消息
   * @param eventLang 事件语言
   * @param item 事件项
   * @return 转换后的消息字符串
   */
  String? score_miss_to_msg(
      String? eventLang, AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    return MatchDataBasketballEventService.scoreMissToMsg(state, eventLang, item);
  }

  /**
   * 比分变更或删除事件转换为消息
   * @param eventLang 事件语言
   * @param item 事件项
   * @return 转换后的消息字符串
   */
  String score_change_or_score_delete_to_msg(
      String? eventLang, AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    return MatchDataBasketballEventService.scoreChangeOrScoreDeleteToMsg(
        state, eventLang, item);
  }

  /**
   * 开始计时事件转换为消息
   * @param eventLang 事件语言
   * @param item 事件项
   * @return 转换后的消息字符串
   */
  String? time_start_to_msg(
      String? eventLang, AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    return MatchDataBasketballEventService.timeStartToMsg(state, eventLang, item);
  }

  /**
   * 获取篮球消息事件代码文本
   * @param item 事件项
   * @return 事件代码文本
   */
  String get_basketball_message_event_code_txt(
      AnalyzeLiveVideoLiveEventEntityDataEvents item) {
    return MatchDataBasketballEventService.getBasketballMessageEventCodeTxt(
        state, item);
  }

  /**
   * 在列表中查找指定ID的Map
   * @param list Map列表
   * @param id 要查找的ID
   * @return 找到的Map，如果未找到返回null
   */
  Map? findIndex(List<Map> list, int id) {
    Map? result;
    for (int i = 0; i < list.length; i++) {
      Map item = list[i];
      if (item["id"] == id) {
        result = item;
        break;
      }
    }
    return result;
  }

  /**
   * tabs 切换以后数据赋值
   * 根据tab ID切换篮球事件列表
   * @param val tab配置Map
   */
  changeTemplate(Map val) {
    state.basketballEventList = [];
    if (val["id"] == 1) {
      state.basketballEventList = state.list_event1;
    }
    if (val["id"] == 2) {
      state.basketballEventList = state.list_event2;
    }
    if (val["id"] == 3) {
      state.basketballEventList.addAll(state.list_event1);
      state.basketballEventList.addAll(state.list_event2);
    }
    if (val["id"] == 4) {
      state.basketballEventList = state.list_event3;
    }
    if (val["id"] == 5) {
      state.basketballEventList = state.list_event4;
    }
    if (val["id"] == 6) {
      state.basketballEventList.addAll(state.list_event3);
      state.basketballEventList.addAll(state.list_event4);
    }
    if (val["id"] == 7) {
      state.basketballEventList = state.list_event5;
    }
    state.basketballEventList.sort((a, b) {
      int aTime = int.tryParse(a.eventTime ?? "0") ?? 0;
      int bTime = int.tryParse(b.eventTime ?? "0") ?? 0;
      return bTime - aTime;
    });
  }
}

