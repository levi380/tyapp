import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_event_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';


import '../../../services/models/res/match_playback_video_info_entity.dart';
import '../constants/all_key_events.dart';
import '../models/analysis/analysis_data_model.dart';
import '../models/match_detail_tab.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球数据State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 数据State控制器
    - 数据State初始化
    - 篮球足球切换变量
    - 进攻 危险进攻 、控球率 圆环数据 ringData = [];
    - 黄牌 红牌 角球集合  second = [];
    - 射正 射偏 three = [];
    - 预期进球、预期失球  four=[]
    】】】
 *
 */
class MatchDataState {
  TabController? tabController;

  // 回放事件 总集合
  List<AnalyzeLiveVideoLiveEventEntityDataEvents> totalEventDataEvents = [];

  TabController? eventTabController;

  int MAX_INT = 5;
  bool noData = true;

  bool isExpandImport = false;

  // ========== UI常量（篮球页面） ==========
  /// 容器底部内边距
  static const double basketballPageBottomPadding = 10.0;
  
  /// 容器水平外边距
  static const double basketballPageHorizontalMargin = 6.0;
  
  /// 容器垂直外边距
  static const double basketballPageVerticalMargin = 8.0;
  
  /// Tab栏水平外边距
  static const double basketballTabHorizontalMargin = 8.0;
  
  /// Tab栏垂直外边距
  static const double basketballTabVerticalMargin = 8.0;
  
  /// Tab指示器高度
  static const double basketballTabIndicatorHeight = 2.0;
  
  /// Tab栏高度
  static const double basketballTabHeight = 28.0;
  
  /// Tab标签水平内边距
  static const double basketballTabLabelPadding = 12.0;
  
  /// Tab标签字体大小
  static const double basketballTabFontSize = 12.0;

  // ========== UI常量（足球页面） ==========
  /// 主队颜色
  static const Color footballManColor = Color(0xFFF53F3F);
  
  /// 客队颜色
  static const Color footballAwayColor = Color(0xFFFEAE2B);
  
  /// 容器顶部外边距
  static const double footballPageTopMargin = 8.0;
  
  /// 容器水平外边距
  static const double footballPageHorizontalMargin = 4.0;
  
  /// 选择按钮最小高度
  static const double footballSelectButtonMinHeight = 55.0;
  
  /// 选择按钮最大高度
  static const double footballSelectButtonMaxHeight = 55.0;
  
  /// 事件列表垂直间距
  static const double footballEventListVerticalSpacing = 60.0;

  // ========== UI常量（颜色） ==========
  /// 事件连接线颜色
  static const Color eventLineColor = Color(0xFF179CFF);
  
  /// 进度条背景颜色（灰色）
  static const Color progressBackgroundColor = Color(0xFFd8d8d8);
  
  /// 主队进度条渐变颜色1
  static const Color progressManGradientColor1 = Color(0xFF58B6FF);
  
  /// 主队进度条渐变颜色2
  static const Color progressManGradientColor2 = Color(0xFF6923FF);
  
  /// 客队进度条渐变颜色1
  static const Color progressAwayGradientColor1 = Color(0xFFFFCC54);
  
  /// 客队进度条渐变颜色2
  static const Color progressAwayGradientColor2 = Color(0xFFFF8A2D);
  
  /// 篮球事件页面背景颜色
  static const Color basketballEventPageBackgroundColor = Color(0xFFE4E6ED);
  
  /// 篮球事件页面文字颜色
  static const Color basketballEventPageTextColor = Color(0xFF616783);
  
  /// 头部渐变颜色1
  static const Color headerGradientColor1 = Color(0xFF179CFF);
  
  /// 头部渐变颜色2
  static const Color headerGradientColor2 = Color(0xFFFFFFFF);
  
  /// 头部渐变颜色3
  static const Color headerGradientColor3 = Color(0xFFB1451A);
  
  /// 头部渐变透明度
  static const double headerGradientAlpha = 0.1;
  
  /// 预测进球标签颜色
  static const Color predictGoalLabelColor = Color(0xFFFEBE55);
  
  // ========== UI常量（字体） ==========
  /// 预测进球标签字体大小（iPad）
  static const double predictGoalLabelFontSizeIPad = 15.0;
  
