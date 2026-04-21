
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';

import '../../../services/models/res/analyze_v_s_info_entity.dart';
import '../../../services/models/res/statistics_team_vs_other_team_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 统计】】】
    【【【 AUTO_PARAGRAPH_TITLE 本赛季数据State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 本赛季数据State
    】】】
 *
 */
class SeasonStatisticState {

  //历史交战选择器
  RxInt curSelectTab1 = 0.obs;
  RxInt curSelectTab2 = 0.obs;
  RxInt curSelectTab3 = 0.obs;
  RxString curDay = "5".obs;
  RxString curFlag = "0".obs;

  //近期选择器
  RxBool curOtherSelectTab1 = false.obs;
  RxBool curOtherSelectTab2 = false.obs;
  RxString curOtherDay = "999".obs;
  RxString curOtherFlag = "0".obs;

  RxList<AnalyzeVSInfoEntity> analyzeList = <AnalyzeVSInfoEntity>[].obs;
  RxList<AnalyzeTeamVsHistoryEntity> analyzeTeamsList =
      <AnalyzeTeamVsHistoryEntity>[].obs;

  //近期战绩
  List<StatisticsTeamVsOtherTeam> home = [];
  List<StatisticsTeamVsOtherTeam> away = [];
  Map<String, int> homeVSHistoryMap = {};
  Map<String, int> awayVSHistoryMap = {};
  List<String> teamsNames = <String>[];
  RxInt selectTeamIndex = 0.obs;

  GlobalKey menuItemKey = GlobalKey(); //获取计算弹框位置
  List<String> morePlays = [
    LocaleKeys.footer_menu_all.tr,
    LocaleKeys.app_h5_handicap_tutorial_home_team.tr,
    LocaleKeys.app_h5_handicap_tutorial_away_team.tr
  ];


  RxString selectPlayInfo = LocaleKeys.footer_menu_all.tr.obs;

  Map teamVsHistoryResult = {
    "home": {"win": 0, "dogfall": 0, "lose": 0},
    "away": {
      "dogfall": 0,
      "lose": 0,
      "win": 0,
    },
  };

  // ========== UI常量 ==========
  /// 无数据提示顶部间距
  static const double noDataTopSpacing = 70.0;
  
  /// 容器水平内边距
  static const double pageHorizontalPadding = 4.0;
  
  /// 赛季标题垂直内边距
  static const double seasonTitleVerticalPadding = 8.0;
  
  /// 赛季标题水平内边距
  static const double seasonTitleHorizontalPadding = 8.0;
  
  /// 赛季标题字体大小
  static const double seasonTitleFontSize = 12.0;

  SeasonStatisticState() {
  }
}
