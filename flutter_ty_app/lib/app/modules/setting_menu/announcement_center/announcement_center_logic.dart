/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心  AnnouncementCenterLogic  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心  AnnouncementCenterLogic
    - AnnouncementCenterLogic
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
class AnnouncementCenterLogic {
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
  String noticeType = '8888';

  ///固定展示时间
  String sendTimeOther = '';

  ///种类索引
  int typeIndex = 0;

  int sIndex = 0;
  int yIndex = 0;

  ///置顶按钮
  bool returnToFirst = false;

  ///搜索框
  bool searchBox = false;


  bool nlBool = false;

  AnnouncementCenterLogic() {
    ///Initialize variables
  }
}
