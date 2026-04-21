
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../generated/locales.g.dart';

import '../../../services/api/result_api.dart';
import '../../../services/models/res/query_tournament_score_result_entity.dart';
import '../../../services/models/res/virtual_menus_entity.dart';

import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../login/login_head_import.dart';
import 'package:intl/intl.dart';
import '../../setting_menu/league_filter/manager/league_manager.dart';
import '../gaming_results/gaming_results_controller.dart';

import '../result_controller.dart';
import 'vr_results_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 控制器 VrResultsController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 控制器 VrResultsController
    - VrResultsController
    ```
    ///结束时间
    late String endTime;
    ///开始时间
    late String startTime;
    ///页数
    int page = 1;
    /// 加载页
    RxBool loading = false.obs;


    ///菜单数据
    late List<VirtualMenusData> vRMenuListData = [];

    ///菜单默认索引
    int vRMenuIndex = 0;
    String vRMenuMenuId = '1001';

    ///联赛标题数据
    late List<VirtualMenusDataSubList> vRLeagueSubList = [];
    int vRLeagueIndex = 0;
    String vRLeagueMenuId = '516778647047262210';
    late List<QueryTournamentScoreResultDataRecords> recordsList = [];

    ///展开收起
    bool isExpand = true;

    ///联赛筛选开关
    bool vRLeagueMen = false;

    ///球类开关
    bool vRMen = false;
    ```
    】】】
 *
 */
