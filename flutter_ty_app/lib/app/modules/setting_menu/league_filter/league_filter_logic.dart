
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  LeagueFilterlogic  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  LeagueFilterlogic
    - LeagueFilterlogic
    ```
    ///全选
    bool selectAll = false;

    ///指示器图片状态
    bool indicator = false;

    ///有无数据状态
    bool noData = false;
    int currentIndex = 0;
    double location = 0;

    /// 只有一条数据 不显示分组头
    bool onlyOne = false;

    bool click = true;

    List<String> indexNationList = [];
    List selectedList = LeagueManager.tid;

    ///源数据列表
    late List<GetFilterMatchListData> getFilterMatchListData = [];

    ///搜索筛选后数据
    late List<GetFilterMatchListData> getFilterMatchList =
    getFilterMatchListData.where((item) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    if (searchControllerText.isEmpty) {
    return true;
    }

    ```
    】】】
 *
 */

class LeagueFilterlogic {

  ///全选
  bool selectAll = false;

  ///指示器图片状态
  bool indicator = false;

  ///有无数据状态
  bool noData = false;
  int currentIndex = 0;
  double location = 0;

  /// 只有一条数据 不显示分组头
  bool onlyOne = false;

  bool click = true;

  int isSelectCount = 0;

  String spell = '0';

  LeagueFilterlogic() {
    ///Initialize variables
  }
}
