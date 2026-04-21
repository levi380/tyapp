import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/front_fight_p_b_bean_entity_electronic_football_entity.dart';

import '../../../services/models/res/statistics_front_fight_entity.dart';
import '../../../services/models/res/statistics_technical_entity.dart';
import '../models/analysis/analysis_model.dart';
import '../models/match_detail_tab.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 统计】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球统计State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘面State
    】】】
 *
 */
class MatchStatisticMatchHistoryState {


  TabController? tabController;
  bool expand1 = false;

  bool isTopDataEmpty = true;


  GlobalKey toastItemKey = GlobalKey(); //获取计算弹框位置


  List<LineColorBean> lineColorBeans = [
    LineColorBean(63),
    LineColorBean(7),
    LineColorBean(30)
  ];

  bool expand = false;
  List<List<AnalyzeTeamVsHistoryEntity>> pageList = [];
  List<FrontFightPBBeanEntityElectronicFootballEntity>
      electronicFootballPBBeanList = [];
  List<StatisticsTechnicalEntity> technicalPBBeanEntitys = [];
  List<TechnicalPBUIBean> technicalPBUIBeans = [];

  List<GridColorBean> gridColorBeans = [
    GridColorBean("67%", LocaleKeys.analysis_football_matches_over_1_5.tr,
        "2/3赛事", [Color(0xFF4CD238), Color(0xFF4CD238)],
        name4: LocaleKeys.analysis_football_matches_contentTitle1.tr),
    GridColorBean("67%", LocaleKeys.analysis_football_matches_over_2_5.tr,
        "2/3赛事", [Color(0xFFD45FFF), Color(0xFFD45FFF)],
        name4: LocaleKeys.analysis_football_matches_contentTitle2.tr),
    GridColorBean("67%", LocaleKeys.analysis_football_matches_over_3_5.tr,
        "2/3赛事", [Color(0xFFFF7F47), Color(0xFFFF7F47)],
        name4: LocaleKeys.analysis_football_matches_contentTitle3.tr),
    GridColorBean(
        "67%",
        LocaleKeys.analysis_k_all_scores.tr,
        "2/3赛事",
        [Color(0xFFFF5F8C), Color(0xFFFF5F8C)],
        name4: LocaleKeys.analysis_k_all_scores_ab.tr),

    GridColorBean(
        "67%",
        "${LocaleKeys.analysis_k_not_lost.tr}(${LocaleKeys.ouzhou_bet_col_bet_col_4_bet_col_1.tr})",
        "阿斯顿维拉",
        [Color(0xFF179CFF), Color(0xFF179CFF)],
        name4: LocaleKeys.analysis_football_matches_contentTitle6.tr),
    GridColorBean(
        "67%",
        "${LocaleKeys.analysis_k_not_lost.tr}(${LocaleKeys.app_h5_handicap_tutorial_away_team.tr})",

        "阿森纳",
        [Color(0xFFFFC32F), Color(0xFFFFC32F)],
        name4: LocaleKeys.analysis_football_matches_contentTitle6.tr),
  ];

  // tab
  List<MatchDetailTab> tabs = [];

  List<AnalyzeTeamVsHistoryEntity> analyzeTeamsList = [];

  StatisticsFrontFightEntity? page1FrontFightPBBeanEntity;
  FrontFightPBBeanEntityElectronicFootballEntity?
      page1FrontFightPBBeanEntityElectronicFootballEntity;

  // ========== UI常量 ==========
  /// 容器顶部外边距
  static const double pageTopMargin = 2.0;
  
  /// 容器水平外边距
  static const double pageHorizontalMargin = 4.0;
  
  /// Tab栏水平外边距
  static const double tabHorizontalMargin = 8.0;
  
  /// Tab栏垂直外边距
  static const double tabVerticalMargin = 8.0;
  
  /// Tab指示器高度
  static const double tabIndicatorHeight = 2.0;
  
  /// Tab栏高度
  static const double tabHeight = 28.0;
  
  /// Tab标签水平内边距
  static const double tabLabelPadding = 12.0;
  
  /// Tab标签字体大小
  static const double tabFontSize = 12.0;

  // ========== UI常量（正面交手页面） ==========
  /// 主队颜色
  static const Color headOnConfrontationManColor = Color(0xFFF53F3F);
  
  /// 客队颜色
  static const Color headOnConfrontationAwayColor = Color(0xFFFEAE2B);
  