  /// 预测进球标签字体大小（普通）
  static const double predictGoalLabelFontSize = 12.0;
  
  /// 预测进球标签字体粗细
  static const FontWeight predictGoalLabelFontWeight = FontWeight.w600;
  
  /// 状态文字字体大小
  static const double statusTextFontSize = 12.0;
  /// 事件内容文字字体大小
  static const double eventContentTextFontSize = 12.0;
  
  /// 事件内容标题字体粗细
  static const FontWeight eventContentTitleFontWeight = FontWeight.w600;
  
  /// 分类标签字体大小（iPad）
  static const double categoryTabFontSizeIPad = 14.0;
  
  /// 分类标签字体大小（普通）
  static const double categoryTabFontSize = 10.0;
  
  /// 分类标签字体粗细
  static const FontWeight categoryTabFontWeight = FontWeight.w400;
  
  /// 事件底部文字字体大小
  static const double eventFooterTextFontSize = 12.0;
  
  /// 折线图标题字体大小
  static const double lineChartTitleFontSize = 10.0;
  
  /// 折线图数值字体大小
  static const double lineChartValueFontSize = 12.0;
  
  /// 折线图标题字体粗细
  static const FontWeight lineChartTitleFontWeight = FontWeight.w400;
  
  /// 折线图数值字体粗细
  static const FontWeight lineChartValueFontWeight = FontWeight.w700;
  
  /// 篮球事件页面文字字体大小
  static const double basketballEventPageTextFontSize = 12.0;
  
  /// 篮球数据页面文字字体大小
  static const double basketballDataPageTextFontSize = 12.0;
  
  /// 篮球标签字体粗细
  static const FontWeight basketballTabFontWeight = FontWeight.w500;

  /// 篮球数据页面文字字体大小
  static const double basketballDataTextFontSize = 12.0;
  
  /// 篮球事件页面文字字体大小
  static const double basketballEventTextFontSize = 12.0;

  // 进攻 危险进攻 、控球率 圆环数据
  List<NewAnalyzeMatchResultItem> ringData = [];

  // 黄牌 红牌 角球集合
  List<NewAnalyzeMatchResultItem> second = [];

  // 射正 射偏
  List<NewAnalyzeMatchResultItem> three = [];

  // 预期进球、预期失球
  List<NewAnalyzeMatchResultItem> four = [
    NewAnalyzeMatchResultItem(
        "S801", LocaleKeys.analysis_football_matches_expected_goals_xg.tr, ""),
    NewAnalyzeMatchResultItem(
        "S802", LocaleKeys.analysis_football_matches_expected_goals.tr, "")
  ];

  List<NewAnalyzeMatchResultItem> basketballFreeThrowsList = [
    NewAnalyzeMatchResultItem("S106", "已犯规次数", ""),
    NewAnalyzeMatchResultItem("S109", "已暂停次数", "")
  ];

  List<NewAnalyzeMatchResultItem> basketballFreeThrowsResultList = [];

  AnalyzeNewMatchResultData analyzeMatchResultData =
      AnalyzeNewMatchResultData();
  List<NewAnalyzeMatchResultItem> football_ring_statistics = [];
  List<NewAnalyzeMatchResultItem> football_card_corner_list = [];
  List<NewAnalyzeMatchResultItem> football_progress_graph = [];

  List<NewAnalyzeMatchResultItem> basketball_card_corner_list = [];
  List<NewAnalyzeMatchResultItem> basketball_ring_statistics = [];
  List<NewAnalyzeMatchResultItem> basketball_progress_graph = [];

  List<NewAnalyzeMatchResultItem> ring_statistics = [];
  List<NewAnalyzeMatchResultItem> card_corner_list = [];
  List<NewAnalyzeMatchResultItem> progress_graph = [];

  List<NewAnalyzeMatchResultItem> four_statistics = [];

  // 是否有点球分类
  bool shootout = false;

  // 数据tab
  List<String> currentTitlePage = ["全场", "90分钟", "加时赛"];

  /**
      "全部回放",
      "进球回放",
      "角球回放",
      "罚球回放" tab
   */
  List<String> generalEventList = [];

  // 精彩回放接口总数据
  MatchPlaybackVideoInfoEntity? analyzeBackVideoInfoEntity;

