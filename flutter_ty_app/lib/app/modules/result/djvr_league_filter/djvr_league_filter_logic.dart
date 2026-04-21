
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3a9df28f-c590-402c-a99e-edc66a224cb3-dj 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果电竞冠军联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果冠军赛果 联赛筛选  DjVrLeagueFilterlogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞赛果冠军赛果  控制器 DjVrLeagueFilterlogic
    - DjVrLeagueFilterlogic
    ```
    ///源数据
    late List<GetFilterMatchListNewDData> getFilterMatchListNewsData = [];

    ///搜索删选后数据
    late List<GetFilterMatchListNewDData> getFilterMatchListNews =
    getFilterMatchListNewsData.where((item) {
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

    return item.tournaments.any((tag) {
    return tag.nameText.toLowerCase().contains(lowerKeyword) ||
    tag.tnjc.toLowerCase().contains(lowerKeyword);

    /// 同时匹配 nameText 和 tnjc
    });
    });
    }).toList();

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
    ```
    】】】
 *
 */

class DjVrLeagueFilterlogic {
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
  bool downloadData = false;

  DjVrLeagueFilterlogic() {
    ///Initialize variables
  }
}
