
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单 注单通知 BetOrderNotificationLogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单 注单通知 BetOrderNotificationLogic
    - BetOrderNotificationLogic
    - 设置菜单 注单通知 BetOrderNotificationLogic
    ```
    /// 每分钟点击次数限制
    final int limit = 3;
    /// 计时器时间
    final Duration duration = Duration(minutes: 1);
    /// 按钮的点击计数
    List<int> clickCounts = [0, 0, 0,0,0];
    /// 按钮状态
    List<bool> buttonEnabled = [true, true, true, true, true];
    ```
    】】】
 *
 */
class BetOrderNotificationLogic {


  /// 每分钟点击次数限制
  final int limit = 3;
  /// 计时器时间
  final Duration duration = Duration(minutes: 1);
  /// 按钮的点击计数
  List<int> clickCounts = [0, 0, 0,0,0];
  /// 按钮状态
  List<bool> buttonEnabled = [true, true, true, true, true];

  BetOrderNotificationLogic() {
    ///Initialize variables
  }
}
