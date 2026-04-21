import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../generated/locales.g.dart';



import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../../utils/utils.dart';
import 'announcement_center_controller.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 控制器 AnnouncementCenterController  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 控制器 AnnouncementCenterController
    - AnnouncementCenterController
    ```
    ///选项卡控制器
    late TabController tabController;

    ///滚动控制器
    final ScrollController scrollController = ScrollController();

    ///输入框控制器
    TextEditingController searchController = TextEditingController();

    ///光标控制器
    final FocusNode focusNode = FocusNode();

    ///列表观察者控制器
    late ListObserverController listObserverController =
    ListObserverController(controller: scrollController);

    ///显示关闭日期弹窗
    bool openDate = false;

    ///更新数据
    bool updateList = false;

    ///开始时间
    String beginTime = '';

    ///结束时间
    String endTime = '';

    ///外部时间区间
    DateTime? rangeStart;
    DateTime? rangeEnd;

    ///类型
    String noticeType = '';

    ///固定展示时间
    String sendTimeOther = '';

    ///公告列表数据
    late List<GetNoticeFrontListDataNb> nb = [];

    ///根据搜索条件删选后数据
    late List<GetNoticeFrontListDataNb> nbList = nb.where((item) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    if (searchControllerText.isEmpty) {
    return true;
    }

    return keywords.every((keyword) {
    var lowerKeyword = keyword.toLowerCase();
    return item.context.toLowerCase().contains(lowerKeyword);
    });
    }).toList();

    ///球种类型数据
    late List<GetNoticeFrontListDataNl> nl = [];

    ///置顶按钮
    bool returnToFirst = false;

    ///搜索框
    bool searchBox = false;

    ```
    】】】
 *
 */
extension AnnouncementCenterControllerExt on AnnouncementCenterController {

  ///日期选择回调
  selectDate(DateTime? rangeStart, DateTime? rangeEnd) {
    onCloseData();
    if (rangeStart != null && rangeEnd != null) {
      logic.rangeStart = rangeStart;
      logic.rangeEnd = rangeEnd;
      // String endFormattedString= DateFormat('yyyy-MM-dd').format(rangeEnd);
      // endFormattedString = endFormattedString + ' 23:59:59';
      logic.beginTime = rangeStart.millisecondsSinceEpoch.toString();
      logic.endTime = endOfDayTimestamp(rangeEnd).toString();
      initData();
    }
  }

  ///时间格式化
  int endOfDayTimestamp(DateTime date) {
    /// 构造当天 23:59:59 的时间（本地时间）
    final dt = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return dt.millisecondsSinceEpoch;
  }

  ///赛种类型选择
  onTypeIndex(int index) {
    logic.typeIndex = index;
    logic.noticeType = nl[index].net;
    initData();
    logic.returnToFirst = false;

    logic.searchBox = false;
    searchController.text = '';
    update();
  }

  ///输入框内容处理
  debounceSearch(value) {
    print(value);
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 判断时候包含搜索条件组成list
    nbList = nb.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();
        return logic.typeIndex == 0 ? (item.context1.toLowerCase().contains(lowerKeyword) || item.context2.toLowerCase().contains(lowerKeyword)) : item.context.toLowerCase().contains(lowerKeyword);
      });
    }).toList();
    update();
  }

  ///清空搜索栏
  onClearSearchText() {
    searchController.text = '';
    nbList = nb;
    update();
  }

  ///输入框显示隐藏
  onCancel() {
    logic.searchBox = !logic.searchBox;
    searchController.text = '';
    nbList = nb;
    update();
  }

  ///列表滚动更新头部时间
  void onObserves(int? index) {
    /// 获取列表第一个item 时间加时区更新
    logic.sendTimeOther = DateUtil.formatDateMs(
        TimeZoneUtils.convertTimeToTimestamp(nbList[index ?? 0].sendTimeOther,
            formatIndex: 4,
            isMilliseconds: true,
            returnMilliseconds: true) ??
            0,
        format: LocaleKeys.time12.tr,
        isUtc: true);
    update();
  }


  ///赛事阶段-玩法名称
  String getPlayNames(int i,int e) {
    String playName = '';
    if (nb[i].orderInfo.detailList.isNotEmpty) {
      String matchType = '';
      int chType = nb[i].orderInfo.detailList[e].matchType;
      String langCode = nb[i].orderInfo.langCode;
      matchType = getBetType(chType, langCode);
      playName = ' $matchType ${nb[i].orderInfo.detailList[e].playName}';
    }
    return playName;
  }

}