  /// 以往数据标题顶部外边距
  static const double headOnConfrontationPastDataTopMargin = 12.0;
  
  /// 以往数据标题字体大小
  static const double headOnConfrontationPastDataFontSize = 14.0;
  
  /// 以往数据标题下方间距
  static const double headOnConfrontationPastDataBottomSpacing = 16.0;
  
  /// 底部间距
  static const double headOnConfrontationBottomSpacing = 20.0;
  
  /// 展开收起按钮水平内边距
  static const double headOnConfrontationExpandButtonHorizontalPadding = 4.0;
  
  /// 展开收起按钮垂直内边距
  static const double headOnConfrontationExpandButtonVerticalPadding = 2.0;
  
  /// 展开收起按钮间距
  static const double headOnConfrontationExpandButtonSpacing = 2.0;
  
  /// 展开收起按钮字体大小（iPad）
  static const double headOnConfrontationExpandButtonFontSizeIPad = 16.0;
  
  /// 展开收起按钮字体大小（普通）
  static const double headOnConfrontationExpandButtonFontSize = 12.0;
  
  /// 展开收起按钮图标大小
  static const double headOnConfrontationExpandButtonIconSize = 12.0;
  
  /// 列表项容器高度
  static const double headOnConfrontationItemHeight = 48.0;
  
  /// 列表项容器水平内边距
  static const double headOnConfrontationItemHorizontalPadding = 8.0;
  
  /// 列表项字体大小（iPad）
  static const double headOnConfrontationItemFontSizeIPad = 15.0;
  
  /// 列表项字体大小（普通）
  static const double headOnConfrontationItemFontSize = 12.0;
  
  /// 列表项比分字体大小（iPad）
  static const double headOnConfrontationItemScoreFontSizeIPad = 15.0;
  
  /// 列表项比分字体大小（普通）
  static const double headOnConfrontationItemScoreFontSize = 11.0;
  
  /// 列表项比分颜色
  static const Color headOnConfrontationItemScoreColor = Color(0xFF4176FA);
  
  /// 列表项暗色模式背景色
  static const Color headOnConfrontationItemBackgroundColorDark = Color(0xFF272932);
  
  /// 列表项亮色模式背景色
  static const Color headOnConfrontationItemBackgroundColorLight = Colors.white;
  
  /// 列表项队伍名称宽度
  static const double headOnConfrontationItemTeamNameWidth = 60.0;
  
  /// 列表项图标间距
  static const double headOnConfrontationItemIconSpacing = 6.0;
  
  /// 列表项图标大小
  static const double headOnConfrontationItemIconSize = 24.0;
  
  /// 列表头部水平内边距
  static const double headOnConfrontationHeaderHorizontalPadding = 8.0;
  
  /// 列表头部垂直内边距
  static const double headOnConfrontationHeaderVerticalPadding = 4.0;
  
  /// 列表头部字体大小（iPad）
  static const double headOnConfrontationHeaderFontSizeIPad = 15.0;
  
  /// 列表头部字体大小（普通）
  static const double headOnConfrontationHeaderFontSize = 12.0;
  
  /// 列表头部间距
  static const double headOnConfrontationHeaderSpacing = 28.0;
  
  /// 最大显示数量
  static const int headOnConfrontationMaxDisplayCount = 5;

  // ========== UI常量（历史表现页面） ==========
  /// 历史表现页面顶部间距
  static const double historyPerformanceTopSpacing = 8.0;

  // ========== UI常量（颜色 - 统计组件） ==========
  /// 边框颜色
  static const Color borderColor = Color(0xFFE4E6ED);
  
  /// 选中标签背景颜色
  static const Color selectedTabBackgroundColor = Color(0xFFE8F5FF);
  
  /// 主色调（蓝色）
  static const Color primaryColor = Color(0xFF179CFF);
  
  /// 未选中文字颜色
  static const Color unselectedTextColor = Color(0xFFAFB3C8);
  
  /// 比分颜色
  static const Color scoreColor = Color(0xFF4176FA);
  
  /// 图表渐变颜色1（紫色系）
  static const Color chartGradientColor1Start = Color(0xFFD666FF);
  static const Color chartGradientColor1End = Color(0xFF9760F0);
  
  /// 图表渐变颜色2（蓝色系）
  static const Color chartGradientColor2Start = Color(0xFF179AFF);
  static const Color chartGradientColor2End = Color(0xFF4557FF);
  
