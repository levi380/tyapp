import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/common_score_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/group_soure_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/item_disuse_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_history_dog_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr详情State
    - 临时数据存储
    - 状态存储
    】】】
 *
 */
class VrSportDetailState {
  /// 静态资源常量与工具方法
  /// 统一管理 VR 详情页使用到的图片/图标资源，避免视图层写死路径
  static const String defaultTeamHome =
      'assets/images/detail/default_team_home.svg';
  static const String defaultTeamAway =
      'assets/images/detail/default_team_away.svg';
  static const String arrowDownNight =
      'assets/images/detail/icon_arrowdown_nor_night.svg';
  static const String vsBg = 'assets/images/icon/vs_bg.png';
  static const String expandsIcon = 'assets/images/icon/expands.png';
  static const String colorBackgroundSkin =
      'assets/images/home/color_background_skin.png';
  static const String icoFavSel = 'assets/images/vr/ico_fav_sel.svg';
  static const String icoFav = 'assets/images/vr/ico_fav.svg';

  /// 赛狗/赛马排名图标（动态）
  static String dogHorseRankIcon(int index) =>
      'assets/images/vr/vr_dog_horse_rank$index.png';

  /// 默认新的排名图标（1~3名）
  static String detailNewRankIcon(int index) =>
      'assets/images/detailnew/rank$index.png';

  /// 排名图标（1/2/3）
  static String betRecordNoIcon(int no) =>
      'assets/images/vr/bet_record_NO.$no.png';

  /// 历史战绩胜平负图标
  static String resultIconPng(String name) => 'assets/images/vr/$name.png';

  /// 历史战绩胜平负图标
  static String resultIconSvg(String name) => 'assets/images/vr/$name.svg';

  /// 将阿拉伯数字替换为英文字母（A-Z）
  static String replaceEnglishNumber(String input) {
    const arabic = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25'
    ];
    const english = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  /// 格式化淘汰赛比分（最多三段）
  static List<String> getMatchScore(String Score) {
    List<String> scoreList = [];
    List<String> temp = [];
    if (Score.isNotEmpty) {
      temp = Score.split(',');
    }
    for (int i = 0; i < 3; i++) {
      if (i < temp.length) {
        scoreList.add(temp[i]);
      } else {
        scoreList.add("-");
      }
    }
    return scoreList;
  }

  List matchDetailList = [
    LocaleKeys.virtual_sports_match_detail_historical_results.tr,
    LocaleKeys.virtual_sports_match_detail_bet.tr,
    LocaleKeys.virtual_sports_match_detail_leaderboard.tr,
  ];

  ///悬停标识
  RxBool overlapsContent = false.obs;
  TabController? matchTabController;
  ScrollController scrollController = ScrollController();

  ///历史战绩-足球类型
  List<String> historyScore = [];

  ///历史战绩-赛狗类型
  List<VrHistoryDogEntity> historyScoreDog = [];

  ///是否是世界杯类型
  RxBool isCup = false.obs;

  ///小组赛 淘汰赛切换下标
  RxInt groudIndex = 1.obs;

  ///排行榜
  List<CommonScoreModelData> rankList = [];

  ///小组赛
  List<GroupSoureModelDataGroupData> groupList = [];

  ///淘汰赛列表
  List<ItemDisuseEntity> disuseList = [];

  ///淘汰赛数据
  Map<String, List<ItemDisuseEntity>> disuseListMap = {};

  ///淘汰赛下标
  RxInt disuseIndex = 0.obs;

  ///世界杯类型-头部
  List disuseTitle = [
    LocaleKeys.virtual_sports_Q8.tr,
    LocaleKeys.virtual_sports_quarter_finals.tr,
    LocaleKeys.virtual_sports_SEMIFINAL.tr,
    LocaleKeys.virtual_sports_FINAL.tr,
  ];

  ///小组赛 淘汰赛
  List dataHeadTitle = [
    LocaleKeys.virtual_sports_group_matches.tr,
    LocaleKeys.virtual_sports_knockout.tr,
  ];

  ///是否显示淘汰赛下标
  int isDisuse = 0;

  ///VR赛事的实体，包含列表
  VrMatchEntity? vrMatch;

  ///从外部选中的赛事
  MatchEntity? match;

  ///世界杯淘汰赛类型，赛事id
  String? batchNo;
  String? lod;
  VrSportsMenuEntity? topMenu;

  // 是否打开联赛选择
  RxBool isOpenOtherMatch = false.obs;

  bool isBalls = false;
}
