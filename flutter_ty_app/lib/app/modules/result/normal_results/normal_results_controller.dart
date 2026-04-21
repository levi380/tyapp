import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import '../../../../generated/locales.g.dart';
import '../../../core/constant/common/module/csid.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/get_notice_list_by_id_entity.dart';

import '../../../utils/lodash.dart';
import '../../../utils/match_util.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../login/login_head_import.dart';
import 'package:intl/intl.dart';
import '../../setting_menu/league_filter/manager/league_manager.dart';
import '../gaming_results/gaming_results_controller.dart';
import 'normal_results_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-aac9743b-8526-4a48-b939-39e894116a65-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 普通赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  普通赛果 控制器 NormalResultsController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  普通赛果 控制器 NormalResultsController
    - NormalResultsController
    ```
    /// 初始化日期
    initDate();
    ///初始化数据
    initData();
    ```
    】】】
 *
 */
class NormalResultsController extends GetxController
    with GetTickerProviderStateMixin {
  final NormalResultslogic logic = NormalResultslogic();

  final ScrollController scrollController = ScrollController();
  final ScrollController typeScrollController = ScrollController();
  late TabController dateTabController;
  late TabController typeFilterTabController;

  List<DateItemModel> dateList = [];

  List<String> dateTimes = [];

  List<int> visibleIndexes = [];

  late List<TidDataList> matcheResultData = [];

  List<int> visibleItemIndices = [];


  GlobalKey? normalResultsKey = GlobalKey();
  /// 球类数据
  List<TypeModel> typeFilterList = [];



  ///公告数据
  late List<GetNoticeListByIdData> noticeListByIdData = [];

  @override
  void onInit() {
    typeFilterList = NormalResultslogic.getMenu();
    /// 初始化日期
    initDate();
    dateTabController = TabController(length: dateList.length, vsync: this);
    /// 球类筛选控制器
    typeFilterTabController =
        TabController(length: typeFilterList.length, vsync: this);
    ///初始化种类ID
    LeagueManager.euid = typeFilterList[0].euid.toString();
    initData();
    ///返回置顶位置
    scrollController.addListener(() {
      if (scrollController.offset > 5 * 100.0) {
        logic.returnToFirst = true;
        update(["back"]);
      } else {
        logic.returnToFirst = false;
        update(["back"]);
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
    typeFilterTabController.dispose();
    super.onClose();
  }


  ///初始化数据
  Future<void> initData({String? stid}) async {
    logic.tid = stid ?? '';
    LeagueManager.md = dateList[logic.dateIndex].timestamp;
    LeagueManager.euid = typeFilterList[logic.typeFilterIndex].euid.toString();
    getMatcheResult();
  }

  ///requestCount 这里只做了记录 并没有指定终止次数
  ///服务器问题/网络问题导致getMatcheResult 会无限调用 缺失终止逻辑
  Future<void> getMatcheResult() async {
    logic.loading.value = true;
    try {
      logic.requestCount++;
      matcheResultData.clear();
      logic.downloadData = true;
      update(["data"]);
      final res = await ResultApi.instance().matcheResult(
        1,
        '240640629535469568',
        'v2_h5_st',
        logic.euid,
        '',
        LeagueManager.md,
        1,
        LeagueManager.sort.value,
        logic.tid,
        28,
      );
      if (res.data != null) {
        ///每次切换界面折叠开关就打开的。
        logic.isExpandAll = true;
        onFormatData(res.data?.reversed.toList());
        logic.downloadData = false;
        logic.noData = false;
        update(["data"]);
      } else {
        logic.downloadData = false;
        logic.noData = true;
        update(["data"]);
      }
      logic.loading.value = false;
    } catch (e) {
      1100.milliseconds.delay(() {
        if (isClosed) return;
        initData();
      });
    }
  }

  ///列表数据处理
  onFormatData(data) {
    // 上个id
    String preTid = '';
    // 上条数据
    late TidDataList preItem;
    data.asMap().forEach((index, element) {
      if (index > 0) {
        preTid = data[index - 1].tid;
      }
      String tid = element.tid;

      if (tid == preTid) {
        preItem.list.add(element);
      } else {
        TidDataList item = TidDataList();

        item.list = [element];
        item.tid = tid;
        item.mid = element.mid;
        item.tn = element.tn;
        item.tnjc = element.tnjc;
        item.lurl = element.lurl;
        item.isIcon = element.isIcon;

        preItem = item;

        matcheResultData.add(item);

      }
    });

    update(["data"]);
  }

  onDateIndex(int index) {
    logic.tid = '';
    LeagueManager.tid.clear();
    logic.dateIndex = index;
    LeagueManager.md = dateList[index].timestamp;
    getMatcheResult();
    update(["date"]);
  }

  ///选择球种
  onTypeFilterIndex(int index, String sportIdx) {

    print(sportIdx+'sportIdx');
    logic.leftShow = false;
    logic.rightShow = false;
    LeagueManager.euid = typeFilterList[index].euid.toString();
    logic.tid = '';
    logic.sportid = sportIdx.toString();
    logic.typePicture = typeFilterList[index].image;
    logic.typeFilterIndex = index;
    logic.euid = typeFilterList[index].euid.toString();
    update(["type"]);
    logic.returnToFirst = false;
    update(["back"]);
    getMatcheResult();

    Scrollable.ensureVisible(
        normalResultsKey!.currentContext!,
        alignment: 0.5,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut);

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
              returnMilliseconds: true),isUtc: true);

      /// 格式化日期，如果是今天则显示“今天”的标签
      String formattedDate = (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day)
          ? today
          : '${date.day == now.day ? today : ''}${formatter.format(dateZoomTime)}';

      /// 创建新的日期项模型
      DateItemModel item = DateItemModel();
      /// 设置日期为格式化后的字符串
      item.date = formattedDate;
      /// 设置时间戳为该日期的毫秒数
      item.timestamp = DateTime(date.year, date.month, date.day)
          .millisecondsSinceEpoch
          .toString();

      /// 将日期项添加到日期列表中
      dateList.add(item);
      /// 更新 UI
      update(["date"]);
    }
  }

  ///置顶
  void scrollToFirstItem() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    update(["data"]);
  }

  ///跳转详情
  onGoToDetails(item, int titleIndex) {
    Get.toNamed(Routes.matchResultsDetails, arguments: [
      {"item": item},
      {"typePicture": logic.typePicture},
      {"titleIndex": titleIndex}
    ]);
  }

  onExpandItem(item) {
    item.isExpand = !item.isExpand;
    update(["data"]);
  }

  /// 点击展开全部
  onExpandAll() {
    logic.isExpandAll = !logic.isExpandAll;
    for (var element in matcheResultData) {
      element.isExpand = logic.isExpandAll;
    }
    update(["data"]);
  }

  ///点击喇叭获取公告通知
  onIsIcon(String matchManageId) async {
    logic.mid = matchManageId;
    if(logic.isIcon!=true){
      final res = await ResultApi.instance().getNoticeListById(
        matchManageId,
      );
      if(res.code=='0000000'){
        noticeListByIdData = res.data;
        logic.isIcon = true;
      }
    }else {
      onCloseIsIcon();
    }

    update(["data"]);
    update();
  }

  ///关闭公告通知
  onCloseIsIcon() {
    logic.isIcon = false;
    update(["data"]);
    update();
  }

  ///滑动位置左右悬停
  onCallBack(int firstIndex, int lastIndex) {
    int currentIndex = typeFilterList
        .indexWhere((element) => element.sportId.contains(logic.sportid));

    if (currentIndex == -1) return;
    if (currentIndex < firstIndex) {
      logic.leftShow = true;
      logic.rightShow = false;
    } else if (currentIndex > lastIndex) {
      logic.leftShow = false;
      logic.rightShow = true;
    } else {
      logic.leftShow = false;
      logic.rightShow = false;
    }
    update(['type']);
  }
}

///赛果列表数据模型
class DateItemModel {
  late String date;
  late String timestamp;
}

class TypeModel {
  late String name;
  late String label;
  late int euid;
  late int miid;
  late String sportId;
  late String image; // 详情底图
  // late int position;

  TypeModel(this.label, this.euid, this.image) {
    sportId = (euid + 100).toString();
    miid = euid;
    name = ConfigController.to.getName(sportId);
    image =
        lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$euid.detail.B') ??
            Csid.result_detail_images_postion[euid] ??
            "";
  }
}
