import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/knockout_info_bean_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../login/login_head_import.dart';
import '../models/analysis/knockout_info_model.dart';
import '../models/match_detail_tab.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分状态State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 杯赛积分状态State
    - 杯赛原始数据
    - Map tabList 1-32强/ 2-16强/ 3-8强/ 4-半决赛/ 5-决赛
    - 所有常量、文案、UI状态统一在State中管理

    】】】
 *
 */
class MatchCupPointState {
  // ========== UI状态 ==========
  TabController? tabController;
  bool isExpandImport = false;
  bool expand = false;
  int currentIndex = 0;
  int currentCupBasketBallEventPageIndex = 0;

  // ========== 常量 ==========
  /// 最大显示长度
  static const int MAX_LENGTH = 4;

  // ========== UI常量 ==========
  /// 容器顶部外边距
  static const double pageTopMargin = 12.0;

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

  // ========== UI常量（颜色） ==========
  /// 主队背景色（暗色模式）
  static const Color team1BackgroundColorDark = Color(0xFF24374A);

  /// 客队背景色（暗色模式）
  static const Color team2BackgroundColorDark = Color(0xFF41392A);

  /// 主队背景色（亮色模式）
  static const Color team1BackgroundColorLight = Color(0xFFD1ECFF);

  /// 客队背景色（亮色模式）
  static const Color team2BackgroundColorLight = Color(0xFFFEEECC);

  /// 进球数背景色
  static const Color goalsForBackgroundColor = Color(0xFF00B42A);

  /// 失球数背景色
  static const Color goalsAgainstBackgroundColor = Color(0xFFF53F3F);

  /// 进球数/失球数文字颜色
  static const Color goalsTextColor = Colors.white;

  /// 淘汰赛背景颜色
  static const Color knockoutBackgroundColor = Color(0xFFF3FAFF);

  /// 选中项边框和背景颜色
  static const Color selectedItemColor = Color(0xFF4176FA);
  
  // ========== UI常量（字体） ==========
  /// 淘汰赛选择项字体大小（iPad）
  static const double eliminateSelectItemFontSizeIPad = 14.0;
  
  /// 淘汰赛选择项字体大小（普通）
  static const double eliminateSelectItemFontSize = 10.0;
  
  /// 篮球联赛积分标签字体大小
  static const double basketballLeaguePointsLabelFontSize = 12.0;

  // ========== UI常量（字体） ==========
  /// 进球数/失球数文字字体大小（iPad）
  static const double goalsTextFontSizeIPad = 15.0;

  /// 进球数/失球数文字字体大小（普通）
  static const double goalsTextFontSize = 11.0;


  // ========== 数据 ==========
  List<MatchDetailTab> tabs = [];
  List<KnockoutInfoBeanEntity> currentList = [];
  Map<String, Map> union = {};
  List<KnockoutInfo> dataList = [];
  List<AnalyzeVsInfoNewInfoEntity> currentCupBasketBallEventDataEvents = [];

  // ========== 初始化常量数据 ==========
  /// 淘汰赛轮次名称列表
  static List<String> get knockoutRoundNames => [
    "32强",
    "16强",
    "8强",
    "半决赛",
    "决赛"
  ];

  /// 颜色列表（用于图表显示）
  static List<Color> get colors => [
    Color(0xFF4176FA),
    Color(0xFFFEAE2C),
    Color(0xFF00B42A),
    Color(0xFF7DA1FC),
    Color(0xFFFDB1B1)
  ];

  /// 淘汰赛轮次映射表
  /// key: "1"-32强, "2"-16强, "3"-8强, "4"-半决赛, "5"-决赛
  static Map<String, String> get tabList => {
    "1": LocaleKeys.virtual_sports_Q16.tr,
    "2": LocaleKeys.virtual_sports_Q8.tr,
    "3": LocaleKeys.virtual_sports_Q4.tr,
    "4": LocaleKeys.virtual_sports_semifinals.tr,
    "5": LocaleKeys.vsport_etab4.tr
  };

  /// 初始化淘汰赛数据列表
  List<KnockoutInfo> get initialDataList => knockoutRoundNames
      .map((name) => KnockoutInfo(name: name))
      .toList();

  MatchCupPointState() {
    // 初始化数据列表
    dataList = initialDataList;
  }
}