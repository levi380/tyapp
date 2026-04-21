
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-245a3681-af98-492f-85f3-b3190a23bc35-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 普通赛果联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  普通赛果 联赛筛选 ResultsLeagueFilterlogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  普通赛果 联赛筛选 ResultsLeagueFilterlogic
    - ResultsLeagueFilterlogic
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
    ```
    】】】
 *
 */
class ResultsLeagueFilterlogic {
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

  ResultsLeagueFilterlogic() {
    ///Initialize variables
  }
}
