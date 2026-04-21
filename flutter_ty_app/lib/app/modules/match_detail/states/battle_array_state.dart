import 'package:flutter_ty_app/app/services/models/res/analyze_array_person_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../../login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 统计】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球统计状态State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球统计状态State
    - 当前一级标签页  curMainTab
    - 第一页数据
    - 第二页数据
    - 主队 从对文字tab
    】】】
 *
 */
class BattleArrayState{
  /// 当前一级标签页
  int curMainTab = 0;
  // 第一页数据
  AnalyzeArrayPersonEntity? analyzeArrayPersonEntity;
  // 第二页数据
  AnalyzeArrayPersonEntity? analyzeArrayPersonEntity2;
  // 主队 从对文字tab
  List<String> teamsNames = [
    LocaleKeys.app_h5_handicap_tutorial_home_team.tr,
    LocaleKeys.app_h5_handicap_tutorial_away_team.tr
  ];
  // 是否展开
  bool expand = false;
  // 矩形集合
  Map<int, Rect> map = {};
  // 主队数据列表
  AnalyzeArrayPersonEntity? line_up_data_home;
  // 从队数据列表
  AnalyzeArrayPersonEntity? line_up_data_away;
  List<Up>? basketball_data;
  int number = 0;
  List<List<Up>> football_filtered_data_home = [];
  List<List<Up>> football_filtered_data_away = [];

  TabController? tabController;

  double bgImgWidth = 1.sw * 0.93;
  double bgImgHeight = 1.sw * 0.96;

  // ========== UI常量（足球阵容页面） ==========
  /// Tab栏下方间距
  static const double footballTabBottomSpacing = 12.0;
  
  /// Tab栏宽度比例
  static const double footballTabWidthRatio = 0.93;
  
  /// Tab栏高度
  static const double footballTabHeight = 26.0;
  
  /// 列表项头部高度
  static const double footballListItemHeadHeight = 40.0;
  
  /// 列表项头部左侧间距
  static const double footballListItemHeadLeftSpacing = 8.0;
  
  /// 列表项头部字体大小（iPad）
  static const double footballListItemHeadFontSizeIPad = 18.0;
  
  /// 列表项头部字体大小（普通）
  static const double footballListItemHeadFontSize = 14.0;
  
  /// 替补阵容网格水平内边距
  static const double footballSubstituteGridHorizontalPadding = 8.0;
  
  /// 替补阵容网格底部内边距
  static const double footballSubstituteGridBottomPadding = 30.0;
  
  /// 网格列数
  static const int footballGridCrossAxisCount = 3;
  
  /// 网格主轴间距
  static const double footballGridMainAxisSpacing = 8.0;
  
  /// 网格交叉轴间距
  static const double footballGridCrossAxisSpacing = 8.0;
  
  /// 网格子项宽高比（宽度/高度）
  static const double footballGridChildAspectRatio = 116.0 / 106.0;
  
  /// 首发阵容网格水平内边距
  static const double footballStartingGridHorizontalPadding = 8.0;

  // ========== UI常量（篮球阵容页面） ==========
  /// Tab栏下方间距
  static const double basketballTabBottomSpacing = 12.0;
  
  /// Tab栏宽度比例
  static const double basketballTabWidthRatio = 0.93;
  
  /// Tab栏高度
  static const double basketballTabHeight = 26.0;
  
  /// 底部间距
  static const double basketballBottomSpacing = 40.0;
}