  // 精彩回放集合，由于接口不一致，此时需要转换成事件
  List<MatchPlaybackVideoInfoEntityEventList> playbackVideoEventList = [];

  /**
   *90分钟  120min
   */
  int currentTitlePageIndex = 0;

  /**
   * 当前总事件，切换事件
   */
  int currentGeneralEventIndex = 0;

  List<String> videoHead = [
    LocaleKeys.analysis_all_events.tr,
    LocaleKeys.analysis_key_events.tr
  ];

  // 数据-实时事件
  AnalyzeLiveVideoEventDataVideo? analyzeLiveVideoEventDataVideo;
  List<AnalyzeLiveVideoLiveEventEntityDataEvents>
      analyzeTotalLiveVideoEventDataEvents = [];

  List<AnalyzeLiveVideoLiveEventEntityDataEvents>
      originLiveVideoEventDataEvents = [];

  // 篮球事件集合
  List<AnalyzeLiveVideoLiveEventEntityDataEvents> basketballEventList = [];
  List<AnalyzeLiveVideoLiveEventEntityDataEvents> list_event1 = [];
  List<AnalyzeLiveVideoLiveEventEntityDataEvents> list_event2 = [];
  List<AnalyzeLiveVideoLiveEventEntityDataEvents> list_event3 = [];
  List<AnalyzeLiveVideoLiveEventEntityDataEvents> list_event4 = [];
  List<AnalyzeLiveVideoLiveEventEntityDataEvents> list_event5 = [];

  // tabs 的所有数据
  List<Map> listTabs = [
    {"name": LocaleKeys.analysis_section_1.tr, "id": 1},
    {"name": LocaleKeys.analysis_section_2.tr, "id": 2},
    {"name": LocaleKeys.analysis_first_half.tr, "id": 3},
    {"name": LocaleKeys.analysis_section_3.tr, "id": 4},
    {"name": LocaleKeys.analysis_section_4.tr, "id": 5},
    {"name": LocaleKeys.analysis_second_half.tr, "id": 6},
    {"name": LocaleKeys.analysis_overtime.tr, "id": 7},
  ];

  // 是否显示加时赛 90分钟
  bool showOvertime = false;

  List<AnalyzeLiveVideoLiveEventEntityDataEvents> currentEventDataEvents = [];

  List bottomKeyEvent = [];
  RxInt selectBasketBallIndex = 0.obs;

  // 选择tab
  int videoIndex = 0;

  // 获取[角球、红牌、黄牌]集合
  List<List<NewAnalyzeMatchResultItem>> totalSecondListData = [];

  // [射正,射偏] 主客对百分比 集合
  List<List<NewAnalyzeMatchResultItem>> totalThreeListData = [];

  Color manColor = Color(0xFFF53F3F);
  Color awayColor = Color(0xFFFEAE2B);

  // 篮球赛事tab
  List<MatchDetailTab> basketballTabs = [];

  List allKeyEvents = [];