  /// 图表渐变颜色3（橙色系）
  static const Color chartGradientColor3Start = Color(0xFFFFCD54);
  static const Color chartGradientColor3End = Color(0xFFFF842A);
  
  /// 头部渐变颜色1
  static const Color headerGradientColor1 = Color(0xFF179CFF);
  
  /// 头部渐变颜色2
  static const Color headerGradientColor2 = Color(0xFFFFFFFF);
  
  /// 头部渐变颜色3
  static const Color headerGradientColor3 = Color(0xFFB1451A);
  
  /// 头部渐变透明度
  static const double headerGradientAlpha = 0.1;
  
  /// 技术统计文字颜色
  static const Color technicalStatisticsTextColor = Color(0xFF616783);
  
  /// 技术统计标记颜色
  static const Color technicalStatisticsMarkerColor = Color(0xFFFEAE2C);
  
  /// 历史表现头部渐变颜色1开始（蓝色，带透明度）
  static const Color historyPerformanceHeaderGradient1Start = Color(0x19179AFF);
  
  /// 历史表现头部渐变颜色1结束（蓝色，透明）
  static const Color historyPerformanceHeaderGradient1End = Color(0x00179AFF);
  
  /// 历史表现头部渐变颜色2开始（橙色，带透明度）
  static const Color historyPerformanceHeaderGradient2Start = Color(0x19B1451A);
  
  /// 历史表现头部渐变颜色2结束（橙色，透明）
  static const Color historyPerformanceHeaderGradient2End = Color(0x00B1451A);
  
  /// 比赛结果颜色 - 胜（绿色）
  static const Color matchResultWinColor = Color(0xFF00B42A);
  
  /// 比赛结果颜色 - 平（橙色）
  static const Color matchResultDrawColor = Color(0xFFF29041);
  
  /// 比赛结果颜色 - 负（红色）
  static const Color matchResultLossColor = Color(0xFFF53F3F);
  
  /// 圆形进度条默认进度颜色
  static const Color circleProgressDefaultProgressColor = Color(0xFFF53F3F);
  
  /// 圆形进度条背景渐变颜色
  static const Color circleProgressBackgroundGradientColor = Color(0xFFF2F2F6);
  
  /// 边框颜色（通用）
  static const Color commonBorderColor = Color(0xFFE4E6ED);
  
  /// 背景灰色（通用）
  static const Color commonBackgroundGrayColor = Color(0xFFF2F2F6);
  
  /// 阵容位置项颜色类型0（灰色）
  static const Color battlePositionColorType0 = Color(0xFF7981A4);
  
  /// 阵容位置项颜色类型1（蓝色）
  static const Color battlePositionColorType1 = Color(0xFF33A7FF);
  
  /// 阵容位置项颜色类型2（黄色）
  static const Color battlePositionColorType2 = Color(0xFFFFF733);
  
  /// 阵容位置项颜色类型3（红色）
  static const Color battlePositionColorType3 = Color(0xFFF53F3F);
  
  /// 阵容位置项文字颜色类型2（灰色）
  static const Color battlePositionTextColorType2 = Color(0xFF7981A4);
  
  /// 阵容子项文字颜色（橙色）
  static const Color battleArrayChildItemTextColor = Color(0xFFF29041);
  
  // ========== UI常量（字体） ==========
  /// 篮球阵容球员项字体大小
  static const double basketBallBattleArrayPlayerItemFontSize = 12.0;
  
  /// 篮球历史交战列表头部字体大小（iPad）
  static const double basketBallHistoryWarListHeadFontSizeIPad = 15.0;
  
  /// 篮球历史交战列表头部字体大小（普通）
  static const double basketBallHistoryWarListHeadFontSize = 11.0;
  
  /// 篮球近期战绩头部标题字体大小
  static const double basketBallRecentWarHeaderTitleFontSize = 14.0;
  
  /// 篮球近期战绩头部标题字体粗细
  static const FontWeight basketBallRecentWarHeaderTitleFontWeight = FontWeight.w600;
  
  /// 图表头部字体大小（iPad）
  static const double chartHeadFontSizeIPad = 15.0;
  
  /// 图表头部字体大小（普通）
  static const double chartHeadFontSize = 11.0;
  
  /// 图表项字体大小（iPad）
  static const double chartItemFontSizeIPad = 15.0;
  
  /// 图表项字体大小（普通）
  static const double chartItemFontSize = 11.0;

  MatchStatisticMatchHistoryState() {
    ///Initialize variables
  }
}
