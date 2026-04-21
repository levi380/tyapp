class StorageKey {
  static const String isFristApp = 'isFristApp'; //是否为第一次启动安装
  static const String tokenKey = 'token'; //token

  static const String rememberMeState = 'isrememberMe'; //是否记住账号密码
  static const String rememberMe = 'rememberMe'; //登录信息记录
  static const String userName = 'userName'; //userName
  static const String password = 'password'; //password

  static const String appLocalLanguage = 'appLocalLanguage'; //当前语言

  static const String appDarkTheme = 'appDarkTheme'; //App肤色 true 为深色  flase为浅色

  // 币种
  static const String currency = 'currency';

  static const String avatar = 'avatar'; //头像

  static const String hibalance = 'hibalance'; //头像

  static const String splashModel = 'splashModel'; //启动页数据

  static const String kdate = 'kdate'; //今天

  static const String homeAdsDate = 'homeAdsDate'; //广告

  static const String firstClickToDeposit = 'firstClickToDeposit'; //首次点击存款
  static const String firstClickToWithdraw = 'firstClickToWithdraw'; //首次点击取款

  /// XInstall 安装参数异常日志是否已上报（卸载前只上报一次）
  static const String installParamLogUploaded = 'installParamLogUploaded';

  /// 上次测速选中的最快 API、图片域名，下次启动先 ping 连通则直接使用
  static const String cachedFastestApiDomain = 'cachedFastestApiDomain';
  static const String cachedFastestImgDomain = 'cachedFastestImgDomain';
}