  Map<String, String> basket_all_map = {
    "match_status": LocaleKeys.analysis_match_status.tr,
    // 赛事阶段
    "time_start": LocaleKeys.analysis_time_start.tr,
    // 开始计时
    // time_start_0: i18n_t("analysisen.time_start"), // 停止计时
    "timeout": LocaleKeys.analysis_timeout.tr,
    // 比赛暂停
    "timeout_over": LocaleKeys.analysis_end_of_pause.tr,
    // 暂停结束
    "delete_event": LocaleKeys.analysis_delete_event.tr,
    // 手动删除事件
    "period_score_change": LocaleKeys.analysis_period_score_change.tr,
    // 跨阶段修改比分®
    "score_correction": LocaleKeys.analysis_score_correction.tr,
    //修正比分
    "won_jump_ball": LocaleKeys.analysis_won_jump_ball.tr,
    // 赢得跳球
    "possession": LocaleKeys.analysis_possession.tr,
    // 控球权
    "score_change": LocaleKeys.analysis_score_change.tr,
    // 比分变更

    "play_canceled": LocaleKeys.analysis_play_canceled.tr,
    // 罚球取消
    "rebound": LocaleKeys.analysis_rebound.tr,
    // 篮板
    "steal": LocaleKeys.analysis_steal.tr,
    // 抢断
    "turnover": LocaleKeys.analysis_turnover.tr,
    // 失误
    "block": LocaleKeys.analysis_block.tr,
    // 盖帽
    "score_miss": LocaleKeys.analysis_score_miss.tr,
    // 未命中
    "foul": LocaleKeys.analysis_foul.tr,
    // 犯规
    "rebound_defense": LocaleKeys.analysis_rebound_defense.tr,
    // 防守篮板
    "rebound_attack": LocaleKeys.analysis_rebound_attack.tr,
    // 进攻篮板
    "score_delete": LocaleKeys.analysis_score_delete.tr,
    // 删除比分
    '2p_miss': LocaleKeys.analysis_score_miss.tr +
        ": " +
        LocaleKeys.analysis_f_2_Point.tr +
        LocaleKeys.analysis_score_miss.tr,
    // 二分球命中
    '3p_miss': LocaleKeys.analysis_score_miss.tr +
        ": " +
        LocaleKeys.analysis_f_3_Point.tr +
        LocaleKeys.analysis_score_miss.tr,
    // 三分球命中
    "free_throw": LocaleKeys.analysis_free_throw.tr,
    // 罚球
    "free_throw_add": LocaleKeys.analysis_free_throw_count.tr + "+1",
    // 罚球
    "free_throw_sub": LocaleKeys.analysis_free_throw_count.tr + "-1",
    // 罚球
    "manual_time_adjust": LocaleKeys.analysis_manual_time_adjust.tr,
    // 抢断
  };

  /** 后端返回对应赛事阶段 */
  Map<String, String> all_match_status_map = {
    "0": LocaleKeys.analysis_w0.tr, // 上半场
    "1": "HT", // 上半场
    "2": "2HT", // 下半场
    "40": "OT", // 加时赛
    "13": "Q1", // 第一节
    "21": "Q1", // 第一节
    "14": "Q2", // 第二节
    "15": "Q3", // 第三节
    "16": "Q4", // 第四节
    "31": "2HT", // 上半场结束
    "32": "OT", // 加时赛未开始
    "80": LocaleKeys.analysis_f_t37.tr, // 比赛中断
    "100": LocaleKeys.analysis_matchPeriodId1_100.tr, // 常规时间比赛结束
    "301": LocaleKeys.analysis_matchPeriodId2_301.tr, // 第一节休息
    "302": LocaleKeys.analysis_matchPeriodId2_302.tr, // 第二节休息
    "303": LocaleKeys.analysis_matchPeriodId2_303.tr, // 第三节休息
    "110": "OT", // 加时赛结束
    "999": "Ended", // 比赛结束
    // ...match_status_map
  };

  Map<String, Map<String, String>> send_ball_extra_info_map = {
    "score_change": {
      "1": LocaleKeys.analysis_free_throw.tr + LocaleKeys.analysis_f_Hit.tr,
      // 罚球命中
      "2": LocaleKeys.analysis_f_2_Point.tr + LocaleKeys.analysis_f_Hit.tr,
      // 二分球命中
      "3": LocaleKeys.analysis_f_3_Point.tr + LocaleKeys.analysis_f_Hit.tr,
      // 三分球命中
    },
    "score_delete": {
      "1": LocaleKeys.analysis_free_throw.tr + LocaleKeys.analysis_f_Hit.tr,
      // 罚球命中
      "2": LocaleKeys.analysis_f_2_Point.tr + LocaleKeys.analysis_f_Hit.tr,
      // 二分球命中
      "3": LocaleKeys.analysis_f_3_Point.tr + LocaleKeys.analysis_f_Hit.tr,
      // 三分球命中
    },
    "score_miss": {
      "1": LocaleKeys.analysis_free_throw.tr + LocaleKeys.analysis_f_Miss.tr,
      // 罚球未命中
      "2": LocaleKeys.analysis_f_2_Point.tr + LocaleKeys.analysis_f_Miss.tr,
      // 二分球未命中
      "3": LocaleKeys.analysis_f_3_Point.tr + LocaleKeys.analysis_f_Miss.tr,
      // 三分球未命中
    },
  };

  MatchDataState() {
    allKeyEvents = generateKeyEvents();
  }
}
