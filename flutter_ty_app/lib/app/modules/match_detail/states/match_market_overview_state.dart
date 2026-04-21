import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_market_overview_models.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/match_detail_tab.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_market_overview/bean/series_bean.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_match_information_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/odd_report_analyze_data_entity.dart';

import '../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘面State
    - 盘面初始化State
    - 盘面足球切换State
    - 一级选项标题  是否展示 showSelect_Option1 = true;
    - 二级选项标题 是否展示 showSelect_Option2 = true;
    - 三级选项标题 是否展示  showSelect_Option3 = false;
    - 一级选项标题 select_Option1 = "";
    - 二级选项标题  select_Option2 = "";
    - 三级选项标题 select_Option3 = "";
    - 标记的值  marketValue = "";
    - 走势、预期分析、赛事文章  tabs = [];
    - 走势图表数据 seriesBeanList = [];
    - 走势请求接口  oddsType
    - 主1   客  2  平  x  currentOddReportAnalyzeDataData;
    - 获取计算弹框位置selectZoushiTitleKey = GlobalKey(); //获取计算弹框位置
    - 获取计算弹框位置selectZoushiTitleKey2 = GlobalKey(); //获取计算弹框位置
    - 获取计算弹框位置selectZoushiTitleKey3 = GlobalKey(); //获取计算弹框位置

    】】】
 *
 */
class MatchMarketOverviewState {


  String current = "";

  // 一级选项标题  是否展示
  bool showSelect_Option1 = true;

  // 二级选项标题 是否展示
  bool showSelect_Option2 = true;

  // 三级选项标题 是否展示
  bool showSelect_Option3 = false;

  // 一级选项标题
  String select_Option1 = "";

  // 二级选项标题
  String select_Option2 = "";

  ChildSelectBean? select_Option2SelectBean;

  // 三级选项标题
  String select_Option3 = "";

  // 标记的值
  String marketValue = "";

  RxInt curMainTab = 0.obs;
  List<AnalyzeMatchInformationEntity> dataList = [];
  Map<String, dynamic> analyzeGetMatchAnalysiseDataItemEntity = {};

  // 走势、预期分析、赛事文章 tab
  List<MatchDetailTab> tabs = [];

  TabController? tabController;

  // 走势图表数据
  List<SeriesBean> seriesBeanList = [];

  Map<String, dynamic>? chartMap;
  List<List<SeriesColorStops>> colorStops = [];
  int playId = 1;

  // 走势请求接口
  /**
   * 主1   客  2  平  x
   */
  String oddsType = "1";
  OddReportAnalyzeDataEntity? currentOddReportAnalyzeDataData;

  List<SelectBean> selectBeans = [];
  int selectOptionIndex1 = 0;
  int selectOptionIndex2 = 0;
  int selectOptionIndex3 = 0;

  // ========== UI常量 ==========
  /// 容器顶部外边距
  static const double pageTopMargin = 12.0;
  
  /// 容器水平外边距
  static const double pageHorizontalMargin = 4.0;
  
  /// 无数据提示顶部间距
  static const double noDataTopSpacing = 100.0;
  
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
  
  /// 分隔线背景色
  static const Color dividerBackgroundColor = Color(0xFFF2F1F6);

  // ========== UI常量（预期分析页面） ==========
  /// 头部渐变颜色1
  static const Color expectedAnalysisHeaderGradientColor1 = Color(0xFF179CFF);
  
  /// 头部渐变颜色2
  static const Color expectedAnalysisHeaderGradientColor2 = Color(0xFFFFFFFF);
  
  /// 头部渐变颜色3
  static const Color expectedAnalysisHeaderGradientColor3 = Color(0xFFB1451A);
  
  /// 头部渐变透明度
  static const double expectedAnalysisHeaderGradientAlpha = 0.1;

  // ========== UI常量（足球走势页面） ==========
  /// 文本颜色（暗色模式）
  static const Color footballTrendTextColorDark = Color(0xFFE5FFFFFF);
  
  /// 文本颜色（亮色模式）
  static const Color footballTrendTextColorLight = Color(0xFF303442);
  
  /// 下拉箭头颜色
  static const Color footballTrendArrowColor = Color(0xFF3AA6FC);
  
  /// 确认按钮文字颜色
  static const Color footballTrendConfirmButtonTextColor = Colors.white;
  
  /// 菜单选中项文字颜色（暗色模式）
  static const Color footballTrendMenuSelectedTextColorDark = Colors.white;
  
  /// 菜单选中项文字颜色（亮色模式）
  static const Color footballTrendMenuSelectedTextColorLight = Colors.black;
  
  /// 菜单未选中项文字颜色（暗色模式）
  static const Color footballTrendMenuUnselectedTextColorDark = Color(0xFFAFB3C8);
  
  /// 菜单未选中项文字颜色（亮色模式）
  static const Color footballTrendMenuUnselectedTextColorLight = Colors.black;
  
  /// 菜单选中图标颜色（暗色模式）
  static const Color footballTrendMenuCheckIconColorDark = Colors.white;
  
  /// 菜单选中图标颜色（亮色模式）
  static const Color footballTrendMenuCheckIconColorLight = Colors.black;

  MatchMarketOverviewState() {
  }


}