class VrResultsController extends GetxController
    with GetTickerProviderStateMixin {
  final VrResultslogic logic = VrResultslogic();
  final resultController = Get.find<ResultController>();

  final ScrollController scrollController = ScrollController();
  final ScrollController typeScrollController = ScrollController();
  RefreshController refreshController = RefreshController();

  late TabController dateTabController;
  late TabController vRTypeTabController;
  late TabController vRLeagueTypeTabController;

  List<DateItemModel> dateList = [];


  ///菜单数据
  late List<VirtualMenusData> vRMenuListData = [];



  ///联赛标题数据
  late List<VirtualMenusDataSubList> vRLeagueSubList = [];
  late List<QueryTournamentScoreResultDataRecords> recordsList = [];



  @override
  void onInit() {
    ///初始化日期
    initDate();

    ///拉去VR菜单
    getVirtualMenus();

    ///拿预加载赛果页面VR菜单
    if (resultController.vRMenuListData.isNotEmpty) {
      vRMenuListData = resultController.vRMenuListData;
      logic.vRMenuMenuId = vRMenuListData[0].menuId;

      ///球种选择类型
      vRTypeTabController =
          TabController(length: vRMenuListData.length, vsync: this);

      vRLeagueSubList = vRMenuListData[0].subList;
      logic.vRLeagueMenuId = vRMenuListData[0].subList[0].menuId;

      ///联赛选择abBar
      vRLeagueTypeTabController =
          TabController(length: vRLeagueSubList.length, vsync: this);
      logic.vRMen = true;
      logic.vRLeagueMen = true;
    } else {
      logic.vRMen = false;
      logic.vRLeagueMen = false;
      vRTypeTabController = TabController(length: 0, vsync: this);
      vRLeagueTypeTabController = TabController(length: 0, vsync: this);
    }

    ///置顶滚动页面最上方
    scrollController.addListener(() {
      if (scrollController.offset > 5 * 100.0) {
        logic.returnToFirst = true;
        update();
      } else {
        logic.returnToFirst = false;
        update();
      }

      ///滑动到底部分页加载更多数据
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        onLoadMore();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    dateTabController.dispose();
    vRTypeTabController.dispose();
    vRLeagueTypeTabController.dispose();
    super.onClose();
  }

  ///时间选择
  onDateIndex(int index) {
    logic.dateIndex = index;
    LeagueManager.md = dateList[index].timestamp;
    logic.startTime = dateList[index].startTime;
    logic.endTime = dateList[index].endTime;
    getVirtualMenus();
    update();
  }

  ///球类选择
  onVrMenuIndex(int index) {
    logic.vRLeagueIndex = 0;
    logic.vRMenuIndex = index;
    update();
    getVirtualMenus();
  }

  ///获取VR菜单数据
  Future<void> getVirtualMenus() async {
    logic.downloadData = true;
    logic.vRLeagueMen = false;
    final res = await ResultApi.instance().getVirtualMenus();
    if (res.data.isNotEmpty) {
      vRMenuListData = res.data;
      logic.vRMenuMenuId = vRMenuListData[logic.vRMenuIndex].menuId;
      vRTypeTabController =
          TabController(length: vRMenuListData.length, vsync: this);

      vRLeagueSubList = vRMenuListData[logic.vRMenuIndex].subList;
      logic.vRLeagueMenuId =
          vRMenuListData[logic.vRMenuIndex].subList[logic.vRLeagueIndex].menuId;
      vRLeagueTypeTabController =
          TabController(length: vRLeagueSubList.length, vsync: this);
      logic.vRMen = true;
      logic.vRLeagueMen = true;
      getQueryTournamentScoreResult();
    } else {
      logic.vRMen = false;
      logic.vRLeagueMen = false;
      logic.downloadData = false;
      logic.noData = true;
    }

    update();
  }

  ///联赛选择
  onVrLeagueDateIndex(int index) {
    logic.vRLeagueIndex = index;
    logic.vRLeagueMenuId =
        resultController.vRMenuListData[logic.vRMenuIndex].subList[index].menuId;
    print(logic.vRLeagueMenuId);
    getQueryTournamentScoreResult();
    update();
  }

  ///删选日期
  void initDate() {
    /// 获取当前日期和时间
    DateTime now = DateTime.now();

    /// 创建日期格式化器，格式为 MM/dd
    DateFormat formatter = DateFormat('MM/dd');

    /// 获取今天的国际化
    String today = LocaleKeys.types_competitions_menu_itme_name_today.tr;

    /// 遍历过去 7 天的日期
    for (int i = 0; i <= 7; i++) {
      /// 计算当前日期减去 i 天的日期
      DateTime date = now.subtract(Duration(days: i));

      /// 将当前日期减去 i 天的时间戳转换为特定时区的时间
      DateTime dateZoomTime = DateTime.fromMillisecondsSinceEpoch(
          TimeZoneUtils.convertTimeToTimestamp(
              now.subtract(Duration(days: i)).millisecondsSinceEpoch.toString(),
              isMilliseconds: true,
              returnMilliseconds: true),
          isUtc: true);

      /// 格式化日期，如果是今天则显示“今天”的标签
      String formattedDate = (date.year == now.year &&
              date.month == now.month &&
              date.day == now.day)
          ? today
          : '${date.day == now.day ? today : ''}${formatter.format(dateZoomTime)}';
      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        logic.startTime = DateTime(date.year, date.month, date.day, 0, 0, 0)
            .millisecondsSinceEpoch
            .toString();
        logic.endTime = DateTime(date.year, date.month, date.day, 23, 59, 59)
            .millisecondsSinceEpoch
            .toString();
      }

      /// 创建新的日期项模型
      DateItemModel item = DateItemModel();

      /// 设置日期为格式化后的字符串
      item.date = formattedDate;

      /// 设置时间戳为该日期的毫秒数
      item.timestamp = DateTime(date.year, date.month, date.day)
          .millisecondsSinceEpoch
          .toString();
      item.startTime = DateTime(date.year, date.month, date.day, 0, 0, 0)
          .millisecondsSinceEpoch
          .toString();
      item.endTime = DateTime(date.year, date.month, date.day, 23, 59, 59)
          .millisecondsSinceEpoch
          .toString();

      /// 将日期项添加到日期列表中
      dateList.add(item);
    }

    ///时间TabBar
    dateTabController = TabController(length: dateList.length, vsync: this);
    getVirtualMenus();

    /// 更新 UI
    update();
  }

  ///置顶
  void scrollToFirstItem() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    update();
  }

  ///联赛头部展开折叠
  onExpandItem() {
    logic.isExpand = !logic.isExpand;
    update();
  }

  ///数据刷新加载
  onRefresh() {
    getQueryTournamentScoreResult();
  }

  ///列表请求数据接口
  Future<void> getQueryTournamentScoreResult() async {
    logic.downloadData = true;
    logic.page = 1;
    recordsList.clear();
    final res = await ResultApi.instance().getQueryTournamentScoreResult({
      "batchNo": "",
      "endTime": logic.endTime,
      "isVirtualSport": 1,
      "page": {"size": 50, "current": logic.page},
      "sportType": logic.vRMenuMenuId,
      "orderBy": 0,
      "startTime": logic.startTime,
      "tournamentId": logic.vRLeagueMenuId
    });

    if (res.data.records.isNotEmpty) {
      recordsList = res.data.records;
      logic.downloadData = false;
      logic.noData = false;
      logic.vRLeagueMen = true;
      refreshController.loadComplete();
    } else {
      logic.downloadData = false;
      logic.noData = true;
      refreshController.loadNoData();
    }
    update();
  }

  ///翻页加载更多数据
  onLoadMore() {
    getQueryTournamentScoreResultLoadMore();
  }

  ///列表请求数据接口翻译加载更多
  Future<void> getQueryTournamentScoreResultLoadMore() async {
    final res = await ResultApi.instance().getQueryTournamentScoreResult({
      "batchNo": "",
      "endTime": logic.endTime,
      "isVirtualSport": 1,
      "page": {"size": 50, "current": logic.page++},
      "sportType": logic.vRMenuMenuId,
      "orderBy": 0,
      "startTime": logic.startTime,
      "tournamentId": logic.vRLeagueMenuId
    });

    if (res.data.records.isNotEmpty) {
      recordsList.addAll(res.data.records);
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    update();
  }
}
