import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/mchampion_match_result_entity.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../login/login_head_import.dart';
import 'package:intl/intl.dart';

import 'championship_results_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-245a3681-af98-492f-85f3-b3190a23bc35-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 冠军赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 冠军赛果 控制器  ChampionshipResultsController】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  冠军赛果 控制器  ChampionshipResultsController
    - ChampionshipResultsController
    ```
    ///初始化时间
    initDate();
    ///初始化加载数据
    initData();
    ```
    】】】
 *
 */
class ChampionshipResultsController extends GetxController
    with GetTickerProviderStateMixin {
  final ChampionshipResultslogic logic = ChampionshipResultslogic();

  final ScrollController scrollController = ScrollController();
  late TabController dateTabController;
  List<DateItemModel> dateList = [];


  @override
  void onInit() {
    ///初始化时间
    initDate();
    dateTabController = TabController(length: dateList.length, vsync: this);
    ///初始化加载数据
    initData();
    scrollController.addListener(() {
      if (scrollController.offset > 5 * 100.0) {
        logic.returnToFirst = true;
        update();
      } else {
        logic.returnToFirst = false;
        update();
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
    super.onClose();
  }

  /// 选择了日期 切换其他赛果 回来还是要请求之前的时间
  Future<void> initData({String? stid}) async {
    logic.tid = stid ?? '';
    LeagueManager.md = dateList[logic.dateIndex].timestamp;
    LeagueManager.euid = '10000';
    var index = logic.dateIndex;
    logic.md = dateList[index].timestamp;
    logic.startTime = dateList[index].startTime;
    logic.endTime = dateList[index].endTime;
    ///接口请求数据
    getChampionMatchResult();
  }

  ///requestCount 这里只做了记录 并没有指定终止次数
  ///服务器问题/网络问题导致getMatcheResult 会无限调用 缺失终止逻辑
  Future<void> getChampionMatchResult() async {
    logic.loading.value = true;
    logic.requestCount++;
    logic.downloadData = true;
    update(["data"]);

    final res = await ResultApi.instance().championMatchResult(
      1,
      '240640629535469568',
      'v2_h5_st',
      logic.endTime,
      10000,
      1,
      logic.md.toString(),
      1,
      LeagueManager.sort.value,
      1000,
      logic.startTime,
      28,
      logic.tid,
    );

    if (res.data.isNotEmpty) {
      logic.downloadData = false;
      logic.noData = false;
      onFormatData(res.data);
      update(["data"]);
    } else {
      logic.downloadData = false;
      logic.noData = true;
      update(["data"]);
    }
    logic.loading.value = false;
    update(["data"]);
  }

  /// 格式化数据
  onFormatData(List<MchampionMatchResultData> data) {
    /// 定义两个空的 Map 对象，用于存储
    Map sportObj = {};
    Map tourObj = {};

    /// 初始化一个空的列表，用于存储分组信息
    logic.groupList = [];

    /// 遍历输入数据
    for (var element in data) {
      String sportId = element.sportId;
      String tournamentId = element.tournamentId;

      /// 检查 sportObj 是否已经包含 sportId
      if (sportObj.containsKey(sportId)) {
        /// 获取对应的 SportItem
        SportItem sportItem = sportObj[sportId];
        sportItem.length += 1;

        /// 检查 tourObj 是否已经包含该 tournamentId
        if (tourObj.containsKey(tournamentId)) {
          /// 如果存在，则将加到列表中
          tourObj[tournamentId].list.add(element);
        } else {
          /// 如果不存在，创建新的 GroupItem
          GroupItem groupItem = GroupItem();
          groupItem.tournamentId = element.tournamentId;
          groupItem.tournamentName = element.tournamentName;
          groupItem.sportName = element.sportName;
          groupItem.picUrl = element.picUrl;
          /// 初始化比赛列表，添加当前元素
          groupItem.list = [element];
          /// 将新创建的 GroupItem 添加到 tourObj
          tourObj[tournamentId] = groupItem;
          /// 将 GroupItem 添加到对应的 SportItem 列表中
          sportItem.list.add(groupItem);
        }

      } else {
        /// 如果 sportObj 不包含该 ID，创建新的 SportItem
        SportItem sportItem = SportItem();
        sportItem.sportName = element.sportName;
        sportItem.picUrl = element.picUrl;
        sportItem.sportId = element.sportId;
        sportItem.length = 1;

        /// 创建新的 GroupItem
        GroupItem groupItem = GroupItem();
        groupItem.tournamentId = tournamentId;
        groupItem.tournamentName = element.tournamentName;
        groupItem.sportName = element.sportName;
        groupItem.picUrl = element.picUrl;

        groupItem.list = [element];
        tourObj[tournamentId] = groupItem;

        sportItem.list = [groupItem];
        sportObj[sportId] = sportItem;

        logic.groupList.add(sportItem);
      }
    }

    update(["data"]);

  }

  /// 点击展开全部
  onExpandAll() {
    logic.isExpandAll = !logic.isExpandAll;
    for (var i in logic.groupList) {
      for (var element1 in i.list) {
        element1.isExpand = logic.isExpandAll;
      }
    }
    update(["data"]);
  }

  ///日期选中删选
  onDateIndex(int index) {
    logic.tid = '';
    LeagueManager.tid.clear();
    logic.dateIndex = index;
    LeagueManager.md = dateList[index].timestamp;
    logic.startTime = dateList[index].startTime;
    logic.endTime = dateList[index].endTime;
    getChampionMatchResult();
    update(["date"]);
  }

  ///初始化删选日期
  void initDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MM/dd');
    String today = LocaleKeys.types_competitions_menu_itme_name_today.tr;

    for (int i = 0; i <= 7; i++) {
      DateTime date = now.subtract(Duration(days: i));
      DateTime dateZoomTime = DateTime.fromMillisecondsSinceEpoch(
          TimeZoneUtils.convertTimeToTimestamp(
            now.subtract(Duration(days: i)).millisecondsSinceEpoch.toString(),
            isMilliseconds: true,
            returnMilliseconds: true,),isUtc: true);
      String formattedDate = (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day)
          ? today
          : '${date.day == now.day ? today : ''}${formatter.format(dateZoomTime)}';

      DateItemModel item = DateItemModel();
      item.date = formattedDate;
      item.timestamp = DateTime(date.year, date.month, date.day)
          .millisecondsSinceEpoch
          .toString();
      item.startTime = DateTime(date.year, date.month, date.day, 00, 00, 00)
          .millisecondsSinceEpoch
          .toString();
      item.endTime = DateTime(date.year, date.month, date.day, 23, 59, 59)
          .millisecondsSinceEpoch
          .toString();
      dateList.add(item);
      LeagueManager.md = dateList[logic.dateIndex].timestamp;
      update(["type"]);
      getChampionMatchResult();
    }
  }

  ///滚动到最上方
  void scrollToFirstItem() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    update(["data"]);
  }

  ///列表item 展开 收缩
  onExpandItem(item) {
    item.isExpand = !item.isExpand;
    update(["data"]);
  }
}

class DateItemModel {
  late String date;
  late String timestamp;
  late String startTime;
  late String endTime;
}

class SportItem {
  int length = 0;
  late String sportName = '';
  late String sportId = '';
  late String picUrl = '';
  bool showTitle = false;
  late List<GroupItem> list = [];
}

class GroupItem {
  late int length;
  late String sportName;
  late String tournamentId;
  late String tournamentName;
  late String picUrl;
  bool showTitle = false;
  bool isExpand = true;
  late List<MchampionMatchResultData> list = [];
}
