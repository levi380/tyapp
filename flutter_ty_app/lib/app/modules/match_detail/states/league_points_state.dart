import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analyze_vs_info_entity.dart';

import '../../vr/vr_sport_detail/import_head.dart';
import '../models/request_status.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛积分状态State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛积分状态State
    - 横向滚动组件 horizontalListKey
    - 联赛切换索引 selectPageIndex = 0;
    - 当前联赛 切换页面集合  currentCupBasketBallEventDataEvents = [];
    - 当前联赛 切换页面索引 currentCupBasketBallEventPageIndex = 0;
    】】】
 *
 */
class LeaguePointsState {


  // 原始数据
  List<MatchAnalyzeVsInfoEntity> dataList = [];
  int MAX_LENGTH = 2;
  Map<String, Map> union = {};

  bool expand = false;
  RequestStatus requestStatus = RequestStatus.loading;

  // 横向滚动组件 key
  final GlobalKey horizontalListKey = GlobalKey();

  // 联赛切换索引
  int selectPageIndex = 0;

  ScrollController scrollController = ScrollController();

  // 当前联赛 切换页面集合
  List<AnalyzeVsInfoNewInfoEntity> currentCupBasketBallEventDataEvents = [];


  // 原始数据
  List<MatchAnalyzeVsInfoEntity> version3MatchAnalyzeVsInfoDataList = [];

  // 当前联赛 切换页面索引
  int currentCupBasketBallEventPageIndex = 0;
  // 存在两种数据结构
  LeaguePointVersion version= LeaguePointVersion.version2;
  List<Color> colors = [
    Color(0xFF4176FA),
    Color(0xFFFEAE2C),
    Color(0xFF00B42A),
    Color(0xFF7DA1FC),
    Color(0xFFFDB1B1)
  ];

  // ========== UI常量 ==========
  /// 无数据提示顶部间距
  static const double noDataTopSpacing = 100.0;
  
  /// 容器水平外边距
  static const double pageHorizontalMargin = 6.0;
  
  /// 容器垂直外边距
  static const double pageVerticalMargin = 4.0;
  
  /// 容器水平内边距
  static const double pageHorizontalPadding = 4.0;

  // ========== UI常量（篮球页面） ==========
  /// 容器顶部外边距
  static const double basketballPageTopMargin = 6.0;
  
  /// 容器圆角半径
  static const double basketballPageBorderRadius = 8.0;
  
  /// 容器垂直内边距
  static const double basketballPageVerticalPadding = 8.0;
  
  /// 头部容器高度
  static const double basketballHeaderHeight = 44.0;
  
  /// 头部容器水平内边距
  static const double basketballHeaderHorizontalPadding = 12.0;
  
  /// 头部容器圆角半径
  static const double basketballHeaderBorderRadius = 10.0;
  
  /// 头部渐变颜色1
  static const Color basketballHeaderGradientColor1 = Color(0xFF179CFF);
  
  /// 头部渐变颜色2
  static const Color basketballHeaderGradientColor2 = Color(0xFFFFFFFF);
  
  /// 头部渐变颜色3
  static const Color basketballHeaderGradientColor3 = Color(0xFFB1451A);
  
  /// 头部渐变透明度
  static const double basketballHeaderGradientAlpha = 0.1;
  
  /// 表格头部高度
  static const double basketballTableHeaderHeight = 40.0;
  
  /// 表格头部水平内边距
  static const double basketballTableHeaderHorizontalPadding = 4.0;
  
  /// 表格行高度
  static const double basketballTableRowHeight = 40.0;
  
  /// 表格行标记宽度
  static const double basketballTableRowMarkerWidth = 2.0;
  
  /// 表格行标记高度
  static const double basketballTableRowMarkerHeight = 43.5;
  
  /// 底部展开收起按钮高度
  static const double basketballFooterButtonHeight = 28.0;
  
  /// 底部展开收起按钮圆角半径
  static const double basketballFooterButtonBorderRadius = 23.0;
  
  /// 底部展开收起按钮水平内边距
  static const double basketballFooterButtonHorizontalPadding = 4.0;
  
  /// 底部展开收起按钮水平外边距比例
  static const double basketballFooterButtonHorizontalMarginRatio = 0.3;
  
  /// 底部展开收起按钮图标大小
  static const double basketballFooterButtonIconSize = 20.0;
  
  /// 底部展开收起按钮字体大小（iPad）
  static const double basketballFooterButtonFontSizeIPad = 16.0;
  
  /// 底部展开收起按钮字体大小（普通）
  static const double basketballFooterButtonFontSize = 12.0;
  
  /// 底部展开收起按钮底部间距
  static const double basketballFooterButtonBottomSpacing = 20.0;
  
  /// 底部展开收起按钮顶部间距
  static const double basketballFooterButtonTopSpacing = 8.0;
  
  /// 底部展开收起按钮底部外边距
  static const double basketballFooterButtonBottomMargin = 12.0;
  
  /// 底部图例间距
  static const double basketballFooterLegendSpacing = 4.0;
  
  /// 底部图例图标大小
  static const double basketballFooterLegendIconSize = 8.0;
  
  /// 底部图例图标间距
  static const double basketballFooterLegendIconSpacing = 4.0;
  
  /// 底部图例字体大小
  static const double basketballFooterLegendFontSize = 12.0;
  
  /// 阴影模糊半径
  static const double basketballShadowBlurRadius = 8.0;
  
  /// 阴影偏移Y
  static const double basketballShadowOffsetY = 4.0;
  
  /// 阴影透明度
  static const double basketballShadowOpacity = 0.04;
  
  /// 主队背景色（暗色模式）
  static const Color basketballTeam1BackgroundColorDark = Color(0xFF24374A);
  
  /// 客队背景色（暗色模式）
  static const Color basketballTeam2BackgroundColorDark = Color(0xFF41392A);
  
  /// 主队背景色（亮色模式）
  static const Color basketballTeam1BackgroundColorLight = Color(0xFFD1ECFF);
  
  /// 客队背景色（亮色模式）
  static const Color basketballTeam2BackgroundColorLight = Color(0xFFFEEECC);
}
enum LeaguePointVersion{
  version3,
  version2,
}