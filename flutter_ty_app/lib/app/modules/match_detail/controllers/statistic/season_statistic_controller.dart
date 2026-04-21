
import 'package:flutter_ty_app/app/modules/match_detail/states/season_statistic_state.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_team_vs_other_team_entity.dart';
import '../../../login/login_head_import.dart';
import '../../models/analysis/analysis_model.dart';
import 'services/season_statistic_api_service.dart';
import 'services/season_statistic_data_converter.dart';
import 'services/season_statistic_result_formatter.dart';
import 'services/season_statistic_team_helper.dart';
import 'services/season_statistic_business_service.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 统计】】】
    【【【 AUTO_PARAGRAPH_TITLE 本赛季数据控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 本赛季数据控制器
    】】】
 *
 */
class SeasonStatisticController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// 构造函数
  /// [tag] 比赛ID标识
  SeasonStatisticController({required this.tag});

  /// 比赛ID标识
  final String tag;

  /// 状态管理对象
  SeasonStatisticState state = SeasonStatisticState();

  /// 标签页列表
  List<String> tabs = [];

  /// 近期历史类型
  int buildRecentHistoryType = 0;

  /// 历史类型
  int buildHistoryType = 0;

  /// 是否显示顶部空状态
  bool isShowTopEmpty = true;

  /// 是否显示底部空状态
  bool isShowBottomEmpty = true;

  /// 加载状态
  bool loading = true;

  /// 篮球队伍名称列表
  List<String> basketBallTeamNameList = [];

  /// 赛季持续时间数据Bean列表
  List<ListSaishiDurationDataBean> listSaishiDurationDataBeans =
      SeasonStatisticDataConverter.createDefaultDataBeans();

  /// 展开状态1
  bool expand1 = false;

  /// 展开状态
  bool expand = false;

  @override
  void onInit() {
    super.onInit();
    initTeams();
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  /// 初始化队伍信息
  /// 获取主队和客队名称，如果是篮球比赛则请求VS信息
  void initTeams() {
    bool needRequestVS = SeasonStatisticTeamHelper.initTeams(
      tag,
      basketBallTeamNameList,
    );
    update();
    
    if (needRequestVS) {
      requestTeamsVSInfo(flag: "1");
      requestOtherTeamsVSInfo();
    }
  }

  /// 初始化数据
  /// 请求本赛季统计数据和其他团队VS信息
  void initData() {
    requestGetSeasonStats();
    readyOtherRequestTeamsOn();
  }

  /// 请求获取本赛季统计数据
  /// 获取赛季统计数据并更新数据Bean列表
  void requestGetSeasonStats() {
    SeasonStatisticApiService.requestGetSeasonStats(mid: tag, flag: "0")
        .then((value) {
      if (value.data?.isNotEmpty == true) {
        isShowTopEmpty = false;
        listSaishiDurationDataBeans =
            SeasonStatisticDataConverter.createDefaultDataBeans();
      }
      
      // 转换数据
      for (int index = 0; index < (value.data?.length ?? 0); index++) {
        SeasonStatisticDataConverter.convertSeasonStatsPBBeanEntity(
          listSaishiDurationDataBeans,
          index,
          value.data?[index],
        );
      }
      update();
    });
  }

  /// 获取队伍图片URL
  /// [awayTeamName] 客队名称
  /// 返回队伍图片URL
  String getPlayImage(String awayTeamName) {
    return SeasonStatisticTeamHelper.getPlayImage(awayTeamName, tag);
  }

  /// 准备请求其他团队VS信息
  /// [flag] 标志位，默认为"3"
  void readyOtherRequestTeamsOn({String flag = "3"}) {
    state.curOtherFlag.value = "${state.curSelectTab2.value + 1}";
    requestOtherTeamsVSInfo(
      day: state.curOtherDay.value,
      flag: state.curOtherFlag.value,
    );
  }

  /// 请求VS信息
  /// [flag] 标志位
  void requestVSInfo({String? flag}) async {
    loading = true;
    update();
    try {
      var res = await SeasonStatisticApiService.requestVSInfo(
        mid: tag,
        flag: flag,
      );
      if (res.success) {
        state.analyzeList.value = res.data ?? [];
        loading = false;
        update();
      }
    } catch (_) {
      loading = false;
      update();
    }
  }

  /// 切换近期历史类型
  /// [type] 类型值
  /// [teamName] 队伍名称（保留参数，暂未使用）
  void switchBuildRecentHistoryType(int type, String teamName) {
    buildRecentHistoryType = type;
    update();
  }

  /// 请求团队与其他团队的交手记录
  /// [day] 天数，默认为"999"
  /// [flag] 标志位，默认为"0"
  void requestOtherTeamsVSInfo({String day = "999", String flag = "0"}) async {
    SeasonStatisticApiService.requestOtherTeamsVSInfo(
      mid: tag,
      flag: flag,
      day: day,
    ).then((value) {
      if (!value.success || value.data == null) {
        return;
      }
      
      isShowBottomEmpty = false;
      List<StatisticsTeamVsOtherTeam> home = value.data?.home ?? [];
      List<StatisticsTeamVsOtherTeam> away = value.data?.away ?? [];

      SeasonStatisticBusinessService.processOtherTeamsVSInfoData(
        state,
        home,
        away,
      );
      update();
    });
  }

  /// 切换历史类型
  /// [type] 类型值
  void switchBuildHistory(int type) {
    buildHistoryType = type;
    update();
  }

  /// 设置当前选择的标签页1
  /// [type] 标签页类型
  void setCurSelectTab1(int type) {
    state.curSelectTab1.value = type;
    requestTeamsVSInfo(day: state.curDay.value, flag: "${type + 1}");
    update();
  }

  /// 请求团队VS历史记录
  /// [day] 天数，默认为"5"
  /// [flag] 标志位，默认为"0"
  void requestTeamsVSInfo({String day = "5", String flag = "0"}) async {
    SeasonStatisticApiService.requestTeamsVSInfo(
      mid: tag,
      flag: flag,
      day: day,
    ).then((value) {
      SeasonStatisticBusinessService.processTeamsVSInfoData(
        state,
        value.data ?? [],
      );
      update();
    });
  }

  /// 准备请求团队信息
  void readyRequestTeamsOn() {
    state.curFlag.value = "${state.curSelectTab1.value + 1}";
    requestTeamsVSInfo(day: state.curDay.value, flag: state.curFlag.value);
  }

  /// 获取比赛结果字符串（根据比赛类型）
  /// [type] 结果类型：2-平，3-负，4-胜
  /// 返回对应的结果字符串
  String getWinResultStr(num? type) {
    return SeasonStatisticResultFormatter.getWinResultStr(type, tag);
  }

  /// 获取比赛结果字符串（格式1）
  /// [type] 结果类型：2-平，3-负，4-胜
  /// 返回对应的结果字符串
  String getWinResultStr1(num? type) {
    return SeasonStatisticResultFormatter.getWinResultStr1(type);
  }

  /// 获取大小球结果字符串
  /// [type] 结果类型：3-小，4-大
  /// 返回对应的结果字符串
  String getWinResultStr2(num? type) {
    return SeasonStatisticResultFormatter.getWinResultStr2(type);
  }

  /// 获取比赛结果字符串（格式3）
  /// [type] 结果类型：2-平，3-负，4-胜
  /// 返回对应的结果字符串
  String getWinResultStr3(num? type) {
    return SeasonStatisticResultFormatter.getWinResultStr3(type);
  }

  /// 设置队伍选择索引
  /// [index] 索引值，0为主队，1为客队
  void setTeamSelectIndex(int index) {
    state.selectTeamIndex.value = index;
    update();
  }

  /// 更新队伍索引
  /// [value] 索引值，用于切换不同的玩法数据
  void updateTeamIndex(int value) {
    state.selectPlayInfo.value = state.morePlays[value];
    readyOtherRequestTeamsOn(flag: "${value}");
    update();
  }

  /// 切换展开/收起状态
  /// 用于控制数据列表的展开和收起
  void switchExpand() {
    expand1 = !expand1;
    update();
  }

  /// 获取结果文本颜色
  /// [type] 结果类型字符串
  /// 返回对应的颜色
  Color getWinResultTextColor(String type) {
    return SeasonStatisticResultFormatter.getWinResultTextColor(type);
  }

  /// 设置当前其他选择的标签页2
  /// [type] 标签页类型索引
  void setcurOtherSelectTab2(int type) {
    state.curSelectTab2.value = type;
    readyOtherRequestTeamsOn();
    update();
  }

  /// 胜平负、大小走水格式化
  /// [type] 类型：'cls'、'resultLabel'、'resultwinlose'、'overunderLabel'
  /// [value] 值：2-平/走水，3-负/小，4-胜/大
  /// 返回格式化后的字符串
  String resultFilter(String type, int value) {
    return SeasonStatisticResultFormatter.resultFilter(type, value);
  }
}
