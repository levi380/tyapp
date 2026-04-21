class SettingMenulogic {

  ///投注模式 1新手 2专业

  int bettingMode = 2;

  ///排序规则 1热门 2时间
  int sortingRules = 1;

  ///盘口设置 1欧洲盘 2香港盘口
  int handicapSettings = 1;

  //投注按钮设置 1滑动下注 2点击下注
  int betButtonStyle = 1;

  ///主题风格 1日间 2夜间
  int themeStyle = 1;

  ///每日活动 1开启 2关闭
  int dailyActivities = 1;

  bool isDarkMode = false;

  /// 是否显示活动
  late bool showActivity = false;



  /// 字体大小 1 默认 2 放大
  int fontSize = 1;

  /// 投注手势 1 滑动投注  2 点击投注
  int bettingGestures = 1;



  /// 当前值
  int fastBetAmount = 0;

  /// 是否开启和关闭
  bool switchOn = false;

  /// 最小投注额
  int min = 0;

  /// 最大投注额
  int max = 100000000;

  ///简译繁译加载框
  bool updateLanguage = false;

  ///商户开关 0-关，1-开 队名偏好菜单
  String languageSwitch = '0';

  ///系统级别开关 0-关，1-开 队名偏好菜单
  String languageSystemSwitch = '0';
  bool betAmount = false;
  late List<int> singleList = [];

  SettingMenulogic() {
    ///Initialize variables
  }
}
