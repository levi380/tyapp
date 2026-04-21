/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 滚球全部  AllLeagueFilterlogic  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 滚球全部   AllLeagueFilterlogic
    - AllLeagueFilterlogic
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

    int isSelectCount = 0;
    String spell = '0';
    ```
    】】】
 *
 */
class AllLeagueFilterlogic {
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

  AllLeagueFilterlogic() {
    ///Initialize variables
  }
}
